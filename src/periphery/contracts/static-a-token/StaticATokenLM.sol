// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.17;

import {PausableUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol';
import {ERC20Upgradeable} from 'openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol';
import {ERC20PermitUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC20PermitUpgradeable.sol';
import {ERC20PausableUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC20PausableUpgradeable.sol';
import {ERC4626Upgradeable, Math, IERC4626} from 'openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC4626Upgradeable.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/interfaces/IERC20.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

import {IPool} from '../../../core/contracts/interfaces/IPool.sol';
import {IPoolAddressesProvider} from '../../../core/contracts/interfaces/IPoolAddressesProvider.sol';
import {IAaveOracle} from '../../../core/contracts/interfaces/IAaveOracle.sol';
import {DataTypes, ReserveConfiguration} from '../../../core/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {WadRayMath} from '../../../core/contracts/protocol/libraries/math/WadRayMath.sol';
import {MathUtils} from '../../../core/contracts/protocol/libraries/math/MathUtils.sol';
import {IACLManager} from '../../../core/contracts/interfaces/IACLManager.sol';
import {IRewardsController} from '../rewards/interfaces/IRewardsController.sol';
import {SafeCast} from 'solidity-utils/contracts/oz-common/SafeCast.sol';
import {IRescuable, Rescuable} from 'solidity-utils/contracts/utils/Rescuable.sol';

import {IStaticATokenLM} from './interfaces/IStaticATokenLM.sol';
import {IAToken} from './interfaces/IAToken.sol';
import {IInitializableStaticATokenLM} from './interfaces/IInitializableStaticATokenLM.sol';
import {StaticATokenErrors} from './StaticATokenErrors.sol';
import {RayMathExplicitRounding, Rounding} from '../libraries/RayMathExplicitRounding.sol';

/**
 * @title StaticATokenLM
 * @notice Wrapper smart contract that allows to deposit tokens on the Aave protocol and receive
 * a token which balance doesn't increase automatically, but uses an ever-increasing exchange rate.
 * It supports claiming liquidity mining rewards from the Aave system.
 * @author BGD labs
 */
contract StaticATokenLM is
  ERC20Upgradeable,
  ERC20PermitUpgradeable,
  ERC20PausableUpgradeable,
  ERC4626Upgradeable,
  IStaticATokenLM,
  Rescuable
{
  using SafeCast for uint256;
  using WadRayMath for uint256;
  using RayMathExplicitRounding for uint256;

  error StaticATokenLMInvalidZeroShares();

  IPool public immutable POOL;
  IPoolAddressesProvider public immutable POOL_ADDRESSES_PROVIDER;
  IRewardsController public immutable INCENTIVES_CONTROLLER;

  IERC20 internal _aToken;
  address[] internal _rewardTokens;
  mapping(address user => RewardIndexCache cache) internal _startIndex;
  mapping(address user => mapping(address reward => UserRewardsData cache))
    internal _userRewardsData;

  constructor(IPool pool, IRewardsController rewardsController) {
    _disableInitializers();
    POOL = pool;
    INCENTIVES_CONTROLLER = rewardsController;
    POOL_ADDRESSES_PROVIDER = pool.ADDRESSES_PROVIDER();
  }

  ///@inheritdoc IInitializableStaticATokenLM
  function initialize(
    address newAToken,
    string calldata staticATokenName,
    string calldata staticATokenSymbol
  ) external initializer {
    require(IAToken(newAToken).POOL() == address(POOL));

    IERC20 aTokenUnderlying = IERC20(IAToken(newAToken).UNDERLYING_ASSET_ADDRESS());

    __ERC20_init(staticATokenName, staticATokenSymbol);
    __ERC20Permit_init(staticATokenName);
    __ERC4626_init(aTokenUnderlying);
    __ERC20Pausable_init();

    _aToken = IERC20(newAToken);

    SafeERC20.forceApprove(aTokenUnderlying, address(POOL), type(uint256).max);

    if (INCENTIVES_CONTROLLER != IRewardsController(address(0))) {
      refreshRewardTokens();
    }

    emit Initialized(newAToken, staticATokenName, staticATokenSymbol);
  }

  modifier onlyPauseGuardian() {
    if (!canPause(_msgSender())) revert OnlyPauseGuardian(_msgSender());
    _;
  }

  function decimals() public view override(ERC20Upgradeable, ERC4626Upgradeable) returns (uint8) {
    return ERC4626Upgradeable.decimals();
  }
  ///@inheritdoc IStaticATokenLM
  function canPause(address actor) public view returns (bool) {
    return IACLManager(POOL_ADDRESSES_PROVIDER.getACLManager()).isEmergencyAdmin(actor);
  }

  /// @inheritdoc IRescuable
  function whoCanRescue() public view override returns (address) {
    return POOL_ADDRESSES_PROVIDER.getACLAdmin();
  }

  ///@inheritdoc IStaticATokenLM
  function depositATokens(uint256 assets, address receiver) public returns (uint256) {
    uint256 shares = previewDeposit(assets);
    _deposit(_msgSender(), receiver, assets, shares, false);

    return shares;
  }

  ///@inheritdoc IStaticATokenLM
  function redeemATokens(uint256 shares, address receiver, address owner) public returns (uint256) {
    uint256 assets = previewRedeem(shares);
    _withdraw(_msgSender(), receiver, owner, shares, assets, false);

    return assets;
  }

  ///@inheritdoc IStaticATokenLM
  function claimRewardsOnBehalf(
    address onBehalfOf,
    address receiver,
    address[] memory rewards
  ) external {
    require(
      _msgSender() == onBehalfOf || _msgSender() == INCENTIVES_CONTROLLER.getClaimer(onBehalfOf),
      StaticATokenErrors.INVALID_CLAIMER
    );
    _claimRewardsOnBehalf(onBehalfOf, receiver, rewards);
  }

  ///@inheritdoc IStaticATokenLM
  function claimRewards(address receiver, address[] memory rewards) external {
    _claimRewardsOnBehalf(_msgSender(), receiver, rewards);
  }

  ///@inheritdoc IStaticATokenLM
  function claimRewardsToSelf(address[] memory rewards) external {
    _claimRewardsOnBehalf(_msgSender(), _msgSender(), rewards);
  }

  ///@inheritdoc IStaticATokenLM
  function setPaused(bool paused) external onlyPauseGuardian {
    if (paused) _pause();
    else _unpause();
  }

  ///@inheritdoc IStaticATokenLM
  function refreshRewardTokens() public override {
    address[] memory rewards = INCENTIVES_CONTROLLER.getRewardsByAsset(address(_aToken));
    for (uint256 i = 0; i < rewards.length; i++) {
      _registerRewardToken(rewards[i]);
    }
  }

  ///@inheritdoc IStaticATokenLM
  function collectAndUpdateRewards(address reward) public returns (uint256) {
    if (reward == address(0)) {
      return 0;
    }

    address[] memory assets = new address[](1);
    assets[0] = address(_aToken);

    return INCENTIVES_CONTROLLER.claimRewards(assets, type(uint256).max, address(this), reward);
  }

  ///@inheritdoc IStaticATokenLM
  function isRegisteredRewardToken(address reward) public view override returns (bool) {
    return _startIndex[reward].isRegistered;
  }

  ///@inheritdoc IStaticATokenLM
  function getCurrentRewardsIndex(address reward) public view returns (uint256) {
    if (address(reward) == address(0)) {
      return 0;
    }
    (, uint256 nextIndex) = INCENTIVES_CONTROLLER.getAssetIndex(address(_aToken), reward);
    return nextIndex;
  }

  ///@inheritdoc IStaticATokenLM
  function getTotalClaimableRewards(address reward) external view returns (uint256) {
    if (reward == address(0)) {
      return 0;
    }

    address[] memory assets = new address[](1);
    assets[0] = address(_aToken);
    uint256 freshRewards = INCENTIVES_CONTROLLER.getUserRewards(assets, address(this), reward);
    return IERC20(reward).balanceOf(address(this)) + freshRewards;
  }

  ///@inheritdoc IStaticATokenLM
  function getClaimableRewards(address user, address reward) external view returns (uint256) {
    return _getClaimableRewards(user, reward, balanceOf(user), getCurrentRewardsIndex(reward));
  }

  ///@inheritdoc IStaticATokenLM
  function getUnclaimedRewards(address user, address reward) external view returns (uint256) {
    return _userRewardsData[user][reward].unclaimedRewards;
  }

  ///@inheritdoc IStaticATokenLM
  function rate() public view returns (uint256) {
    return POOL.getReserveNormalizedIncome(asset());
  }

  ///@inheritdoc IStaticATokenLM
  function aToken() external view returns (IERC20) {
    return _aToken;
  }

  ///@inheritdoc IStaticATokenLM
  function rewardTokens() external view returns (address[] memory) {
    return _rewardTokens;
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

  ///@inheritdoc IStaticATokenLM
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
      revert StaticATokenLMInvalidZeroShares();
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

  /**
   * @notice Updates rewards for senders and receiver in a transfer (not updating rewards for address(0))
   * @param from The address of the sender of tokens
   * @param to The address of the receiver of tokens
   */
  function _update(
    address from,
    address to,
    uint256 amount
  ) internal override(ERC20Upgradeable, ERC20PausableUpgradeable) whenNotPaused {
    for (uint256 i = 0; i < _rewardTokens.length; i++) {
      address rewardToken = address(_rewardTokens[i]);
      uint256 rewardsIndex = getCurrentRewardsIndex(rewardToken);
      if (from != address(0)) {
        _updateUser(from, rewardsIndex, rewardToken);
      }
      if (to != address(0) && from != to) {
        _updateUser(to, rewardsIndex, rewardToken);
      }
    }
    super._update(from, to, amount);
  }

  /**
   * @notice Adding the pending rewards to the unclaimed for specific user and updating user index
   * @param user The address of the user to update
   * @param currentRewardsIndex The current rewardIndex
   * @param rewardToken The address of the reward token
   */
  function _updateUser(address user, uint256 currentRewardsIndex, address rewardToken) internal {
    uint256 balance = balanceOf(user);
    if (balance > 0) {
      _userRewardsData[user][rewardToken].unclaimedRewards = _getClaimableRewards(
        user,
        rewardToken,
        balance,
        currentRewardsIndex
      ).toUint128();
    }
    _userRewardsData[user][rewardToken].rewardsIndexOnLastInteraction = currentRewardsIndex
      .toUint128();
  }

  /**
   * @notice Compute the pending in WAD. Pending is the amount to add (not yet unclaimed) rewards in WAD.
   * @param balance The balance of the user
   * @param rewardsIndexOnLastInteraction The index which was on the last interaction of the user
   * @param currentRewardsIndex The current rewards index in the system
   * @return The amount of pending rewards in WAD
   */
  function _getPendingRewards(
    uint256 balance,
    uint256 rewardsIndexOnLastInteraction,
    uint256 currentRewardsIndex
  ) internal view returns (uint256) {
    if (balance == 0) {
      return 0;
    }
    return (balance * (currentRewardsIndex - rewardsIndexOnLastInteraction)) / 10 ** decimals();
  }

  /**
   * @notice Compute the claimable rewards for a user
   * @param user The address of the user
   * @param reward The address of the reward
   * @param balance The balance of the user in WAD
   * @param currentRewardsIndex The current rewards index
   * @return The total rewards that can be claimed by the user (if `fresh` flag true, after updating rewards)
   */
  function _getClaimableRewards(
    address user,
    address reward,
    uint256 balance,
    uint256 currentRewardsIndex
  ) internal view returns (uint256) {
    RewardIndexCache memory rewardsIndexCache = _startIndex[reward];
    require(rewardsIndexCache.isRegistered == true, StaticATokenErrors.REWARD_NOT_INITIALIZED);
    UserRewardsData memory currentUserRewardsData = _userRewardsData[user][reward];
    return
      currentUserRewardsData.unclaimedRewards +
      _getPendingRewards(
        balance,
        currentUserRewardsData.rewardsIndexOnLastInteraction == 0
          ? rewardsIndexCache.lastUpdatedIndex
          : currentUserRewardsData.rewardsIndexOnLastInteraction,
        currentRewardsIndex
      );
  }

  /**
   * @notice Claim rewards on behalf of a user and send them to a receiver
   * @param onBehalfOf The address to claim on behalf of
   * @param rewards The addresses of the rewards
   * @param receiver The address to receive the rewards
   */
  function _claimRewardsOnBehalf(
    address onBehalfOf,
    address receiver,
    address[] memory rewards
  ) internal whenNotPaused {
    for (uint256 i = 0; i < rewards.length; i++) {
      if (address(rewards[i]) == address(0)) {
        continue;
      }
      uint256 currentRewardsIndex = getCurrentRewardsIndex(rewards[i]);
      uint256 balance = balanceOf(onBehalfOf);
      uint256 userReward = _getClaimableRewards(
        onBehalfOf,
        rewards[i],
        balance,
        currentRewardsIndex
      );
      uint256 totalRewardTokenBalance = IERC20(rewards[i]).balanceOf(address(this));
      uint256 unclaimedReward = 0;

      if (userReward > totalRewardTokenBalance) {
        totalRewardTokenBalance += collectAndUpdateRewards(address(rewards[i]));
      }

      if (userReward > totalRewardTokenBalance) {
        unclaimedReward = userReward - totalRewardTokenBalance;
        userReward = totalRewardTokenBalance;
      }
      if (userReward > 0) {
        _userRewardsData[onBehalfOf][rewards[i]].unclaimedRewards = unclaimedReward.toUint128();
        _userRewardsData[onBehalfOf][rewards[i]].rewardsIndexOnLastInteraction = currentRewardsIndex
          .toUint128();
        SafeERC20.safeTransfer(IERC20(rewards[i]), receiver, userReward);
      }
    }
  }

  function _convertToShares(
    uint256 assets,
    Math.Rounding rounding
  ) internal view virtual override returns (uint256) {
    if (Math.unsignedRoundsUp(rounding)) return assets.rayDivRoundUp(rate());
    return assets.rayDivRoundDown(rate());
  }

  function _convertToAssets(
    uint256 shares,
    Math.Rounding rounding
  ) internal view virtual override returns (uint256) {
    if (Math.unsignedRoundsUp(rounding)) return shares.rayMulRoundUp(rate());
    return shares.rayMulRoundDown(rate());
  }

  /**
   * @notice Initializes a new rewardToken
   * @param reward The reward token to be registered
   */
  function _registerRewardToken(address reward) internal {
    if (isRegisteredRewardToken(reward)) return;
    uint256 startIndex = getCurrentRewardsIndex(reward);

    _rewardTokens.push(reward);
    _startIndex[reward] = RewardIndexCache(true, startIndex.toUint240());

    emit RewardTokenRegistered(reward, startIndex);
  }
}
