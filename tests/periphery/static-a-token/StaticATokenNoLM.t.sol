// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.10;

import {BaseTest, IERC20, IERC20AaveLM} from './TestBase.sol';

/**
 * Testing the static token wrapper on a pool that never had LM enabled
 * This is a slightly different assumption than a pool that doesn't have LM enabled any more as incentivesController.rewardTokens() will have length=0
 */
contract StaticATokenNoLMTest is BaseTest {
  function setUp() public override {
    super.setUp();

    vm.startPrank(user);
  }

  // test rewards
  function test_collectAndUpdateRewardsWithLMDisabled() public {
    uint128 amountToDeposit = 5 ether;
    _fundUser(amountToDeposit, user);

    _depositAToken(amountToDeposit, user);

    _skipBlocks(60);
    assertEq(IERC20(REWARD_TOKEN).balanceOf(address(staticATokenLM)), 0);
    assertEq(staticATokenLM.getTotalClaimableRewards(REWARD_TOKEN), 0);
    assertEq(staticATokenLM.collectAndUpdateRewards(REWARD_TOKEN), 0);
    assertEq(IERC20(REWARD_TOKEN).balanceOf(address(staticATokenLM)), 0);
  }

  function test_claimRewardsToSelfWithLMDisabled() public {
    uint128 amountToDeposit = 5 ether;
    _fundUser(amountToDeposit, user);

    _depositAToken(amountToDeposit, user);

    _skipBlocks(60);

    vm.expectRevert(
      abi.encodeWithSelector(IERC20AaveLM.RewardNotInitialized.selector, REWARD_TOKEN)
    );
    staticATokenLM.getClaimableRewards(user, REWARD_TOKEN);

    vm.expectRevert(
      abi.encodeWithSelector(IERC20AaveLM.RewardNotInitialized.selector, REWARD_TOKEN)
    );
    staticATokenLM.claimRewardsToSelf(rewardTokens);

    assertEq(IERC20(REWARD_TOKEN).balanceOf(user), 0);
  }
}
