```diff
diff --git a/./downloads/SONEIUM/L2_ENCODER.sol b/./downloads/LINEA/L2_ENCODER.sol
index 092448b..4037e0d 100644
--- a/./downloads/SONEIUM/L2_ENCODER.sol
+++ b/./downloads/LINEA/L2_ENCODER.sol
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/SONEIUM/L2_ENCODER/src/contracts/protocol/libraries/types/DataTypes.sol
+// downloads/LINEA/L2_ENCODER/L2Encoder/src/contracts/protocol/libraries/types/DataTypes.sol
 
 library DataTypes {
   /**
@@ -52,9 +52,8 @@ library DataTypes {
     uint128 variableBorrowIndex;
     //the current variable borrow rate. Expressed in ray
     uint128 currentVariableBorrowRate;
-    /// @notice reused `__deprecatedStableBorrowRate` storage from pre 3.2
-    // the current accumulate deficit in underlying tokens
-    uint128 deficit;
+    // DEPRECATED on v3.2.0
+    uint128 __deprecatedStableBorrowRate;
     //timestamp of last update
     uint40 lastUpdateTimestamp;
     //the id of the reserve. Represents the position in the list of the active reserves
@@ -220,11 +219,6 @@ library DataTypes {
     uint8 userEModeCategory;
   }
 
-  struct ExecuteEliminateDeficitParams {
-    address asset;
-    uint256 amount;
-  }
-
   struct ExecuteSetUserEModeParams {
     uint256 reservesCount;
     address oracle;
@@ -331,7 +325,7 @@ library DataTypes {
   }
 }
 
-// downloads/SONEIUM/L2_ENCODER/src/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/L2_ENCODER/L2Encoder/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -558,7 +552,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/SONEIUM/L2_ENCODER/src/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
+// downloads/LINEA/L2_ENCODER/L2Encoder/src/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
 
 // OpenZeppelin Contracts v4.4.1 (utils/math/SafeCast.sol)
 
@@ -814,7 +808,7 @@ library SafeCast {
   }
 }
 
-// downloads/SONEIUM/L2_ENCODER/src/contracts/interfaces/IPool.sol
+// downloads/LINEA/L2_ENCODER/L2Encoder/src/contracts/interfaces/IPool.sol
 
 /**
  * @title IPool
@@ -997,14 +991,6 @@ interface IPool {
     uint256 variableBorrowIndex
   );
 
-  /**
-   * @dev Emitted when the deficit of a reserve is covered.
-   * @param reserve The address of the underlying asset of the reserve
-   * @param caller The caller that triggered the DeficitCovered event
-   * @param amountCovered The amount of deficit covered
-   */
-  event DeficitCovered(address indexed reserve, address caller, uint256 amountCovered);
-
   /**
    * @dev Emitted when the protocol treasury receives minted aTokens from the accrued interest.
    * @param reserve The address of the reserve
@@ -1012,14 +998,6 @@ interface IPool {
    */
   event MintedToTreasury(address indexed reserve, uint256 amountMinted);
 
-  /**
-   * @dev Emitted when deficit is realized on a liquidation.
-   * @param user The user address where the bad debt will be burned
-   * @param debtAsset The address of the underlying borrowed asset to be burned
-   * @param amountCreated The amount of deficit created
-   */
-  event DeficitCreated(address indexed user, address indexed debtAsset, uint256 amountCreated);
-
   /**
    * @notice Mints an `amount` of aTokens to the `onBehalfOf`
    * @param asset The address of the underlying asset to mint
@@ -1387,6 +1365,16 @@ interface IPool {
    */
   function getReserveData(address asset) external view returns (DataTypes.ReserveDataLegacy memory);
 
+  /**
+   * @notice Returns the state and configuration of the reserve, including extra data included with Aave v3.1
+   * @dev DEPRECATED use independent getters instead (getReserveData, getLiquidationGracePeriod)
+   * @param asset The address of the underlying asset of the reserve
+   * @return The state and configuration data of the reserve with virtual accounting
+   */
+  function getReserveDataExtended(
+    address asset
+  ) external view returns (DataTypes.ReserveData memory);
+
   /**
    * @notice Returns the virtual underlying balance of the reserve
    * @param asset The address of the underlying asset of the reserve
@@ -1561,7 +1549,7 @@ interface IPool {
    * @param asset The address of the underlying asset
    * @return Timestamp when the liquidation grace period will end
    **/
-  function getLiquidationGracePeriod(address asset) external view returns (uint40);
+  function getLiquidationGracePeriod(address asset) external returns (uint40);
 
   /**
    * @notice Returns the total fee on flash loans
@@ -1615,37 +1603,6 @@ interface IPool {
    */
   function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
 
-  /**
-   * @notice It covers the deficit of a specified reserve by burning:
-   * - the equivalent aToken `amount` for assets with virtual accounting enabled
-   * - the equivalent `amount` of underlying for assets with virtual accounting disabled (e.g. GHO)
-   * @dev The deficit of a reserve can occur due to situations where borrowed assets are not repaid, leading to bad debt.
-   * @param asset The address of the underlying asset to cover the deficit.
-   * @param amount The amount to be covered, in aToken or underlying on non-virtual accounted assets
-   */
-  function eliminateReserveDeficit(address asset, uint256 amount) external;
-
-  /**
-   * @notice Returns the current deficit of a reserve.
-   * @param asset The address of the underlying asset of the reserve
-   * @return The current deficit of the reserve
-   */
-  function getReserveDeficit(address asset) external view returns (uint256);
-
-  /**
-   * @notice Returns the aToken address of a reserve.
-   * @param asset The address of the underlying asset of the reserve
-   * @return The address of the aToken
-   */
-  function getReserveAToken(address asset) external view returns (address);
-
-  /**
-   * @notice Returns the variableDebtToken address of a reserve.
-   * @param asset The address of the underlying asset of the reserve
-   * @return The address of the variableDebtToken
-   */
-  function getReserveVariableDebtToken(address asset) external view returns (address);
-
   /**
    * @notice Gets the address of the external FlashLoanLogic
    */
@@ -1682,7 +1639,7 @@ interface IPool {
   function getSupplyLogic() external view returns (address);
 }
 
-// downloads/SONEIUM/L2_ENCODER/src/contracts/helpers/L2Encoder.sol
+// downloads/LINEA/L2_ENCODER/L2Encoder/src/contracts/helpers/L2Encoder.sol
 
 /**
  * @title L2Encoder
```
