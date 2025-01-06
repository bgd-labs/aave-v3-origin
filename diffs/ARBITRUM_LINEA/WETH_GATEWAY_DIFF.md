```diff
diff --git a/./downloads/ARBITRUM/WETH_GATEWAY.sol b/./downloads/LINEA/WETH_GATEWAY.sol
index 5984e04..cba4608 100644
--- a/./downloads/ARBITRUM/WETH_GATEWAY.sol
+++ b/./downloads/LINEA/WETH_GATEWAY.sol
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/dependencies/openzeppelin/contracts/Context.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/dependencies/openzeppelin/contracts/Context.sol
 
 /*
  * @dev Provides information about the current execution context, including the
@@ -24,7 +24,7 @@ abstract contract Context {
   }
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
 
 /**
  * @dev Interface of the ERC20 standard as defined in the EIP.
@@ -100,7 +100,7 @@ interface IERC20 {
   event Approval(address indexed owner, address indexed spender, uint256 value);
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/helpers/interfaces/IWETH.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/helpers/interfaces/IWETH.sol
 
 interface IWETH {
   function deposit() external payable;
@@ -112,7 +112,7 @@ interface IWETH {
   function transferFrom(address src, address dst, uint256 wad) external returns (bool);
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/helpers/interfaces/IWrappedTokenGatewayV3.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/helpers/interfaces/IWrappedTokenGatewayV3.sol
 
 interface IWrappedTokenGatewayV3 {
   function depositETH(address pool, address onBehalfOf, uint16 referralCode) external payable;
@@ -134,7 +134,7 @@ interface IWrappedTokenGatewayV3 {
   ) external;
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IAaveIncentivesController.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/interfaces/IAaveIncentivesController.sol
 
 /**
  * @title IAaveIncentivesController
@@ -153,7 +153,7 @@ interface IAaveIncentivesController {
   function handleAction(address user, uint256 totalSupply, uint256 userBalance) external;
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -380,7 +380,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IScaledBalanceToken.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/interfaces/IScaledBalanceToken.sol
 
 /**
  * @title IScaledBalanceToken
@@ -452,7 +452,7 @@ interface IScaledBalanceToken {
   function getPreviousIndex(address user) external view returns (uint256);
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/protocol/libraries/helpers/Errors.sol
 
 /**
  * @title Errors library
@@ -555,7 +555,7 @@ library Errors {
   string public constant NOT_BORROWABLE_IN_EMODE = '100'; // Asset not borrowable in eMode
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/types/DataTypes.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/protocol/libraries/types/DataTypes.sol
 
 library DataTypes {
   /**
@@ -879,7 +879,7 @@ library DataTypes {
   }
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/dependencies/gnosis/contracts/GPv2SafeERC20.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/dependencies/gnosis/contracts/GPv2SafeERC20.sol
 
 /// @title Gnosis Protocol v2 Safe ERC20 Transfer Library
 /// @author Gnosis Developers
@@ -992,7 +992,7 @@ library GPv2SafeERC20 {
   }
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/dependencies/openzeppelin/contracts/Ownable.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/dependencies/openzeppelin/contracts/Ownable.sol
 
 /**
  * @dev Contract module which provides a basic access control mechanism, where
@@ -1058,7 +1058,7 @@ contract Ownable is Context {
   }
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPool.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/interfaces/IPool.sol
 
 /**
  * @title IPool
@@ -1889,7 +1889,7 @@ interface IPool {
   function getSupplyLogic() external view returns (address);
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
 
 /**
  * @title ReserveConfiguration library
@@ -2470,7 +2470,7 @@ library ReserveConfiguration {
   }
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
 
 /**
  * @title UserConfiguration library
@@ -2702,7 +2702,7 @@ library UserConfiguration {
   }
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IInitializableAToken.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/interfaces/IInitializableAToken.sol
 
 /**
  * @title IInitializableAToken
@@ -2755,7 +2755,7 @@ interface IInitializableAToken {
   ) external;
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IAToken.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/interfaces/IAToken.sol
 
 /**
  * @title IAToken
@@ -2889,7 +2889,7 @@ interface IAToken is IERC20, IScaledBalanceToken, IInitializableAToken {
   function rescueTokens(address token, address to, uint256 amount) external;
 }
 
-// downloads/ARBITRUM/WETH_GATEWAY/WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/helpers/WrappedTokenGatewayV3.sol
+// downloads/LINEA/WETH_GATEWAY/WrappedTokenGatewayV3/src/contracts/helpers/WrappedTokenGatewayV3.sol
 
 /**
  * @dev This contract is an upgrade of the WrappedTokenGatewayV3 contract, with immutable pool address.
```
