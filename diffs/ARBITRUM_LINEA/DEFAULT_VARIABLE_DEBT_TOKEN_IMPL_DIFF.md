```diff
diff --git a/./downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL.sol b/./downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL.sol
index d6d70f1..1be027a 100644
--- a/./downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL.sol
+++ b/./downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL.sol
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
-pragma solidity =0.8.10 ^0.8.0;
+pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/dependencies/openzeppelin/contracts/Context.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/dependencies/openzeppelin/contracts/Context.sol
 
 /*
  * @dev Provides information about the current execution context, including the
@@ -24,7 +24,7 @@ abstract contract Context {
   }
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
 
 /**
  * @dev Interface of the ERC20 standard as defined in the EIP.
@@ -100,7 +100,7 @@ interface IERC20 {
   event Approval(address indexed owner, address indexed spender, uint256 value);
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
 
 // OpenZeppelin Contracts v4.4.1 (utils/math/SafeCast.sol)
 
@@ -356,7 +356,7 @@ library SafeCast {
   }
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/interfaces/IAaveIncentivesController.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/interfaces/IAaveIncentivesController.sol
 
 /**
  * @title IAaveIncentivesController
@@ -375,7 +375,7 @@ interface IAaveIncentivesController {
   function handleAction(address user, uint256 totalSupply, uint256 userBalance) external;
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/interfaces/ICreditDelegationToken.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/interfaces/ICreditDelegationToken.sol
 
 /**
  * @title ICreditDelegationToken
@@ -435,7 +435,7 @@ interface ICreditDelegationToken {
   ) external;
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -662,7 +662,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/interfaces/IScaledBalanceToken.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/interfaces/IScaledBalanceToken.sol
 
 /**
  * @title IScaledBalanceToken
@@ -734,7 +734,7 @@ interface IScaledBalanceToken {
   function getPreviousIndex(address user) external view returns (uint256);
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/protocol/libraries/aave-upgradeability/VersionedInitializable.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/misc/aave-upgradeability/VersionedInitializable.sol
 
 /**
  * @title VersionedInitializable
@@ -811,7 +811,7 @@ abstract contract VersionedInitializable {
   uint256[50] private ______gap;
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/protocol/libraries/helpers/Errors.sol
 
 /**
  * @title Errors library
@@ -849,17 +849,14 @@ library Errors {
   string public constant RESERVE_FROZEN = '28'; // 'Action cannot be performed because the reserve is frozen'
   string public constant RESERVE_PAUSED = '29'; // 'Action cannot be performed because the reserve is paused'
   string public constant BORROWING_NOT_ENABLED = '30'; // 'Borrowing is not enabled'
-  string public constant STABLE_BORROWING_NOT_ENABLED = '31'; // 'Stable borrowing is not enabled'
   string public constant NOT_ENOUGH_AVAILABLE_USER_BALANCE = '32'; // 'User cannot withdraw more than the available balance'
   string public constant INVALID_INTEREST_RATE_MODE_SELECTED = '33'; // 'Invalid interest rate mode selected'
   string public constant COLLATERAL_BALANCE_IS_ZERO = '34'; // 'The collateral balance is 0'
   string public constant HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD = '35'; // 'Health factor is lesser than the liquidation threshold'
   string public constant COLLATERAL_CANNOT_COVER_NEW_BORROW = '36'; // 'There is not enough collateral to cover a new borrow'
   string public constant COLLATERAL_SAME_AS_BORROWING_CURRENCY = '37'; // 'Collateral is (mostly) the same currency that is being borrowed'
-  string public constant AMOUNT_BIGGER_THAN_MAX_LOAN_SIZE_STABLE = '38'; // 'The requested amount is greater than the max loan size in stable rate mode'
   string public constant NO_DEBT_OF_SELECTED_TYPE = '39'; // 'For repayment of a specific type of debt, the user needs to have debt that type'
   string public constant NO_EXPLICIT_AMOUNT_TO_REPAY_ON_BEHALF = '40'; // 'To repay on behalf of a user an explicit amount to repay is needed'
-  string public constant NO_OUTSTANDING_STABLE_DEBT = '41'; // 'User does not have outstanding stable rate debt on this reserve'
   string public constant NO_OUTSTANDING_VARIABLE_DEBT = '42'; // 'User does not have outstanding variable rate debt on this reserve'
   string public constant UNDERLYING_BALANCE_ZERO = '43'; // 'The underlying balance needs to be greater than 0'
   string public constant INTEREST_RATE_REBALANCE_CONDITIONS_NOT_MET = '44'; // 'Interest rate rebalance conditions were not met'
@@ -872,7 +869,6 @@ library Errors {
   string public constant UNBACKED_MINT_CAP_EXCEEDED = '52'; // 'Unbacked mint cap is exceeded'
   string public constant DEBT_CEILING_EXCEEDED = '53'; // 'Debt ceiling is exceeded'
   string public constant UNDERLYING_CLAIMABLE_RIGHTS_NOT_ZERO = '54'; // 'Claimable rights over underlying not zero (aToken supply or accruedToTreasury)'
-  string public constant STABLE_DEBT_NOT_ZERO = '55'; // 'Stable debt supply is not zero'
   string public constant VARIABLE_DEBT_SUPPLY_NOT_ZERO = '56'; // 'Variable debt supply is not zero'
   string public constant LTV_VALIDATION_FAILED = '57'; // 'Ltv validation failed'
   string public constant INCONSISTENT_EMODE_CATEGORY = '58'; // 'Inconsistent eMode category'
@@ -901,17 +897,24 @@ library Errors {
   string public constant DEBT_CEILING_NOT_ZERO = '81'; // 'Debt ceiling is not zero'
   string public constant ASSET_NOT_LISTED = '82'; // 'Asset is not listed'
   string public constant INVALID_OPTIMAL_USAGE_RATIO = '83'; // 'Invalid optimal usage ratio'
-  string public constant INVALID_OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO = '84'; // 'Invalid optimal stable to total debt ratio'
   string public constant UNDERLYING_CANNOT_BE_RESCUED = '85'; // 'The underlying asset cannot be rescued'
   string public constant ADDRESSES_PROVIDER_ALREADY_ADDED = '86'; // 'Reserve has already been added to reserve list'
   string public constant POOL_ADDRESSES_DO_NOT_MATCH = '87'; // 'The token implementation pool address and the pool address provided by the initializing pool do not match'
-  string public constant STABLE_BORROWING_ENABLED = '88'; // 'Stable borrowing is enabled'
   string public constant SILOED_BORROWING_VIOLATION = '89'; // 'User is trying to borrow multiple assets including a siloed one'
   string public constant RESERVE_DEBT_NOT_ZERO = '90'; // the total debt of the reserve needs to be 0
   string public constant FLASHLOAN_DISABLED = '91'; // FlashLoaning for this asset is disabled
+  string public constant INVALID_MAX_RATE = '92'; // The expect maximum borrow rate is invalid
+  string public constant WITHDRAW_TO_ATOKEN = '93'; // Withdrawing to the aToken is not allowed
+  string public constant SUPPLY_TO_ATOKEN = '94'; // Supplying to the aToken is not allowed
+  string public constant SLOPE_2_MUST_BE_GTE_SLOPE_1 = '95'; // Variable interest rate slope 2 can not be lower than slope 1
+  string public constant CALLER_NOT_RISK_OR_POOL_OR_EMERGENCY_ADMIN = '96'; // 'The caller of the function is not a risk, pool or emergency admin'
+  string public constant LIQUIDATION_GRACE_SENTINEL_CHECK_FAILED = '97'; // 'Liquidation grace sentinel validation failed'
+  string public constant INVALID_GRACE_PERIOD = '98'; // Grace period above a valid range
+  string public constant INVALID_FREEZE_STATE = '99'; // Reserve is already in the passed freeze state
+  string public constant NOT_BORROWABLE_IN_EMODE = '100'; // Asset not borrowable in eMode
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/protocol/libraries/math/WadRayMath.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/protocol/libraries/math/WadRayMath.sol
 
 /**
  * @title WadRayMath library
@@ -1037,10 +1040,14 @@ library WadRayMath {
   }
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/protocol/libraries/types/DataTypes.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/protocol/libraries/types/DataTypes.sol
 
 library DataTypes {
-  struct ReserveData {
+  /**
+   * This exists specifically to maintain the `getReserveData()` interface, since the new, internal
+   * `ReserveData` struct includes the reserve's `virtualUnderlyingBalance`.
+   */
+  struct ReserveDataLegacy {
     //stores the reserve configuration
     ReserveConfigurationMap configuration;
     //the liquidity index. Expressed in ray
@@ -1051,7 +1058,7 @@ library DataTypes {
     uint128 variableBorrowIndex;
     //the current variable borrow rate. Expressed in ray
     uint128 currentVariableBorrowRate;
-    //the current stable borrow rate. Expressed in ray
+    // DEPRECATED on v3.2.0
     uint128 currentStableBorrowRate;
     //timestamp of last update
     uint40 lastUpdateTimestamp;
@@ -1059,7 +1066,7 @@ library DataTypes {
     uint16 id;
     //aToken address
     address aTokenAddress;
-    //stableDebtToken address
+    // DEPRECATED on v3.2.0
     address stableDebtTokenAddress;
     //variableDebtToken address
     address variableDebtTokenAddress;
@@ -1073,6 +1080,43 @@ library DataTypes {
     uint128 isolationModeTotalDebt;
   }
 
+  struct ReserveData {
+    //stores the reserve configuration
+    ReserveConfigurationMap configuration;
+    //the liquidity index. Expressed in ray
+    uint128 liquidityIndex;
+    //the current supply rate. Expressed in ray
+    uint128 currentLiquidityRate;
+    //variable borrow index. Expressed in ray
+    uint128 variableBorrowIndex;
+    //the current variable borrow rate. Expressed in ray
+    uint128 currentVariableBorrowRate;
+    // DEPRECATED on v3.2.0
+    uint128 __deprecatedStableBorrowRate;
+    //timestamp of last update
+    uint40 lastUpdateTimestamp;
+    //the id of the reserve. Represents the position in the list of the active reserves
+    uint16 id;
+    //timestamp until when liquidations are not allowed on the reserve, if set to past liquidations will be allowed
+    uint40 liquidationGracePeriodUntil;
+    //aToken address
+    address aTokenAddress;
+    // DEPRECATED on v3.2.0
+    address __deprecatedStableDebtTokenAddress;
+    //variableDebtToken address
+    address variableDebtTokenAddress;
+    //address of the interest rate strategy
+    address interestRateStrategyAddress;
+    //the current treasury balance, scaled
+    uint128 accruedToTreasury;
+    //the outstanding unbacked aTokens minted through the bridging feature
+    uint128 unbacked;
+    //the outstanding debt borrowed against this asset in isolation mode
+    uint128 isolationModeTotalDebt;
+    //the amount of underlying accounted for by the protocol
+    uint128 virtualUnderlyingBalance;
+  }
+
   struct ReserveConfigurationMap {
     //bit 0-15: LTV
     //bit 16-31: Liq. threshold
@@ -1081,18 +1125,20 @@ library DataTypes {
     //bit 56: reserve is active
     //bit 57: reserve is frozen
     //bit 58: borrowing is enabled
-    //bit 59: stable rate borrowing enabled
+    //bit 59: DEPRECATED: stable rate borrowing enabled
     //bit 60: asset is paused
     //bit 61: borrowing in isolation mode is enabled
-    //bit 62-63: reserved
+    //bit 62: siloed borrowing enabled
+    //bit 63: flashloaning enabled
     //bit 64-79: reserve factor
-    //bit 80-115 borrow cap in whole tokens, borrowCap == 0 => no cap
-    //bit 116-151 supply cap in whole tokens, supplyCap == 0 => no cap
-    //bit 152-167 liquidation protocol fee
-    //bit 168-175 eMode category
-    //bit 176-211 unbacked mint cap in whole tokens, unbackedMintCap == 0 => minting disabled
-    //bit 212-251 debt ceiling for isolation mode with (ReserveConfiguration::DEBT_CEILING_DECIMALS) decimals
-    //bit 252-255 unused
+    //bit 80-115: borrow cap in whole tokens, borrowCap == 0 => no cap
+    //bit 116-151: supply cap in whole tokens, supplyCap == 0 => no cap
+    //bit 152-167: liquidation protocol fee
+    //bit 168-175: DEPRECATED: eMode category
+    //bit 176-211: unbacked mint cap in whole tokens, unbackedMintCap == 0 => minting disabled
+    //bit 212-251: debt ceiling for isolation mode with (ReserveConfiguration::DEBT_CEILING_DECIMALS) decimals
+    //bit 252: virtual accounting is enabled for the reserve
+    //bit 253-255 unused
 
     uint256 data;
   }
@@ -1106,30 +1152,49 @@ library DataTypes {
     uint256 data;
   }
 
-  struct EModeCategory {
+  // DEPRECATED: kept for backwards compatibility, might be removed in a future version
+  struct EModeCategoryLegacy {
     // each eMode category has a custom ltv and liquidation threshold
     uint16 ltv;
     uint16 liquidationThreshold;
     uint16 liquidationBonus;
-    // each eMode category may or may not have a custom oracle to override the individual assets price oracles
+    // DEPRECATED
     address priceSource;
     string label;
   }
 
+  struct CollateralConfig {
+    uint16 ltv;
+    uint16 liquidationThreshold;
+    uint16 liquidationBonus;
+  }
+
+  struct EModeCategoryBaseConfiguration {
+    uint16 ltv;
+    uint16 liquidationThreshold;
+    uint16 liquidationBonus;
+    string label;
+  }
+
+  struct EModeCategory {
+    // each eMode category has a custom ltv and liquidation threshold
+    uint16 ltv;
+    uint16 liquidationThreshold;
+    uint16 liquidationBonus;
+    uint128 collateralBitmap;
+    string label;
+    uint128 borrowableBitmap;
+  }
+
   enum InterestRateMode {
     NONE,
-    STABLE,
+    __DEPRECATED,
     VARIABLE
   }
 
   struct ReserveCache {
     uint256 currScaledVariableDebt;
     uint256 nextScaledVariableDebt;
-    uint256 currPrincipalStableDebt;
-    uint256 currAvgStableBorrowRate;
-    uint256 currTotalStableDebt;
-    uint256 nextAvgStableBorrowRate;
-    uint256 nextTotalStableDebt;
     uint256 currLiquidityIndex;
     uint256 nextLiquidityIndex;
     uint256 currVariableBorrowIndex;
@@ -1139,10 +1204,8 @@ library DataTypes {
     uint256 reserveFactor;
     ReserveConfigurationMap reserveConfiguration;
     address aTokenAddress;
-    address stableDebtTokenAddress;
     address variableDebtTokenAddress;
     uint40 reserveLastUpdateTimestamp;
-    uint40 stableDebtLastUpdateTimestamp;
   }
 
   struct ExecuteLiquidationCallParams {
@@ -1172,7 +1235,6 @@ library DataTypes {
     InterestRateMode interestRateMode;
     uint16 referralCode;
     bool releaseUnderlying;
-    uint256 maxStableRateBorrowSizePercent;
     uint256 reservesCount;
     address oracle;
     uint8 userEModeCategory;
@@ -1224,9 +1286,9 @@ library DataTypes {
     uint16 referralCode;
     uint256 flashLoanPremiumToProtocol;
     uint256 flashLoanPremiumTotal;
-    uint256 maxStableRateBorrowSizePercent;
     uint256 reservesCount;
     address addressesProvider;
+    address pool;
     uint8 userEModeCategory;
     bool isAuthorizedFlashBorrower;
   }
@@ -1265,7 +1327,6 @@ library DataTypes {
     address userAddress;
     uint256 amount;
     InterestRateMode interestRateMode;
-    uint256 maxStableLoanPercent;
     uint256 reservesCount;
     address oracle;
     uint8 userEModeCategory;
@@ -1286,18 +1347,16 @@ library DataTypes {
     uint256 unbacked;
     uint256 liquidityAdded;
     uint256 liquidityTaken;
-    uint256 totalStableDebt;
-    uint256 totalVariableDebt;
-    uint256 averageStableBorrowRate;
+    uint256 totalDebt;
     uint256 reserveFactor;
     address reserve;
-    address aToken;
+    bool usingVirtualBalance;
+    uint256 virtualUnderlyingBalance;
   }
 
   struct InitReserveParams {
     address asset;
     address aTokenAddress;
-    address stableDebtAddress;
     address variableDebtAddress;
     address interestRateStrategyAddress;
     uint16 reservesCount;
@@ -1305,7 +1364,7 @@ library DataTypes {
   }
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/protocol/tokenization/base/EIP712Base.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/protocol/tokenization/base/EIP712Base.sol
 
 /**
  * @title EIP712Base
@@ -1375,7 +1434,7 @@ abstract contract EIP712Base {
   function _EIP712BaseId() internal view virtual returns (string memory);
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
 
 interface IERC20Detailed is IERC20 {
   function name() external view returns (string memory);
@@ -1385,7 +1444,7 @@ interface IERC20Detailed is IERC20 {
   function decimals() external view returns (uint8);
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/interfaces/IACLManager.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/interfaces/IACLManager.sol
 
 /**
  * @title IACLManager
@@ -1558,7 +1617,7 @@ interface IACLManager {
   function isAssetListingAdmin(address admin) external view returns (bool);
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/interfaces/IPool.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/interfaces/IPool.sol
 
 /**
  * @title IPool
@@ -1623,7 +1682,7 @@ interface IPool {
    * initiator of the transaction on flashLoan()
    * @param onBehalfOf The address that will be getting the debt
    * @param amount The amount borrowed out
-   * @param interestRateMode The rate mode: 1 for Stable, 2 for Variable
+   * @param interestRateMode The rate mode: 2 for Variable, 1 is deprecated (changed on v3.2.0)
    * @param borrowRate The numeric rate at which the user has borrowed, expressed in ray
    * @param referralCode The referral code used
    */
@@ -1653,18 +1712,6 @@ interface IPool {
     bool useATokens
   );
 
-  /**
-   * @dev Emitted on swapBorrowRateMode()
-   * @param reserve The address of the underlying asset of the reserve
-   * @param user The address of the user swapping his rate mode
-   * @param interestRateMode The current interest rate mode of the position being swapped: 1 for Stable, 2 for Variable
-   */
-  event SwapBorrowRateMode(
-    address indexed reserve,
-    address indexed user,
-    DataTypes.InterestRateMode interestRateMode
-  );
-
   /**
    * @dev Emitted on borrow(), repay() and liquidationCall() when using isolated assets
    * @param asset The address of the underlying asset of the reserve
@@ -1693,20 +1740,14 @@ interface IPool {
    */
   event ReserveUsedAsCollateralDisabled(address indexed reserve, address indexed user);
 
-  /**
-   * @dev Emitted on rebalanceStableBorrowRate()
-   * @param reserve The address of the underlying asset of the reserve
-   * @param user The address of the user for which the rebalance has been executed
-   */
-  event RebalanceStableBorrowRate(address indexed reserve, address indexed user);
-
   /**
    * @dev Emitted on flashLoan()
    * @param target The address of the flash loan receiver contract
    * @param initiator The address initiating the flash loan
    * @param asset The address of the asset being flash borrowed
    * @param amount The amount flash borrowed
-   * @param interestRateMode The flashloan mode: 0 for regular flashloan, 1 for Stable debt, 2 for Variable debt
+   * @param interestRateMode The flashloan mode: 0 for regular flashloan,
+   *        1 for Stable (Deprecated on v3.2.0), 2 for Variable
    * @param premium The fee flash borrowed
    * @param referralCode The referral code used
    */
@@ -1745,7 +1786,7 @@ interface IPool {
    * @dev Emitted when the state of a reserve is updated.
    * @param reserve The address of the underlying asset of the reserve
    * @param liquidityRate The next liquidity rate
-   * @param stableBorrowRate The next stable borrow rate
+   * @param stableBorrowRate The next stable borrow rate @note deprecated on v3.2.0
    * @param variableBorrowRate The next variable borrow rate
    * @param liquidityIndex The next liquidity index
    * @param variableBorrowIndex The next variable borrow index
@@ -1844,13 +1885,12 @@ interface IPool {
 
   /**
    * @notice Allows users to borrow a specific `amount` of the reserve underlying asset, provided that the borrower
-   * already supplied enough collateral, or he was given enough allowance by a credit delegator on the
-   * corresponding debt token (StableDebtToken or VariableDebtToken)
+   * already supplied enough collateral, or he was given enough allowance by a credit delegator on the VariableDebtToken
    * - E.g. User borrows 100 USDC passing as `onBehalfOf` his own address, receiving the 100 USDC in his wallet
-   *   and 100 stable/variable debt tokens, depending on the `interestRateMode`
+   *   and 100 variable debt tokens
    * @param asset The address of the underlying asset to borrow
    * @param amount The amount to be borrowed
-   * @param interestRateMode The interest rate mode at which the user wants to borrow: 1 for Stable, 2 for Variable
+   * @param interestRateMode 2 for Variable, 1 is deprecated on v3.2.0
    * @param referralCode The code used to register the integrator originating the operation, for potential rewards.
    *   0 if the action is executed directly by the user, without any middle-man
    * @param onBehalfOf The address of the user who will receive the debt. Should be the address of the borrower itself
@@ -1867,11 +1907,11 @@ interface IPool {
 
   /**
    * @notice Repays a borrowed `amount` on a specific reserve, burning the equivalent debt tokens owned
-   * - E.g. User repays 100 USDC, burning 100 variable/stable debt tokens of the `onBehalfOf` address
+   * - E.g. User repays 100 USDC, burning 100 variable debt tokens of the `onBehalfOf` address
    * @param asset The address of the borrowed underlying asset previously borrowed
    * @param amount The amount to repay
    * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
-   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable
+   * @param interestRateMode 2 for Variable, 1 is deprecated on v3.2.0
    * @param onBehalfOf The address of the user who will get his debt reduced/removed. Should be the address of the
    * user calling the function if he wants to reduce/remove his own debt, or the address of any other
    * other borrower whose debt should be removed
@@ -1890,7 +1930,7 @@ interface IPool {
    * @param asset The address of the borrowed underlying asset previously borrowed
    * @param amount The amount to repay
    * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
-   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable
+   * @param interestRateMode 2 for Variable, 1 is deprecated on v3.2.0
    * @param onBehalfOf Address of the user who will get his debt reduced/removed. Should be the address of the
    * user calling the function if he wants to reduce/remove his own debt, or the address of any other
    * other borrower whose debt should be removed
@@ -1914,13 +1954,13 @@ interface IPool {
   /**
    * @notice Repays a borrowed `amount` on a specific reserve using the reserve aTokens, burning the
    * equivalent debt tokens
-   * - E.g. User repays 100 USDC using 100 aUSDC, burning 100 variable/stable debt tokens
+   * - E.g. User repays 100 USDC using 100 aUSDC, burning 100 variable debt tokens
    * @dev  Passing uint256.max as amount will clean up any residual aToken dust balance, if the user aToken
    * balance is not enough to cover the whole debt
    * @param asset The address of the borrowed underlying asset previously borrowed
    * @param amount The amount to repay
    * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
-   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable
+   * @param interestRateMode DEPRECATED in v3.2.0
    * @return The final amount repaid
    */
   function repayWithATokens(
@@ -1929,24 +1969,6 @@ interface IPool {
     uint256 interestRateMode
   ) external returns (uint256);
 
-  /**
-   * @notice Allows a borrower to swap his debt between stable and variable mode, or vice versa
-   * @param asset The address of the underlying asset borrowed
-   * @param interestRateMode The current interest rate mode of the position being swapped: 1 for Stable, 2 for Variable
-   */
-  function swapBorrowRateMode(address asset, uint256 interestRateMode) external;
-
-  /**
-   * @notice Rebalances the stable interest rate of a user to the current stable rate defined on the reserve.
-   * - Users can be rebalanced if the following conditions are satisfied:
-   *     1. Usage ratio is above 95%
-   *     2. the current supply APY is below REBALANCE_UP_THRESHOLD * maxVariableBorrowRate, which means that too
-   *        much has been borrowed at a stable rate and suppliers are not earning enough
-   * @param asset The address of the underlying asset borrowed
-   * @param user The address of the user to be rebalanced
-   */
-  function rebalanceStableBorrowRate(address asset, address user) external;
-
   /**
    * @notice Allows suppliers to enable/disable a specific supplied asset as collateral
    * @param asset The address of the underlying asset supplied
@@ -1983,9 +2005,9 @@ interface IPool {
    * @param amounts The amounts of the assets being flash-borrowed
    * @param interestRateModes Types of the debt to open if the flash loan is not returned:
    *   0 -> Don't open any debt, just revert if funds can't be transferred from the receiver
-   *   1 -> Open debt at stable rate for the value of the amount flash-borrowed to the `onBehalfOf` address
+   *   1 -> Deprecated on v3.2.0
    *   2 -> Open debt at variable rate for the value of the amount flash-borrowed to the `onBehalfOf` address
-   * @param onBehalfOf The address  that will receive the debt in the case of using on `modes` 1 or 2
+   * @param onBehalfOf The address  that will receive the debt in the case of using 2 on `modes`
    * @param params Variadic packed params to pass to the receiver as extra information
    * @param referralCode The code used to register the integrator originating the operation, for potential rewards.
    *   0 if the action is executed directly by the user, without any middle-man
@@ -2050,14 +2072,12 @@ interface IPool {
    * @dev Only callable by the PoolConfigurator contract
    * @param asset The address of the underlying asset of the reserve
    * @param aTokenAddress The address of the aToken that will be assigned to the reserve
-   * @param stableDebtAddress The address of the StableDebtToken that will be assigned to the reserve
    * @param variableDebtAddress The address of the VariableDebtToken that will be assigned to the reserve
    * @param interestRateStrategyAddress The address of the interest rate strategy contract
    */
   function initReserve(
     address asset,
     address aTokenAddress,
-    address stableDebtAddress,
     address variableDebtAddress,
     address interestRateStrategyAddress
   ) external;
@@ -2065,6 +2085,7 @@ interface IPool {
   /**
    * @notice Drop a reserve
    * @dev Only callable by the PoolConfigurator contract
+   * @dev Does not reset eMode flags, which must be considered when reusing the same reserve id for a different reserve.
    * @param asset The address of the underlying asset of the reserve
    */
   function dropReserve(address asset) external;
@@ -2080,6 +2101,22 @@ interface IPool {
     address rateStrategyAddress
   ) external;
 
+  /**
+   * @notice Accumulates interest to all indexes of the reserve
+   * @dev Only callable by the PoolConfigurator contract
+   * @dev To be used when required by the configurator, for example when updating interest rates strategy data
+   * @param asset The address of the underlying asset of the reserve
+   */
+  function syncIndexesState(address asset) external;
+
+  /**
+   * @notice Updates interest rates on the reserve data
+   * @dev Only callable by the PoolConfigurator contract
+   * @dev To be used when required by the configurator, for example when updating interest rates strategy data
+   * @param asset The address of the underlying asset of the reserve
+   */
+  function syncRatesState(address asset) external;
+
   /**
    * @notice Sets the configuration bitmap of the reserve as a whole
    * @dev Only callable by the PoolConfigurator contract
@@ -2135,7 +2172,24 @@ interface IPool {
    * @param asset The address of the underlying asset of the reserve
    * @return The state and configuration data of the reserve
    */
-  function getReserveData(address asset) external view returns (DataTypes.ReserveData memory);
+  function getReserveData(address asset) external view returns (DataTypes.ReserveDataLegacy memory);
+
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
+  /**
+   * @notice Returns the virtual underlying balance of the reserve
+   * @param asset The address of the underlying asset of the reserve
+   * @return The reserve virtual underlying balance
+   */
+  function getVirtualUnderlyingBalance(address asset) external view returns (uint128);
 
   /**
    * @notice Validates and finalizes an aToken transfer
@@ -2163,6 +2217,13 @@ interface IPool {
    */
   function getReservesList() external view returns (address[] memory);
 
+  /**
+   * @notice Returns the number of initialized reserves
+   * @dev It includes dropped reserves
+   * @return The count
+   */
+  function getReservesCount() external view returns (uint256);
+
   /**
    * @notice Returns the address of the underlying asset of a reserve by the reserve id as stored in the DataTypes.ReserveData struct
    * @param id The id of the reserve as stored in the DataTypes.ReserveData struct
@@ -2198,20 +2259,70 @@ interface IPool {
   ) external;
 
   /**
-   * @notice Configures a new category for the eMode.
+   * @notice Configures a new or alters an existing collateral configuration of an eMode.
    * @dev In eMode, the protocol allows very high borrowing power to borrow assets of the same category.
    * The category 0 is reserved as it's the default for volatile assets
    * @param id The id of the category
    * @param config The configuration of the category
    */
-  function configureEModeCategory(uint8 id, DataTypes.EModeCategory memory config) external;
+  function configureEModeCategory(
+    uint8 id,
+    DataTypes.EModeCategoryBaseConfiguration memory config
+  ) external;
+
+  /**
+   * @notice Replaces the current eMode collateralBitmap.
+   * @param id The id of the category
+   * @param collateralBitmap The collateralBitmap of the category
+   */
+  function configureEModeCategoryCollateralBitmap(uint8 id, uint128 collateralBitmap) external;
+
+  /**
+   * @notice Replaces the current eMode borrowableBitmap.
+   * @param id The id of the category
+   * @param borrowableBitmap The borrowableBitmap of the category
+   */
+  function configureEModeCategoryBorrowableBitmap(uint8 id, uint128 borrowableBitmap) external;
 
   /**
    * @notice Returns the data of an eMode category
+   * @dev DEPRECATED use independent getters instead
    * @param id The id of the category
    * @return The configuration data of the category
    */
-  function getEModeCategoryData(uint8 id) external view returns (DataTypes.EModeCategory memory);
+  function getEModeCategoryData(
+    uint8 id
+  ) external view returns (DataTypes.EModeCategoryLegacy memory);
+
+  /**
+   * @notice Returns the label of an eMode category
+   * @param id The id of the category
+   * @return The label of the category
+   */
+  function getEModeCategoryLabel(uint8 id) external view returns (string memory);
+
+  /**
+   * @notice Returns the collateral config of an eMode category
+   * @param id The id of the category
+   * @return The ltv,lt,lb of the category
+   */
+  function getEModeCategoryCollateralConfig(
+    uint8 id
+  ) external view returns (DataTypes.CollateralConfig memory);
+
+  /**
+   * @notice Returns the collateralBitmap of an eMode category
+   * @param id The id of the category
+   * @return The collateralBitmap of the category
+   */
+  function getEModeCategoryCollateralBitmap(uint8 id) external view returns (uint128);
+
+  /**
+   * @notice Returns the borrowableBitmap of an eMode category
+   * @param id The id of the category
+   * @return The borrowableBitmap of the category
+   */
+  function getEModeCategoryBorrowableBitmap(uint8 id) external view returns (uint128);
 
   /**
    * @notice Allows a user to use the protocol in eMode
@@ -2234,10 +2345,20 @@ interface IPool {
   function resetIsolationModeTotalDebt(address asset) external;
 
   /**
-   * @notice Returns the percentage of available liquidity that can be borrowed at once at stable rate
-   * @return The percentage of available liquidity to borrow, expressed in bps
-   */
-  function MAX_STABLE_RATE_BORROW_SIZE_PERCENT() external view returns (uint256);
+   * @notice Sets the liquidation grace period of the given asset
+   * @dev To enable a liquidation grace period, a timestamp in the future should be set,
+   *      To disable a liquidation grace period, any timestamp in the past works, like 0
+   * @param asset The address of the underlying asset to set the liquidationGracePeriod
+   * @param until Timestamp when the liquidation grace period will end
+   **/
+  function setLiquidationGracePeriod(address asset, uint40 until) external;
+
+  /**
+   * @notice Returns the liquidation grace period of the given asset
+   * @param asset The address of the underlying asset
+   * @return Timestamp when the liquidation grace period will end
+   **/
+  function getLiquidationGracePeriod(address asset) external returns (uint40);
 
   /**
    * @notice Returns the total fee on flash loans
@@ -2290,9 +2411,44 @@ interface IPool {
    *   0 if the action is executed directly by the user, without any middle-man
    */
   function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
+
+  /**
+   * @notice Gets the address of the external FlashLoanLogic
+   */
+  function getFlashLoanLogic() external view returns (address);
+
+  /**
+   * @notice Gets the address of the external BorrowLogic
+   */
+  function getBorrowLogic() external view returns (address);
+
+  /**
+   * @notice Gets the address of the external BridgeLogic
+   */
+  function getBridgeLogic() external view returns (address);
+
+  /**
+   * @notice Gets the address of the external EModeLogic
+   */
+  function getEModeLogic() external view returns (address);
+
+  /**
+   * @notice Gets the address of the external LiquidationLogic
+   */
+  function getLiquidationLogic() external view returns (address);
+
+  /**
+   * @notice Gets the address of the external PoolLogic
+   */
+  function getPoolLogic() external view returns (address);
+
+  /**
+   * @notice Gets the address of the external SupplyLogic
+   */
+  function getSupplyLogic() external view returns (address);
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/interfaces/IInitializableDebtToken.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/interfaces/IInitializableDebtToken.sol
 
 /**
  * @title IInitializableDebtToken
@@ -2341,12 +2497,12 @@ interface IInitializableDebtToken {
   ) external;
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/protocol/tokenization/base/DebtTokenBase.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/protocol/tokenization/base/DebtTokenBase.sol
 
 /**
  * @title DebtTokenBase
  * @author Aave
- * @notice Base contract for different types of debt tokens, like StableDebtToken or VariableDebtToken
+ * @notice Base contract for different types of debt tokens, like VariableDebtToken
  */
 abstract contract DebtTokenBase is
   VersionedInitializable,
@@ -2437,7 +2593,7 @@ abstract contract DebtTokenBase is
   }
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/interfaces/IVariableDebtToken.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/interfaces/IVariableDebtToken.sol
 
 /**
  * @title IVariableDebtToken
@@ -2480,7 +2636,7 @@ interface IVariableDebtToken is IScaledBalanceToken, IInitializableDebtToken {
   function UNDERLYING_ASSET_ADDRESS() external view returns (address);
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/protocol/tokenization/base/IncentivizedERC20.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/protocol/tokenization/base/IncentivizedERC20.sol
 
 /**
  * @title IncentivizedERC20
@@ -2511,8 +2667,7 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
   /**
    * @dev UserState - additionalData is a flexible field.
    * ATokens and VariableDebtTokens use this field store the index of the
-   * user's last supply/withdrawal/borrow/repayment. StableDebtTokens use
-   * this field to store the user's stable rate.
+   * user's last supply/withdrawal/borrow/repayment.
    */
   struct UserState {
     uint128 balance;
@@ -2535,15 +2690,15 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
   /**
    * @dev Constructor.
    * @param pool The reference to the main Pool contract
-   * @param name The name of the token
-   * @param symbol The symbol of the token
-   * @param decimals The number of decimals of the token
+   * @param name_ The name of the token
+   * @param symbol_ The symbol of the token
+   * @param decimals_ The number of decimals of the token
    */
-  constructor(IPool pool, string memory name, string memory symbol, uint8 decimals) {
+  constructor(IPool pool, string memory name_, string memory symbol_, uint8 decimals_) {
     _addressesProvider = pool.ADDRESSES_PROVIDER();
-    _name = name;
-    _symbol = symbol;
-    _decimals = decimals;
+    _name = name_;
+    _symbol = symbol_;
+    _decimals = decimals_;
     POOL = pool;
   }
 
@@ -2704,7 +2859,7 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
   }
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/protocol/tokenization/base/MintableIncentivizedERC20.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/protocol/tokenization/base/MintableIncentivizedERC20.sol
 
 /**
  * @title MintableIncentivizedERC20
@@ -2766,7 +2921,7 @@ abstract contract MintableIncentivizedERC20 is IncentivizedERC20 {
   }
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/protocol/tokenization/base/ScaledBalanceTokenBase.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/protocol/tokenization/base/ScaledBalanceTokenBase.sol
 
 /**
  * @title ScaledBalanceTokenBase
@@ -2915,7 +3070,7 @@ abstract contract ScaledBalanceTokenBase is MintableIncentivizedERC20, IScaledBa
   }
 }
 
-// downloads/ARBITRUM/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtToken/lib/aave-v3-core/contracts/protocol/tokenization/VariableDebtToken.sol
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/protocol/tokenization/VariableDebtToken.sol
 
 /**
  * @title VariableDebtToken
@@ -2924,12 +3079,10 @@ abstract contract ScaledBalanceTokenBase is MintableIncentivizedERC20, IScaledBa
  * at variable rate mode
  * @dev Transfer and approve functionalities are disabled since its a non-transferable token
  */
-contract VariableDebtToken is DebtTokenBase, ScaledBalanceTokenBase, IVariableDebtToken {
+abstract contract VariableDebtToken is DebtTokenBase, ScaledBalanceTokenBase, IVariableDebtToken {
   using WadRayMath for uint256;
   using SafeCast for uint256;
 
-  uint256 public constant DEBT_TOKEN_REVISION = 0x2;
-
   /**
    * @dev Constructor.
    * @param pool The address of the Pool contract
@@ -2952,32 +3105,7 @@ contract VariableDebtToken is DebtTokenBase, ScaledBalanceTokenBase, IVariableDe
     string memory debtTokenName,
     string memory debtTokenSymbol,
     bytes calldata params
-  ) external override initializer {
-    require(initializingPool == POOL, Errors.POOL_ADDRESSES_DO_NOT_MATCH);
-    _setName(debtTokenName);
-    _setSymbol(debtTokenSymbol);
-    _setDecimals(debtTokenDecimals);
-
-    _underlyingAsset = underlyingAsset;
-    _incentivesController = incentivesController;
-
-    _domainSeparator = _calculateDomainSeparator();
-
-    emit Initialized(
-      underlyingAsset,
-      address(POOL),
-      address(incentivesController),
-      debtTokenDecimals,
-      debtTokenName,
-      debtTokenSymbol,
-      params
-    );
-  }
-
-  /// @inheritdoc VersionedInitializable
-  function getRevision() internal pure virtual override returns (uint256) {
-    return DEBT_TOKEN_REVISION;
-  }
+  ) external virtual;
 
   /// @inheritdoc IERC20
   function balanceOf(address user) public view virtual override returns (uint256) {
@@ -3056,3 +3184,47 @@ contract VariableDebtToken is DebtTokenBase, ScaledBalanceTokenBase, IVariableDe
     return _underlyingAsset;
   }
 }
+
+// downloads/LINEA/DEFAULT_VARIABLE_DEBT_TOKEN_IMPL/VariableDebtTokenInstance/src/contracts/instances/VariableDebtTokenInstance.sol
+
+contract VariableDebtTokenInstance is VariableDebtToken {
+  uint256 public constant DEBT_TOKEN_REVISION = 1;
+
+  constructor(IPool pool) VariableDebtToken(pool) {}
+
+  /// @inheritdoc VersionedInitializable
+  function getRevision() internal pure virtual override returns (uint256) {
+    return DEBT_TOKEN_REVISION;
+  }
+
+  /// @inheritdoc IInitializableDebtToken
+  function initialize(
+    IPool initializingPool,
+    address underlyingAsset,
+    IAaveIncentivesController incentivesController,
+    uint8 debtTokenDecimals,
+    string memory debtTokenName,
+    string memory debtTokenSymbol,
+    bytes calldata params
+  ) external override initializer {
+    require(initializingPool == POOL, Errors.POOL_ADDRESSES_DO_NOT_MATCH);
+    _setName(debtTokenName);
+    _setSymbol(debtTokenSymbol);
+    _setDecimals(debtTokenDecimals);
+
+    _underlyingAsset = underlyingAsset;
+    _incentivesController = incentivesController;
+
+    _domainSeparator = _calculateDomainSeparator();
+
+    emit Initialized(
+      underlyingAsset,
+      address(POOL),
+      address(incentivesController),
+      debtTokenDecimals,
+      debtTokenName,
+      debtTokenSymbol,
+      params
+    );
+  }
+}
```
