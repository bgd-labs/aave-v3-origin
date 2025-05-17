```diff
diff --git a/./downloads/SONEIUM/FLASHLOAN_LOGIC.sol b/./downloads/LINEA/FLASHLOAN_LOGIC.sol
index 940192d..9c072a0 100644
--- a/./downloads/SONEIUM/FLASHLOAN_LOGIC.sol
+++ b/./downloads/LINEA/FLASHLOAN_LOGIC.sol
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/dependencies/openzeppelin/contracts/Address.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/Address.sol
 
 // OpenZeppelin Contracts v4.4.1 (utils/Address.sol)
 
@@ -221,7 +221,7 @@ library Address {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/dependencies/openzeppelin/contracts/Context.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/Context.sol
 
 /*
  * @dev Provides information about the current execution context, including the
@@ -244,7 +244,7 @@ abstract contract Context {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/types/DataTypes.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/types/DataTypes.sol
 
 library DataTypes {
   /**
@@ -574,7 +574,7 @@ library DataTypes {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/helpers/Errors.sol
 
 /**
  * @title Errors library
@@ -681,7 +681,7 @@ library Errors {
   string public constant USER_CANNOT_HAVE_DEBT = '104'; // Thrown when a user tries to interact with a method that requires a position without debt
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/interfaces/IAaveIncentivesController.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IAaveIncentivesController.sol
 
 /**
  * @title IAaveIncentivesController
@@ -700,9 +700,97 @@ interface IAaveIncentivesController {
   function handleAction(address user, uint256 totalSupply, uint256 userBalance) external;
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/dependencies/openzeppelin/contracts/IAccessControl.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/IAccessControl.sol
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+/**
+ * @dev External interface of AccessControl declared to support ERC165 detection.
+ */
+interface IAccessControl {
+  /**
+   * @dev Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`
+   *
+   * `DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
+   * {RoleAdminChanged} not being emitted signaling this.
+   *
+   * _Available since v3.1._
+   */
+  event RoleAdminChanged(
+    bytes32 indexed role,
+    bytes32 indexed previousAdminRole,
+    bytes32 indexed newAdminRole
+  );
+
+  /**
+   * @dev Emitted when `account` is granted `role`.
+   *
+   * `sender` is the account that originated the contract call, an admin role
+   * bearer except when using {AccessControl-_setupRole}.
+   */
+  event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);
+
+  /**
+   * @dev Emitted when `account` is revoked `role`.
+   *
+   * `sender` is the account that originated the contract call:
+   *   - if using `revokeRole`, it is the admin role bearer
+   *   - if using `renounceRole`, it is the role bearer (i.e. `account`)
+   */
+  event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);
+
+  /**
+   * @dev Returns `true` if `account` has been granted `role`.
+   */
+  function hasRole(bytes32 role, address account) external view returns (bool);
+
+  /**
+   * @dev Returns the admin role that controls `role`. See {grantRole} and
+   * {revokeRole}.
+   *
+   * To change a role's admin, use {AccessControl-_setRoleAdmin}.
+   */
+  function getRoleAdmin(bytes32 role) external view returns (bytes32);
+
+  /**
+   * @dev Grants `role` to `account`.
+   *
+   * If `account` had not been already granted `role`, emits a {RoleGranted}
+   * event.
+   *
+   * Requirements:
+   *
+   * - the caller must have ``role``'s admin role.
+   */
+  function grantRole(bytes32 role, address account) external;
+
+  /**
+   * @dev Revokes `role` from `account`.
+   *
+   * If `account` had been granted `role`, emits a {RoleRevoked} event.
+   *
+   * Requirements:
+   *
+   * - the caller must have ``role``'s admin role.
+   */
+  function revokeRole(bytes32 role, address account) external;
+
+  /**
+   * @dev Revokes `role` from the calling account.
+   *
+   * Roles are often managed via {grantRole} and {revokeRole}: this function's
+   * purpose is to provide a mechanism for accounts to lose their privileges
+   * if they are compromised (such as when a trusted device is misplaced).
+   *
+   * If the calling account had been granted `role`, emits a {RoleRevoked}
+   * event.
+   *
+   * Requirements:
+   *
+   * - the caller must be `account`.
+   */
+  function renounceRole(bytes32 role, address account) external;
+}
+
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
 
 /**
  * @dev Interface of the ERC20 standard as defined in the EIP.
@@ -778,7 +866,7 @@ interface IERC20 {
   event Approval(address indexed owner, address indexed spender, uint256 value);
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -1005,7 +1093,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/interfaces/IPriceOracleGetter.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IPriceOracleGetter.sol
 
 /**
  * @title IPriceOracleGetter
@@ -1035,9 +1123,79 @@ interface IPriceOracleGetter {
   function getAssetPrice(address asset) external view returns (uint256);
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/interfaces/IScaledBalanceToken.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IScaledBalanceToken.sol
+
+/**
+ * @title IScaledBalanceToken
+ * @author Aave
+ * @notice Defines the basic interface for a scaled-balance token.
+ */
+interface IScaledBalanceToken {
+  /**
+   * @dev Emitted after the mint action
+   * @param caller The address performing the mint
+   * @param onBehalfOf The address of the user that will receive the minted tokens
+   * @param value The scaled-up amount being minted (based on user entered amount and balance increase from interest)
+   * @param balanceIncrease The increase in scaled-up balance since the last action of 'onBehalfOf'
+   * @param index The next liquidity index of the reserve
+   */
+  event Mint(
+    address indexed caller,
+    address indexed onBehalfOf,
+    uint256 value,
+    uint256 balanceIncrease,
+    uint256 index
+  );
+
+  /**
+   * @dev Emitted after the burn action
+   * @dev If the burn function does not involve a transfer of the underlying asset, the target defaults to zero address
+   * @param from The address from which the tokens will be burned
+   * @param target The address that will receive the underlying, if any
+   * @param value The scaled-up amount being burned (user entered amount - balance increase from interest)
+   * @param balanceIncrease The increase in scaled-up balance since the last action of 'from'
+   * @param index The next liquidity index of the reserve
+   */
+  event Burn(
+    address indexed from,
+    address indexed target,
+    uint256 value,
+    uint256 balanceIncrease,
+    uint256 index
+  );
+
+  /**
+   * @notice Returns the scaled balance of the user.
+   * @dev The scaled balance is the sum of all the updated stored balance divided by the reserve's liquidity index
+   * at the moment of the update
+   * @param user The user whose balance is calculated
+   * @return The scaled balance of the user
+   */
+  function scaledBalanceOf(address user) external view returns (uint256);
+
+  /**
+   * @notice Returns the scaled balance of the user and the scaled total supply.
+   * @param user The address of the user
+   * @return The scaled balance of the user
+   * @return The scaled total supply
+   */
+  function getScaledUserBalanceAndSupply(address user) external view returns (uint256, uint256);
+
+  /**
+   * @notice Returns the scaled total supply of the scaled balance token. Represents sum(debt/index)
+   * @return The scaled total supply
+   */
+  function scaledTotalSupply() external view returns (uint256);
+
+  /**
+   * @notice Returns last index interest was accrued to the user's balance
+   * @param user The address of the user
+   * @return The last index interest was accrued to the user's balance, expressed in ray
+   */
+  function getPreviousIndex(address user) external view returns (uint256);
+}
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/math/PercentageMath.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/math/PercentageMath.sol
 
 /**
  * @title PercentageMath library
@@ -1098,7 +1256,7 @@ library PercentageMath {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
 
 // OpenZeppelin Contracts v4.4.1 (utils/math/SafeCast.sol)
 
@@ -1354,7 +1512,7 @@ library SafeCast {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/math/WadRayMath.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/math/WadRayMath.sol
 
 /**
  * @title WadRayMath library
@@ -1480,7 +1638,7 @@ library WadRayMath {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/dependencies/gnosis/contracts/GPv2SafeERC20.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/gnosis/contracts/GPv2SafeERC20.sol
 
 /// @title Gnosis Protocol v2 Safe ERC20 Transfer Library
 /// @author Gnosis Developers
@@ -1593,7 +1751,7 @@ library GPv2SafeERC20 {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/interfaces/IACLManager.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IACLManager.sol
 
 /**
  * @title IACLManager
@@ -1766,7 +1924,7 @@ interface IACLManager {
   function isAssetListingAdmin(address admin) external view returns (bool);
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
 
 interface IERC20Detailed is IERC20 {
   function name() external view returns (string memory);
@@ -1776,7 +1934,7 @@ interface IERC20Detailed is IERC20 {
   function decimals() external view returns (uint8);
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/interfaces/IPriceOracleSentinel.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IPriceOracleSentinel.sol
 
 /**
  * @title IPriceOracleSentinel
@@ -1841,7 +1999,7 @@ interface IPriceOracleSentinel {
   function getGracePeriod() external view returns (uint256);
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/interfaces/IReserveInterestRateStrategy.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IReserveInterestRateStrategy.sol
 
 /**
  * @title IReserveInterestRateStrategy
@@ -1868,7 +2026,7 @@ interface IReserveInterestRateStrategy {
   ) external view returns (uint256, uint256);
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/math/MathUtils.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/math/MathUtils.sol
 
 /**
  * @title MathUtils library
@@ -1965,7 +2123,7 @@ library MathUtils {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/interfaces/IPool.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IPool.sol
 
 /**
  * @title IPool
@@ -2833,7 +2991,7 @@ interface IPool {
   function getSupplyLogic() external view returns (address);
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
 
 /**
  * @title ReserveConfiguration library
@@ -3417,7 +3575,7 @@ library ReserveConfiguration {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/configuration/EModeConfiguration.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/configuration/EModeConfiguration.sol
 
 /**
  * @title EModeConfiguration library
@@ -3466,7 +3624,7 @@ library EModeConfiguration {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/misc/flashloan/interfaces/IFlashLoanReceiver.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/misc/flashloan/interfaces/IFlashLoanReceiver.sol
 
 /**
  * @title IFlashLoanReceiver
@@ -3499,7 +3657,7 @@ interface IFlashLoanReceiver {
   function POOL() external view returns (IPool);
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/misc/flashloan/interfaces/IFlashLoanSimpleReceiver.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/misc/flashloan/interfaces/IFlashLoanSimpleReceiver.sol
 
 /**
  * @title IFlashLoanSimpleReceiver
@@ -3532,7 +3690,7 @@ interface IFlashLoanSimpleReceiver {
   function POOL() external view returns (IPool);
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
 
 /**
  * @title UserConfiguration library
@@ -3764,7 +3922,7 @@ library UserConfiguration {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/interfaces/IInitializableAToken.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IInitializableAToken.sol
 
 /**
  * @title IInitializableAToken
@@ -3817,7 +3975,7 @@ interface IInitializableAToken {
   ) external;
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/interfaces/IInitializableDebtToken.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IInitializableDebtToken.sol
 
 /**
  * @title IInitializableDebtToken
@@ -3866,7 +4024,7 @@ interface IInitializableDebtToken {
   ) external;
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/logic/IsolationModeLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/IsolationModeLogic.sol
 
 /**
  * @title IsolationModeLogic library
@@ -3941,7 +4099,7 @@ library IsolationModeLogic {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/interfaces/IVariableDebtToken.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IVariableDebtToken.sol
 
 /**
  * @title IVariableDebtToken
@@ -3984,7 +4142,7 @@ interface IVariableDebtToken is IScaledBalanceToken, IInitializableDebtToken {
   function UNDERLYING_ASSET_ADDRESS() external view returns (address);
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/interfaces/IAToken.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/interfaces/IAToken.sol
 
 /**
  * @title IAToken
@@ -4118,7 +4276,7 @@ interface IAToken is IERC20, IScaledBalanceToken, IInitializableAToken {
   function rescueTokens(address token, address to, uint256 amount) external;
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/tokenization/base/IncentivizedERC20.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/tokenization/base/IncentivizedERC20.sol
 
 /**
  * @title IncentivizedERC20
@@ -4341,7 +4499,7 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/logic/ReserveLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/ReserveLogic.sol
 
 /**
  * @title ReserveLogic library
@@ -4643,7 +4801,7 @@ library ReserveLogic {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/logic/EModeLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/EModeLogic.sol
 
 /**
  * @title EModeLogic library
@@ -4705,7 +4863,7 @@ library EModeLogic {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/logic/GenericLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/GenericLogic.sol
 
 /**
  * @title GenericLogic library
@@ -4957,7 +5115,7 @@ library GenericLogic {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/logic/ValidationLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/ValidationLogic.sol
 
 /**
  * @title ValidationLogic library
@@ -5577,7 +5735,7 @@ library ValidationLogic {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/logic/BorrowLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/BorrowLogic.sol
 
 /**
  * @title BorrowLogic library
@@ -5800,7 +5958,7 @@ library BorrowLogic {
   }
 }
 
-// downloads/SONEIUM/FLASHLOAN_LOGIC/src/contracts/protocol/libraries/logic/FlashLoanLogic.sol
+// downloads/LINEA/FLASHLOAN_LOGIC/FlashLoanLogic/src/contracts/protocol/libraries/logic/FlashLoanLogic.sol
 
 /**
  * @title FlashLoanLogic library
```
