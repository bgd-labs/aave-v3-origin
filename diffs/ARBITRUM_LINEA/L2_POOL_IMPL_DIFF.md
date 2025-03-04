```diff
diff --git a/./downloads/ARBITRUM/L2_POOL_IMPL.sol b/./downloads/LINEA/L2_POOL_IMPL.sol
index 50a2a4d..8f4817d 100644
--- a/./downloads/ARBITRUM/L2_POOL_IMPL.sol
+++ b/./downloads/LINEA/L2_POOL_IMPL.sol

-// downloads/ARBITRUM/L2_POOL_IMPL/L2PoolInstance/lib/aave-v3-origin/src/contracts/protocol/pool/Pool.sol
+// downloads/LINEA/L2_POOL_IMPL/L2PoolInstance/src/contracts/protocol/pool/Pool.sol

 /**
  * @title Pool contract
@@ -8137,7 +8137,7 @@ abstract contract Pool is VersionedInitializable, PoolStorage, IPool {
     res.isolationModeTotalDebt = reserve.isolationModeTotalDebt;
     // This is a temporary workaround for integrations that are broken by Aave 3.2
     // While the new pool data provider is backward compatible, some integrations hard-code an old implementation
-    // To allow them to unlock the funds, the pool address provider is setting a stable debt token, so balanceOf() and totalSupply() will return zero instead of reverting
+    // To allow them to not have any infrastructural blocker, a mock must be configured in the Aave Pool Addresses Provider, returning zero on all required view methods, instead of reverting
     res.stableDebtTokenAddress = ADDRESSES_PROVIDER.getAddress(bytes32('MOCK_STABLE_DEBT'));
     return res;
   }
@@ -8555,7 +8555,7 @@ abstract contract Pool is VersionedInitializable, PoolStorage, IPool {
   }
 }

```
