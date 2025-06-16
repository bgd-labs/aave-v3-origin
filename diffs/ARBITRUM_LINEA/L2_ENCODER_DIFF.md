```diff
diff --git a/./downloads/ARBITRUM/L2_ENCODER.sol b/./downloads/LINEA/L2_ENCODER.sol
index 9ab49b3..42a5580 100644
--- a/./downloads/ARBITRUM/L2_ENCODER.sol
+++ b/./downloads/LINEA/L2_ENCODER.sol

-// downloads/ARBITRUM/L2_ENCODER/L2Encoder/@aave/core-v3/contracts/misc/L2Encoder.sol
+// downloads/LINEA/L2_ENCODER/L2Encoder/src/contracts/helpers/L2Encoder.sol

 /**
  * @title L2Encoder
@@ -1512,7 +1673,7 @@ contract L2Encoder {
     uint256 amount,
     uint16 referralCode
   ) external view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);

     uint16 assetId = data.id;
     uint128 shortenedAmount = amount.toUint128();
@@ -1548,7 +1709,7 @@ contract L2Encoder {
     bytes32 permitR,
     bytes32 permitS
   ) external view returns (bytes32, bytes32, bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);

     uint16 assetId = data.id;
     uint128 shortenedAmount = amount.toUint128();
@@ -1576,7 +1737,7 @@ contract L2Encoder {
    * @return compact representation of withdraw parameters
    */
   function encodeWithdrawParams(address asset, uint256 amount) external view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);

     uint16 assetId = data.id;
     uint128 shortenedAmount = amount == type(uint256).max ? type(uint128).max : amount.toUint128();
@@ -1593,7 +1754,7 @@ contract L2Encoder {
    * @dev Without an onBehalfOf parameter as the compact calls to L2Pool will use msg.sender as onBehalfOf
    * @param asset The address of the underlying asset to borrow
    * @param amount The amount to be borrowed
-   * @param interestRateMode The interest rate mode at which the user wants to borrow: 1 for Stable, 2 for Variable
+   * @param interestRateMode The interest rate mode at which the user wants to borrow: 2 for Variable, 1 is deprecated (changed on v3.2.0)
    * @param referralCode The code used to register the integrator originating the operation, for potential rewards.
    *   0 if the action is executed directly by the user, without any middle-man
    * @return compact representation of withdraw parameters
@@ -1604,7 +1765,7 @@ contract L2Encoder {
     uint256 interestRateMode,
     uint16 referralCode
   ) external view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);

     uint16 assetId = data.id;
     uint128 shortenedAmount = amount.toUint128();
@@ -1628,7 +1789,7 @@ contract L2Encoder {
    * @param asset The address of the borrowed underlying asset previously borrowed
    * @param amount The amount to repay
    * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `interestRateMode`
-   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable
+   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 2 for Variable, 1 is deprecated (changed on v3.2.0)
    * @return compact representation of repay parameters
    */
   function encodeRepayParams(
@@ -1636,7 +1797,7 @@ contract L2Encoder {
     uint256 amount,
     uint256 interestRateMode
   ) public view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);

     uint16 assetId = data.id;
     uint128 shortenedAmount = amount == type(uint256).max ? type(uint128).max : amount.toUint128();
@@ -1655,7 +1816,7 @@ contract L2Encoder {
    * @param asset The address of the borrowed underlying asset previously borrowed
    * @param amount The amount to repay
    * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
-   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable
+   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 2 for Variable, 1 is deprecated (changed on v3.2.0)
    * @param deadline The deadline timestamp that the permit is valid
    * @param permitV The V parameter of ERC712 permit sig
    * @param permitR The R parameter of ERC712 permit sig
@@ -1673,7 +1834,7 @@ contract L2Encoder {
     bytes32 permitR,
     bytes32 permitS
   ) external view returns (bytes32, bytes32, bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);

     uint16 assetId = data.id;
     uint128 shortenedAmount = amount == type(uint256).max ? type(uint128).max : amount.toUint128();
@@ -1701,7 +1862,7 @@ contract L2Encoder {
    * @param asset The address of the borrowed underlying asset previously borrowed
    * @param amount The amount to repay
    * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
-   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable
+   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 2 for Variable, 1 is deprecated  (changed on v3.2.0)
    * @return compact representation of repay with aToken parameters
    */
   function encodeRepayWithATokensParams(
@@ -1712,46 +1873,6 @@ contract L2Encoder {
     return encodeRepayParams(asset, amount, interestRateMode);
   }

-  /**
-   * @notice Encodes swap borrow rate mode parameters from standard input to compact representation of 1 bytes32
-   * @param asset The address of the underlying asset borrowed
-   * @param interestRateMode The current interest rate mode of the position being swapped: 1 for Stable, 2 for Variable
-   * @return compact representation of swap borrow rate mode parameters
-   */
-  function encodeSwapBorrowRateMode(
-    address asset,
-    uint256 interestRateMode
-  ) external view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
-    uint16 assetId = data.id;
-    uint8 shortenedInterestRateMode = interestRateMode.toUint8();
-    bytes32 res;
-    assembly {
-      res := add(assetId, shl(16, shortenedInterestRateMode))
-    }
-    return res;
-  }
-
-  /**
-   * @notice Encodes rebalance stable borrow rate parameters from standard input to compact representation of 1 bytes32
-   * @param asset The address of the underlying asset borrowed
-   * @param user The address of the user to be rebalanced
-   * @return compact representation of rebalance stable borrow rate parameters
-   */
-  function encodeRebalanceStableBorrowRate(
-    address asset,
-    address user
-  ) external view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
-    uint16 assetId = data.id;
-
-    bytes32 res;
-    assembly {
-      res := add(assetId, shl(16, user))
-    }
-    return res;
-  }
-
   /**
    * @notice Encodes set user use reserve as collateral parameters from standard input to compact representation of 1 bytes32
    * @param asset The address of the underlying asset borrowed
@@ -1762,7 +1883,7 @@ contract L2Encoder {
     address asset,
     bool useAsCollateral
   ) external view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);
     uint16 assetId = data.id;
     bytes32 res;
     assembly {
@@ -1789,10 +1910,10 @@ contract L2Encoder {
     uint256 debtToCover,
     bool receiveAToken
   ) external view returns (bytes32, bytes32) {
-    DataTypes.ReserveData memory collateralData = POOL.getReserveData(collateralAsset);
+    DataTypes.ReserveDataLegacy memory collateralData = POOL.getReserveData(collateralAsset);
     uint16 collateralAssetId = collateralData.id;

-    DataTypes.ReserveData memory debtData = POOL.getReserveData(debtAsset);
+    DataTypes.ReserveDataLegacy memory debtData = POOL.getReserveData(debtAsset);
     uint16 debtAssetId = debtData.id;

     uint128 shortenedDebtToCover = debtToCover == type(uint256).max
```
