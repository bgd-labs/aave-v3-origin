```diff
diff --git a/./downloads/MAINNET/POOL_ADDRESSES_PROVIDER.sol b/./downloads/ZKSYNC/POOL_ADDRESSES_PROVIDER.sol
index f6ec86b..7b370c5 100644
--- a/./downloads/MAINNET/POOL_ADDRESSES_PROVIDER.sol
+++ b/./downloads/ZKSYNC/POOL_ADDRESSES_PROVIDER.sol

-// downloads/MAINNET/POOL_ADDRESSES_PROVIDER/PoolAddressesProvider/@aave/core-v3/contracts/dependencies/openzeppelin/upgradeability/Proxy.sol
+// downloads/ZKSYNC/POOL_ADDRESSES_PROVIDER/PoolAddressesProvider/src/core/contracts/dependencies/openzeppelin/upgradeability/Proxy.sol

 /**
  * @title Proxy
@@ -104,6 +263,14 @@ abstract contract Proxy {
     _fallback();
   }

+  /**
+   * @dev Fallback function that will run if call data is empty.
+   * IMPORTANT. receive() on implementation contracts will be unreachable
+   */
+  receive() external payable {
+    _fallback();
+  }
+
   /**
    * @return The Address of the implementation.
    */
@@ -158,7 +325,7 @@ abstract contract Proxy {
   }
 }

-// downloads/MAINNET/POOL_ADDRESSES_PROVIDER/PoolAddressesProvider/@aave/core-v3/contracts/protocol/libraries/aave-upgradeability/BaseImmutableAdminUpgradeabilityProxy.sol
+// downloads/ZKSYNC/POOL_ADDRESSES_PROVIDER/PoolAddressesProvider/src/core/contracts/protocol/libraries/aave-upgradeability/BaseImmutableAdminUpgradeabilityProxy.sol

 /**
  * @title BaseImmutableAdminUpgradeabilityProxy
@@ -558,10 +725,10 @@ contract BaseImmutableAdminUpgradeabilityProxy is BaseUpgradeabilityProxy {

   /**
    * @dev Constructor.
-   * @param admin The address of the admin
+   * @param admin_ The address of the admin
    */
-  constructor(address admin) {
-    _admin = admin;
+  constructor(address admin_) {
+    _admin = admin_;
   }

   modifier ifAdmin() {
@@ -624,7 +791,7 @@ contract BaseImmutableAdminUpgradeabilityProxy is BaseUpgradeabilityProxy {
   }
 }
```
