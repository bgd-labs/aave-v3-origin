```diff
diff --git a/./downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER.sol b/./downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER.sol
index cf5f34b..116b0dd 100644
--- a/./downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER.sol
+++ b/./downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER.sol
@@ -1,55 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.0 ^0.8.10;

-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/dependencies/chainlink/AggregatorInterface.sol
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

-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/helpers/interfaces/IEACAggregatorProxy.sol
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
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol

-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/rewards/libraries/RewardsDataTypes.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/rewards/libraries/RewardsDataTypes.sol

 library RewardsDataTypes {
   struct RewardsConfigInput {
@@ -3144,7 +3065,7 @@ library RewardsDataTypes {
     address asset;
     address reward;
     ITransferStrategyBase transferStrategy;
-    AggregatorInterface rewardOracle;
+    IEACAggregatorProxy rewardOracle;
   }

   struct UserAssetBalance {
@@ -3185,7 +3106,7 @@ library RewardsDataTypes {
   }
 }

-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/rewards/interfaces/IRewardsController.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/rewards/interfaces/IRewardsController.sol

 /**
  * @title IRewardsController
@@ -3483,9 +3404,9 @@ interface IRewardsController is IRewardsDistributor {
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
@@ -3517,8 +3438,8 @@ interface IRewardsController is IRewardsDistributor {
    *   address asset: The asset address to incentivize
    *   address reward: The reward token address
    *   ITransferStrategy transferStrategy: The TransferStrategy address with the install hook and claim logic.
-   *   AggregatorInterface rewardOracle: The Price Oracle of a reward to visualize the incentives at the UI Frontend.
-   *                                     Must follow Chainlink Aggregator AggregatorInterface interface to be compatible.
+   *   IEACAggregatorProxy rewardOracle: The Price Oracle of a reward to visualize the incentives at the UI Frontend.
+   *                                     Must follow Chainlink Aggregator IEACAggregatorProxy interface to be compatible.
    */
   function configureAssets(RewardsDataTypes.RewardsConfigInput[] memory config) external;

@@ -3615,7 +3536,7 @@ interface IRewardsController is IRewardsDistributor {
   ) external returns (address[] memory rewardsList, uint256[] memory claimedAmounts);
 }

-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/helpers/UiIncentiveDataProviderV3.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/helpers/UiIncentiveDataProviderV3.sol

 contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
   using UserConfiguration for DataTypes.UserConfigurationMap;
@@ -3913,10 +3834,10 @@ contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
           rewardInformation.rewardOracleAddress = aTokenIncentiveController.getRewardOracle(
             rewardInformation.rewardTokenAddress
           );
-          rewardInformation.priceFeedDecimals = AggregatorInterface(
+          rewardInformation.priceFeedDecimals = IEACAggregatorProxy(
             rewardInformation.rewardOracleAddress
           ).decimals();
-          rewardInformation.rewardPriceFeed = AggregatorInterface(
+          rewardInformation.rewardPriceFeed = IEACAggregatorProxy(
             rewardInformation.rewardOracleAddress
           ).latestAnswer();

@@ -3967,10 +3888,10 @@ contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
           rewardInformation.rewardOracleAddress = vTokenIncentiveController.getRewardOracle(
             rewardInformation.rewardTokenAddress
           );
-          rewardInformation.priceFeedDecimals = AggregatorInterface(
+          rewardInformation.priceFeedDecimals = IEACAggregatorProxy(
             rewardInformation.rewardOracleAddress
           ).decimals();
-          rewardInformation.rewardPriceFeed = AggregatorInterface(
+          rewardInformation.rewardPriceFeed = IEACAggregatorProxy(
             rewardInformation.rewardOracleAddress
           ).latestAnswer();

@@ -4047,10 +3968,10 @@ contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
           userRewardInformation.rewardOracleAddress = aTokenIncentiveController.getRewardOracle(
             userRewardInformation.rewardTokenAddress
           );
-          userRewardInformation.priceFeedDecimals = AggregatorInterface(
+          userRewardInformation.priceFeedDecimals = IEACAggregatorProxy(
             userRewardInformation.rewardOracleAddress
           ).decimals();
-          userRewardInformation.rewardPriceFeed = AggregatorInterface(
+          userRewardInformation.rewardPriceFeed = IEACAggregatorProxy(
             userRewardInformation.rewardOracleAddress
           ).latestAnswer();

@@ -4100,10 +4021,10 @@ contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
           userRewardInformation.rewardOracleAddress = vTokenIncentiveController.getRewardOracle(
             userRewardInformation.rewardTokenAddress
           );
-          userRewardInformation.priceFeedDecimals = AggregatorInterface(
+          userRewardInformation.priceFeedDecimals = IEACAggregatorProxy(
             userRewardInformation.rewardOracleAddress
           ).decimals();
-          userRewardInformation.rewardPriceFeed = AggregatorInterface(
+          userRewardInformation.rewardPriceFeed = IEACAggregatorProxy(
             userRewardInformation.rewardOracleAddress
           ).latestAnswer();

```
