```diff
diff --git a/./downloads/MAINNET/EMISSION_MANAGER.sol b/./downloads/ZKSYNC/EMISSION_MANAGER.sol
index 0f66685..16d9cb7 100644
--- a/./downloads/MAINNET/EMISSION_MANAGER.sol
+++ b/./downloads/ZKSYNC/EMISSION_MANAGER.sol
@@ -1,30 +1,7 @@
-// SPDX-License-Identifier: AGPL-3.0
-pragma solidity =0.8.10 ^0.8.10;
+// SPDX-License-Identifier: BUSL-1.1
+pragma solidity ^0.8.10;
 
-// downloads/MAINNET/EMISSION_MANAGER/EmissionManager/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/Context.sol
-
-/*
- * @dev Provides information about the current execution context, including the
- * sender of the transaction and its data. While these are generally available
- * via msg.sender and msg.data, they should not be accessed in such a direct
- * manner, since when dealing with GSN meta-transactions the account sending and
- * paying for execution may not be the actual sender (as far as an application
- * is concerned).
- *
- * This contract is only required for intermediate, library-like contracts.
- */
-abstract contract Context {
-  function _msgSender() internal view virtual returns (address payable) {
-    return payable(msg.sender);
-  }
-
-  function _msgData() internal view virtual returns (bytes memory) {
-    this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
-    return msg.data;
-  }
-}
-
-// downloads/MAINNET/EMISSION_MANAGER/EmissionManager/@aave/periphery-v3/contracts/misc/interfaces/IEACAggregatorProxy.sol
+// downloads/ZKSYNC/EMISSION_MANAGER/EmissionManager/src/periphery/contracts/misc/interfaces/IEACAggregatorProxy.sol
 
 interface IEACAggregatorProxy {
   function decimals() external view returns (uint8);
@@ -43,7 +20,7 @@ interface IEACAggregatorProxy {
   event NewRound(uint256 indexed roundId, address indexed startedBy);
 }
 
-// downloads/MAINNET/EMISSION_MANAGER/EmissionManager/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsDistributor.sol
+// downloads/ZKSYNC/EMISSION_MANAGER/EmissionManager/src/periphery/contracts/rewards/interfaces/IRewardsDistributor.sol
 
 /**
  * @title IRewardsDistributor
@@ -220,7 +197,7 @@ interface IRewardsDistributor {
   function getEmissionManager() external view returns (address);
 }
 
-// downloads/MAINNET/EMISSION_MANAGER/EmissionManager/@aave/periphery-v3/contracts/rewards/interfaces/ITransferStrategyBase.sol
+// downloads/ZKSYNC/EMISSION_MANAGER/EmissionManager/src/periphery/contracts/rewards/interfaces/ITransferStrategyBase.sol
 
 interface ITransferStrategyBase {
   event EmergencyWithdrawal(
@@ -258,7 +235,30 @@ interface ITransferStrategyBase {
   function emergencyWithdrawal(address token, address to, uint256 amount) external;
 }
 
-// downloads/MAINNET/EMISSION_MANAGER/EmissionManager/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/Ownable.sol
+// src/core/contracts/dependencies/openzeppelin/contracts/Context.sol
+
+/*
+ * @dev Provides information about the current execution context, including the
+ * sender of the transaction and its data. While these are generally available
+ * via msg.sender and msg.data, they should not be accessed in such a direct
+ * manner, since when dealing with GSN meta-transactions the account sending and
+ * paying for execution may not be the actual sender (as far as an application
+ * is concerned).
+ *
+ * This contract is only required for intermediate, library-like contracts.
+ */
+abstract contract Context {
+  function _msgSender() internal view virtual returns (address payable) {
+    return payable(msg.sender);
+  }
+
+  function _msgData() internal view virtual returns (bytes memory) {
+    this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
+    return msg.data;
+  }
+}
+
+// src/core/contracts/dependencies/openzeppelin/contracts/Ownable.sol
 
 /**
  * @dev Contract module which provides a basic access control mechanism, where
@@ -324,7 +324,7 @@ contract Ownable is Context {
   }
 }
 
-// downloads/MAINNET/EMISSION_MANAGER/EmissionManager/@aave/periphery-v3/contracts/rewards/libraries/RewardsDataTypes.sol
+// downloads/ZKSYNC/EMISSION_MANAGER/EmissionManager/src/periphery/contracts/rewards/libraries/RewardsDataTypes.sol
 
 library RewardsDataTypes {
   struct RewardsConfigInput {
@@ -375,7 +375,7 @@ library RewardsDataTypes {
   }
 }
 
-// downloads/MAINNET/EMISSION_MANAGER/EmissionManager/@aave/periphery-v3/contracts/rewards/interfaces/IRewardsController.sol
+// downloads/ZKSYNC/EMISSION_MANAGER/EmissionManager/src/periphery/contracts/rewards/interfaces/IRewardsController.sol
 
 /**
  * @title IRewardsController
@@ -573,7 +573,7 @@ interface IRewardsController is IRewardsDistributor {
   ) external returns (address[] memory rewardsList, uint256[] memory claimedAmounts);
 }
 
-// downloads/MAINNET/EMISSION_MANAGER/EmissionManager/@aave/periphery-v3/contracts/rewards/interfaces/IEmissionManager.sol
+// downloads/ZKSYNC/EMISSION_MANAGER/EmissionManager/src/periphery/contracts/rewards/interfaces/IEmissionManager.sol
 
 /**
  * @title IEmissionManager
@@ -686,7 +686,7 @@ interface IEmissionManager {
   function getEmissionAdmin(address reward) external view returns (address);
 }
 
-// downloads/MAINNET/EMISSION_MANAGER/EmissionManager/@aave/periphery-v3/contracts/rewards/EmissionManager.sol
+// downloads/ZKSYNC/EMISSION_MANAGER/EmissionManager/src/periphery/contracts/rewards/EmissionManager.sol
 
 /**
  * @title EmissionManager
```
