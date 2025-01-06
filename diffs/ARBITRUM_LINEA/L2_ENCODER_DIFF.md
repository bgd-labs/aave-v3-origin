```diff
diff --git a/./downloads/ARBITRUM/L2_ENCODER.sol b/./downloads/LINEA/L2_ENCODER.sol
index 9ab49b3..42a5580 100644
--- a/./downloads/ARBITRUM/L2_ENCODER.sol
+++ b/./downloads/LINEA/L2_ENCODER.sol
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: BUSL-1.1
-pragma solidity =0.8.10;
+// SPDX-License-Identifier: MIT
+pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/ARBITRUM/L2_ENCODER/L2Encoder/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
+// downloads/LINEA/L2_ENCODER/L2Encoder/src/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
 
 // OpenZeppelin Contracts v4.4.1 (utils/math/SafeCast.sol)
 
@@ -257,13 +257,13 @@ library SafeCast {
   }
 }
 
-// downloads/ARBITRUM/L2_ENCODER/L2Encoder/@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/L2_ENCODER/L2Encoder/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
  * @author Aave
  * @notice Defines the basic interface for a Pool Addresses Provider.
- **/
+ */
 interface IPoolAddressesProvider {
   /**
    * @dev Emitted when the market identifier is updated.
@@ -358,7 +358,7 @@ interface IPoolAddressesProvider {
   /**
    * @notice Returns the id of the Aave market to which this contract points to.
    * @return The market id
-   **/
+   */
   function getMarketId() external view returns (string memory);
 
   /**
@@ -400,27 +400,27 @@ interface IPoolAddressesProvider {
   /**
    * @notice Returns the address of the Pool proxy.
    * @return The Pool proxy address
-   **/
+   */
   function getPool() external view returns (address);
 
   /**
    * @notice Updates the implementation of the Pool, or creates a proxy
    * setting the new `pool` implementation when the function is called for the first time.
    * @param newPoolImpl The new Pool implementation
-   **/
+   */
   function setPoolImpl(address newPoolImpl) external;
 
   /**
    * @notice Returns the address of the PoolConfigurator proxy.
    * @return The PoolConfigurator proxy address
-   **/
+   */
   function getPoolConfigurator() external view returns (address);
 
   /**
    * @notice Updates the implementation of the PoolConfigurator, or creates a proxy
    * setting the new `PoolConfigurator` implementation when the function is called for the first time.
    * @param newPoolConfiguratorImpl The new PoolConfigurator implementation
-   **/
+   */
   function setPoolConfiguratorImpl(address newPoolConfiguratorImpl) external;
 
   /**
@@ -444,7 +444,7 @@ interface IPoolAddressesProvider {
   /**
    * @notice Updates the address of the ACL manager.
    * @param newAclManager The address of the new ACLManager
-   **/
+   */
   function setACLManager(address newAclManager) external;
 
   /**
@@ -468,7 +468,7 @@ interface IPoolAddressesProvider {
   /**
    * @notice Updates the address of the price oracle sentinel.
    * @param newPriceOracleSentinel The address of the new PriceOracleSentinel
-   **/
+   */
   function setPriceOracleSentinel(address newPriceOracleSentinel) external;
 
   /**
@@ -480,14 +480,18 @@ interface IPoolAddressesProvider {
   /**
    * @notice Updates the address of the data provider.
    * @param newDataProvider The address of the new DataProvider
-   **/
+   */
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/ARBITRUM/L2_ENCODER/L2Encoder/@aave/core-v3/contracts/protocol/libraries/types/DataTypes.sol
+// downloads/LINEA/L2_ENCODER/L2Encoder/src/contracts/protocol/libraries/types/DataTypes.sol
 
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
@@ -498,7 +502,7 @@ library DataTypes {
     uint128 variableBorrowIndex;
     //the current variable borrow rate. Expressed in ray
     uint128 currentVariableBorrowRate;
-    //the current stable borrow rate. Expressed in ray
+    // DEPRECATED on v3.2.0
     uint128 currentStableBorrowRate;
     //timestamp of last update
     uint40 lastUpdateTimestamp;
@@ -506,7 +510,7 @@ library DataTypes {
     uint16 id;
     //aToken address
     address aTokenAddress;
-    //stableDebtToken address
+    // DEPRECATED on v3.2.0
     address stableDebtTokenAddress;
     //variableDebtToken address
     address variableDebtTokenAddress;
@@ -520,6 +524,43 @@ library DataTypes {
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
@@ -528,18 +569,20 @@ library DataTypes {
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
@@ -553,30 +596,49 @@ library DataTypes {
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
@@ -586,10 +648,8 @@ library DataTypes {
     uint256 reserveFactor;
     ReserveConfigurationMap reserveConfiguration;
     address aTokenAddress;
-    address stableDebtTokenAddress;
     address variableDebtTokenAddress;
     uint40 reserveLastUpdateTimestamp;
-    uint40 stableDebtLastUpdateTimestamp;
   }
 
   struct ExecuteLiquidationCallParams {
@@ -619,7 +679,6 @@ library DataTypes {
     InterestRateMode interestRateMode;
     uint16 referralCode;
     bool releaseUnderlying;
-    uint256 maxStableRateBorrowSizePercent;
     uint256 reservesCount;
     address oracle;
     uint8 userEModeCategory;
@@ -671,9 +730,9 @@ library DataTypes {
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
@@ -712,7 +771,6 @@ library DataTypes {
     address userAddress;
     uint256 amount;
     InterestRateMode interestRateMode;
-    uint256 maxStableLoanPercent;
     uint256 reservesCount;
     address oracle;
     uint8 userEModeCategory;
@@ -733,18 +791,16 @@ library DataTypes {
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
@@ -752,13 +808,13 @@ library DataTypes {
   }
 }
 
-// downloads/ARBITRUM/L2_ENCODER/L2Encoder/@aave/core-v3/contracts/interfaces/IPool.sol
+// downloads/LINEA/L2_ENCODER/L2Encoder/src/contracts/interfaces/IPool.sol
 
 /**
  * @title IPool
  * @author Aave
  * @notice Defines the basic interface for an Aave Pool.
- **/
+ */
 interface IPool {
   /**
    * @dev Emitted on mintUnbacked()
@@ -767,7 +823,7 @@ interface IPool {
    * @param onBehalfOf The beneficiary of the supplied assets, receiving the aTokens
    * @param amount The amount of supplied assets
    * @param referralCode The referral code used
-   **/
+   */
   event MintUnbacked(
     address indexed reserve,
     address user,
@@ -782,7 +838,7 @@ interface IPool {
    * @param backer The address paying for the backing
    * @param amount The amount added as backing
    * @param fee The amount paid in fees
-   **/
+   */
   event BackUnbacked(address indexed reserve, address indexed backer, uint256 amount, uint256 fee);
 
   /**
@@ -792,7 +848,7 @@ interface IPool {
    * @param onBehalfOf The beneficiary of the supply, receiving the aTokens
    * @param amount The amount supplied
    * @param referralCode The referral code used
-   **/
+   */
   event Supply(
     address indexed reserve,
     address user,
@@ -807,7 +863,7 @@ interface IPool {
    * @param user The address initiating the withdrawal, owner of aTokens
    * @param to The address that will receive the underlying
    * @param amount The amount to be withdrawn
-   **/
+   */
   event Withdraw(address indexed reserve, address indexed user, address indexed to, uint256 amount);
 
   /**
@@ -817,10 +873,10 @@ interface IPool {
    * initiator of the transaction on flashLoan()
    * @param onBehalfOf The address that will be getting the debt
    * @param amount The amount borrowed out
-   * @param interestRateMode The rate mode: 1 for Stable, 2 for Variable
+   * @param interestRateMode The rate mode: 2 for Variable, 1 is deprecated (changed on v3.2.0)
    * @param borrowRate The numeric rate at which the user has borrowed, expressed in ray
    * @param referralCode The referral code used
-   **/
+   */
   event Borrow(
     address indexed reserve,
     address user,
@@ -838,7 +894,7 @@ interface IPool {
    * @param repayer The address of the user initiating the repay(), providing the funds
    * @param amount The amount repaid
    * @param useATokens True if the repayment is done using aTokens, `false` if done with underlying asset directly
-   **/
+   */
   event Repay(
     address indexed reserve,
     address indexed user,
@@ -847,18 +903,6 @@ interface IPool {
     bool useATokens
   );
 
-  /**
-   * @dev Emitted on swapBorrowRateMode()
-   * @param reserve The address of the underlying asset of the reserve
-   * @param user The address of the user swapping his rate mode
-   * @param interestRateMode The current interest rate mode of the position being swapped: 1 for Stable, 2 for Variable
-   **/
-  event SwapBorrowRateMode(
-    address indexed reserve,
-    address indexed user,
-    DataTypes.InterestRateMode interestRateMode
-  );
-
   /**
    * @dev Emitted on borrow(), repay() and liquidationCall() when using isolated assets
    * @param asset The address of the underlying asset of the reserve
@@ -870,40 +914,34 @@ interface IPool {
    * @dev Emitted when the user selects a certain asset category for eMode
    * @param user The address of the user
    * @param categoryId The category id
-   **/
+   */
   event UserEModeSet(address indexed user, uint8 categoryId);
 
   /**
    * @dev Emitted on setUserUseReserveAsCollateral()
    * @param reserve The address of the underlying asset of the reserve
    * @param user The address of the user enabling the usage as collateral
-   **/
+   */
   event ReserveUsedAsCollateralEnabled(address indexed reserve, address indexed user);
 
   /**
    * @dev Emitted on setUserUseReserveAsCollateral()
    * @param reserve The address of the underlying asset of the reserve
    * @param user The address of the user enabling the usage as collateral
-   **/
+   */
   event ReserveUsedAsCollateralDisabled(address indexed reserve, address indexed user);
 
-  /**
-   * @dev Emitted on rebalanceStableBorrowRate()
-   * @param reserve The address of the underlying asset of the reserve
-   * @param user The address of the user for which the rebalance has been executed
-   **/
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
-   **/
+   */
   event FlashLoan(
     address indexed target,
     address initiator,
@@ -924,7 +962,7 @@ interface IPool {
    * @param liquidator The address of the liquidator
    * @param receiveAToken True if the liquidators wants to receive the collateral aTokens, `false` if he wants
    * to receive the underlying collateral asset directly
-   **/
+   */
   event LiquidationCall(
     address indexed collateralAsset,
     address indexed debtAsset,
@@ -939,11 +977,11 @@ interface IPool {
    * @dev Emitted when the state of a reserve is updated.
    * @param reserve The address of the underlying asset of the reserve
    * @param liquidityRate The next liquidity rate
-   * @param stableBorrowRate The next stable borrow rate
+   * @param stableBorrowRate The next stable borrow rate @note deprecated on v3.2.0
    * @param variableBorrowRate The next variable borrow rate
    * @param liquidityIndex The next liquidity index
    * @param variableBorrowIndex The next variable borrow index
-   **/
+   */
   event ReserveDataUpdated(
     address indexed reserve,
     uint256 liquidityRate,
@@ -957,17 +995,17 @@ interface IPool {
    * @dev Emitted when the protocol treasury receives minted aTokens from the accrued interest.
    * @param reserve The address of the reserve
    * @param amountMinted The amount minted to the treasury
-   **/
+   */
   event MintedToTreasury(address indexed reserve, uint256 amountMinted);
 
   /**
-   * @dev Mints an `amount` of aTokens to the `onBehalfOf`
+   * @notice Mints an `amount` of aTokens to the `onBehalfOf`
    * @param asset The address of the underlying asset to mint
    * @param amount The amount to mint
    * @param onBehalfOf The address that will receive the aTokens
    * @param referralCode Code used to register the integrator originating the operation, for potential rewards.
    *   0 if the action is executed directly by the user, without any middle-man
-   **/
+   */
   function mintUnbacked(
     address asset,
     uint256 amount,
@@ -976,12 +1014,13 @@ interface IPool {
   ) external;
 
   /**
-   * @dev Back the current unbacked underlying with `amount` and pay `fee`.
+   * @notice Back the current unbacked underlying with `amount` and pay `fee`.
    * @param asset The address of the underlying asset to back
    * @param amount The amount to back
    * @param fee The amount paid in fees
-   **/
-  function backUnbacked(address asset, uint256 amount, uint256 fee) external;
+   * @return The backed amount
+   */
+  function backUnbacked(address asset, uint256 amount, uint256 fee) external returns (uint256);
 
   /**
    * @notice Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
@@ -993,7 +1032,7 @@ interface IPool {
    *   is a different wallet
    * @param referralCode Code used to register the integrator originating the operation, for potential rewards.
    *   0 if the action is executed directly by the user, without any middle-man
-   **/
+   */
   function supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
 
   /**
@@ -1010,7 +1049,7 @@ interface IPool {
    * @param permitV The V parameter of ERC712 permit sig
    * @param permitR The R parameter of ERC712 permit sig
    * @param permitS The S parameter of ERC712 permit sig
-   **/
+   */
   function supplyWithPermit(
     address asset,
     uint256 amount,
@@ -1032,24 +1071,23 @@ interface IPool {
    *   wants to receive it on his own wallet, or a different address if the beneficiary is a
    *   different wallet
    * @return The final amount withdrawn
-   **/
+   */
   function withdraw(address asset, uint256 amount, address to) external returns (uint256);
 
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
    * calling the function if he wants to borrow against his own collateral, or the address of the credit delegator
    * if he has been given credit delegation allowance
-   **/
+   */
   function borrow(
     address asset,
     uint256 amount,
@@ -1060,16 +1098,16 @@ interface IPool {
 
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
    * @return The final amount repaid
-   **/
+   */
   function repay(
     address asset,
     uint256 amount,
@@ -1083,7 +1121,7 @@ interface IPool {
    * @param asset The address of the borrowed underlying asset previously borrowed
    * @param amount The amount to repay
    * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
-   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable
+   * @param interestRateMode 2 for Variable, 1 is deprecated on v3.2.0
    * @param onBehalfOf Address of the user who will get his debt reduced/removed. Should be the address of the
    * user calling the function if he wants to reduce/remove his own debt, or the address of any other
    * other borrower whose debt should be removed
@@ -1092,7 +1130,7 @@ interface IPool {
    * @param permitR The R parameter of ERC712 permit sig
    * @param permitS The S parameter of ERC712 permit sig
    * @return The final amount repaid
-   **/
+   */
   function repayWithPermit(
     address asset,
     uint256 amount,
@@ -1107,44 +1145,26 @@ interface IPool {
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
-   **/
+   */
   function repayWithATokens(
     address asset,
     uint256 amount,
     uint256 interestRateMode
   ) external returns (uint256);
 
-  /**
-   * @notice Allows a borrower to swap his debt between stable and variable mode, or vice versa
-   * @param asset The address of the underlying asset borrowed
-   * @param interestRateMode The current interest rate mode of the position being swapped: 1 for Stable, 2 for Variable
-   **/
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
-   **/
-  function rebalanceStableBorrowRate(address asset, address user) external;
-
   /**
    * @notice Allows suppliers to enable/disable a specific supplied asset as collateral
    * @param asset The address of the underlying asset supplied
    * @param useAsCollateral True if the user wants to use the supply as collateral, false otherwise
-   **/
+   */
   function setUserUseReserveAsCollateral(address asset, bool useAsCollateral) external;
 
   /**
@@ -1157,7 +1177,7 @@ interface IPool {
    * @param debtToCover The debt amount of borrowed `asset` the liquidator wants to cover
    * @param receiveAToken True if the liquidators wants to receive the collateral aTokens, `false` if he wants
    * to receive the underlying collateral asset directly
-   **/
+   */
   function liquidationCall(
     address collateralAsset,
     address debtAsset,
@@ -1170,19 +1190,19 @@ interface IPool {
    * @notice Allows smartcontracts to access the liquidity of the pool within one transaction,
    * as long as the amount taken plus a fee is returned.
    * @dev IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
-   * into consideration. For further details please visit https://developers.aave.com
+   * into consideration. For further details please visit https://docs.aave.com/developers/
    * @param receiverAddress The address of the contract receiving the funds, implementing IFlashLoanReceiver interface
    * @param assets The addresses of the assets being flash-borrowed
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
-   **/
+   */
   function flashLoan(
     address receiverAddress,
     address[] calldata assets,
@@ -1197,14 +1217,14 @@ interface IPool {
    * @notice Allows smartcontracts to access the liquidity of the pool within one transaction,
    * as long as the amount taken plus a fee is returned.
    * @dev IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
-   * into consideration. For further details please visit https://developers.aave.com
+   * into consideration. For further details please visit https://docs.aave.com/developers/
    * @param receiverAddress The address of the contract receiving the funds, implementing IFlashLoanSimpleReceiver interface
    * @param asset The address of the asset being flash-borrowed
    * @param amount The amount of the asset being flash-borrowed
    * @param params Variadic packed params to pass to the receiver as extra information
    * @param referralCode The code used to register the integrator originating the operation, for potential rewards.
    *   0 if the action is executed directly by the user, without any middle-man
-   **/
+   */
   function flashLoanSimple(
     address receiverAddress,
     address asset,
@@ -1222,7 +1242,7 @@ interface IPool {
    * @return currentLiquidationThreshold The liquidation threshold of the user
    * @return ltv The loan to value of The user
    * @return healthFactor The current health factor of the user
-   **/
+   */
   function getUserAccountData(
     address user
   )
@@ -1243,14 +1263,12 @@ interface IPool {
    * @dev Only callable by the PoolConfigurator contract
    * @param asset The address of the underlying asset of the reserve
    * @param aTokenAddress The address of the aToken that will be assigned to the reserve
-   * @param stableDebtAddress The address of the StableDebtToken that will be assigned to the reserve
    * @param variableDebtAddress The address of the VariableDebtToken that will be assigned to the reserve
    * @param interestRateStrategyAddress The address of the interest rate strategy contract
-   **/
+   */
   function initReserve(
     address asset,
     address aTokenAddress,
-    address stableDebtAddress,
     address variableDebtAddress,
     address interestRateStrategyAddress
   ) external;
@@ -1258,8 +1276,9 @@ interface IPool {
   /**
    * @notice Drop a reserve
    * @dev Only callable by the PoolConfigurator contract
+   * @dev Does not reset eMode flags, which must be considered when reusing the same reserve id for a different reserve.
    * @param asset The address of the underlying asset of the reserve
-   **/
+   */
   function dropReserve(address asset) external;
 
   /**
@@ -1267,18 +1286,34 @@ interface IPool {
    * @dev Only callable by the PoolConfigurator contract
    * @param asset The address of the underlying asset of the reserve
    * @param rateStrategyAddress The address of the interest rate strategy contract
-   **/
+   */
   function setReserveInterestRateStrategyAddress(
     address asset,
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
    * @param asset The address of the underlying asset of the reserve
    * @param configuration The new configuration bitmap
-   **/
+   */
   function setConfiguration(
     address asset,
     DataTypes.ReserveConfigurationMap calldata configuration
@@ -1288,7 +1323,7 @@ interface IPool {
    * @notice Returns the configuration of the reserve
    * @param asset The address of the underlying asset of the reserve
    * @return The configuration of the reserve
-   **/
+   */
   function getConfiguration(
     address asset
   ) external view returns (DataTypes.ReserveConfigurationMap memory);
@@ -1297,13 +1332,13 @@ interface IPool {
    * @notice Returns the configuration of the user across all the reserves
    * @param user The user address
    * @return The configuration of the user
-   **/
+   */
   function getUserConfiguration(
     address user
   ) external view returns (DataTypes.UserConfigurationMap memory);
 
   /**
-   * @notice Returns the normalized income normalized income of the reserve
+   * @notice Returns the normalized income of the reserve
    * @param asset The address of the underlying asset of the reserve
    * @return The reserve's normalized income
    */
@@ -1311,6 +1346,13 @@ interface IPool {
 
   /**
    * @notice Returns the normalized variable debt per unit of asset
+   * @dev WARNING: This function is intended to be used primarily by the protocol itself to get a
+   * "dynamic" variable index based on time, current stored index and virtual rate at the current
+   * moment (approx. a borrower would get if opening a position). This means that is always used in
+   * combination with variable debt supply/balances.
+   * If using this function externally, consider that is possible to have an increasing normalized
+   * variable debt that is not equivalent to how the variable debt index would be updated in storage
+   * (e.g. only updates with non-zero variable debt supply)
    * @param asset The address of the underlying asset of the reserve
    * @return The reserve normalized variable debt
    */
@@ -1320,8 +1362,25 @@ interface IPool {
    * @notice Returns the state and configuration of the reserve
    * @param asset The address of the underlying asset of the reserve
    * @return The state and configuration data of the reserve
-   **/
-  function getReserveData(address asset) external view returns (DataTypes.ReserveData memory);
+   */
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
@@ -1346,20 +1405,27 @@ interface IPool {
    * @notice Returns the list of the underlying assets of all the initialized reserves
    * @dev It does not include dropped reserves
    * @return The addresses of the underlying assets of the initialized reserves
-   **/
+   */
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
    * @return The address of the reserve associated with id
-   **/
+   */
   function getReserveAddressById(uint16 id) external view returns (address);
 
   /**
    * @notice Returns the PoolAddressesProvider connected to this contract
    * @return The address of the PoolAddressesProvider
-   **/
+   */
   function ADDRESSES_PROVIDER() external view returns (IPoolAddressesProvider);
 
   /**
@@ -1384,20 +1450,70 @@ interface IPool {
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
@@ -1420,10 +1536,20 @@ interface IPool {
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
@@ -1452,7 +1578,7 @@ interface IPool {
   /**
    * @notice Mints the assets accrued through the reserve factor to the treasury in the form of aTokens
    * @param assets The list of reserves for which the minting needs to be executed
-   **/
+   */
   function mintToTreasury(address[] calldata assets) external;
 
   /**
@@ -1474,11 +1600,46 @@ interface IPool {
    *   is a different wallet
    * @param referralCode Code used to register the integrator originating the operation, for potential rewards.
    *   0 if the action is executed directly by the user, without any middle-man
-   **/
+   */
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
 
-// downloads/ARBITRUM/L2_ENCODER/L2Encoder/@aave/core-v3/contracts/misc/L2Encoder.sol
+// downloads/LINEA/L2_ENCODER/L2Encoder/src/contracts/helpers/L2Encoder.sol
 
 /**
  * @title L2Encoder
@@ -1512,7 +1673,7 @@ contract L2Encoder {
     uint256 amount,
     uint16 referralCode
   ) external view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);
 
     uint16 assetId = data.id;
     uint128 shortenedAmount = amount.toUint128();
@@ -1548,7 +1709,7 @@ contract L2Encoder {
     bytes32 permitR,
     bytes32 permitS
   ) external view returns (bytes32, bytes32, bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);
 
     uint16 assetId = data.id;
     uint128 shortenedAmount = amount.toUint128();
@@ -1576,7 +1737,7 @@ contract L2Encoder {
    * @return compact representation of withdraw parameters
    */
   function encodeWithdrawParams(address asset, uint256 amount) external view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);
 
     uint16 assetId = data.id;
     uint128 shortenedAmount = amount == type(uint256).max ? type(uint128).max : amount.toUint128();
@@ -1593,7 +1754,7 @@ contract L2Encoder {
    * @dev Without an onBehalfOf parameter as the compact calls to L2Pool will use msg.sender as onBehalfOf
    * @param asset The address of the underlying asset to borrow
    * @param amount The amount to be borrowed
-   * @param interestRateMode The interest rate mode at which the user wants to borrow: 1 for Stable, 2 for Variable
+   * @param interestRateMode The interest rate mode at which the user wants to borrow: 2 for Variable, 1 is deprecated (changed on v3.2.0)
    * @param referralCode The code used to register the integrator originating the operation, for potential rewards.
    *   0 if the action is executed directly by the user, without any middle-man
    * @return compact representation of withdraw parameters
@@ -1604,7 +1765,7 @@ contract L2Encoder {
     uint256 interestRateMode,
     uint16 referralCode
   ) external view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);
 
     uint16 assetId = data.id;
     uint128 shortenedAmount = amount.toUint128();
@@ -1628,7 +1789,7 @@ contract L2Encoder {
    * @param asset The address of the borrowed underlying asset previously borrowed
    * @param amount The amount to repay
    * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `interestRateMode`
-   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable
+   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 2 for Variable, 1 is deprecated (changed on v3.2.0)
    * @return compact representation of repay parameters
    */
   function encodeRepayParams(
@@ -1636,7 +1797,7 @@ contract L2Encoder {
     uint256 amount,
     uint256 interestRateMode
   ) public view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);
 
     uint16 assetId = data.id;
     uint128 shortenedAmount = amount == type(uint256).max ? type(uint128).max : amount.toUint128();
@@ -1655,7 +1816,7 @@ contract L2Encoder {
    * @param asset The address of the borrowed underlying asset previously borrowed
    * @param amount The amount to repay
    * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
-   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable
+   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 2 for Variable, 1 is deprecated (changed on v3.2.0)
    * @param deadline The deadline timestamp that the permit is valid
    * @param permitV The V parameter of ERC712 permit sig
    * @param permitR The R parameter of ERC712 permit sig
@@ -1673,7 +1834,7 @@ contract L2Encoder {
     bytes32 permitR,
     bytes32 permitS
   ) external view returns (bytes32, bytes32, bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);
 
     uint16 assetId = data.id;
     uint128 shortenedAmount = amount == type(uint256).max ? type(uint128).max : amount.toUint128();
@@ -1701,7 +1862,7 @@ contract L2Encoder {
    * @param asset The address of the borrowed underlying asset previously borrowed
    * @param amount The amount to repay
    * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
-   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable
+   * @param interestRateMode The interest rate mode at of the debt the user wants to repay: 2 for Variable, 1 is deprecated  (changed on v3.2.0)
    * @return compact representation of repay with aToken parameters
    */
   function encodeRepayWithATokensParams(
@@ -1712,46 +1873,6 @@ contract L2Encoder {
     return encodeRepayParams(asset, amount, interestRateMode);
   }
 
-  /**
-   * @notice Encodes swap borrow rate mode parameters from standard input to compact representation of 1 bytes32
-   * @param asset The address of the underlying asset borrowed
-   * @param interestRateMode The current interest rate mode of the position being swapped: 1 for Stable, 2 for Variable
-   * @return compact representation of swap borrow rate mode parameters
-   */
-  function encodeSwapBorrowRateMode(
-    address asset,
-    uint256 interestRateMode
-  ) external view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
-    uint16 assetId = data.id;
-    uint8 shortenedInterestRateMode = interestRateMode.toUint8();
-    bytes32 res;
-    assembly {
-      res := add(assetId, shl(16, shortenedInterestRateMode))
-    }
-    return res;
-  }
-
-  /**
-   * @notice Encodes rebalance stable borrow rate parameters from standard input to compact representation of 1 bytes32
-   * @param asset The address of the underlying asset borrowed
-   * @param user The address of the user to be rebalanced
-   * @return compact representation of rebalance stable borrow rate parameters
-   */
-  function encodeRebalanceStableBorrowRate(
-    address asset,
-    address user
-  ) external view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
-    uint16 assetId = data.id;
-
-    bytes32 res;
-    assembly {
-      res := add(assetId, shl(16, user))
-    }
-    return res;
-  }
-
   /**
    * @notice Encodes set user use reserve as collateral parameters from standard input to compact representation of 1 bytes32
    * @param asset The address of the underlying asset borrowed
@@ -1762,7 +1883,7 @@ contract L2Encoder {
     address asset,
     bool useAsCollateral
   ) external view returns (bytes32) {
-    DataTypes.ReserveData memory data = POOL.getReserveData(asset);
+    DataTypes.ReserveDataLegacy memory data = POOL.getReserveData(asset);
     uint16 assetId = data.id;
     bytes32 res;
     assembly {
@@ -1789,10 +1910,10 @@ contract L2Encoder {
     uint256 debtToCover,
     bool receiveAToken
   ) external view returns (bytes32, bytes32) {
-    DataTypes.ReserveData memory collateralData = POOL.getReserveData(collateralAsset);
+    DataTypes.ReserveDataLegacy memory collateralData = POOL.getReserveData(collateralAsset);
     uint16 collateralAssetId = collateralData.id;
 
-    DataTypes.ReserveData memory debtData = POOL.getReserveData(debtAsset);
+    DataTypes.ReserveDataLegacy memory debtData = POOL.getReserveData(debtAsset);
     uint16 debtAssetId = debtData.id;
 
     uint128 shortenedDebtToCover = debtToCover == type(uint256).max
```
