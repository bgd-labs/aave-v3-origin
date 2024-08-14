// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.10;

import {UpgradableOwnableWithGuardian} from 'solidity-utils/contracts/access-control/UpgradableOwnableWithGuardian.sol';
import {PausableUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol';
import {IERC20Metadata, IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {AToken} from '../../../src/core/contracts/protocol/tokenization/AToken.sol';
import {DataTypes} from '../../../src/core/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {PullRewardsTransferStrategy} from '../../../src/periphery/contracts/rewards/transfer-strategies/PullRewardsTransferStrategy.sol';
import {RewardsDataTypes} from '../../../src/periphery/contracts/rewards/libraries/RewardsDataTypes.sol';
import {ITransferStrategyBase} from '../../../src/periphery/contracts/rewards/interfaces/ITransferStrategyBase.sol';
import {IEACAggregatorProxy} from '../../../src/periphery/contracts/misc/interfaces/IEACAggregatorProxy.sol';
import {IStata4626} from '../../../src/periphery/contracts/static-a-token/interfaces/IStata4626.sol';
import {SigUtils} from '../../utils/SigUtils.sol';
import {BaseTest, TestnetERC20} from './TestBase.sol';

contract StataPausableTest is BaseTest {
  function test_setPaused_shouldRevertForInvalidCaller(address actor) external {
    vm.assume(actor != poolAdmin && actor != proxyAdmin);
    vm.expectRevert(abi.encodeWithSelector(IStata4626.OnlyPauseGuardian.selector, actor));
    _setPaused(actor, true);
  }

  function test_setPaused_shouldSucceedForOwner() external {
    assertEq(PausableUpgradeable(address(staticATokenLM)).paused(), false);
    _setPaused(poolAdmin, true);
    assertEq(PausableUpgradeable(address(staticATokenLM)).paused(), true);
  }

  function test_deposit_shouldRevert() external {
    vm.startPrank(user);
    uint128 amountToDeposit = 5 ether;
    _fundUser(amountToDeposit, user);
    IERC20(UNDERLYING).approve(address(staticATokenLM), amountToDeposit);
    vm.stopPrank();

    _setPausedAsAclAdmin(true);
    vm.expectRevert(PausableUpgradeable.EnforcedPause.selector);
    vm.prank(user);
    staticATokenLM.deposit(amountToDeposit, user);
  }
  // TODO: add depositATokens

  function test_mint_shouldRevert() external {
    vm.startPrank(user);
    uint128 amountToDeposit = 5 ether;
    _fundUser(amountToDeposit, user);
    IERC20(UNDERLYING).approve(address(staticATokenLM), amountToDeposit);
    vm.stopPrank();

    uint256 sharesToMint = staticATokenLM.previewDeposit(amountToDeposit);
    _setPausedAsAclAdmin(true);
    vm.expectRevert(PausableUpgradeable.EnforcedPause.selector);
    vm.prank(user);
    staticATokenLM.mint(sharesToMint, user);
  }

  function test_redeem_shouldRevert() external {
    uint128 amountToDeposit = 5 ether;
    vm.startPrank(user);
    _fundUser(amountToDeposit, user);
    _depositAToken(amountToDeposit, user);
    vm.stopPrank();

    assertEq(staticATokenLM.maxRedeem(user), staticATokenLM.balanceOf(user));

    _setPausedAsAclAdmin(true);
    uint256 maxRedeem = staticATokenLM.maxRedeem(user);
    vm.expectRevert(PausableUpgradeable.EnforcedPause.selector);
    vm.prank(user);
    staticATokenLM.redeem(maxRedeem, user, user);
  }

  function test_withdraw_shouldRevert() external {
    uint128 amountToDeposit = 5 ether;
    vm.startPrank(user);
    _fundUser(amountToDeposit, user);
    _depositAToken(amountToDeposit, user);
    vm.stopPrank();

    uint256 maxWithdraw = staticATokenLM.maxWithdraw(user);
    _setPausedAsAclAdmin(true);
    vm.expectRevert(PausableUpgradeable.EnforcedPause.selector);
    vm.prank(user);
    staticATokenLM.withdraw(maxWithdraw, user, user);
  }

  function test_transfer_shouldRevert() external {
    uint128 amountToDeposit = 10 ether;
    vm.startPrank(user);
    _fundUser(amountToDeposit, user);
    _depositAToken(amountToDeposit, user);
    vm.stopPrank();

    _setPausedAsAclAdmin(true);
    vm.expectRevert(PausableUpgradeable.EnforcedPause.selector);
    vm.prank(user);
    staticATokenLM.transfer(user1, amountToDeposit);
  }

  function test_claimingRewards_shouldRevert() external {
    _configureLM();
    uint128 amountToDeposit = 10 ether;
    vm.startPrank(user);
    _fundUser(amountToDeposit, user);
    _depositAToken(amountToDeposit, user);
    vm.stopPrank();

    _setPausedAsAclAdmin(true);
    vm.expectRevert(PausableUpgradeable.EnforcedPause.selector);
    vm.prank(user);
    staticATokenLM.claimRewardsToSelf(rewardTokens);
  }

  function _setPausedAsAclAdmin(bool paused) internal {
    _setPaused(poolAdmin, paused);
  }

  function _setPaused(address actor, bool paused) internal {
    vm.prank(actor);
    staticATokenLM.setPaused(paused);
  }
}
