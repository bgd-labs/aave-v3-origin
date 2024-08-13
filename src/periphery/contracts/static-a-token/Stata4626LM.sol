// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.17;

import {IERC20} from 'openzeppelin-contracts/contracts/interfaces/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from 'solidity-utils/contracts/oz-common/SafeCast.sol';

import {Stata4626} from './Stata4626.sol';
import {IRewardsController} from '../rewards/interfaces/IRewardsController.sol';
import {IPool} from '../../../core/contracts/interfaces/IPool.sol';
import {IStata4626LM, IInitializableStata4626LM} from './interfaces/IStata4626LM.sol';

/**
 * @title Stata4626LM
 * @notice Wrapper smart contract that allows to deposit tokens on the Aave protocol and receive
 * a token which balance doesn't increase automatically, but uses an ever-increasing exchange rate.
 * It supports claiming liquidity mining rewards from the Aave system.
 * @author BGD labs
 */
contract Stata4626LM is Stata4626, IStata4626LM {
  using SafeCast for uint256;

  /// @custom:storage-location erc7201:aave-dao.storage.Stata4626LM
  struct Stata4626LMStorage {
    address[] _rewardTokens;
    mapping(address user => RewardIndexCache cache) _startIndex;
    mapping(address user => mapping(address reward => UserRewardsData cache)) _userRewardsData;
  }

  // keccak256(abi.encode(uint256(keccak256("aave-dao.storage.Stata4626LM")) - 1)) & ~bytes32(uint256(0xff))
  bytes32 private constant Stata4626LMStorageLocation =
    0x4a43e5c82db1d4c294eb6c47f1b5f92e6755a2055d3e0d4bb07e80af15cd9d00;

  function _getStata4626LMStorage() private pure returns (Stata4626LMStorage storage $) {
    assembly {
      $.slot := Stata4626LMStorageLocation
    }
  }

  IRewardsController public immutable INCENTIVES_CONTROLLER;

  constructor(IPool pool, IRewardsController rewardsController) Stata4626(pool) {
    INCENTIVES_CONTROLLER = rewardsController;
  }

  ///@inheritdoc IInitializableStata4626LM
  function initialize(
    address newAToken,
    string calldata staticATokenName,
    string calldata staticATokenSymbol
  ) external initializer {
    __Stata4626_init(newAToken, staticATokenName, staticATokenSymbol);

    if (INCENTIVES_CONTROLLER != IRewardsController(address(0))) {
      refreshRewardTokens();
    }
    emit Initialized(newAToken, staticATokenName, staticATokenSymbol);
  }

  ///@inheritdoc IStata4626LM
  function claimRewardsOnBehalf(
    address onBehalfOf,
    address receiver,
    address[] memory rewards
  ) external {
    address msgSender = _msgSender();
    if (msgSender != onBehalfOf && msgSender != INCENTIVES_CONTROLLER.getClaimer(onBehalfOf)) {
      revert InvalidClaimer(msgSender);
    }

    _claimRewardsOnBehalf(onBehalfOf, receiver, rewards);
  }

  ///@inheritdoc IStata4626LM
  function claimRewards(address receiver, address[] memory rewards) external {
    _claimRewardsOnBehalf(_msgSender(), receiver, rewards);
  }

  ///@inheritdoc IStata4626LM
  function claimRewardsToSelf(address[] memory rewards) external {
    _claimRewardsOnBehalf(_msgSender(), _msgSender(), rewards);
  }

  ///@inheritdoc IStata4626LM
  function refreshRewardTokens() public override {
    address[] memory rewards = INCENTIVES_CONTROLLER.getRewardsByAsset(address(aToken()));
    for (uint256 i = 0; i < rewards.length; i++) {
      _registerRewardToken(rewards[i]);
    }
  }

  ///@inheritdoc IStata4626LM
  function collectAndUpdateRewards(address reward) public returns (uint256) {
    if (reward == address(0)) {
      return 0;
    }

    address[] memory assets = new address[](1);
    assets[0] = address(aToken());

    return INCENTIVES_CONTROLLER.claimRewards(assets, type(uint256).max, address(this), reward);
  }

  ///@inheritdoc IStata4626LM
  function isRegisteredRewardToken(address reward) public view override returns (bool) {
    Stata4626LMStorage storage $ = _getStata4626LMStorage();
    return $._startIndex[reward].isRegistered;
  }

  ///@inheritdoc IStata4626LM
  function getCurrentRewardsIndex(address reward) public view returns (uint256) {
    if (address(reward) == address(0)) {
      return 0;
    }
    (, uint256 nextIndex) = INCENTIVES_CONTROLLER.getAssetIndex(address(aToken()), reward);
    return nextIndex;
  }

  ///@inheritdoc IStata4626LM
  function getTotalClaimableRewards(address reward) external view returns (uint256) {
    if (reward == address(0)) {
      return 0;
    }

    address[] memory assets = new address[](1);
    assets[0] = address(aToken());
    uint256 freshRewards = INCENTIVES_CONTROLLER.getUserRewards(assets, address(this), reward);
    return IERC20(reward).balanceOf(address(this)) + freshRewards;
  }

  ///@inheritdoc IStata4626LM
  function getClaimableRewards(address user, address reward) external view returns (uint256) {
    return _getClaimableRewards(user, reward, balanceOf(user), getCurrentRewardsIndex(reward));
  }

  ///@inheritdoc IStata4626LM
  function getUnclaimedRewards(address user, address reward) external view returns (uint256) {
    Stata4626LMStorage storage $ = _getStata4626LMStorage();
    return $._userRewardsData[user][reward].unclaimedRewards;
  }

  ///@inheritdoc IStata4626LM
  function rewardTokens() external view returns (address[] memory) {
    Stata4626LMStorage storage $ = _getStata4626LMStorage();
    return $._rewardTokens;
  }

  /**
   * @notice Updates rewards for senders and receiver in a transfer (not updating rewards for address(0))
   * @param from The address of the sender of tokens
   * @param to The address of the receiver of tokens
   */
  function _update(address from, address to, uint256 amount) internal override(Stata4626) {
    Stata4626LMStorage storage $ = _getStata4626LMStorage();
    for (uint256 i = 0; i < $._rewardTokens.length; i++) {
      address rewardToken = address($._rewardTokens[i]);
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
    Stata4626LMStorage storage $ = _getStata4626LMStorage();
    uint256 balance = balanceOf(user);
    if (balance > 0) {
      $._userRewardsData[user][rewardToken].unclaimedRewards = _getClaimableRewards(
        user,
        rewardToken,
        balance,
        currentRewardsIndex
      ).toUint128();
    }
    $._userRewardsData[user][rewardToken].rewardsIndexOnLastInteraction = currentRewardsIndex
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
    Stata4626LMStorage storage $ = _getStata4626LMStorage();
    RewardIndexCache memory rewardsIndexCache = $._startIndex[reward];
    if (!rewardsIndexCache.isRegistered) {
      revert RewardNotInitialized(reward);
    }

    UserRewardsData memory currentUserRewardsData = $._userRewardsData[user][reward];
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
        Stata4626LMStorage storage $ = _getStata4626LMStorage();
        $._userRewardsData[onBehalfOf][rewards[i]].unclaimedRewards = unclaimedReward.toUint128();
        $
        ._userRewardsData[onBehalfOf][rewards[i]]
          .rewardsIndexOnLastInteraction = currentRewardsIndex.toUint128();
        SafeERC20.safeTransfer(IERC20(rewards[i]), receiver, userReward);
      }
    }
  }

  /**
   * @notice Initializes a new rewardToken
   * @param reward The reward token to be registered
   */
  function _registerRewardToken(address reward) internal {
    if (isRegisteredRewardToken(reward)) return;
    uint256 startIndex = getCurrentRewardsIndex(reward);

    Stata4626LMStorage storage $ = _getStata4626LMStorage();
    $._rewardTokens.push(reward);
    $._startIndex[reward] = RewardIndexCache(true, startIndex.toUint240());

    emit RewardTokenRegistered(reward, startIndex);
  }
}
