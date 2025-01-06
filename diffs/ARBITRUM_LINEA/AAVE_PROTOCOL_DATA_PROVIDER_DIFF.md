```diff
diff --git a/./downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER.sol b/./downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER.sol
index 8142191..9b34753 100644
--- a/./downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER.sol
+++ b/./downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER.sol
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
 
 /**
  * @dev Interface of the ERC20 standard as defined in the EIP.
@@ -77,7 +77,7 @@ interface IERC20 {
   event Approval(address indexed owner, address indexed spender, uint256 value);
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IAaveIncentivesController.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/interfaces/IAaveIncentivesController.sol
 
 /**
  * @title IAaveIncentivesController
@@ -96,7 +96,7 @@ interface IAaveIncentivesController {
   function handleAction(address user, uint256 totalSupply, uint256 userBalance) external;
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -323,7 +323,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IScaledBalanceToken.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/interfaces/IScaledBalanceToken.sol
 
 /**
  * @title IScaledBalanceToken
@@ -395,7 +395,7 @@ interface IScaledBalanceToken {
   function getPreviousIndex(address user) external view returns (uint256);
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/protocol/libraries/helpers/Errors.sol
 
 /**
  * @title Errors library
@@ -498,7 +498,7 @@ library Errors {
   string public constant NOT_BORROWABLE_IN_EMODE = '100'; // Asset not borrowable in eMode
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/math/WadRayMath.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/protocol/libraries/math/WadRayMath.sol
 
 /**
  * @title WadRayMath library
@@ -624,7 +624,7 @@ library WadRayMath {
   }
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/types/DataTypes.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/protocol/libraries/types/DataTypes.sol
 
 library DataTypes {
   /**
@@ -948,7 +948,7 @@ library DataTypes {
   }
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
 
 interface IERC20Detailed is IERC20 {
   function name() external view returns (string memory);
@@ -958,7 +958,7 @@ interface IERC20Detailed is IERC20 {
   function decimals() external view returns (uint8);
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPoolDataProvider.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/interfaces/IPoolDataProvider.sol
 
 /**
  * @title IPoolDataProvider
@@ -1206,7 +1206,7 @@ interface IPoolDataProvider {
   function getVirtualUnderlyingBalance(address asset) external view returns (uint256);
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPool.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/interfaces/IPool.sol
 
 /**
  * @title IPool
@@ -1765,6 +1765,7 @@ interface IPool {
 
   /**
    * @notice Returns the state and configuration of the reserve, including extra data included with Aave v3.1
+   * @dev DEPRECATED use independent getters instead (getReserveData, getLiquidationGracePeriod)
    * @param asset The address of the underlying asset of the reserve
    * @return The state and configuration data of the reserve with virtual accounting
    */
@@ -2036,7 +2037,7 @@ interface IPool {
   function getSupplyLogic() external view returns (address);
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
 
 /**
  * @title ReserveConfiguration library
@@ -2051,6 +2052,7 @@ library ReserveConfiguration {
   uint256 internal constant ACTIVE_MASK =                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant FROZEN_MASK =                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant BORROWING_MASK =                 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFFFFFFFFFFF; // prettier-ignore
+  // @notice there is an unoccupied hole of 1 bit at position 59 from pre 3.2 stableBorrowRateEnabled
   uint256 internal constant PAUSED_MASK =                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant BORROWABLE_IN_ISOLATION_MASK =   0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant SILOED_BORROWING_MASK =          0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFFFFFFFFFFFF; // prettier-ignore
@@ -2059,7 +2061,7 @@ library ReserveConfiguration {
   uint256 internal constant BORROW_CAP_MASK =                0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000FFFFFFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant SUPPLY_CAP_MASK =                0xFFFFFFFFFFFFFFFFFFFFFFFFFF000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant LIQUIDATION_PROTOCOL_FEE_MASK =  0xFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
-  //@notice there is an unoccupied hole of 8 bits from 168 to 176 left from pre 3.2 eModeCategory
+  // @notice there is an unoccupied hole of 8 bits from 168 to 176 left from pre 3.2 eModeCategory
   uint256 internal constant UNBACKED_MINT_CAP_MASK =         0xFFFFFFFFFFF000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant DEBT_CEILING_MASK =              0xF0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant VIRTUAL_ACC_ACTIVE_MASK =        0xEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
@@ -2616,7 +2618,7 @@ library ReserveConfiguration {
   }
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
 
 /**
  * @title UserConfiguration library
@@ -2848,7 +2850,7 @@ library UserConfiguration {
   }
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IInitializableDebtToken.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/interfaces/IInitializableDebtToken.sol
 
 /**
  * @title IInitializableDebtToken
@@ -2897,7 +2899,7 @@ interface IInitializableDebtToken {
   ) external;
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IVariableDebtToken.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/interfaces/IVariableDebtToken.sol
 
 /**
  * @title IVariableDebtToken
@@ -2940,7 +2942,7 @@ interface IVariableDebtToken is IScaledBalanceToken, IInitializableDebtToken {
   function UNDERLYING_ASSET_ADDRESS() external view returns (address);
 }
 
-// downloads/ARBITRUM/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/helpers/AaveProtocolDataProvider.sol
+// downloads/LINEA/AAVE_PROTOCOL_DATA_PROVIDER/AaveProtocolDataProvider/src/contracts/helpers/AaveProtocolDataProvider.sol
 
 /**
  * @title AaveProtocolDataProvider
```
