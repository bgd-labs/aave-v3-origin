```diff
diff --git a/./downloads/ARBITRUM/COLLECTOR_IMPL.sol b/./downloads/LINEA/COLLECTOR_IMPL.sol
index 752e048..80c907f 100644
--- a/./downloads/ARBITRUM/COLLECTOR_IMPL.sol
+++ b/./downloads/LINEA/COLLECTOR_IMPL.sol

-// downloads/ARBITRUM/COLLECTOR_IMPL/Collector/src/contracts/Collector.sol
+// downloads/LINEA/COLLECTOR_IMPL/Collector/src/contracts/treasury/Collector.sol

 /**
  * @title Collector
@@ -903,8 +782,6 @@ contract Collector is VersionedInitializable, ICollector, ReentrancyGuard {
       _nextStreamId = nextStreamId;
     }

-    // can be removed after first deployment
-    _initGuard();
     _setFundsAdmin(fundsAdmin);
   }

@@ -1021,9 +898,6 @@ contract Collector is VersionedInitializable, ICollector, ReentrancyGuard {
     }
   }

-  /// @dev needed in order to receive ETH from the Aave v1 ecosystem reserve
-  receive() external payable {}
-
   /// @inheritdoc ICollector
   function setFundsAdmin(address admin) external onlyFundsAdmin {
     _setFundsAdmin(admin);
```
