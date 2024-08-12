// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IERC20} from 'openzeppelin-contracts/contracts/interfaces/IERC20.sol';
import {IInitializableStaticATokenLM} from './IInitializableStaticATokenLM.sol';

interface IStaticATokenLM is IInitializableStaticATokenLM {
  struct SignatureParams {
    uint8 v;
    bytes32 r;
    bytes32 s;
  }

  struct PermitParams {
    uint256 value;
    uint256 deadline;
    uint8 v;
    bytes32 r;
    bytes32 s;
  }

  struct UserRewardsData {
    uint128 rewardsIndexOnLastInteraction; // (in RAYs)
    uint128 unclaimedRewards; // (in RAYs)
  }

  struct RewardIndexCache {
    bool isRegistered;
    uint248 lastUpdatedIndex;
  }

  error OnlyPauseGuardian(address caller);

  event RewardTokenRegistered(address indexed reward, uint256 startIndex);

  /**
   * @notice Burns `shares` of static aToken, with receiver receiving the corresponding amount of aToken
   * @param shares The shares to withdraw, in static balance of StaticAToken
   * @param receiver The address that will receive the amount of `ASSET` withdrawn from the Aave protocol
   * @return amountToWithdraw: aToken send to `receiver`, dynamic balance
   **/
  function redeemATokens(
    uint256 shares,
    address receiver,
    address owner
  ) external returns (uint256);

  /**
   * @notice Deposits aTokens and mints static aTokens to msg.sender
   * @param assets The amount of aTokens to deposit (e.g. deposit of 100 aUSDC)
   * @param receiver The address that will receive the static aTokens
   * @return uint256 The amount of StaticAToken minted, static balance
   **/
  function depositATokens(uint256 assets, address receiver) external returns (uint256);

  /**
   * @notice Returns the Aave liquidity index of the underlying aToken, denominated rate here
   * as it can be considered as an ever-increasing exchange rate
   * @return The liquidity index
   **/
  function rate() external view returns (uint256);

  /**
   * @notice Claims rewards from `INCENTIVES_CONTROLLER` and updates internal accounting of rewards.
   * @param reward The reward to claim
   * @return uint256 Amount collected
   */
  function collectAndUpdateRewards(address reward) external returns (uint256);

  /**
   * @notice Claim rewards on behalf of a user and send them to a receiver
   * @dev Only callable by if sender is onBehalfOf or sender is approved claimer
   * @param onBehalfOf The address to claim on behalf of
   * @param receiver The address to receive the rewards
   * @param rewards The rewards to claim
   */
  function claimRewardsOnBehalf(
    address onBehalfOf,
    address receiver,
    address[] memory rewards
  ) external;

  /**
   * @notice Claim rewards and send them to a receiver
   * @param receiver The address to receive the rewards
   * @param rewards The rewards to claim
   */
  function claimRewards(address receiver, address[] memory rewards) external;

  /**
   * @notice Claim rewards
   * @param rewards The rewards to claim
   */
  function claimRewardsToSelf(address[] memory rewards) external;

  /**
   * @notice Get the total claimable rewards of the contract.
   * @param reward The reward to claim
   * @return uint256 The current balance + pending rewards from the `_incentivesController`
   */
  function getTotalClaimableRewards(address reward) external view returns (uint256);

  /**
   * @notice Get the total claimable rewards for a user in WAD
   * @param user The address of the user
   * @param reward The reward to claim
   * @return uint256 The claimable amount of rewards in WAD
   */
  function getClaimableRewards(address user, address reward) external view returns (uint256);

  /**
   * @notice The unclaimed rewards for a user in WAD
   * @param user The address of the user
   * @param reward The reward to claim
   * @return uint256 The unclaimed amount of rewards in WAD
   */
  function getUnclaimedRewards(address user, address reward) external view returns (uint256);

  /**
   * @notice The underlying asset reward index in RAY
   * @param reward The reward to claim
   * @return uint256 The underlying asset reward index in RAY
   */
  function getCurrentRewardsIndex(address reward) external view returns (uint256);

  /**
   * @notice The aToken used inside the 4626 vault.
   * @return IERC20 The aToken IERC20.
   */
  function aToken() external view returns (IERC20);

  /**
   * @notice The IERC20s that are currently rewarded to addresses of the vault via LM on incentivescontroller.
   * @return IERC20 The IERC20s of the rewards.
   */
  function rewardTokens() external view returns (address[] memory);

  /**
   * @notice Fetches all rewardTokens from the incentivecontroller and registers the missing ones.
   */
  function refreshRewardTokens() external;

  /**
   * @notice Checks if the passed token is a registered reward.
   * @param reward The reward to claim
   * @return bool signaling if token is a registered reward.
   */
  function isRegisteredRewardToken(address reward) external view returns (bool);

  /**
   * @notice Checks if the passed actor is permissioned emergency admin.
   * @param actor The reward to claim
   * @return bool signaling if actor can pause the vault.
   */
  function canPause(address actor) external view returns (bool);

  /**
   * @notice Pauses/unpauses all system's operations
   * @param paused boolean determining if the token should be paused or unpaused
   */
  function setPaused(bool paused) external;

  /**
   * @notice Returns the current asset price of the stataToken.
   * The price is calculated as `underlying_price * exchangeRate`.
   * It is important to note that:
   * - `underlying_price` is the price obtained by the aave-oracle and is subject to it's internal pricing mechanisms.
   * - as the price is scaled over the exchangeRate, but maintains the same precision as the underlying the price might be underestimated by 1 unit.
   * - when pricing multiple `shares` as `shares * price` keep in mind that the error compounds.
   * @return price the current asset price.
   */
  function latestAnswer() external view returns (int256);
}
