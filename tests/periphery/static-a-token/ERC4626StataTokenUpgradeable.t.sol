// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.10;

import {IERC20Errors} from 'openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {IPool} from '../../../src/core/contracts/interfaces/IPool.sol';
import {TestnetProcedures, TestnetERC20} from '../../utils/TestnetProcedures.sol';
import {ERC4626StataTokenUpgradeable, IERC4626StataToken} from '../../../src/periphery/contracts/static-a-token/ERC4626StataTokenUpgradeable.sol';
import {IRewardsController} from '../../../src/periphery/contracts/rewards/interfaces/IRewardsController.sol';
import {PullRewardsTransferStrategy, ITransferStrategyBase} from '../../../src/periphery/contracts/rewards/transfer-strategies/PullRewardsTransferStrategy.sol';
import {RewardsDataTypes} from '../../../src/periphery/contracts/rewards/libraries/RewardsDataTypes.sol';
import {IEACAggregatorProxy} from '../../../src/periphery/contracts/misc/interfaces/IEACAggregatorProxy.sol';
import {DataTypes} from '../../../src/core/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';

// Minimal mock as contract is abstract
contract MockERC4626StataTokenUpgradeable is ERC4626StataTokenUpgradeable {
  constructor(IPool pool) ERC4626StataTokenUpgradeable(pool) {}

  function mockInit(address aToken) external initializer {
    __ERC4626StataToken_init(aToken);
  }
}

