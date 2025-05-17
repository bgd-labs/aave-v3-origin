```diff
diff --git a/./downloads/SONEIUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL.sol b/./downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL.sol
index 7771d0f..238e892 100644
--- a/./downloads/SONEIUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL.sol
+++ b/./downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL.sol
@@ -1,39 +1,11 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.0 ^0.8.10;

-// downloads/SONEIUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/src/contracts/dependencies/chainlink/AggregatorInterface.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/helpers/interfaces/IEACAggregatorProxy.sol

-// Chainlink Contracts v0.8
-
-interface AggregatorInterface {
+interface IEACAggregatorProxy {
   function decimals() external view returns (uint8);

-  function description() external view returns (string memory);
-
-  function getRoundData(
-    uint80 _roundId
-  )
-    external
-    view
-    returns (
-      uint80 roundId,
-      int256 answer,
-      uint256 startedAt,
-      uint256 updatedAt,
-      uint80 answeredInRound
-    );
-
-  function latestRoundData()
-    external
-    view
-    returns (
-      uint80 roundId,
-      int256 answer,
-      uint256 startedAt,
-      uint256 updatedAt,
-      uint80 answeredInRound
-    );
-
   function latestAnswer() external view returns (int256);

   function latestTimestamp() external view returns (uint256);
@@ -44,12 +16,11 @@ interface AggregatorInterface {

   function getTimestamp(uint256 roundId) external view returns (uint256);

-  event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 updatedAt);
-
-  event NewRound(uint256 indexed roundId, address indexed startedBy, uint256 startedAt);
+  event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 timestamp);
+  event NewRound(uint256 indexed roundId, address indexed startedBy);
 }

-// downloads/SONEIUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/src/contracts/rewards/libraries/RewardsDataTypes.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/rewards/libraries/RewardsDataTypes.sol

 library RewardsDataTypes {
   struct RewardsConfigInput {
@@ -765,7 +736,7 @@ library RewardsDataTypes {
     address asset;
     address reward;
     ITransferStrategyBase transferStrategy;
-    AggregatorInterface rewardOracle;
+    IEACAggregatorProxy rewardOracle;
   }

   struct UserAssetBalance {
@@ -806,7 +777,7 @@ library RewardsDataTypes {
   }
 }

-// downloads/SONEIUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/src/contracts/rewards/interfaces/IRewardsController.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/rewards/interfaces/IRewardsController.sol

 /**
  * @title IRewardsController
@@ -872,9 +843,9 @@ interface IRewardsController is IRewardsDistributor {
    * This check is enforced for integrators to be able to show incentives at
    * the current Aave UI without the need to setup an external price registry
    * @param reward The address of the reward to set the price aggregator
-   * @param rewardOracle The address of price aggregator that follows AggregatorInterface interface
+   * @param rewardOracle The address of price aggregator that follows IEACAggregatorProxy interface
    */
-  function setRewardOracle(address reward, AggregatorInterface rewardOracle) external;
+  function setRewardOracle(address reward, IEACAggregatorProxy rewardOracle) external;

   /**
    * @dev Get the price aggregator oracle address
@@ -906,8 +877,8 @@ interface IRewardsController is IRewardsDistributor {
    *   address asset: The asset address to incentivize
    *   address reward: The reward token address
    *   ITransferStrategy transferStrategy: The TransferStrategy address with the install hook and claim logic.
-   *   AggregatorInterface rewardOracle: The Price Oracle of a reward to visualize the incentives at the UI Frontend.
-   *                                     Must follow Chainlink Aggregator AggregatorInterface interface to be compatible.
+   *   IEACAggregatorProxy rewardOracle: The Price Oracle of a reward to visualize the incentives at the UI Frontend.
+   *                                     Must follow Chainlink Aggregator IEACAggregatorProxy interface to be compatible.
    */
   function configureAssets(RewardsDataTypes.RewardsConfigInput[] memory config) external;

@@ -1004,7 +975,7 @@ interface IRewardsController is IRewardsDistributor {
   ) external returns (address[] memory rewardsList, uint256[] memory claimedAmounts);
 }

-// downloads/SONEIUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/src/contracts/rewards/RewardsController.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/rewards/RewardsController.sol

 /**
  * @title RewardsController
@@ -1561,7 +1532,7 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
   // the current Aave UI without the need to setup an external price registry
   // At the moment of reward configuration, the Incentives Controller performs
   // a check to see if the provided reward oracle contains `latestAnswer`.
-  mapping(address => AggregatorInterface) internal _rewardOracle;
+  mapping(address => IEACAggregatorProxy) internal _rewardOracle;

   modifier onlyAuthorizedClaimers(address claimer, address user) {
     require(_authorizedClaimers[user] == claimer, 'CLAIMER_UNAUTHORIZED');
@@ -1627,7 +1598,7 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
   /// @inheritdoc IRewardsController
   function setRewardOracle(
     address reward,
-    AggregatorInterface rewardOracle
+    IEACAggregatorProxy rewardOracle
   ) external onlyEmissionManager {
     _setRewardOracle(reward, rewardOracle);
   }
@@ -1868,13 +1839,13 @@ contract RewardsController is RewardsDistributor, VersionedInitializable, IRewar
   }

   /**
-   * @dev Update the Price Oracle of a reward token. The Price Oracle must follow Chainlink AggregatorInterface interface.
+   * @dev Update the Price Oracle of a reward token. The Price Oracle must follow Chainlink IEACAggregatorProxy interface.
    * @notice The Price Oracle of a reward is used for displaying correct data about the incentives at the UI frontend.
    * @param reward The address of the reward token
    * @param rewardOracle The address of the price oracle
    */

-  function _setRewardOracle(address reward, AggregatorInterface rewardOracle) internal {
+  function _setRewardOracle(address reward, IEACAggregatorProxy rewardOracle) internal {
     require(rewardOracle.latestAnswer() > 0, 'ORACLE_MUST_RETURN_PRICE');
     _rewardOracle[reward] = rewardOracle;
     emit RewardOracleUpdated(reward, address(rewardOracle));
```
