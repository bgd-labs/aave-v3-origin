```diff
diff --git a/./downloads/ARBITRUM/POOL_ADDRESSES_PROVIDER.sol b/./downloads/LINEA/POOL_ADDRESSES_PROVIDER.sol
index 9478e36..7a14597 100644
--- a/./downloads/ARBITRUM/POOL_ADDRESSES_PROVIDER.sol
+++ b/./downloads/LINEA/POOL_ADDRESSES_PROVIDER.sol

-// downloads/ARBITRUM/POOL_ADDRESSES_PROVIDER/PoolAddressesProvider/@aave/core-v3/contracts/dependencies/openzeppelin/upgradeability/Proxy.sol
+// downloads/LINEA/POOL_ADDRESSES_PROVIDER/PoolAddressesProvider/src/contracts/dependencies/openzeppelin/upgradeability/Proxy.sol

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
@@ -158,13 +325,13 @@ abstract contract Proxy {
   }
 }

-// downloads/ARBITRUM/POOL_ADDRESSES_PROVIDER/PoolAddressesProvider/@aave/core-v3/contracts/protocol/libraries/aave-upgradeability/BaseImmutableAdminUpgradeabilityProxy.sol
+// downloads/LINEA/POOL_ADDRESSES_PROVIDER/PoolAddressesProvider/src/contracts/misc/aave-upgradeability/BaseImmutableAdminUpgradeabilityProxy.sol

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

-// downloads/ARBITRUM/POOL_ADDRESSES_PROVIDER/PoolAddressesProvider/@aave/core-v3/contracts/protocol/configuration/PoolAddressesProvider.sol
+// downloads/LINEA/POOL_ADDRESSES_PROVIDER/PoolAddressesProvider/src/contracts/protocol/configuration/PoolAddressesProvider.sol

 /**
  * @title PoolAddressesProvider
@@ -657,7 +824,7 @@ contract InitializableImmutableAdminUpgradeabilityProxy is
  * @notice Main registry of addresses part of or connected to the protocol, including permissioned roles
  * @dev Acts as factory of proxies and admin of those, so with right to change its implementations
  * @dev Owned by the Aave Governance
- **/
+ */
 contract PoolAddressesProvider is Ownable, IPoolAddressesProvider {
   // Identifier of the Aave Market
   string private _marketId;
@@ -809,7 +976,7 @@ contract PoolAddressesProvider is Ownable, IPoolAddressesProvider {
    *   calls the initialize() function via upgradeToAndCall() in the proxy
    * @param id The id of the proxy to be updated
    * @param newAddress The address of the new implementation
-   **/
+   */
   function _updateImpl(bytes32 id, address newAddress) internal {
     address proxyAddress = _addresses[id];
     InitializableImmutableAdminUpgradeabilityProxy proxy;
@@ -829,7 +996,7 @@ contract PoolAddressesProvider is Ownable, IPoolAddressesProvider {
   /**
    * @notice Updates the identifier of the Aave market.
    * @param newMarketId The new id of the market
-   **/
+   */
   function _setMarketId(string memory newMarketId) internal {
     string memory oldMarketId = _marketId;
     _marketId = newMarketId;
```
