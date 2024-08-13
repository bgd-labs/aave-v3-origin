// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.17;

import {PausableUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol';
import {ERC20Upgradeable} from 'openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol';
import {ERC20PermitUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC20PermitUpgradeable.sol';
import {ERC20PausableUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC20PausableUpgradeable.sol';
import {ERC4626Upgradeable, Math, IERC4626} from 'openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC4626Upgradeable.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/interfaces/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

import {IPool} from '../../../core/contracts/interfaces/IPool.sol';
import {IPoolAddressesProvider} from '../../../core/contracts/interfaces/IPoolAddressesProvider.sol';
import {IAaveOracle} from '../../../core/contracts/interfaces/IAaveOracle.sol';
import {DataTypes, ReserveConfiguration} from '../../../core/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {IACLManager} from '../../../core/contracts/interfaces/IACLManager.sol';
import {IRescuable, Rescuable} from 'solidity-utils/contracts/utils/Rescuable.sol';

import {IAToken} from './interfaces/IAToken.sol';
import {RayMathExplicitRounding} from '../libraries/RayMathExplicitRounding.sol';
import {IStata4626} from './interfaces/IStata4626.sol';

/**
 * @title Stata4626
 * @notice Wrapper smart contract that allows to deposit tokens on the Aave protocol and receive
 * a token which balance doesn't increase automatically, but uses an ever-increasing exchange rate.
 * @author BGD labs
 */
contract Stata4626 is
  ERC20Upgradeable,
  ERC20PermitUpgradeable,
  ERC20PausableUpgradeable,
  ERC4626Upgradeable,
  Rescuable,
  IStata4626
{
  using RayMathExplicitRounding for uint256;

  IPool public immutable POOL;
  IPoolAddressesProvider public immutable POOL_ADDRESSES_PROVIDER;

  IERC20 internal _aToken;

  constructor(IPool pool) {
    _disableInitializers();
    POOL = pool;
    POOL_ADDRESSES_PROVIDER = pool.ADDRESSES_PROVIDER();
  }

  // TODO: maybe I should not put calls to initializers here
  function __Stata4626_init(
    address newAToken,
    string calldata staticATokenName,
    string calldata staticATokenSymbol
  ) internal onlyInitializing {
    require(IAToken(newAToken).POOL() == address(POOL));

    IERC20 aTokenUnderlying = IERC20(IAToken(newAToken).UNDERLYING_ASSET_ADDRESS());

    __ERC20_init(staticATokenName, staticATokenSymbol);
    __ERC20Permit_init(staticATokenName);
    __ERC4626_init(aTokenUnderlying);
    __ERC20Pausable_init();

    _aToken = IERC20(newAToken);

    SafeERC20.forceApprove(aTokenUnderlying, address(POOL), type(uint256).max);
  }

  modifier onlyPauseGuardian() {
    if (!canPause(_msgSender())) revert OnlyPauseGuardian(_msgSender());
    _;
  }

  function decimals() public view override(ERC20Upgradeable, ERC4626Upgradeable) returns (uint8) {
    return ERC4626Upgradeable.decimals();
  }
  ///@inheritdoc IStata4626
  function canPause(address actor) public view returns (bool) {
    return IACLManager(POOL_ADDRESSES_PROVIDER.getACLManager()).isEmergencyAdmin(actor);
  }

  /// @inheritdoc IRescuable
  function whoCanRescue() public view override returns (address) {
    return POOL_ADDRESSES_PROVIDER.getACLAdmin();
  }

  ///@inheritdoc IStata4626
  function depositATokens(uint256 assets, address receiver) public returns (uint256) {
    uint256 shares = previewDeposit(assets);
    _deposit(_msgSender(), receiver, assets, shares, false);

    return shares;
  }

  ///@inheritdoc IStata4626
  function redeemATokens(uint256 shares, address receiver, address owner) public returns (uint256) {
    uint256 assets = previewRedeem(shares);
    _withdraw(_msgSender(), receiver, owner, shares, assets, false);

    return assets;
  }

  ///@inheritdoc IStata4626
  function setPaused(bool paused) external onlyPauseGuardian {
    if (paused) _pause();
    else _unpause();
  }

  ///@inheritdoc IStata4626
  function rate() public view returns (uint256) {
    return POOL.getReserveNormalizedIncome(asset());
  }

  ///@inheritdoc IStata4626
  function aToken() external view returns (IERC20) {
    return _aToken;
  }

  ///@inheritdoc IERC4626
  function maxMint(address) public view override returns (uint256) {
    uint256 assets = maxDeposit(address(0));
    if (assets == type(uint256).max) return type(uint256).max;
    return convertToShares(assets);
  }

  ///@inheritdoc IERC4626
  function maxWithdraw(address owner) public view override returns (uint256) {
    return convertToAssets(maxRedeem(owner));
  }

  ///@inheritdoc IERC4626
  function maxRedeem(address owner) public view override returns (uint256) {
    DataTypes.ReserveData memory reserveData = POOL.getReserveDataExtended(asset());

    // if paused or inactive users cannot withdraw underlying
    if (
      !ReserveConfiguration.getActive(reserveData.configuration) ||
      ReserveConfiguration.getPaused(reserveData.configuration)
    ) {
      return 0;
    }

    // otherwise users can withdraw up to the available amount
    uint256 underlyingTokenBalanceInShares = convertToShares(reserveData.virtualUnderlyingBalance);
    uint256 cachedUserBalance = balanceOf(owner);
    return
      underlyingTokenBalanceInShares >= cachedUserBalance
        ? cachedUserBalance
        : underlyingTokenBalanceInShares;
  }

  ///@inheritdoc IERC4626
  function maxDeposit(address) public view override returns (uint256) {
    DataTypes.ReserveDataLegacy memory reserveData = POOL.getReserveData(asset());

    // if inactive, paused or frozen users cannot deposit underlying
    if (
      !ReserveConfiguration.getActive(reserveData.configuration) ||
      ReserveConfiguration.getPaused(reserveData.configuration) ||
      ReserveConfiguration.getFrozen(reserveData.configuration)
    ) {
      return 0;
    }

    uint256 supplyCap = ReserveConfiguration.getSupplyCap(reserveData.configuration) *
      (10 ** ReserveConfiguration.getDecimals(reserveData.configuration));
    // if no supply cap deposit is unlimited
    if (supplyCap == 0) return type(uint256).max;
    // return remaining supply cap margin
    uint256 currentSupply = (IAToken(reserveData.aTokenAddress).scaledTotalSupply() +
      reserveData.accruedToTreasury).rayMulRoundUp(rate());
    return currentSupply > supplyCap ? 0 : supplyCap - currentSupply;
  }

  ///@inheritdoc IStata4626
  function latestAnswer() external view returns (int256) {
    uint256 aTokenUnderlyingAssetPrice = IAaveOracle(POOL_ADDRESSES_PROVIDER.getPriceOracle())
      .getAssetPrice(asset());
    return int256(convertToAssets(aTokenUnderlyingAssetPrice));
  }

  function _deposit(
    address caller,
    address receiver,
    uint256 assets,
    uint256 shares,
    bool depositToAave
  ) internal virtual {
    if (shares == 0) {
      revert StaticATokenInvalidZeroShares();
    }
    // If _asset is ERC777, `transferFrom` can trigger a reentrancy BEFORE the transfer happens through the
    // `tokensToSend` hook. On the other hand, the `tokenReceived` hook, that is triggered after the transfer,
    // calls the vault, which is assumed not malicious.
    //
    // Conclusion: we need to do the transfer before we mint so that any reentrancy would happen before the
    // assets are transferred and before the shares are minted, which is a valid state.
    // slither-disable-next-line reentrancy-no-eth

    if (depositToAave) {
      address cachedAsset = asset();
      SafeERC20.safeTransferFrom(IERC20(cachedAsset), caller, address(this), assets);
      POOL.deposit(cachedAsset, assets, address(this), 0);
    } else {
      SafeERC20.safeTransferFrom(_aToken, caller, address(this), assets);
    }
    _mint(receiver, shares);

    emit Deposit(caller, receiver, assets, shares);
  }

  function _deposit(
    address caller,
    address receiver,
    uint256 assets,
    uint256 shares
  ) internal virtual override {
    _deposit(caller, receiver, assets, shares, true);
  }

  function _withdraw(
    address caller,
    address receiver,
    address owner,
    uint256 assets,
    uint256 shares,
    bool withdrawFromAave
  ) internal virtual {
    if (caller != owner) {
      _spendAllowance(owner, caller, shares);
    }

    // If _asset is ERC777, `transfer` can trigger a reentrancy AFTER the transfer happens through the
    // `tokensReceived` hook. On the other hand, the `tokensToSend` hook, that is triggered before the transfer,
    // calls the vault, which is assumed not malicious.
    //
    // Conclusion: we need to do the transfer after the burn so that any reentrancy would happen after the
    // shares are burned and after the assets are transferred, which is a valid state.
    _burn(owner, shares);
    if (withdrawFromAave) {
      POOL.withdraw(asset(), assets, receiver);
    } else {
      SafeERC20.safeTransfer(_aToken, receiver, assets);
    }

    emit Withdraw(caller, receiver, owner, assets, shares);
  }

  function _withdraw(
    address caller,
    address receiver,
    address owner,
    uint256 assets,
    uint256 shares
  ) internal virtual override {
    _withdraw(caller, receiver, owner, assets, shares, true);
  }

  function _convertToShares(
    uint256 assets,
    Math.Rounding rounding
  ) internal view virtual override returns (uint256) {
    // @dev we use unsignedRoundsUp instead of just simple comparison to be sure that the code will work as expected
    // in case Math.Rounding.Trunc or Math.Rounding.Expand will be passed
    if (Math.unsignedRoundsUp(rounding)) return assets.rayDivRoundUp(rate());
    return assets.rayDivRoundDown(rate());
  }

  function _convertToAssets(
    uint256 shares,
    Math.Rounding rounding
  ) internal view virtual override returns (uint256) {
    // @dev we use unsignedRoundsUp instead of just simple comparison to be sure that the code will work as expected
    // in case Math.Rounding.Trunc or Math.Rounding.Expand will be passed
    if (Math.unsignedRoundsUp(rounding)) return shares.rayMulRoundUp(rate());
    return shares.rayMulRoundDown(rate());
  }

  function _update(
    address from,
    address to,
    uint256 amount
  ) internal virtual override(ERC20Upgradeable, ERC20PausableUpgradeable) whenNotPaused {
    super._update(from, to, amount);
  }
}
