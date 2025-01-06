```diff
diff --git a/./downloads/ARBITRUM/FLASHLOAN_LOGIC.sol b/./downloads/LINEA/FLASHLOAN_LOGIC.sol
index 35feed8..639a33a 100644
--- a/./downloads/ARBITRUM/FLASHLOAN_LOGIC.sol
+++ b/./downloads/LINEA/FLASHLOAN_LOGIC.sol
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/Address.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/Address.sol
 
 // OpenZeppelin Contracts v4.4.1 (utils/Address.sol)
 
@@ -221,7 +221,7 @@ library Address {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/Context.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/Context.sol
 
 /*
  * @dev Provides information about the current execution context, including the
@@ -244,7 +244,7 @@ abstract contract Context {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/IAccessControl.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/IAccessControl.sol
 
 /**
  * @dev External interface of AccessControl declared to support ERC165 detection.
@@ -334,7 +334,7 @@ interface IAccessControl {
   function renounceRole(bytes32 role, address account) external;
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
 
 /**
  * @dev Interface of the ERC20 standard as defined in the EIP.
@@ -410,7 +410,7 @@ interface IERC20 {
   event Approval(address indexed owner, address indexed spender, uint256 value);
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
 
 // OpenZeppelin Contracts v4.4.1 (utils/math/SafeCast.sol)
 
@@ -666,7 +666,7 @@ library SafeCast {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IAaveIncentivesController.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IAaveIncentivesController.sol
 
 /**
  * @title IAaveIncentivesController
@@ -685,7 +685,7 @@ interface IAaveIncentivesController {
   function handleAction(address user, uint256 totalSupply, uint256 userBalance) external;
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -912,7 +912,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IPriceOracleGetter.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IPriceOracleGetter.sol
 
 /**
  * @title IPriceOracleGetter
@@ -942,7 +942,7 @@ interface IPriceOracleGetter {
   function getAssetPrice(address asset) external view returns (uint256);
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IScaledBalanceToken.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IScaledBalanceToken.sol
 
 /**
  * @title IScaledBalanceToken
@@ -1014,7 +1014,7 @@ interface IScaledBalanceToken {
   function getPreviousIndex(address user) external view returns (uint256);
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/helpers/Errors.sol
 
 /**
  * @title Errors library
@@ -1117,7 +1117,7 @@ library Errors {
   string public constant NOT_BORROWABLE_IN_EMODE = '100'; // Asset not borrowable in eMode
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/math/PercentageMath.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/math/PercentageMath.sol
 
 /**
  * @title PercentageMath library
@@ -1178,7 +1178,7 @@ library PercentageMath {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/math/WadRayMath.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/math/WadRayMath.sol
 
 /**
  * @title WadRayMath library
@@ -1304,7 +1304,7 @@ library WadRayMath {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/types/DataTypes.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/types/DataTypes.sol
 
 library DataTypes {
   /**
@@ -1628,7 +1628,7 @@ library DataTypes {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/gnosis/contracts/GPv2SafeERC20.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/gnosis/contracts/GPv2SafeERC20.sol
 
 /// @title Gnosis Protocol v2 Safe ERC20 Transfer Library
 /// @author Gnosis Developers
@@ -1741,7 +1741,7 @@ library GPv2SafeERC20 {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
 
 interface IERC20Detailed is IERC20 {
   function name() external view returns (string memory);
@@ -1751,7 +1751,7 @@ interface IERC20Detailed is IERC20 {
   function decimals() external view returns (uint8);
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IACLManager.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IACLManager.sol
 
 /**
  * @title IACLManager
@@ -1924,7 +1924,7 @@ interface IACLManager {
   function isAssetListingAdmin(address admin) external view returns (bool);
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IPriceOracleSentinel.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IPriceOracleSentinel.sol
 
 /**
  * @title IPriceOracleSentinel
@@ -1989,7 +1989,7 @@ interface IPriceOracleSentinel {
   function getGracePeriod() external view returns (uint256);
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IReserveInterestRateStrategy.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IReserveInterestRateStrategy.sol
 
 /**
  * @title IReserveInterestRateStrategy
@@ -2016,7 +2016,7 @@ interface IReserveInterestRateStrategy {
   ) external view returns (uint256, uint256);
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/math/MathUtils.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/math/MathUtils.sol
 
 /**
  * @title MathUtils library
@@ -2113,7 +2113,7 @@ library MathUtils {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IPool.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IPool.sol
 
 /**
  * @title IPool
@@ -2672,6 +2672,7 @@ interface IPool {
 
   /**
    * @notice Returns the state and configuration of the reserve, including extra data included with Aave v3.1
+   * @dev DEPRECATED use independent getters instead (getReserveData, getLiquidationGracePeriod)
    * @param asset The address of the underlying asset of the reserve
    * @return The state and configuration data of the reserve with virtual accounting
    */
@@ -2943,7 +2944,7 @@ interface IPool {
   function getSupplyLogic() external view returns (address);
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
 
 /**
  * @title ReserveConfiguration library
@@ -2958,6 +2959,7 @@ library ReserveConfiguration {
   uint256 internal constant ACTIVE_MASK =                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant FROZEN_MASK =                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant BORROWING_MASK =                 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFFFFFFFFFFF; // prettier-ignore
+  // @notice there is an unoccupied hole of 1 bit at position 59 from pre 3.2 stableBorrowRateEnabled
   uint256 internal constant PAUSED_MASK =                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant BORROWABLE_IN_ISOLATION_MASK =   0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant SILOED_BORROWING_MASK =          0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFFFFFFFFFFFF; // prettier-ignore
@@ -2966,7 +2968,7 @@ library ReserveConfiguration {
   uint256 internal constant BORROW_CAP_MASK =                0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000FFFFFFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant SUPPLY_CAP_MASK =                0xFFFFFFFFFFFFFFFFFFFFFFFFFF000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant LIQUIDATION_PROTOCOL_FEE_MASK =  0xFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
-  //@notice there is an unoccupied hole of 8 bits from 168 to 176 left from pre 3.2 eModeCategory
+  // @notice there is an unoccupied hole of 8 bits from 168 to 176 left from pre 3.2 eModeCategory
   uint256 internal constant UNBACKED_MINT_CAP_MASK =         0xFFFFFFFFFFF000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant DEBT_CEILING_MASK =              0xF0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant VIRTUAL_ACC_ACTIVE_MASK =        0xEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
@@ -3523,7 +3525,7 @@ library ReserveConfiguration {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/misc/flashloan/interfaces/IFlashLoanReceiver.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/misc/flashloan/interfaces/IFlashLoanReceiver.sol
 
 /**
  * @title IFlashLoanReceiver
@@ -3556,7 +3558,7 @@ interface IFlashLoanReceiver {
   function POOL() external view returns (IPool);
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/misc/flashloan/interfaces/IFlashLoanSimpleReceiver.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/misc/flashloan/interfaces/IFlashLoanSimpleReceiver.sol
 
 /**
  * @title IFlashLoanSimpleReceiver
@@ -3589,7 +3591,7 @@ interface IFlashLoanSimpleReceiver {
   function POOL() external view returns (IPool);
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/configuration/EModeConfiguration.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/configuration/EModeConfiguration.sol
 
 /**
  * @title EModeConfiguration library
@@ -3638,7 +3640,7 @@ library EModeConfiguration {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
 
 /**
  * @title UserConfiguration library
@@ -3870,7 +3872,7 @@ library UserConfiguration {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IInitializableAToken.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IInitializableAToken.sol
 
 /**
  * @title IInitializableAToken
@@ -3923,7 +3925,7 @@ interface IInitializableAToken {
   ) external;
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IInitializableDebtToken.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IInitializableDebtToken.sol
 
 /**
  * @title IInitializableDebtToken
@@ -3972,7 +3974,7 @@ interface IInitializableDebtToken {
   ) external;
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/IsolationModeLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/IsolationModeLogic.sol
 
 /**
  * @title IsolationModeLogic library
@@ -4031,7 +4033,7 @@ library IsolationModeLogic {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IVariableDebtToken.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IVariableDebtToken.sol
 
 /**
  * @title IVariableDebtToken
@@ -4074,7 +4076,7 @@ interface IVariableDebtToken is IScaledBalanceToken, IInitializableDebtToken {
   function UNDERLYING_ASSET_ADDRESS() external view returns (address);
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IAToken.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IAToken.sol
 
 /**
  * @title IAToken
@@ -4208,7 +4210,7 @@ interface IAToken is IERC20, IScaledBalanceToken, IInitializableAToken {
   function rescueTokens(address token, address to, uint256 amount) external;
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/tokenization/base/IncentivizedERC20.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/tokenization/base/IncentivizedERC20.sol
 
 /**
  * @title IncentivizedERC20
@@ -4431,7 +4433,7 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/ReserveLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/ReserveLogic.sol
 
 /**
  * @title ReserveLogic library
@@ -4732,7 +4734,7 @@ library ReserveLogic {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/EModeLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/EModeLogic.sol
 
 /**
  * @title EModeLogic library
@@ -4794,7 +4796,7 @@ library EModeLogic {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/GenericLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/GenericLogic.sol
 
 /**
  * @title GenericLogic library
@@ -5038,7 +5040,7 @@ library GenericLogic {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/ValidationLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/ValidationLogic.sol
 
 /**
  * @title ReserveLogic library
@@ -5658,7 +5660,7 @@ library ValidationLogic {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/BorrowLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/BorrowLogic.sol
 
 /**
  * @title BorrowLogic library
@@ -5880,7 +5882,7 @@ library BorrowLogic {
   }
 }
 
-// downloads/ARBITRUM/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/FlashLoanLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/FlashLoanLogic.sol
 
 /**
  * @title FlashLoanLogic library
```
