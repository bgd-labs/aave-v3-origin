```diff
diff --git a/./downloads/SONEIUM/EMISSION_MANAGER.sol b/./downloads/LINEA/EMISSION_MANAGER.sol
index ffede7b..9de846c 100644
--- a/./downloads/SONEIUM/EMISSION_MANAGER.sol
+++ b/./downloads/LINEA/EMISSION_MANAGER.sol
@@ -1,55 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
-pragma solidity ^0.8.0 ^0.8.10;
+pragma solidity ^0.8.10;

-// downloads/SONEIUM/EMISSION_MANAGER/src/contracts/dependencies/chainlink/AggregatorInterface.sol
-
-// Chainlink Contracts v0.8
-
-interface AggregatorInterface {
-  function decimals() external view returns (uint8);
-
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
-  function latestAnswer() external view returns (int256);
-
-  function latestTimestamp() external view returns (uint256);
-
-  function latestRound() external view returns (uint256);
-
-  function getAnswer(uint256 roundId) external view returns (int256);
-
-  function getTimestamp(uint256 roundId) external view returns (uint256);
-
-  event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 updatedAt);
-
-  event NewRound(uint256 indexed roundId, address indexed startedBy, uint256 startedAt);
-}

-// downloads/SONEIUM/EMISSION_MANAGER/src/contracts/rewards/interfaces/IRewardsDistributor.sol
+// downloads/LINEA/EMISSION_MANAGER/EmissionManager/src/contracts/helpers/interfaces/IEACAggregatorProxy.sol
+
+interface IEACAggregatorProxy {
+  function decimals() external view returns (uint8);
+
+  function latestAnswer() external view returns (int256);
+
+  function latestTimestamp() external view returns (uint256);
+
+  function latestRound() external view returns (uint256);
+
+  function getAnswer(uint256 roundId) external view returns (int256);
+
+  function getTimestamp(uint256 roundId) external view returns (uint256);
+
+  event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 timestamp);
+  event NewRound(uint256 indexed roundId, address indexed startedBy);
+}
+
+// downloads/LINEA/EMISSION_MANAGER/EmissionManager/src/contracts/rewards/interfaces/IRewardsDistributor.sol

 /**
  * @title IRewardsDistributor
@@ -249,7 +220,7 @@ interface IRewardsDistributor {
   function getEmissionManager() external view returns (address);
 }

-// downloads/SONEIUM/EMISSION_MANAGER/src/contracts/rewards/libraries/RewardsDataTypes.sol
+// downloads/LINEA/EMISSION_MANAGER/EmissionManager/src/contracts/rewards/libraries/RewardsDataTypes.sol

 library RewardsDataTypes {
   struct RewardsConfigInput {
@@ -363,7 +334,7 @@ library RewardsDataTypes {
     address asset;
     address reward;
     ITransferStrategyBase transferStrategy;
-    AggregatorInterface rewardOracle;
+    IEACAggregatorProxy rewardOracle;
   }

   struct UserAssetBalance {
@@ -404,7 +375,7 @@ library RewardsDataTypes {
   }
 }

-// downloads/SONEIUM/EMISSION_MANAGER/src/contracts/rewards/interfaces/IRewardsController.sol
+// downloads/LINEA/EMISSION_MANAGER/EmissionManager/src/contracts/rewards/interfaces/IRewardsController.sol

 /**
  * @title IRewardsController
@@ -470,9 +441,9 @@ interface IRewardsController is IRewardsDistributor {
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
@@ -504,8 +475,8 @@ interface IRewardsController is IRewardsDistributor {
    *   address asset: The asset address to incentivize
    *   address reward: The reward token address
    *   ITransferStrategy transferStrategy: The TransferStrategy address with the install hook and claim logic.
-   *   AggregatorInterface rewardOracle: The Price Oracle of a reward to visualize the incentives at the UI Frontend.
-   *                                     Must follow Chainlink Aggregator AggregatorInterface interface to be compatible.
+   *   IEACAggregatorProxy rewardOracle: The Price Oracle of a reward to visualize the incentives at the UI Frontend.
+   *                                     Must follow Chainlink Aggregator IEACAggregatorProxy interface to be compatible.
    */
   function configureAssets(RewardsDataTypes.RewardsConfigInput[] memory config) external;

@@ -602,7 +573,7 @@ interface IRewardsController is IRewardsDistributor {
   ) external returns (address[] memory rewardsList, uint256[] memory claimedAmounts);
 }

-// downloads/SONEIUM/EMISSION_MANAGER/src/contracts/rewards/interfaces/IEmissionManager.sol
+// downloads/LINEA/EMISSION_MANAGER/EmissionManager/src/contracts/rewards/interfaces/IEmissionManager.sol

 /**
  * @title IEmissionManager
@@ -632,8 +603,8 @@ interface IEmissionManager {
    *   address asset: The asset address to incentivize
    *   address reward: The reward token address
    *   ITransferStrategy transferStrategy: The TransferStrategy address with the install hook and claim logic.
-   *   AggregatorInterface rewardOracle: The Price Oracle of a reward to visualize the incentives at the UI Frontend.
-   *                                     Must follow Chainlink Aggregator AggregatorInterface interface to be compatible.
+   *   IEACAggregatorProxy rewardOracle: The Price Oracle of a reward to visualize the incentives at the UI Frontend.
+   *                                     Must follow Chainlink Aggregator IEACAggregatorProxy interface to be compatible.
    */
   function configureAssets(RewardsDataTypes.RewardsConfigInput[] memory config) external;

@@ -649,13 +620,13 @@ interface IEmissionManager {
    * @dev Sets an Aave Oracle contract to enforce rewards with a source of value.
    * @dev Only callable by the emission admin of the given reward
    * @notice At the moment of reward configuration, the Incentives Controller performs
-   * a check to see if the reward asset oracle is compatible with AggregatorInterface proxy.
+   * a check to see if the reward asset oracle is compatible with IEACAggregator proxy.
    * This check is enforced for integrators to be able to show incentives at
    * the current Aave UI without the need to setup an external price registry
    * @param reward The address of the reward to set the price aggregator
-   * @param rewardOracle The address of price aggregator that follows AggregatorInterface interface
+   * @param rewardOracle The address of price aggregator that follows IEACAggregatorProxy interface
    */
-  function setRewardOracle(address reward, AggregatorInterface rewardOracle) external;
+  function setRewardOracle(address reward, IEACAggregatorProxy rewardOracle) external;

   /**
    * @dev Sets the end date for the distribution
@@ -715,7 +686,7 @@ interface IEmissionManager {
   function getEmissionAdmin(address reward) external view returns (address);
 }

-// downloads/SONEIUM/EMISSION_MANAGER/src/contracts/rewards/EmissionManager.sol
+// downloads/LINEA/EMISSION_MANAGER/EmissionManager/src/contracts/rewards/EmissionManager.sol

 /**
  * @title EmissionManager
@@ -763,7 +734,7 @@ contract EmissionManager is Ownable, IEmissionManager {
   /// @inheritdoc IEmissionManager
   function setRewardOracle(
     address reward,
-    AggregatorInterface rewardOracle
+    IEACAggregatorProxy rewardOracle
   ) external override onlyEmissionAdmin(reward) {
     _rewardsController.setRewardOracle(reward, rewardOracle);
   }
```
