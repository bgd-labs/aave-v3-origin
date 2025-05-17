```diff
diff --git a/./downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL.sol b/./downloads/LINEA/DEFAULT_A_TOKEN_IMPL.sol
index 695e135..205927b 100644
--- a/./downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL.sol
+++ b/./downloads/LINEA/DEFAULT_A_TOKEN_IMPL.sol
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/dependencies/openzeppelin/contracts/Context.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/dependencies/openzeppelin/contracts/Context.sol
 
 /*
  * @dev Provides information about the current execution context, including the
@@ -24,7 +24,7 @@ abstract contract Context {
   }
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/protocol/libraries/types/DataTypes.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/protocol/libraries/types/DataTypes.sol
 
 library DataTypes {
   /**
@@ -75,9 +75,8 @@ library DataTypes {
     uint128 variableBorrowIndex;
     //the current variable borrow rate. Expressed in ray
     uint128 currentVariableBorrowRate;
-    /// @notice reused `__deprecatedStableBorrowRate` storage from pre 3.2
-    // the current accumulate deficit in underlying tokens
-    uint128 deficit;
+    // DEPRECATED on v3.2.0
+    uint128 __deprecatedStableBorrowRate;
     //timestamp of last update
     uint40 lastUpdateTimestamp;
     //the id of the reserve. Represents the position in the list of the active reserves
@@ -243,11 +242,6 @@ library DataTypes {
     uint8 userEModeCategory;
   }
 
-  struct ExecuteEliminateDeficitParams {
-    address asset;
-    uint256 amount;
-  }
-
   struct ExecuteSetUserEModeParams {
     uint256 reservesCount;
     address oracle;
@@ -354,7 +348,7 @@ library DataTypes {
   }
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/protocol/tokenization/base/EIP712Base.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/protocol/tokenization/base/EIP712Base.sol
 
 /**
  * @title EIP712Base
@@ -424,7 +418,7 @@ abstract contract EIP712Base {
   function _EIP712BaseId() internal view virtual returns (string memory);
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/protocol/libraries/helpers/Errors.sol
 
 /**
  * @title Errors library
@@ -525,13 +519,9 @@ library Errors {
   string public constant INVALID_GRACE_PERIOD = '98'; // Grace period above a valid range
   string public constant INVALID_FREEZE_STATE = '99'; // Reserve is already in the passed freeze state
   string public constant NOT_BORROWABLE_IN_EMODE = '100'; // Asset not borrowable in eMode
-  string public constant CALLER_NOT_UMBRELLA = '101'; // The caller of the function is not the umbrella contract
-  string public constant RESERVE_NOT_IN_DEFICIT = '102'; // The reserve is not in deficit
-  string public constant MUST_NOT_LEAVE_DUST = '103'; // Below a certain threshold liquidators need to take the full position
-  string public constant USER_CANNOT_HAVE_DEBT = '104'; // Thrown when a user tries to interact with a method that requires a position without debt
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/interfaces/IAaveIncentivesController.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/interfaces/IAaveIncentivesController.sol
 
 /**
  * @title IAaveIncentivesController
@@ -550,7 +540,7 @@ interface IAaveIncentivesController {
   function handleAction(address user, uint256 totalSupply, uint256 userBalance) external;
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
 
 /**
  * @dev Interface of the ERC20 standard as defined in the EIP.
@@ -626,7 +616,7 @@ interface IERC20 {
   event Approval(address indexed owner, address indexed spender, uint256 value);
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -853,7 +843,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/interfaces/IScaledBalanceToken.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/interfaces/IScaledBalanceToken.sol
 
 /**
  * @title IScaledBalanceToken
@@ -925,7 +915,7 @@ interface IScaledBalanceToken {
   function getPreviousIndex(address user) external view returns (uint256);
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
 
 // OpenZeppelin Contracts v4.4.1 (utils/math/SafeCast.sol)
 
@@ -1181,7 +1171,7 @@ library SafeCast {
   }
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/misc/aave-upgradeability/VersionedInitializable.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/misc/aave-upgradeability/VersionedInitializable.sol
 
 /**
  * @title VersionedInitializable
@@ -1258,7 +1248,7 @@ abstract contract VersionedInitializable {
   uint256[50] private ______gap;
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/protocol/libraries/math/WadRayMath.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/protocol/libraries/math/WadRayMath.sol
 
 /**
  * @title WadRayMath library
@@ -1384,7 +1374,7 @@ library WadRayMath {
   }
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/dependencies/gnosis/contracts/GPv2SafeERC20.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/dependencies/gnosis/contracts/GPv2SafeERC20.sol
 
 /// @title Gnosis Protocol v2 Safe ERC20 Transfer Library
 /// @author Gnosis Developers
@@ -1497,7 +1487,7 @@ library GPv2SafeERC20 {
   }
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/interfaces/IACLManager.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/interfaces/IACLManager.sol
 
 /**
  * @title IACLManager
@@ -1670,7 +1660,7 @@ interface IACLManager {
   function isAssetListingAdmin(address admin) external view returns (bool);
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
 
 interface IERC20Detailed is IERC20 {
   function name() external view returns (string memory);
@@ -1680,7 +1670,7 @@ interface IERC20Detailed is IERC20 {
   function decimals() external view returns (uint8);
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/interfaces/IPool.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/interfaces/IPool.sol
 
 /**
  * @title IPool
@@ -1863,14 +1853,6 @@ interface IPool {
     uint256 variableBorrowIndex
   );
 
-  /**
-   * @dev Emitted when the deficit of a reserve is covered.
-   * @param reserve The address of the underlying asset of the reserve
-   * @param caller The caller that triggered the DeficitCovered event
-   * @param amountCovered The amount of deficit covered
-   */
-  event DeficitCovered(address indexed reserve, address caller, uint256 amountCovered);
-
   /**
    * @dev Emitted when the protocol treasury receives minted aTokens from the accrued interest.
    * @param reserve The address of the reserve
@@ -1878,14 +1860,6 @@ interface IPool {
    */
   event MintedToTreasury(address indexed reserve, uint256 amountMinted);
 
-  /**
-   * @dev Emitted when deficit is realized on a liquidation.
-   * @param user The user address where the bad debt will be burned
-   * @param debtAsset The address of the underlying borrowed asset to be burned
-   * @param amountCreated The amount of deficit created
-   */
-  event DeficitCreated(address indexed user, address indexed debtAsset, uint256 amountCreated);
-
   /**
    * @notice Mints an `amount` of aTokens to the `onBehalfOf`
    * @param asset The address of the underlying asset to mint
@@ -2253,6 +2227,16 @@ interface IPool {
    */
   function getReserveData(address asset) external view returns (DataTypes.ReserveDataLegacy memory);
 
+  /**
+   * @notice Returns the state and configuration of the reserve, including extra data included with Aave v3.1
+   * @dev DEPRECATED use independent getters instead (getReserveData, getLiquidationGracePeriod)
+   * @param asset The address of the underlying asset of the reserve
+   * @return The state and configuration data of the reserve with virtual accounting
+   */
+  function getReserveDataExtended(
+    address asset
+  ) external view returns (DataTypes.ReserveData memory);
+
   /**
    * @notice Returns the virtual underlying balance of the reserve
    * @param asset The address of the underlying asset of the reserve
@@ -2427,7 +2411,7 @@ interface IPool {
    * @param asset The address of the underlying asset
    * @return Timestamp when the liquidation grace period will end
    **/
-  function getLiquidationGracePeriod(address asset) external view returns (uint40);
+  function getLiquidationGracePeriod(address asset) external returns (uint40);
 
   /**
    * @notice Returns the total fee on flash loans
@@ -2481,37 +2465,6 @@ interface IPool {
    */
   function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
 
-  /**
-   * @notice It covers the deficit of a specified reserve by burning:
-   * - the equivalent aToken `amount` for assets with virtual accounting enabled
-   * - the equivalent `amount` of underlying for assets with virtual accounting disabled (e.g. GHO)
-   * @dev The deficit of a reserve can occur due to situations where borrowed assets are not repaid, leading to bad debt.
-   * @param asset The address of the underlying asset to cover the deficit.
-   * @param amount The amount to be covered, in aToken or underlying on non-virtual accounted assets
-   */
-  function eliminateReserveDeficit(address asset, uint256 amount) external;
-
-  /**
-   * @notice Returns the current deficit of a reserve.
-   * @param asset The address of the underlying asset of the reserve
-   * @return The current deficit of the reserve
-   */
-  function getReserveDeficit(address asset) external view returns (uint256);
-
-  /**
-   * @notice Returns the aToken address of a reserve.
-   * @param asset The address of the underlying asset of the reserve
-   * @return The address of the aToken
-   */
-  function getReserveAToken(address asset) external view returns (address);
-
-  /**
-   * @notice Returns the variableDebtToken address of a reserve.
-   * @param asset The address of the underlying asset of the reserve
-   * @return The address of the variableDebtToken
-   */
-  function getReserveVariableDebtToken(address asset) external view returns (address);
-
   /**
    * @notice Gets the address of the external FlashLoanLogic
    */
@@ -2548,7 +2501,7 @@ interface IPool {
   function getSupplyLogic() external view returns (address);
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/interfaces/IInitializableAToken.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/interfaces/IInitializableAToken.sol
 
 /**
  * @title IInitializableAToken
@@ -2601,7 +2554,7 @@ interface IInitializableAToken {
   ) external;
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/interfaces/IAToken.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/interfaces/IAToken.sol
 
 /**
  * @title IAToken
@@ -2735,7 +2688,7 @@ interface IAToken is IERC20, IScaledBalanceToken, IInitializableAToken {
   function rescueTokens(address token, address to, uint256 amount) external;
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/protocol/tokenization/base/IncentivizedERC20.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/protocol/tokenization/base/IncentivizedERC20.sol
 
 /**
  * @title IncentivizedERC20
@@ -2958,7 +2911,7 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
   }
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/protocol/tokenization/base/MintableIncentivizedERC20.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/protocol/tokenization/base/MintableIncentivizedERC20.sol
 
 /**
  * @title MintableIncentivizedERC20
@@ -3020,7 +2973,7 @@ abstract contract MintableIncentivizedERC20 is IncentivizedERC20 {
   }
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/protocol/tokenization/base/ScaledBalanceTokenBase.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/protocol/tokenization/base/ScaledBalanceTokenBase.sol
 
 /**
  * @title ScaledBalanceTokenBase
@@ -3169,7 +3122,7 @@ abstract contract ScaledBalanceTokenBase is MintableIncentivizedERC20, IScaledBa
   }
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/protocol/tokenization/AToken.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/protocol/tokenization/AToken.sol
 
 /**
  * @title Aave ERC20 AToken
@@ -3382,7 +3335,7 @@ abstract contract AToken is VersionedInitializable, ScaledBalanceTokenBase, EIP7
   }
 }
 
-// downloads/SONEIUM/DEFAULT_A_TOKEN_IMPL/src/contracts/instances/ATokenInstance.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/instances/ATokenInstance.sol
 
 contract ATokenInstance is AToken {
   uint256 public constant ATOKEN_REVISION = 1;
```
