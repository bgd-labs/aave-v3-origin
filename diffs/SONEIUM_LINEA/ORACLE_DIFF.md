```diff
diff --git a/./downloads/SONEIUM/ORACLE.sol b/./downloads/LINEA/ORACLE.sol
index df71522..e493f8a 100644
--- a/./downloads/SONEIUM/ORACLE.sol
+++ b/./downloads/LINEA/ORACLE.sol
@@ -1,39 +1,11 @@
 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/SONEIUM/ORACLE/src/contracts/dependencies/chainlink/AggregatorInterface.sol
+// downloads/LINEA/ORACLE/AaveOracle/src/contracts/dependencies/chainlink/AggregatorInterface.sol
 
 // Chainlink Contracts v0.8
 
 interface AggregatorInterface {
-  function decimals() external view returns (uint8);
-
-  function description() external view returns (string memory);
-
-  function getRoundData(
-    uint80 _roundId
-  )
-    external
-    view
-    returns (
-      uint80 roundId,
-      int256 answer,
-      uint256 startedAt,
-      uint256 updatedAt,
-      uint80 answeredInRound
-    );
-
-  function latestRoundData()
-    external
-    view
-    returns (
-      uint80 roundId,
-      int256 answer,
-      uint256 startedAt,
-      uint256 updatedAt,
-      uint80 answeredInRound
-    );
-
   function latestAnswer() external view returns (int256);
 
   function latestTimestamp() external view returns (uint256);
@@ -49,7 +21,7 @@ interface AggregatorInterface {
   event NewRound(uint256 indexed roundId, address indexed startedBy, uint256 startedAt);
 }
 
-// downloads/SONEIUM/ORACLE/src/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/ORACLE/AaveOracle/src/contracts/protocol/libraries/helpers/Errors.sol
 
 /**
  * @title Errors library
@@ -150,13 +122,9 @@ library Errors {
   string public constant INVALID_GRACE_PERIOD = '98'; // Grace period above a valid range
   string public constant INVALID_FREEZE_STATE = '99'; // Reserve is already in the passed freeze state
   string public constant NOT_BORROWABLE_IN_EMODE = '100'; // Asset not borrowable in eMode
-  string public constant CALLER_NOT_UMBRELLA = '101'; // The caller of the function is not the umbrella contract
-  string public constant RESERVE_NOT_IN_DEFICIT = '102'; // The reserve is not in deficit
-  string public constant MUST_NOT_LEAVE_DUST = '103'; // Below a certain threshold liquidators need to take the full position
-  string public constant USER_CANNOT_HAVE_DEBT = '104'; // Thrown when a user tries to interact with a method that requires a position without debt
 }
 
-// downloads/SONEIUM/ORACLE/src/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/ORACLE/AaveOracle/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -383,7 +351,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/SONEIUM/ORACLE/src/contracts/interfaces/IPriceOracleGetter.sol
+// downloads/LINEA/ORACLE/AaveOracle/src/contracts/interfaces/IPriceOracleGetter.sol
 
 /**
  * @title IPriceOracleGetter
@@ -413,7 +381,7 @@ interface IPriceOracleGetter {
   function getAssetPrice(address asset) external view returns (uint256);
 }
 
-// downloads/SONEIUM/ORACLE/src/contracts/interfaces/IACLManager.sol
+// downloads/LINEA/ORACLE/AaveOracle/src/contracts/interfaces/IACLManager.sol
 
 /**
  * @title IACLManager
@@ -586,7 +554,7 @@ interface IACLManager {
   function isAssetListingAdmin(address admin) external view returns (bool);
 }
 
-// downloads/SONEIUM/ORACLE/src/contracts/interfaces/IAaveOracle.sol
+// downloads/LINEA/ORACLE/AaveOracle/src/contracts/interfaces/IAaveOracle.sol
 
 /**
  * @title IAaveOracle
@@ -654,7 +622,7 @@ interface IAaveOracle is IPriceOracleGetter {
   function getFallbackOracle() external view returns (address);
 }
 
-// downloads/SONEIUM/ORACLE/src/contracts/misc/AaveOracle.sol
+// downloads/LINEA/ORACLE/AaveOracle/src/contracts/misc/AaveOracle.sol
 
 /**
  * @title AaveOracle
```
