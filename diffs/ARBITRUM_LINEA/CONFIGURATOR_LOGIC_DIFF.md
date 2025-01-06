```diff
diff --git a/./downloads/ARBITRUM/CONFIGURATOR_LOGIC.sol b/./downloads/LINEA/CONFIGURATOR_LOGIC.sol
index b92a1a1..22e067d 100644
--- a/./downloads/ARBITRUM/CONFIGURATOR_LOGIC.sol
+++ b/./downloads/LINEA/CONFIGURATOR_LOGIC.sol
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/dependencies/openzeppelin/contracts/Address.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/dependencies/openzeppelin/contracts/Address.sol
 
 // OpenZeppelin Contracts v4.4.1 (utils/Address.sol)
 
@@ -221,7 +221,7 @@ library Address {
   }
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
 
 /**
  * @dev Interface of the ERC20 standard as defined in the EIP.
@@ -297,7 +297,7 @@ interface IERC20 {
   event Approval(address indexed owner, address indexed spender, uint256 value);
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/dependencies/openzeppelin/upgradeability/Proxy.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/dependencies/openzeppelin/upgradeability/Proxy.sol
 
 /**
  * @title Proxy
@@ -378,7 +378,7 @@ abstract contract Proxy {
   }
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/interfaces/IAaveIncentivesController.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/interfaces/IAaveIncentivesController.sol
 
 /**
  * @title IAaveIncentivesController
@@ -397,7 +397,7 @@ interface IAaveIncentivesController {
   function handleAction(address user, uint256 totalSupply, uint256 userBalance) external;
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -624,7 +624,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/protocol/libraries/helpers/Errors.sol
 
 /**
  * @title Errors library
@@ -662,17 +662,14 @@ library Errors {
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
@@ -685,7 +682,6 @@ library Errors {
   string public constant UNBACKED_MINT_CAP_EXCEEDED = '52'; // 'Unbacked mint cap is exceeded'
   string public constant DEBT_CEILING_EXCEEDED = '53'; // 'Debt ceiling is exceeded'
   string public constant UNDERLYING_CLAIMABLE_RIGHTS_NOT_ZERO = '54'; // 'Claimable rights over underlying not zero (aToken supply or accruedToTreasury)'
-  string public constant STABLE_DEBT_NOT_ZERO = '55'; // 'Stable debt supply is not zero'
   string public constant VARIABLE_DEBT_SUPPLY_NOT_ZERO = '56'; // 'Variable debt supply is not zero'
   string public constant LTV_VALIDATION_FAILED = '57'; // 'Ltv validation failed'
   string public constant INCONSISTENT_EMODE_CATEGORY = '58'; // 'Inconsistent eMode category'
@@ -714,11 +710,9 @@ library Errors {
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
@@ -730,14 +724,14 @@ library Errors {
   string public constant LIQUIDATION_GRACE_SENTINEL_CHECK_FAILED = '97'; // 'Liquidation grace sentinel validation failed'
   string public constant INVALID_GRACE_PERIOD = '98'; // Grace period above a valid range
   string public constant INVALID_FREEZE_STATE = '99'; // Reserve is already in the passed freeze state
+  string public constant NOT_BORROWABLE_IN_EMODE = '100'; // Asset not borrowable in eMode
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/protocol/libraries/types/ConfiguratorInputTypes.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/protocol/libraries/types/ConfiguratorInputTypes.sol
 
 library ConfiguratorInputTypes {
   struct InitReserveInput {
     address aTokenImpl;
-    address stableDebtTokenImpl;
     address variableDebtTokenImpl;
     bool useVirtualBalance;
     address interestRateStrategyAddress;
@@ -748,8 +742,6 @@ library ConfiguratorInputTypes {
     string aTokenSymbol;
     string variableDebtTokenName;
     string variableDebtTokenSymbol;
-    string stableDebtTokenName;
-    string stableDebtTokenSymbol;
     bytes params;
     bytes interestRateData;
   }
@@ -774,7 +766,7 @@ library ConfiguratorInputTypes {
   }
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/protocol/libraries/types/DataTypes.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/protocol/libraries/types/DataTypes.sol
 
 library DataTypes {
   /**
@@ -792,7 +784,7 @@ library DataTypes {
     uint128 variableBorrowIndex;
     //the current variable borrow rate. Expressed in ray
     uint128 currentVariableBorrowRate;
-    //the current stable borrow rate. Expressed in ray
+    // DEPRECATED on v3.2.0
     uint128 currentStableBorrowRate;
     //timestamp of last update
     uint40 lastUpdateTimestamp;
@@ -800,7 +792,7 @@ library DataTypes {
     uint16 id;
     //aToken address
     address aTokenAddress;
-    //stableDebtToken address
+    // DEPRECATED on v3.2.0
     address stableDebtTokenAddress;
     //variableDebtToken address
     address variableDebtTokenAddress;
@@ -825,8 +817,8 @@ library DataTypes {
     uint128 variableBorrowIndex;
     //the current variable borrow rate. Expressed in ray
     uint128 currentVariableBorrowRate;
-    //the current stable borrow rate. Expressed in ray
-    uint128 currentStableBorrowRate;
+    // DEPRECATED on v3.2.0
+    uint128 __deprecatedStableBorrowRate;
     //timestamp of last update
     uint40 lastUpdateTimestamp;
     //the id of the reserve. Represents the position in the list of the active reserves
@@ -835,8 +827,8 @@ library DataTypes {
     uint40 liquidationGracePeriodUntil;
     //aToken address
     address aTokenAddress;
-    //stableDebtToken address
-    address stableDebtTokenAddress;
+    // DEPRECATED on v3.2.0
+    address __deprecatedStableDebtTokenAddress;
     //variableDebtToken address
     address variableDebtTokenAddress;
     //address of the interest rate strategy
@@ -859,7 +851,7 @@ library DataTypes {
     //bit 56: reserve is active
     //bit 57: reserve is frozen
     //bit 58: borrowing is enabled
-    //bit 59: stable rate borrowing enabled
+    //bit 59: DEPRECATED: stable rate borrowing enabled
     //bit 60: asset is paused
     //bit 61: borrowing in isolation mode is enabled
     //bit 62: siloed borrowing enabled
@@ -868,7 +860,7 @@ library DataTypes {
     //bit 80-115: borrow cap in whole tokens, borrowCap == 0 => no cap
     //bit 116-151: supply cap in whole tokens, supplyCap == 0 => no cap
     //bit 152-167: liquidation protocol fee
-    //bit 168-175: eMode category
+    //bit 168-175: DEPRECATED: eMode category
     //bit 176-211: unbacked mint cap in whole tokens, unbackedMintCap == 0 => minting disabled
     //bit 212-251: debt ceiling for isolation mode with (ReserveConfiguration::DEBT_CEILING_DECIMALS) decimals
     //bit 252: virtual accounting is enabled for the reserve
@@ -886,30 +878,49 @@ library DataTypes {
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
@@ -919,10 +930,8 @@ library DataTypes {
     uint256 reserveFactor;
     ReserveConfigurationMap reserveConfiguration;
     address aTokenAddress;
-    address stableDebtTokenAddress;
     address variableDebtTokenAddress;
     uint40 reserveLastUpdateTimestamp;
-    uint40 stableDebtLastUpdateTimestamp;
   }
 
   struct ExecuteLiquidationCallParams {
@@ -952,7 +961,6 @@ library DataTypes {
     InterestRateMode interestRateMode;
     uint16 referralCode;
     bool releaseUnderlying;
-    uint256 maxStableRateBorrowSizePercent;
     uint256 reservesCount;
     address oracle;
     uint8 userEModeCategory;
@@ -1004,7 +1012,6 @@ library DataTypes {
     uint16 referralCode;
     uint256 flashLoanPremiumToProtocol;
     uint256 flashLoanPremiumTotal;
-    uint256 maxStableRateBorrowSizePercent;
     uint256 reservesCount;
     address addressesProvider;
     address pool;
@@ -1046,7 +1053,6 @@ library DataTypes {
     address userAddress;
     uint256 amount;
     InterestRateMode interestRateMode;
-    uint256 maxStableLoanPercent;
     uint256 reservesCount;
     address oracle;
     uint8 userEModeCategory;
@@ -1067,9 +1073,7 @@ library DataTypes {
     uint256 unbacked;
     uint256 liquidityAdded;
     uint256 liquidityTaken;
-    uint256 totalStableDebt;
-    uint256 totalVariableDebt;
-    uint256 averageStableBorrowRate;
+    uint256 totalDebt;
     uint256 reserveFactor;
     address reserve;
     bool usingVirtualBalance;
@@ -1079,7 +1083,6 @@ library DataTypes {
   struct InitReserveParams {
     address asset;
     address aTokenAddress;
-    address stableDebtAddress;
     address variableDebtAddress;
     address interestRateStrategyAddress;
     uint16 reservesCount;
@@ -1087,7 +1090,7 @@ library DataTypes {
   }
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
 
 interface IERC20Detailed is IERC20 {
   function name() external view returns (string memory);
@@ -1097,7 +1100,7 @@ interface IERC20Detailed is IERC20 {
   function decimals() external view returns (uint8);
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/interfaces/IReserveInterestRateStrategy.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/interfaces/IReserveInterestRateStrategy.sol
 
 /**
  * @title IReserveInterestRateStrategy
@@ -1117,15 +1120,14 @@ interface IReserveInterestRateStrategy {
    * @notice Calculates the interest rates depending on the reserve's state and configurations
    * @param params The parameters needed to calculate interest rates
    * @return liquidityRate The liquidity rate expressed in ray
-   * @return stableBorrowRate The stable borrow rate expressed in ray
    * @return variableBorrowRate The variable borrow rate expressed in ray
    */
   function calculateInterestRates(
     DataTypes.CalculateInterestRatesParams memory params
-  ) external view returns (uint256, uint256, uint256);
+  ) external view returns (uint256, uint256);
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/dependencies/openzeppelin/upgradeability/BaseUpgradeabilityProxy.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/dependencies/openzeppelin/upgradeability/BaseUpgradeabilityProxy.sol
 
 /**
  * @title BaseUpgradeabilityProxy
@@ -1188,7 +1190,7 @@ contract BaseUpgradeabilityProxy is Proxy {
   }
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/interfaces/IPool.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/interfaces/IPool.sol
 
 /**
  * @title IPool
@@ -1253,7 +1255,7 @@ interface IPool {
    * initiator of the transaction on flashLoan()
    * @param onBehalfOf The address that will be getting the debt
    * @param amount The amount borrowed out
-   * @param interestRateMode The rate mode: 1 for Stable, 2 for Variable
+   * @param interestRateMode The rate mode: 2 for Variable, 1 is deprecated (changed on v3.2.0)
    * @param borrowRate The numeric rate at which the user has borrowed, expressed in ray
    * @param referralCode The referral code used
    */
@@ -1283,18 +1285,6 @@ interface IPool {
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
@@ -1323,20 +1313,14 @@ interface IPool {
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
@@ -1375,7 +1359,7 @@ interface IPool {
    * @dev Emitted when the state of a reserve is updated.
    * @param reserve The address of the underlying asset of the reserve
    * @param liquidityRate The next liquidity rate
-   * @param stableBorrowRate The next stable borrow rate
+   * @param stableBorrowRate The next stable borrow rate @note deprecated on v3.2.0
    * @param variableBorrowRate The next variable borrow rate
    * @param liquidityIndex The next liquidity index
    * @param variableBorrowIndex The next variable borrow index
@@ -1474,13 +1458,12 @@ interface IPool {
 
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
@@ -1497,11 +1480,11 @@ interface IPool {
 
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
@@ -1520,7 +1503,7 @@ interface IPool {
    * @param asset The address of the borrowed underlying asset previously borrowed
    * @param amount The amount to repay
    * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
-   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable
+   * @param interestRateMode 2 for Variable, 1 is deprecated on v3.2.0
    * @param onBehalfOf Address of the user who will get his debt reduced/removed. Should be the address of the
    * user calling the function if he wants to reduce/remove his own debt, or the address of any other
    * other borrower whose debt should be removed
@@ -1544,13 +1527,13 @@ interface IPool {
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
@@ -1559,32 +1542,6 @@ interface IPool {
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
-   * @notice Permissionless method which allows anyone to swap a users stable debt to variable debt
-   * @dev Introduced in favor of stable rate deprecation
-   * @param asset The address of the underlying asset borrowed
-   * @param user The address of the user whose debt will be swapped from stable to variable
-   */
-  function swapToVariable(address asset, address user) external;
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
@@ -1621,9 +1578,9 @@ interface IPool {
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
@@ -1688,14 +1645,12 @@ interface IPool {
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
@@ -1703,6 +1658,7 @@ interface IPool {
   /**
    * @notice Drop a reserve
    * @dev Only callable by the PoolConfigurator contract
+   * @dev Does not reset eMode flags, which must be considered when reusing the same reserve id for a different reserve.
    * @param asset The address of the underlying asset of the reserve
    */
   function dropReserve(address asset) external;
@@ -1793,6 +1749,7 @@ interface IPool {
 
   /**
    * @notice Returns the state and configuration of the reserve, including extra data included with Aave v3.1
+   * @dev DEPRECATED use independent getters instead (getReserveData, getLiquidationGracePeriod)
    * @param asset The address of the underlying asset of the reserve
    * @return The state and configuration data of the reserve with virtual accounting
    */
@@ -1875,20 +1832,70 @@ interface IPool {
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
@@ -1926,12 +1933,6 @@ interface IPool {
    **/
   function getLiquidationGracePeriod(address asset) external returns (uint40);
 
-  /**
-   * @notice Returns the percentage of available liquidity that can be borrowed at once at stable rate
-   * @return The percentage of available liquidity to borrow, expressed in bps
-   */
-  function MAX_STABLE_RATE_BORROW_SIZE_PERCENT() external view returns (uint256);
-
   /**
    * @notice Returns the total fee on flash loans
    * @return The total fee on flashloans
@@ -1987,40 +1988,40 @@ interface IPool {
   /**
    * @notice Gets the address of the external FlashLoanLogic
    */
-  function getFlashLoanLogic() external returns (address);
+  function getFlashLoanLogic() external view returns (address);
 
   /**
    * @notice Gets the address of the external BorrowLogic
    */
-  function getBorrowLogic() external returns (address);
+  function getBorrowLogic() external view returns (address);
 
   /**
    * @notice Gets the address of the external BridgeLogic
    */
-  function getBridgeLogic() external returns (address);
+  function getBridgeLogic() external view returns (address);
 
   /**
    * @notice Gets the address of the external EModeLogic
    */
-  function getEModeLogic() external returns (address);
+  function getEModeLogic() external view returns (address);
 
   /**
    * @notice Gets the address of the external LiquidationLogic
    */
-  function getLiquidationLogic() external returns (address);
+  function getLiquidationLogic() external view returns (address);
 
   /**
    * @notice Gets the address of the external PoolLogic
    */
-  function getPoolLogic() external returns (address);
+  function getPoolLogic() external view returns (address);
 
   /**
    * @notice Gets the address of the external SupplyLogic
    */
-  function getSupplyLogic() external returns (address);
+  function getSupplyLogic() external view returns (address);
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
 
 /**
  * @title ReserveConfiguration library
@@ -2035,7 +2036,7 @@ library ReserveConfiguration {
   uint256 internal constant ACTIVE_MASK =                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant FROZEN_MASK =                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant BORROWING_MASK =                 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFFFFFFFFFFF; // prettier-ignore
-  uint256 internal constant STABLE_BORROWING_MASK =          0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFF; // prettier-ignore
+  // @notice there is an unoccupied hole of 1 bit at position 59 from pre 3.2 stableBorrowRateEnabled
   uint256 internal constant PAUSED_MASK =                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant BORROWABLE_IN_ISOLATION_MASK =   0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant SILOED_BORROWING_MASK =          0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFFFFFFFFFFFF; // prettier-ignore
@@ -2044,7 +2045,7 @@ library ReserveConfiguration {
   uint256 internal constant BORROW_CAP_MASK =                0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000FFFFFFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant SUPPLY_CAP_MASK =                0xFFFFFFFFFFFFFFFFFFFFFFFFFF000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant LIQUIDATION_PROTOCOL_FEE_MASK =  0xFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
-  uint256 internal constant EMODE_CATEGORY_MASK =            0xFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
+  // @notice there is an unoccupied hole of 8 bits from 168 to 176 left from pre 3.2 eModeCategory
   uint256 internal constant UNBACKED_MINT_CAP_MASK =         0xFFFFFFFFFFF000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant DEBT_CEILING_MASK =              0xF0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
   uint256 internal constant VIRTUAL_ACC_ACTIVE_MASK =        0xEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
@@ -2056,7 +2057,6 @@ library ReserveConfiguration {
   uint256 internal constant IS_ACTIVE_START_BIT_POSITION = 56;
   uint256 internal constant IS_FROZEN_START_BIT_POSITION = 57;
   uint256 internal constant BORROWING_ENABLED_START_BIT_POSITION = 58;
-  uint256 internal constant STABLE_BORROWING_ENABLED_START_BIT_POSITION = 59;
   uint256 internal constant IS_PAUSED_START_BIT_POSITION = 60;
   uint256 internal constant BORROWABLE_IN_ISOLATION_START_BIT_POSITION = 61;
   uint256 internal constant SILOED_BORROWING_START_BIT_POSITION = 62;
@@ -2065,7 +2065,7 @@ library ReserveConfiguration {
   uint256 internal constant BORROW_CAP_START_BIT_POSITION = 80;
   uint256 internal constant SUPPLY_CAP_START_BIT_POSITION = 116;
   uint256 internal constant LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION = 152;
-  uint256 internal constant EMODE_CATEGORY_START_BIT_POSITION = 168;
+  //@notice there is an unoccupied hole of 8 bits from 168 to 176 left from pre 3.2 eModeCategory
   uint256 internal constant UNBACKED_MINT_CAP_START_BIT_POSITION = 176;
   uint256 internal constant DEBT_CEILING_START_BIT_POSITION = 212;
   uint256 internal constant VIRTUAL_ACC_START_BIT_POSITION = 252;
@@ -2078,7 +2078,6 @@ library ReserveConfiguration {
   uint256 internal constant MAX_VALID_BORROW_CAP = 68719476735;
   uint256 internal constant MAX_VALID_SUPPLY_CAP = 68719476735;
   uint256 internal constant MAX_VALID_LIQUIDATION_PROTOCOL_FEE = 65535;
-  uint256 internal constant MAX_VALID_EMODE_CATEGORY = 255;
   uint256 internal constant MAX_VALID_UNBACKED_MINT_CAP = 68719476735;
   uint256 internal constant MAX_VALID_DEBT_CEILING = 1099511627775;
 
@@ -2329,31 +2328,6 @@ library ReserveConfiguration {
     return (self.data & ~BORROWING_MASK) != 0;
   }
 
-  /**
-   * @notice Enables or disables stable rate borrowing on the reserve
-   * @param self The reserve configuration
-   * @param enabled True if the stable rate borrowing needs to be enabled, false otherwise
-   */
-  function setStableRateBorrowingEnabled(
-    DataTypes.ReserveConfigurationMap memory self,
-    bool enabled
-  ) internal pure {
-    self.data =
-      (self.data & STABLE_BORROWING_MASK) |
-      (uint256(enabled ? 1 : 0) << STABLE_BORROWING_ENABLED_START_BIT_POSITION);
-  }
-
-  /**
-   * @notice Gets the stable rate borrowing state of the reserve
-   * @param self The reserve configuration
-   * @return The stable rate borrowing state
-   */
-  function getStableRateBorrowingEnabled(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (bool) {
-    return (self.data & ~STABLE_BORROWING_MASK) != 0;
-  }
-
   /**
    * @notice Sets the reserve factor of the reserve
    * @param self The reserve configuration
@@ -2514,31 +2488,6 @@ library ReserveConfiguration {
     return (self.data & ~UNBACKED_MINT_CAP_MASK) >> UNBACKED_MINT_CAP_START_BIT_POSITION;
   }
 
-  /**
-   * @notice Sets the eMode asset category
-   * @param self The reserve configuration
-   * @param category The asset category when the user selects the eMode
-   */
-  function setEModeCategory(
-    DataTypes.ReserveConfigurationMap memory self,
-    uint256 category
-  ) internal pure {
-    require(category <= MAX_VALID_EMODE_CATEGORY, Errors.INVALID_EMODE_CATEGORY);
-
-    self.data = (self.data & EMODE_CATEGORY_MASK) | (category << EMODE_CATEGORY_START_BIT_POSITION);
-  }
-
-  /**
-   * @dev Gets the eMode asset category
-   * @param self The reserve configuration
-   * @return The eMode category for the asset
-   */
-  function getEModeCategory(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (uint256) {
-    return (self.data & ~EMODE_CATEGORY_MASK) >> EMODE_CATEGORY_START_BIT_POSITION;
-  }
-
   /**
    * @notice Sets the flashloanable flag for the reserve
    * @param self The reserve configuration
@@ -2597,19 +2546,17 @@ library ReserveConfiguration {
    * @return The state flag representing active
    * @return The state flag representing frozen
    * @return The state flag representing borrowing enabled
-   * @return The state flag representing stableRateBorrowing enabled
    * @return The state flag representing paused
    */
   function getFlags(
     DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (bool, bool, bool, bool, bool) {
+  ) internal pure returns (bool, bool, bool, bool) {
     uint256 dataLocal = self.data;
 
     return (
       (dataLocal & ~ACTIVE_MASK) != 0,
       (dataLocal & ~FROZEN_MASK) != 0,
       (dataLocal & ~BORROWING_MASK) != 0,
-      (dataLocal & ~STABLE_BORROWING_MASK) != 0,
       (dataLocal & ~PAUSED_MASK) != 0
     );
   }
@@ -2622,11 +2569,10 @@ library ReserveConfiguration {
    * @return The state param representing liquidation bonus
    * @return The state param representing reserve decimals
    * @return The state param representing reserve factor
-   * @return The state param representing eMode category
    */
   function getParams(
     DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (uint256, uint256, uint256, uint256, uint256, uint256) {
+  ) internal pure returns (uint256, uint256, uint256, uint256, uint256) {
     uint256 dataLocal = self.data;
 
     return (
@@ -2634,8 +2580,7 @@ library ReserveConfiguration {
       (dataLocal & ~LIQUIDATION_THRESHOLD_MASK) >> LIQUIDATION_THRESHOLD_START_BIT_POSITION,
       (dataLocal & ~LIQUIDATION_BONUS_MASK) >> LIQUIDATION_BONUS_START_BIT_POSITION,
       (dataLocal & ~DECIMALS_MASK) >> RESERVE_DECIMALS_START_BIT_POSITION,
-      (dataLocal & ~RESERVE_FACTOR_MASK) >> RESERVE_FACTOR_START_BIT_POSITION,
-      (dataLocal & ~EMODE_CATEGORY_MASK) >> EMODE_CATEGORY_START_BIT_POSITION
+      (dataLocal & ~RESERVE_FACTOR_MASK) >> RESERVE_FACTOR_START_BIT_POSITION
     );
   }
 
@@ -2657,7 +2602,7 @@ library ReserveConfiguration {
   }
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/dependencies/openzeppelin/upgradeability/InitializableUpgradeabilityProxy.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/dependencies/openzeppelin/upgradeability/InitializableUpgradeabilityProxy.sol
 
 /**
  * @title InitializableUpgradeabilityProxy
@@ -2684,7 +2629,7 @@ contract InitializableUpgradeabilityProxy is BaseUpgradeabilityProxy {
   }
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/protocol/libraries/aave-upgradeability/BaseImmutableAdminUpgradeabilityProxy.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/misc/aave-upgradeability/BaseImmutableAdminUpgradeabilityProxy.sol
 
 /**
  * @title BaseImmutableAdminUpgradeabilityProxy
@@ -2767,7 +2712,7 @@ contract BaseImmutableAdminUpgradeabilityProxy is BaseUpgradeabilityProxy {
   }
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/interfaces/IInitializableAToken.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/interfaces/IInitializableAToken.sol
 
 /**
  * @title IInitializableAToken
@@ -2820,7 +2765,7 @@ interface IInitializableAToken {
   ) external;
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/interfaces/IInitializableDebtToken.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/interfaces/IInitializableDebtToken.sol
 
 /**
  * @title IInitializableDebtToken
@@ -2869,7 +2814,7 @@ interface IInitializableDebtToken {
   ) external;
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/protocol/libraries/aave-upgradeability/InitializableImmutableAdminUpgradeabilityProxy.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/misc/aave-upgradeability/InitializableImmutableAdminUpgradeabilityProxy.sol
 
 /**
  * @title InitializableAdminUpgradeabilityProxy
@@ -2894,7 +2839,7 @@ contract InitializableImmutableAdminUpgradeabilityProxy is
   }
 }
 
-// downloads/ARBITRUM/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/core/contracts/protocol/libraries/logic/ConfiguratorLogic.sol
+// downloads/LINEA/CONFIGURATOR_LOGIC/ConfiguratorLogic/src/contracts/protocol/libraries/logic/ConfiguratorLogic.sol
 
 /**
  * @title ConfiguratorLogic library
@@ -2917,11 +2862,6 @@ library ConfiguratorLogic {
     address indexed proxy,
     address indexed implementation
   );
-  event StableDebtTokenUpgraded(
-    address indexed asset,
-    address indexed proxy,
-    address indexed implementation
-  );
   event VariableDebtTokenUpgraded(
     address indexed asset,
     address indexed proxy,
@@ -2929,7 +2869,7 @@ library ConfiguratorLogic {
   );
 
   /**
-   * @notice Initialize a reserve by creating and initializing aToken, stable debt token and variable debt token
+   * @notice Initialize a reserve by creating and initializing aToken and variable debt token
    * @dev Emits the `ReserveInitialized` event
    * @param pool The Pool in which the reserve will be initialized
    * @param input The needed parameters for the initialization
@@ -2957,20 +2897,6 @@ library ConfiguratorLogic {
       )
     );
 
-    address stableDebtTokenProxyAddress = _initTokenWithProxy(
-      input.stableDebtTokenImpl,
-      abi.encodeWithSelector(
-        IInitializableDebtToken.initialize.selector,
-        pool,
-        input.underlyingAsset,
-        input.incentivesController,
-        underlyingAssetDecimals,
-        input.stableDebtTokenName,
-        input.stableDebtTokenSymbol,
-        input.params
-      )
-    );
-
     address variableDebtTokenProxyAddress = _initTokenWithProxy(
       input.variableDebtTokenImpl,
       abi.encodeWithSelector(
@@ -2988,7 +2914,6 @@ library ConfiguratorLogic {
     pool.initReserve(
       input.underlyingAsset,
       aTokenProxyAddress,
-      stableDebtTokenProxyAddress,
       variableDebtTokenProxyAddress,
       input.interestRateStrategyAddress
     );
@@ -3012,7 +2937,7 @@ library ConfiguratorLogic {
     emit ReserveInitialized(
       input.underlyingAsset,
       aTokenProxyAddress,
-      stableDebtTokenProxyAddress,
+      address(0),
       variableDebtTokenProxyAddress,
       input.interestRateStrategyAddress
     );
@@ -3030,7 +2955,7 @@ library ConfiguratorLogic {
   ) external {
     DataTypes.ReserveDataLegacy memory reserveData = cachedPool.getReserveData(input.asset);
 
-    (, , , uint256 decimals, , ) = cachedPool.getConfiguration(input.asset).getParams();
+    (, , , uint256 decimals, ) = cachedPool.getConfiguration(input.asset).getParams();
 
     bytes memory encodedCall = abi.encodeWithSelector(
       IInitializableAToken.initialize.selector,
@@ -3049,44 +2974,6 @@ library ConfiguratorLogic {
     emit ATokenUpgraded(input.asset, reserveData.aTokenAddress, input.implementation);
   }
 
-  /**
-   * @notice Updates the stable debt token implementation and initializes it
-   * @dev Emits the `StableDebtTokenUpgraded` event
-   * @param cachedPool The Pool containing the reserve with the stable debt token
-   * @param input The parameters needed for the initialize call
-   */
-  function executeUpdateStableDebtToken(
-    IPool cachedPool,
-    ConfiguratorInputTypes.UpdateDebtTokenInput calldata input
-  ) external {
-    DataTypes.ReserveDataLegacy memory reserveData = cachedPool.getReserveData(input.asset);
-
-    (, , , uint256 decimals, , ) = cachedPool.getConfiguration(input.asset).getParams();
-
-    bytes memory encodedCall = abi.encodeWithSelector(
-      IInitializableDebtToken.initialize.selector,
-      cachedPool,
-      input.asset,
-      input.incentivesController,
-      decimals,
-      input.name,
-      input.symbol,
-      input.params
-    );
-
-    _upgradeTokenImplementation(
-      reserveData.stableDebtTokenAddress,
-      input.implementation,
-      encodedCall
-    );
-
-    emit StableDebtTokenUpgraded(
-      input.asset,
-      reserveData.stableDebtTokenAddress,
-      input.implementation
-    );
-  }
-
   /**
    * @notice Updates the variable debt token implementation and initializes it
    * @dev Emits the `VariableDebtTokenUpgraded` event
@@ -3099,7 +2986,7 @@ library ConfiguratorLogic {
   ) external {
     DataTypes.ReserveDataLegacy memory reserveData = cachedPool.getReserveData(input.asset);
 
-    (, , , uint256 decimals, , ) = cachedPool.getConfiguration(input.asset).getParams();
+    (, , , uint256 decimals, ) = cachedPool.getConfiguration(input.asset).getParams();
 
     bytes memory encodedCall = abi.encodeWithSelector(
       IInitializableDebtToken.initialize.selector,
```
