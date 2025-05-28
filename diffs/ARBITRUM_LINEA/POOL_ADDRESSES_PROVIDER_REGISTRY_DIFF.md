```diff
diff --git a/./downloads/ARBITRUM/POOL_ADDRESSES_PROVIDER_REGISTRY.sol b/./downloads/LINEA/POOL_ADDRESSES_PROVIDER_REGISTRY.sol
index b396e1f..8ab717f 100644
--- a/./downloads/ARBITRUM/POOL_ADDRESSES_PROVIDER_REGISTRY.sol
+++ b/./downloads/LINEA/POOL_ADDRESSES_PROVIDER_REGISTRY.sol

-// downloads/ARBITRUM/POOL_ADDRESSES_PROVIDER_REGISTRY/PoolAddressesProviderRegistry/@aave/core-v3/contracts/protocol/configuration/PoolAddressesProviderRegistry.sol
+// downloads/LINEA/POOL_ADDRESSES_PROVIDER_REGISTRY/PoolAddressesProviderRegistry/src/contracts/protocol/configuration/PoolAddressesProviderRegistry.sol

 /**
  * @title PoolAddressesProviderRegistry
@@ -258,7 +261,7 @@ contract Ownable is Context {
  * @notice Main registry of PoolAddressesProvider of Aave markets.
  * @dev Used for indexing purposes of Aave protocol's markets. The id assigned to a PoolAddressesProvider refers to the
  * market it is connected with, for example with `1` for the Aave main market and `2` for the next created.
- **/
+ */
 contract PoolAddressesProviderRegistry is Ownable, IPoolAddressesProviderRegistry {
   // Map of address provider ids (addressesProvider => id)
   mapping(address => uint256) private _addressesProviderToId;
```
