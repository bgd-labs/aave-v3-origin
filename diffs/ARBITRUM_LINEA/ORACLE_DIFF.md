```diff
diff --git a/./downloads/ARBITRUM/ORACLE.sol b/./downloads/LINEA/ORACLE.sol
index 4729969..9828b58 100644
--- a/./downloads/ARBITRUM/ORACLE.sol
+++ b/./downloads/LINEA/ORACLE.sol

-// downloads/ARBITRUM/ORACLE/AaveOracle/@aave/core-v3/contracts/misc/AaveOracle.sol
+// downloads/LINEA/ORACLE/AaveOracle/src/contracts/misc/AaveOracle.sol

 /**
  * @title AaveOracle
@@ -641,7 +644,7 @@ contract AaveOracle is IAaveOracle {

   /**
    * @dev Only asset listing or pool admin can call functions marked by this modifier.
-   **/
+   */
   modifier onlyAssetListingOrPoolAdmins() {
     _onlyAssetListingOrPoolAdmins();
     _;
```
