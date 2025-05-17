```diff
diff --git a/./downloads/SONEIUM/ACL_MANAGER.sol b/./downloads/LINEA/ACL_MANAGER.sol
index 9208e13..920985b 100644
--- a/./downloads/SONEIUM/ACL_MANAGER.sol
+++ b/./downloads/LINEA/ACL_MANAGER.sol
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/SONEIUM/ACL_MANAGER/src/contracts/dependencies/openzeppelin/contracts/Context.sol
+// downloads/LINEA/ACL_MANAGER/ACLManager/src/contracts/dependencies/openzeppelin/contracts/Context.sol
 
 /*
  * @dev Provides information about the current execution context, including the
@@ -24,7 +24,7 @@ abstract contract Context {
   }
 }
 
-// downloads/SONEIUM/ACL_MANAGER/src/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/ACL_MANAGER/ACLManager/src/contracts/protocol/libraries/helpers/Errors.sol
 
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
 
-// downloads/SONEIUM/ACL_MANAGER/src/contracts/dependencies/openzeppelin/contracts/IAccessControl.sol
+// downloads/LINEA/ACL_MANAGER/ACLManager/src/contracts/dependencies/openzeppelin/contracts/IAccessControl.sol
 
 /**
  * @dev External interface of AccessControl declared to support ERC165 detection.
@@ -221,7 +217,7 @@ interface IAccessControl {
   function renounceRole(bytes32 role, address account) external;
 }
 
-// downloads/SONEIUM/ACL_MANAGER/src/contracts/dependencies/openzeppelin/contracts/IERC165.sol
+// downloads/LINEA/ACL_MANAGER/ACLManager/src/contracts/dependencies/openzeppelin/contracts/IERC165.sol
 
 /**
  * @dev Interface of the ERC165 standard, as defined in the
@@ -244,7 +240,7 @@ interface IERC165 {
   function supportsInterface(bytes4 interfaceId) external view returns (bool);
 }
 
-// downloads/SONEIUM/ACL_MANAGER/src/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/ACL_MANAGER/ACLManager/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -471,7 +467,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/SONEIUM/ACL_MANAGER/src/contracts/dependencies/openzeppelin/contracts/Strings.sol
+// downloads/LINEA/ACL_MANAGER/ACLManager/src/contracts/dependencies/openzeppelin/contracts/Strings.sol
 
 /**
  * @dev String operations.
@@ -536,7 +532,7 @@ library Strings {
   }
 }
 
-// downloads/SONEIUM/ACL_MANAGER/src/contracts/dependencies/openzeppelin/contracts/ERC165.sol
+// downloads/LINEA/ACL_MANAGER/ACLManager/src/contracts/dependencies/openzeppelin/contracts/ERC165.sol
 
 /**
  * @dev Implementation of the {IERC165} interface.
@@ -561,7 +557,7 @@ abstract contract ERC165 is IERC165 {
   }
 }
 
-// downloads/SONEIUM/ACL_MANAGER/src/contracts/interfaces/IACLManager.sol
+// downloads/LINEA/ACL_MANAGER/ACLManager/src/contracts/interfaces/IACLManager.sol
 
 /**
  * @title IACLManager
@@ -734,7 +730,7 @@ interface IACLManager {
   function isAssetListingAdmin(address admin) external view returns (bool);
 }
 
-// downloads/SONEIUM/ACL_MANAGER/src/contracts/dependencies/openzeppelin/contracts/AccessControl.sol
+// downloads/LINEA/ACL_MANAGER/ACLManager/src/contracts/dependencies/openzeppelin/contracts/AccessControl.sol
 
 /**
  * @dev Contract module that allows children to implement role-based access
@@ -944,7 +940,7 @@ abstract contract AccessControl is Context, IAccessControl, ERC165 {
   }
 }
 
-// downloads/SONEIUM/ACL_MANAGER/src/contracts/protocol/configuration/ACLManager.sol
+// downloads/LINEA/ACL_MANAGER/ACLManager/src/contracts/protocol/configuration/ACLManager.sol
 
 /**
  * @title ACLManager
```