contract ERC4626StataTokenUpgradeableTest is TestnetProcedures {
  MockERC4626StataTokenUpgradeable internal erc4626Upgradeable;
  address internal underlying;
  address internal aToken;

  address public user;
  uint256 internal userPrivateKey;

  function setUp() public virtual {
    initTestEnvironment();

    userPrivateKey = 0xA11CE;
    user = address(vm.addr(userPrivateKey));

    DataTypes.ReserveDataLegacy memory reserveDataWETH = contracts.poolProxy.getReserveData(
      tokenList.weth
    );
    underlying = address(tokenList.weth);
    aToken = reserveDataWETH.aTokenAddress;
    erc4626Upgradeable = new MockERC4626StataTokenUpgradeable(contracts.poolProxy);
    erc4626Upgradeable.mockInit(address(reserveDataWETH.aTokenAddress));
  }

  // ### DEPOSIT TESTS ###
  function test_depositATokens(uint128 assets, address receiver) public {
    vm.assume(receiver != address(0));
    TestEnv memory env = _setupTestEnv(assets);
    _fundAToken(env.amount, user);

    vm.startPrank(user);
    IERC20(aToken).approve(address(erc4626Upgradeable), env.amount);
    uint256 shares = erc4626Upgradeable.depositATokens(env.amount, receiver);
    vm.stopPrank();

    assertEq(erc4626Upgradeable.balanceOf(receiver), shares);
    assertEq(IERC20(aToken).balanceOf(address(erc4626Upgradeable)), env.amount);
    assertEq(IERC20(aToken).balanceOf(user), 0);
  }

  function test_depositATokens_self() external {
    test_depositATokens(1 ether, user);
  }

  function test_deposit_shouldRevert_insufficientAllowance(uint128 assets) external {
    TestEnv memory env = _setupTestEnv(assets);
    _fundAToken(env.amount, user);

    vm.expectRevert(); // underflows
    vm.prank(user);
    uint256 shares = erc4626Upgradeable.depositATokens(env.amount, user);
  }

  // ### REDEEM TESTS ###
  function test_redeemATokens(uint256 assets, address receiver) public {
    vm.assume(receiver != address(0));
    TestEnv memory env = _setupTestEnv(assets);
    uint256 shares = _fund4626(env.amount, user);

    vm.prank(user);
    erc4626Upgradeable.redeemATokens(shares, receiver, user);

    assertEq(erc4626Upgradeable.balanceOf(user), 0);
    assertEq(IERC20(aToken).balanceOf(receiver), env.amount);
  }

  function test_redeemATokens_onBehalf_shouldRevert_insufficientAllowance(
    uint256 assets,
    uint256 allowance
  ) external {
    TestEnv memory env = _setupTestEnv(assets);
    uint256 shares = _fund4626(env.amount, user);

    allowance = bound(allowance, 0, shares - 1);
    vm.prank(user);
    erc4626Upgradeable.approve(address(this), allowance);

    vm.expectRevert(
      abi.encodeWithSelector(
        IERC20Errors.ERC20InsufficientAllowance.selector,
        address(this),
        allowance,
        env.amount
      )
    );
    erc4626Upgradeable.redeemATokens(env.amount, address(this), user);
  }

  function test_redeemATokens_onBehalf(uint256 assets) external {
    TestEnv memory env = _setupTestEnv(assets);
    uint256 shares = _fund4626(env.amount, user);

    vm.prank(user);
    erc4626Upgradeable.approve(address(this), env.amount);
    erc4626Upgradeable.redeemATokens(env.amount, address(this), user);
  }

  // ### maxDeposit TESTS ###
  function test_maxDeposit_freeze() public {
    vm.prank(roleList.marketOwner);
    contracts.poolConfiguratorProxy.setReserveFreeze(underlying, true);

    uint256 max = erc4626Upgradeable.maxDeposit(address(0));

    assertEq(max, 0);
  }

  function test_maxDeposit_paused() public {
    vm.prank(address(roleList.marketOwner));
    contracts.poolConfiguratorProxy.setReservePause(underlying, true);

    uint256 max = erc4626Upgradeable.maxDeposit(address(0));

    assertEq(max, 0);
  }

  function test_maxDeposit_noCap() public {
    vm.prank(address(roleList.marketOwner));
    contracts.poolConfiguratorProxy.setSupplyCap(underlying, 0);

    uint256 maxDeposit = erc4626Upgradeable.maxDeposit(address(0));
    uint256 maxMint = erc4626Upgradeable.maxMint(address(0));

    assertEq(maxDeposit, type(uint256).max);
    assertEq(maxMint, type(uint256).max);
  }

  function test_maxDeposit_cap(uint256 cap) public {
    cap = bound(cap, 1, type(uint32).max);
    vm.prank(address(roleList.marketOwner));
    contracts.poolConfiguratorProxy.setSupplyCap(underlying, cap);

    uint256 max = erc4626Upgradeable.maxDeposit(address(0));
    assertEq(max, cap * 10 ** erc4626Upgradeable.decimals());
  }

  // TODO: perhaps makes sense to add maxDeposit test with accruedToTreasury etc

  // ### maxRedeem TESTS ###
  function test_maxRedeem_paused(uint128 assets) public {
    TestEnv memory env = _setupTestEnv(assets);
    uint256 shares = _fund4626(env.amount, user);

    vm.prank(address(roleList.marketOwner));
    contracts.poolConfiguratorProxy.setReservePause(underlying, true);

    uint256 max = erc4626Upgradeable.maxRedeem(address(user));

    assertEq(max, 0);
  }

  function test_maxRedeem_sufficientAvailableLiquidity(uint128 assets) public {
    TestEnv memory env = _setupTestEnv(assets);
    uint256 shares = _fund4626(env.amount, user);

    uint256 max = erc4626Upgradeable.maxRedeem(address(user));

    assertEq(max, shares);
  }

  function test_maxRedeem_inSufficientAvailableLiquidity(uint256 amountToBorrow) public {
    uint128 assets = 1 ether;
    amountToBorrow = bound(amountToBorrow, 1, assets);
    uint256 shares = _fund4626(assets, user);

    // borrow out some assets
    address borrowUser = address(99);
    vm.startPrank(borrowUser);
    deal(address(wbtc), borrowUser, 2_000e8);
    wbtc.approve(address(contracts.poolProxy), 2_000e8);
    contracts.poolProxy.deposit(address(wbtc), 2_000e8, borrowUser, 0);
    contracts.poolProxy.borrow(underlying, amountToBorrow, 2, 0, borrowUser);

    uint256 max = erc4626Upgradeable.maxRedeem(address(user));

    assertEq(max, erc4626Upgradeable.previewRedeem(assets - amountToBorrow));
  }

  // ### lastestAnswer TESTS ###
  function test_latestAnswer_priceShouldBeEqualOnDefaultIndex() public {
    vm.mockCall(
      address(contracts.poolProxy),
      abi.encodeWithSelector(IPool.getReserveNormalizedIncome.selector),
      abi.encode(1e27)
    );
    uint256 stataPrice = uint256(erc4626Upgradeable.latestAnswer());
    uint256 underlyingPrice = contracts.aaveOracle.getAssetPrice(underlying);
    assertEq(stataPrice, underlyingPrice);
  }

  function test_latestAnswer_priceShouldReflectIndexAccrual(uint256 liquidityIndex) public {
    liquidityIndex = bound(liquidityIndex, 1e27, 1e29);
    vm.mockCall(
      address(contracts.poolProxy),
      abi.encodeWithSelector(IPool.getReserveNormalizedIncome.selector),
      abi.encode(liquidityIndex)
    );
    uint256 stataPrice = uint256(erc4626Upgradeable.latestAnswer());
    uint256 underlyingPrice = contracts.aaveOracle.getAssetPrice(underlying);
    uint256 expectedStataPrice = (underlyingPrice * liquidityIndex) / 1e27;
    assertEq(stataPrice, expectedStataPrice);

    // reverse the math to ensure precision loss is within bounds
    uint256 reversedUnderlying = (stataPrice * 1e27) / liquidityIndex;
    assertApproxEqAbs(underlyingPrice, reversedUnderlying, 1);
  }

  struct TestEnv {
    uint256 amount;
  }

  function _setupTestEnv(uint256 amount) internal returns (TestEnv memory) {
    TestEnv memory env;
    env.amount = bound(amount, 1, type(uint128).max);
    return env;
  }

  function _fundUnderlying(uint256 assets, address user) internal {
    deal(underlying, user, assets);
  }

  function _fundAToken(uint256 assets, address user) internal {
    _fundUnderlying(assets, user);
    vm.startPrank(user);
    IERC20(underlying).approve(address(contracts.poolProxy), assets);
    contracts.poolProxy.deposit(underlying, assets, user, 0);
    vm.stopPrank();
  }

  function _fund4626(uint256 assets, address user) internal returns (uint256) {
    _fundAToken(assets, user);
    vm.startPrank(user);
    IERC20(aToken).approve(address(erc4626Upgradeable), assets);
    uint256 shares = erc4626Upgradeable.depositATokens(assets, user);
    vm.stopPrank();
    return shares;
  }
}
