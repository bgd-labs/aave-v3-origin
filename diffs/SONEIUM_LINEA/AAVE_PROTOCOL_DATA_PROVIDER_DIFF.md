```diff
diff --git a/./downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER.sol b/./downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER.sol
index 95403b8..f025313 100644
--- a/./downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER.sol
+++ b/./downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER.sol
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/protocol/libraries/types/DataTypes.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/protocol/libraries/types/DataTypes.sol
 
 library DataTypes {
   /**
@@ -331,7 +331,7 @@ library DataTypes {
   }
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/protocol/libraries/helpers/Errors.sol
 
 /**
  * @title Errors library
@@ -438,7 +438,7 @@ library Errors {
   string public constant USER_CANNOT_HAVE_DEBT = '104'; // Thrown when a user tries to interact with a method that requires a position without debt
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/interfaces/IAaveIncentivesController.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/interfaces/IAaveIncentivesController.sol
 
 /**
  * @title IAaveIncentivesController
@@ -457,7 +457,7 @@ interface IAaveIncentivesController {
   function handleAction(address user, uint256 totalSupply, uint256 userBalance) external;
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
 
 /**
  * @dev Interface of the ERC20 standard as defined in the EIP.
@@ -533,7 +533,7 @@ interface IERC20 {
   event Approval(address indexed owner, address indexed spender, uint256 value);
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -760,7 +760,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/interfaces/IScaledBalanceToken.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/interfaces/IScaledBalanceToken.sol
 
 /**
  * @title IScaledBalanceToken
@@ -832,7 +832,7 @@ interface IScaledBalanceToken {
   function getPreviousIndex(address user) external view returns (uint256);
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/protocol/libraries/math/WadRayMath.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/protocol/libraries/math/WadRayMath.sol
 
 /**
  * @title WadRayMath library
@@ -958,7 +958,7 @@ library WadRayMath {
   }
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
 
 interface IERC20Detailed is IERC20 {
   function name() external view returns (string memory);
@@ -968,7 +968,7 @@ interface IERC20Detailed is IERC20 {
   function decimals() external view returns (uint8);
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/interfaces/IPoolDataProvider.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/interfaces/IPoolDataProvider.sol
 
 /**
  * @title IPoolDataProvider
@@ -1223,7 +1223,7 @@ interface IPoolDataProvider {
   function getReserveDeficit(address asset) external view returns (uint256);
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/interfaces/IPool.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/interfaces/IPool.sol
 
 /**
  * @title IPool
@@ -2091,7 +2091,7 @@ interface IPool {
   function getSupplyLogic() external view returns (address);
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
 
 /**
  * @title ReserveConfiguration library
@@ -2675,7 +2675,7 @@ library ReserveConfiguration {
   }
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
 
 /**
  * @title UserConfiguration library
@@ -2907,7 +2907,7 @@ library UserConfiguration {
   }
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/interfaces/IInitializableDebtToken.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/interfaces/IInitializableDebtToken.sol
 
 /**
  * @title IInitializableDebtToken
@@ -2956,7 +2956,7 @@ interface IInitializableDebtToken {
   ) external;
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/interfaces/IVariableDebtToken.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/interfaces/IVariableDebtToken.sol
 
 /**
  * @title IVariableDebtToken
@@ -2999,7 +2999,7 @@ interface IVariableDebtToken is IScaledBalanceToken, IInitializableDebtToken {
   function UNDERLYING_ASSET_ADDRESS() external view returns (address);
 }
 
-// downloads/SONEIUM/AAVE_PROTOCOL_DATA_PROVIDER/src/contracts/helpers/AaveProtocolDataProvider.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-v3-origin/src/contracts/helpers/AaveProtocolDataProvider.sol
 
 /**
  * @title AaveProtocolDataProvider
```
