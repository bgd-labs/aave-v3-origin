```diff
diff --git a/./downloads/ARBITRUM/CONFIGURATOR_LOGIC.sol b/./downloads/LINEA/CONFIGURATOR_LOGIC.sol
index b92a1a1..22e067d 100644
--- a/./downloads/ARBITRUM/CONFIGURATOR_LOGIC.sol
+++ b/./downloads/LINEA/CONFIGURATOR_LOGIC.sol

-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/protocol/libraries/logic/ConfiguratorLogic.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/protocol/libraries/logic/ConfiguratorLogic.sol

 /**
  * @title ConfiguratorLogic library
@@ -2917,11 +2862,6 @@ library ConfiguratorLogic {
     address indexed proxy,
     address indexed implementation
   );
-  event StableDebtTokenUpgraded(
-    address indexed asset,
-    address indexed proxy,
-    address indexed implementation
-  );
   event VariableDebtTokenUpgraded(
     address indexed asset,
     address indexed proxy,
@@ -2929,7 +2869,7 @@ library ConfiguratorLogic {
   );

   /**
-   * @notice Initialize a reserve by creating and initializing aToken, stable debt token and variable debt token
+   * @notice Initialize a reserve by creating and initializing aToken and variable debt token
    * @dev Emits the `ReserveInitialized` event
    * @param pool The Pool in which the reserve will be initialized
    * @param input The needed parameters for the initialization
@@ -2957,20 +2897,6 @@ library ConfiguratorLogic {
       )
     );

-    address stableDebtTokenProxyAddress = _initTokenWithProxy(
-      input.stableDebtTokenImpl,
-      abi.encodeWithSelector(
-        IInitializableDebtToken.initialize.selector,
-        pool,
-        input.underlyingAsset,
-        input.incentivesController,
-        underlyingAssetDecimals,
-        input.stableDebtTokenName,
-        input.stableDebtTokenSymbol,
-        input.params
-      )
-    );
-
     address variableDebtTokenProxyAddress = _initTokenWithProxy(
       input.variableDebtTokenImpl,
       abi.encodeWithSelector(
@@ -2988,7 +2914,6 @@ library ConfiguratorLogic {
     pool.initReserve(
       input.underlyingAsset,
       aTokenProxyAddress,
-      stableDebtTokenProxyAddress,
       variableDebtTokenProxyAddress,
       input.interestRateStrategyAddress
     );
@@ -3012,7 +2937,7 @@ library ConfiguratorLogic {
     emit ReserveInitialized(
       input.underlyingAsset,
       aTokenProxyAddress,
-      stableDebtTokenProxyAddress,
+      address(0),
       variableDebtTokenProxyAddress,
       input.interestRateStrategyAddress
     );
@@ -3030,7 +2955,7 @@ library ConfiguratorLogic {
   ) external {
     DataTypes.ReserveDataLegacy memory reserveData = cachedPool.getReserveData(input.asset);

-    (, , , uint256 decimals, , ) = cachedPool.getConfiguration(input.asset).getParams();
+    (, , , uint256 decimals, ) = cachedPool.getConfiguration(input.asset).getParams();

     bytes memory encodedCall = abi.encodeWithSelector(
       IInitializableAToken.initialize.selector,
@@ -3049,44 +2974,6 @@ library ConfiguratorLogic {
     emit ATokenUpgraded(input.asset, reserveData.aTokenAddress, input.implementation);
   }

-  /**
-   * @notice Updates the stable debt token implementation and initializes it
-   * @dev Emits the `StableDebtTokenUpgraded` event
-   * @param cachedPool The Pool containing the reserve with the stable debt token
-   * @param input The parameters needed for the initialize call
-   */
-  function executeUpdateStableDebtToken(
-    IPool cachedPool,
-    ConfiguratorInputTypes.UpdateDebtTokenInput calldata input
-  ) external {
-    DataTypes.ReserveDataLegacy memory reserveData = cachedPool.getReserveData(input.asset);
-
-    (, , , uint256 decimals, , ) = cachedPool.getConfiguration(input.asset).getParams();
-
-    bytes memory encodedCall = abi.encodeWithSelector(
-      IInitializableDebtToken.initialize.selector,
-      cachedPool,
-      input.asset,
-      input.incentivesController,
-      decimals,
-      input.name,
-      input.symbol,
-      input.params
-    );
-
-    _upgradeTokenImplementation(
-      reserveData.stableDebtTokenAddress,
-      input.implementation,
-      encodedCall
-    );
-
-    emit StableDebtTokenUpgraded(
-      input.asset,
-      reserveData.stableDebtTokenAddress,
-      input.implementation
-    );
-  }
-
   /**
    * @notice Updates the variable debt token implementation and initializes it
    * @dev Emits the `VariableDebtTokenUpgraded` event
@@ -3099,7 +2986,7 @@ library ConfiguratorLogic {
   ) external {
     DataTypes.ReserveDataLegacy memory reserveData = cachedPool.getReserveData(input.asset);

-    (, , , uint256 decimals, , ) = cachedPool.getConfiguration(input.asset).getParams();
+    (, , , uint256 decimals, ) = cachedPool.getConfiguration(input.asset).getParams();

     bytes memory encodedCall = abi.encodeWithSelector(
       IInitializableDebtToken.initialize.selector,
```
