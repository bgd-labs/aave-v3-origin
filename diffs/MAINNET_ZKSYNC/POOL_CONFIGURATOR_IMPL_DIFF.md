```diff
diff --git a/./downloads/MAINNET/POOL_CONFIGURATOR_IMPL.sol b/./downloads/ZKSYNC/POOL_CONFIGURATOR_IMPL.sol
index 4d13939..ff9e514 100644
--- a/./downloads/MAINNET/POOL_CONFIGURATOR_IMPL.sol
+++ b/./downloads/ZKSYNC/POOL_CONFIGURATOR_IMPL.sol
@@ -5104,7 +5104,7 @@ abstract contract PoolConfigurator is VersionedInitializable, IPoolConfigurator
   }
 }
 
-// downloads/MAINNET/POOL_CONFIGURATOR_IMPL/PoolConfiguratorInstance/lib/aave-v3-origin/src/core/instances/PoolConfiguratorInstance.sol
+// downloads/ZKSYNC/POOL_CONFIGURATOR_IMPL/PoolConfiguratorInstance/src/core/instances/PoolConfiguratorInstance.sol
 
 contract PoolConfiguratorInstance is PoolConfigurator {
   uint256 public constant CONFIGURATOR_REVISION = 3;
```
