```diff
diff --git a/./downloads/MAINNET/UI_INCENTIVE_DATA_PROVIDER.sol b/./downloads/ZKSYNC/UI_INCENTIVE_DATA_PROVIDER.sol
index df8b21f..8a55fee 100644
--- a/./downloads/MAINNET/UI_INCENTIVE_DATA_PROVIDER.sol
+++ b/./downloads/ZKSYNC/UI_INCENTIVE_DATA_PROVIDER.sol

-// downloads/MAINNET/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/@aave/core-v3/contracts/protocol/tokenization/base/IncentivizedERC20.sol
+// src/core/contracts/protocol/tokenization/base/IncentivizedERC20.sol

 /**
  * @title IncentivizedERC20
@@ -3464,15 +3644,15 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
   /**
    * @dev Constructor.
    * @param pool The reference to the main Pool contract
-   * @param name The name of the token
-   * @param symbol The symbol of the token
-   * @param decimals The number of decimals of the token
+   * @param name_ The name of the token
+   * @param symbol_ The symbol of the token
+   * @param decimals_ The number of decimals of the token
    */
-  constructor(IPool pool, string memory name, string memory symbol, uint8 decimals) {
+  constructor(IPool pool, string memory name_, string memory symbol_, uint8 decimals_) {
     _addressesProvider = pool.ADDRESSES_PROVIDER();
-    _name = name;
-    _symbol = symbol;
-    _decimals = decimals;
+    _name = name_;
+    _symbol = symbol_;
+    _decimals = decimals_;
     POOL = pool;
   }

@@ -3633,7 +3813,7 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
   }
 }

-// downloads/MAINNET/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/@aave/periphery-v3/contracts/misc/UiIncentiveDataProviderV3.sol
+// downloads/ZKSYNC/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/periphery/contracts/misc/UiIncentiveDataProviderV3.sol

 contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
   using UserConfiguration for DataTypes.UserConfigurationMap;
@@ -3668,7 +3848,7 @@ contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
       AggregatedReserveIncentiveData memory reserveIncentiveData = reservesIncentiveData[i];
       reserveIncentiveData.underlyingAsset = reserves[i];

-      DataTypes.ReserveData memory baseData = pool.getReserveData(reserves[i]);
+      DataTypes.ReserveDataLegacy memory baseData = pool.getReserveData(reserves[i]);

       // Get aTokens rewards information
       // TODO: check that this is deployed correctly on contract and remove casting
@@ -3730,12 +3910,11 @@ contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
       IRewardsController vTokenIncentiveController = IRewardsController(
         address(IncentivizedERC20(baseData.variableDebtTokenAddress).getIncentivesController())
       );
-      address[] memory vTokenRewardAddresses = vTokenIncentiveController.getRewardsByAsset(
-        baseData.variableDebtTokenAddress
-      );
       RewardInfo[] memory vRewardsInformation;
-
       if (address(vTokenIncentiveController) != address(0)) {
+        address[] memory vTokenRewardAddresses = vTokenIncentiveController.getRewardsByAsset(
+          baseData.variableDebtTokenAddress
+        );
         vRewardsInformation = new RewardInfo[](vTokenRewardAddresses.length);
         for (uint256 j = 0; j < vTokenRewardAddresses.length; ++j) {
           RewardInfo memory rewardInformation;
@@ -3785,12 +3964,11 @@ contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
       IRewardsController sTokenIncentiveController = IRewardsController(
         address(IncentivizedERC20(baseData.stableDebtTokenAddress).getIncentivesController())
       );
-      address[] memory sTokenRewardAddresses = sTokenIncentiveController.getRewardsByAsset(
-        baseData.stableDebtTokenAddress
-      );
       RewardInfo[] memory sRewardsInformation;
-
       if (address(sTokenIncentiveController) != address(0)) {
+        address[] memory sTokenRewardAddresses = sTokenIncentiveController.getRewardsByAsset(
+          baseData.stableDebtTokenAddress
+        );
         sRewardsInformation = new RewardInfo[](sTokenRewardAddresses.length);
         for (uint256 j = 0; j < sTokenRewardAddresses.length; ++j) {
           RewardInfo memory rewardInformation;
@@ -3859,7 +4037,7 @@ contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
     );

     for (uint256 i = 0; i < reserves.length; i++) {
-      DataTypes.ReserveData memory baseData = pool.getReserveData(reserves[i]);
+      DataTypes.ReserveDataLegacy memory baseData = pool.getReserveData(reserves[i]);

       // user reserve data
       userReservesIncentivesData[i].underlyingAsset = reserves[i];
```
