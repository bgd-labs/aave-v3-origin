```diff
diff --git a/./downloads/SONEIUM/POOL_ADDRESSES_PROVIDER_REGISTRY.sol b/./downloads/LINEA/POOL_ADDRESSES_PROVIDER_REGISTRY.sol
index f86e606..e7d734f 100644
--- a/./downloads/SONEIUM/POOL_ADDRESSES_PROVIDER_REGISTRY.sol
+++ b/./downloads/LINEA/POOL_ADDRESSES_PROVIDER_REGISTRY.sol
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/SONEIUM/POOL_ADDRESSES_PROVIDER_REGISTRY/src/contracts/dependencies/openzeppelin/contracts/Context.sol
+// downloads/LINEA/POOL_ADDRESSES_PROVIDER_REGISTRY/PoolAddressesProviderRegistry/src/contracts/dependencies/openzeppelin/contracts/Context.sol
 
 /*
  * @dev Provides information about the current execution context, including the
@@ -24,7 +24,7 @@ abstract contract Context {
   }
 }
 
-// downloads/SONEIUM/POOL_ADDRESSES_PROVIDER_REGISTRY/src/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/POOL_ADDRESSES_PROVIDER_REGISTRY/PoolAddressesProviderRegistry/src/contracts/protocol/libraries/helpers/Errors.sol
 
 /**
  * @title Errors library
@@ -125,13 +125,9 @@ library Errors {
   string public constant INVALID_GRACE_PERIOD = '98'; // Grace period above a valid range
   string public constant INVALID_FREEZE_STATE = '99'; // Reserve is already in the passed freeze state
   string public constant NOT_BORROWABLE_IN_EMODE = '100'; // Asset not borrowable in eMode
-  string public constant CALLER_NOT_UMBRELLA = '101'; // The caller of the function is not the umbrella contract
-  string public constant RESERVE_NOT_IN_DEFICIT = '102'; // The reserve is not in deficit
-  string public constant MUST_NOT_LEAVE_DUST = '103'; // Below a certain threshold liquidators need to take the full position
-  string public constant USER_CANNOT_HAVE_DEBT = '104'; // Thrown when a user tries to interact with a method that requires a position without debt
 }
 
-// downloads/SONEIUM/POOL_ADDRESSES_PROVIDER_REGISTRY/src/contracts/interfaces/IPoolAddressesProviderRegistry.sol
+// downloads/LINEA/POOL_ADDRESSES_PROVIDER_REGISTRY/PoolAddressesProviderRegistry/src/contracts/interfaces/IPoolAddressesProviderRegistry.sol
 
 /**
  * @title IPoolAddressesProviderRegistry
@@ -191,7 +187,7 @@ interface IPoolAddressesProviderRegistry {
   function unregisterAddressesProvider(address provider) external;
 }
 
-// downloads/SONEIUM/POOL_ADDRESSES_PROVIDER_REGISTRY/src/contracts/dependencies/openzeppelin/contracts/Ownable.sol
+// downloads/LINEA/POOL_ADDRESSES_PROVIDER_REGISTRY/PoolAddressesProviderRegistry/src/contracts/dependencies/openzeppelin/contracts/Ownable.sol
 
 /**
  * @dev Contract module which provides a basic access control mechanism, where
@@ -257,7 +253,7 @@ contract Ownable is Context {
   }
 }
 
-// downloads/SONEIUM/POOL_ADDRESSES_PROVIDER_REGISTRY/src/contracts/protocol/configuration/PoolAddressesProviderRegistry.sol
+// downloads/LINEA/POOL_ADDRESSES_PROVIDER_REGISTRY/PoolAddressesProviderRegistry/src/contracts/protocol/configuration/PoolAddressesProviderRegistry.sol
 
 /**
  * @title PoolAddressesProviderRegistry
```
