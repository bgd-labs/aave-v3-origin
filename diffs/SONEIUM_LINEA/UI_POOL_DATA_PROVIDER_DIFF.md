```diff
diff --git a/./downloads/SONEIUM/UI_POOL_DATA_PROVIDER.sol b/./downloads/LINEA/UI_POOL_DATA_PROVIDER.sol
index 46e3c51..2a04406 100644
--- a/./downloads/SONEIUM/UI_POOL_DATA_PROVIDER.sol
+++ b/./downloads/LINEA/UI_POOL_DATA_PROVIDER.sol
@@ -1,55 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/dependencies/chainlink/AggregatorInterface.sol
-
-// Chainlink Contracts v0.8
-
-interface AggregatorInterface {
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
-  function latestAnswer() external view returns (int256);
-
-  function latestTimestamp() external view returns (uint256);
-
-  function latestRound() external view returns (uint256);
-
-  function getAnswer(uint256 roundId) external view returns (int256);
-
-  function getTimestamp(uint256 roundId) external view returns (uint256);
-
-  event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 updatedAt);
-
-  event NewRound(uint256 indexed roundId, address indexed startedBy, uint256 startedAt);
-}
-
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/protocol/libraries/types/DataTypes.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/protocol/libraries/types/DataTypes.sol
 
 library DataTypes {
   /**
@@ -100,9 +52,8 @@ library DataTypes {
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
@@ -268,11 +219,6 @@ library DataTypes {
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
@@ -379,7 +325,7 @@ library DataTypes {
   }
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/protocol/libraries/helpers/Errors.sol
 
 /**
  * @title Errors library
@@ -480,13 +426,9 @@ library Errors {
   string public constant INVALID_GRACE_PERIOD = '98'; // Grace period above a valid range
   string public constant INVALID_FREEZE_STATE = '99'; // Reserve is already in the passed freeze state
   string public constant NOT_BORROWABLE_IN_EMODE = '100'; // Asset not borrowable in eMode
-  string public constant CALLER_NOT_UMBRELLA = '101'; // The caller of the function is not the umbrella contract
-  string public constant RESERVE_NOT_IN_DEFICIT = '102'; // The reserve is not in deficit
-  string public constant MUST_NOT_LEAVE_DUST = '103'; // Below a certain threshold liquidators need to take the full position
-  string public constant USER_CANNOT_HAVE_DEBT = '104'; // Thrown when a user tries to interact with a method that requires a position without debt
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/interfaces/IAaveIncentivesController.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/interfaces/IAaveIncentivesController.sol
 
 /**
  * @title IAaveIncentivesController
@@ -505,7 +447,26 @@ interface IAaveIncentivesController {
   function handleAction(address user, uint256 totalSupply, uint256 userBalance) external;
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/helpers/interfaces/IEACAggregatorProxy.sol
+
+interface IEACAggregatorProxy {
+  function decimals() external view returns (uint8);
+
+  function latestAnswer() external view returns (int256);
+
+  function latestTimestamp() external view returns (uint256);
+
+  function latestRound() external view returns (uint256);
+
+  function getAnswer(uint256 roundId) external view returns (int256);
+
+  function getTimestamp(uint256 roundId) external view returns (uint256);
+
+  event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 timestamp);
+  event NewRound(uint256 indexed roundId, address indexed startedBy);
+}
+
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
 
 /**
  * @dev Interface of the ERC20 standard as defined in the EIP.
@@ -581,7 +542,7 @@ interface IERC20 {
   event Approval(address indexed owner, address indexed spender, uint256 value);
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -808,7 +769,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/interfaces/IPriceOracleGetter.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/interfaces/IPriceOracleGetter.sol
 
 /**
  * @title IPriceOracleGetter
@@ -838,7 +799,7 @@ interface IPriceOracleGetter {
   function getAssetPrice(address asset) external view returns (uint256);
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/interfaces/IScaledBalanceToken.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/interfaces/IScaledBalanceToken.sol
 
 /**
  * @title IScaledBalanceToken
@@ -910,7 +871,7 @@ interface IScaledBalanceToken {
   function getPreviousIndex(address user) external view returns (uint256);
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/protocol/libraries/math/WadRayMath.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/protocol/libraries/math/WadRayMath.sol
 
 /**
  * @title WadRayMath library
@@ -1036,7 +997,7 @@ library WadRayMath {
   }
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
 
 interface IERC20Detailed is IERC20 {
   function name() external view returns (string memory);
@@ -1046,7 +1007,7 @@ interface IERC20Detailed is IERC20 {
   function decimals() external view returns (uint8);
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/helpers/interfaces/IERC20DetailedBytes.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/helpers/interfaces/IERC20DetailedBytes.sol
 
 interface IERC20DetailedBytes is IERC20 {
   function name() external view returns (bytes32);
@@ -1056,7 +1017,7 @@ interface IERC20DetailedBytes is IERC20 {
   function decimals() external view returns (uint8);
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/interfaces/IPoolDataProvider.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/interfaces/IPoolDataProvider.sol
 
 /**
  * @title IPoolDataProvider
@@ -1302,16 +1263,9 @@ interface IPoolDataProvider {
    * @return The reserve virtual underlying balance
    */
   function getVirtualUnderlyingBalance(address asset) external view returns (uint256);
-
-  /**
-   * @notice Returns the deficit of the reserve
-   * @param asset The address of the underlying asset of the reserve
-   * @return The reserve deficit
-   */
-  function getReserveDeficit(address asset) external view returns (uint256);
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/interfaces/IReserveInterestRateStrategy.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/interfaces/IReserveInterestRateStrategy.sol
 
 /**
  * @title IReserveInterestRateStrategy
@@ -1338,7 +1292,7 @@ interface IReserveInterestRateStrategy {
   ) external view returns (uint256, uint256);
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/interfaces/IAaveOracle.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/interfaces/IAaveOracle.sol
 
 /**
  * @title IAaveOracle
@@ -1406,7 +1360,7 @@ interface IAaveOracle is IPriceOracleGetter {
   function getFallbackOracle() external view returns (address);
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/interfaces/IPool.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/interfaces/IPool.sol
 
 /**
  * @title IPool
@@ -1589,14 +1543,6 @@ interface IPool {
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
@@ -1604,14 +1550,6 @@ interface IPool {
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
@@ -1979,6 +1917,16 @@ interface IPool {
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
@@ -2153,7 +2101,7 @@ interface IPool {
    * @param asset The address of the underlying asset
    * @return Timestamp when the liquidation grace period will end
    **/
-  function getLiquidationGracePeriod(address asset) external view returns (uint40);
+  function getLiquidationGracePeriod(address asset) external returns (uint40);
 
   /**
    * @notice Returns the total fee on flash loans
@@ -2207,37 +2155,6 @@ interface IPool {
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
@@ -2274,7 +2191,7 @@ interface IPool {
   function getSupplyLogic() external view returns (address);
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/helpers/interfaces/IUiPoolDataProviderV3.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/helpers/interfaces/IUiPoolDataProviderV3.sol
 
 interface IUiPoolDataProviderV3 {
   struct AggregatedReserveData {
@@ -2324,8 +2241,6 @@ interface IUiPoolDataProviderV3 {
     // v3.1
     bool virtualAccActive;
     uint128 virtualUnderlyingBalance;
-    // v3.3
-    uint128 deficit;
   }
 
   struct UserReserveData {
@@ -2368,7 +2283,7 @@ interface IUiPoolDataProviderV3 {
   function getEModes(IPoolAddressesProvider provider) external view returns (Emode[] memory);
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
 
 /**
  * @title ReserveConfiguration library
@@ -2376,26 +2291,26 @@ interface IUiPoolDataProviderV3 {
  * @notice Implements the bitmap logic to handle the reserve configuration
  */
 library ReserveConfiguration {
-  uint256 internal constant LTV_MASK =                       0x000000000000000000000000000000000000000000000000000000000000FFFF; // prettier-ignore
-  uint256 internal constant LIQUIDATION_THRESHOLD_MASK =     0x00000000000000000000000000000000000000000000000000000000FFFF0000; // prettier-ignore
-  uint256 internal constant LIQUIDATION_BONUS_MASK =         0x0000000000000000000000000000000000000000000000000000FFFF00000000; // prettier-ignore
-  uint256 internal constant DECIMALS_MASK =                  0x00000000000000000000000000000000000000000000000000FF000000000000; // prettier-ignore
-  uint256 internal constant ACTIVE_MASK =                    0x0000000000000000000000000000000000000000000000000100000000000000; // prettier-ignore
-  uint256 internal constant FROZEN_MASK =                    0x0000000000000000000000000000000000000000000000000200000000000000; // prettier-ignore
-  uint256 internal constant BORROWING_MASK =                 0x0000000000000000000000000000000000000000000000000400000000000000; // prettier-ignore
+  uint256 internal constant LTV_MASK =                       0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000; // prettier-ignore
+  uint256 internal constant LIQUIDATION_THRESHOLD_MASK =     0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF; // prettier-ignore
+  uint256 internal constant LIQUIDATION_BONUS_MASK =         0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFF; // prettier-ignore
+  uint256 internal constant DECIMALS_MASK =                  0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF; // prettier-ignore
+  uint256 internal constant ACTIVE_MASK =                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFF; // prettier-ignore
+  uint256 internal constant FROZEN_MASK =                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFFFFFFFF; // prettier-ignore
+  uint256 internal constant BORROWING_MASK =                 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFFFFFFFFFFF; // prettier-ignore
   // @notice there is an unoccupied hole of 1 bit at position 59 from pre 3.2 stableBorrowRateEnabled
-  uint256 internal constant PAUSED_MASK =                    0x0000000000000000000000000000000000000000000000001000000000000000; // prettier-ignore
-  uint256 internal constant BORROWABLE_IN_ISOLATION_MASK =   0x0000000000000000000000000000000000000000000000002000000000000000; // prettier-ignore
-  uint256 internal constant SILOED_BORROWING_MASK =          0x0000000000000000000000000000000000000000000000004000000000000000; // prettier-ignore
-  uint256 internal constant FLASHLOAN_ENABLED_MASK =         0x0000000000000000000000000000000000000000000000008000000000000000; // prettier-ignore
-  uint256 internal constant RESERVE_FACTOR_MASK =            0x00000000000000000000000000000000000000000000FFFF0000000000000000; // prettier-ignore
-  uint256 internal constant BORROW_CAP_MASK =                0x00000000000000000000000000000000000FFFFFFFFF00000000000000000000; // prettier-ignore
-  uint256 internal constant SUPPLY_CAP_MASK =                0x00000000000000000000000000FFFFFFFFF00000000000000000000000000000; // prettier-ignore
-  uint256 internal constant LIQUIDATION_PROTOCOL_FEE_MASK =  0x0000000000000000000000FFFF00000000000000000000000000000000000000; // prettier-ignore
-  //@notice there is an unoccupied hole of 8 bits from 168 to 176 left from pre 3.2 eModeCategory
-  uint256 internal constant UNBACKED_MINT_CAP_MASK =         0x00000000000FFFFFFFFF00000000000000000000000000000000000000000000; // prettier-ignore
-  uint256 internal constant DEBT_CEILING_MASK =              0x0FFFFFFFFFF00000000000000000000000000000000000000000000000000000; // prettier-ignore
-  uint256 internal constant VIRTUAL_ACC_ACTIVE_MASK =        0x1000000000000000000000000000000000000000000000000000000000000000; // prettier-ignore
+  uint256 internal constant PAUSED_MASK =                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFF; // prettier-ignore
+  uint256 internal constant BORROWABLE_IN_ISOLATION_MASK =   0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFFFFFFFFF; // prettier-ignore
+  uint256 internal constant SILOED_BORROWING_MASK =          0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFFFFFFFFFFFF; // prettier-ignore
+  uint256 internal constant FLASHLOAN_ENABLED_MASK =         0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFFF; // prettier-ignore
+  uint256 internal constant RESERVE_FACTOR_MASK =            0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFF; // prettier-ignore
+  uint256 internal constant BORROW_CAP_MASK =                0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000FFFFFFFFFFFFFFFFFFFF; // prettier-ignore
+  uint256 internal constant SUPPLY_CAP_MASK =                0xFFFFFFFFFFFFFFFFFFFFFFFFFF000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
+  uint256 internal constant LIQUIDATION_PROTOCOL_FEE_MASK =  0xFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
+  // @notice there is an unoccupied hole of 8 bits from 168 to 176 left from pre 3.2 eModeCategory
+  uint256 internal constant UNBACKED_MINT_CAP_MASK =         0xFFFFFFFFFFF000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
+  uint256 internal constant DEBT_CEILING_MASK =              0xF0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
+  uint256 internal constant VIRTUAL_ACC_ACTIVE_MASK =        0xEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // prettier-ignore
 
   /// @dev For the LTV, the start bit is 0 (up to 15), hence no bitshifting is needed
   uint256 internal constant LIQUIDATION_THRESHOLD_START_BIT_POSITION = 16;
@@ -2439,7 +2354,7 @@ library ReserveConfiguration {
   function setLtv(DataTypes.ReserveConfigurationMap memory self, uint256 ltv) internal pure {
     require(ltv <= MAX_VALID_LTV, Errors.INVALID_LTV);
 
-    self.data = (self.data & ~LTV_MASK) | ltv;
+    self.data = (self.data & LTV_MASK) | ltv;
   }
 
   /**
@@ -2448,7 +2363,7 @@ library ReserveConfiguration {
    * @return The loan to value
    */
   function getLtv(DataTypes.ReserveConfigurationMap memory self) internal pure returns (uint256) {
-    return self.data & LTV_MASK;
+    return self.data & ~LTV_MASK;
   }
 
   /**
@@ -2463,7 +2378,7 @@ library ReserveConfiguration {
     require(threshold <= MAX_VALID_LIQUIDATION_THRESHOLD, Errors.INVALID_LIQ_THRESHOLD);
 
     self.data =
-      (self.data & ~LIQUIDATION_THRESHOLD_MASK) |
+      (self.data & LIQUIDATION_THRESHOLD_MASK) |
       (threshold << LIQUIDATION_THRESHOLD_START_BIT_POSITION);
   }
 
@@ -2475,7 +2390,7 @@ library ReserveConfiguration {
   function getLiquidationThreshold(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & LIQUIDATION_THRESHOLD_MASK) >> LIQUIDATION_THRESHOLD_START_BIT_POSITION;
+    return (self.data & ~LIQUIDATION_THRESHOLD_MASK) >> LIQUIDATION_THRESHOLD_START_BIT_POSITION;
   }
 
   /**
@@ -2490,7 +2405,7 @@ library ReserveConfiguration {
     require(bonus <= MAX_VALID_LIQUIDATION_BONUS, Errors.INVALID_LIQ_BONUS);
 
     self.data =
-      (self.data & ~LIQUIDATION_BONUS_MASK) |
+      (self.data & LIQUIDATION_BONUS_MASK) |
       (bonus << LIQUIDATION_BONUS_START_BIT_POSITION);
   }
 
@@ -2502,7 +2417,7 @@ library ReserveConfiguration {
   function getLiquidationBonus(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & LIQUIDATION_BONUS_MASK) >> LIQUIDATION_BONUS_START_BIT_POSITION;
+    return (self.data & ~LIQUIDATION_BONUS_MASK) >> LIQUIDATION_BONUS_START_BIT_POSITION;
   }
 
   /**
@@ -2516,7 +2431,7 @@ library ReserveConfiguration {
   ) internal pure {
     require(decimals <= MAX_VALID_DECIMALS, Errors.INVALID_DECIMALS);
 
-    self.data = (self.data & ~DECIMALS_MASK) | (decimals << RESERVE_DECIMALS_START_BIT_POSITION);
+    self.data = (self.data & DECIMALS_MASK) | (decimals << RESERVE_DECIMALS_START_BIT_POSITION);
   }
 
   /**
@@ -2527,7 +2442,7 @@ library ReserveConfiguration {
   function getDecimals(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & DECIMALS_MASK) >> RESERVE_DECIMALS_START_BIT_POSITION;
+    return (self.data & ~DECIMALS_MASK) >> RESERVE_DECIMALS_START_BIT_POSITION;
   }
 
   /**
@@ -2537,7 +2452,7 @@ library ReserveConfiguration {
    */
   function setActive(DataTypes.ReserveConfigurationMap memory self, bool active) internal pure {
     self.data =
-      (self.data & ~ACTIVE_MASK) |
+      (self.data & ACTIVE_MASK) |
       (uint256(active ? 1 : 0) << IS_ACTIVE_START_BIT_POSITION);
   }
 
@@ -2547,7 +2462,7 @@ library ReserveConfiguration {
    * @return The active state
    */
   function getActive(DataTypes.ReserveConfigurationMap memory self) internal pure returns (bool) {
-    return (self.data & ACTIVE_MASK) != 0;
+    return (self.data & ~ACTIVE_MASK) != 0;
   }
 
   /**
@@ -2557,7 +2472,7 @@ library ReserveConfiguration {
    */
   function setFrozen(DataTypes.ReserveConfigurationMap memory self, bool frozen) internal pure {
     self.data =
-      (self.data & ~FROZEN_MASK) |
+      (self.data & FROZEN_MASK) |
       (uint256(frozen ? 1 : 0) << IS_FROZEN_START_BIT_POSITION);
   }
 
@@ -2567,7 +2482,7 @@ library ReserveConfiguration {
    * @return The frozen state
    */
   function getFrozen(DataTypes.ReserveConfigurationMap memory self) internal pure returns (bool) {
-    return (self.data & FROZEN_MASK) != 0;
+    return (self.data & ~FROZEN_MASK) != 0;
   }
 
   /**
@@ -2577,7 +2492,7 @@ library ReserveConfiguration {
    */
   function setPaused(DataTypes.ReserveConfigurationMap memory self, bool paused) internal pure {
     self.data =
-      (self.data & ~PAUSED_MASK) |
+      (self.data & PAUSED_MASK) |
       (uint256(paused ? 1 : 0) << IS_PAUSED_START_BIT_POSITION);
   }
 
@@ -2587,7 +2502,7 @@ library ReserveConfiguration {
    * @return The paused state
    */
   function getPaused(DataTypes.ReserveConfigurationMap memory self) internal pure returns (bool) {
-    return (self.data & PAUSED_MASK) != 0;
+    return (self.data & ~PAUSED_MASK) != 0;
   }
 
   /**
@@ -2604,7 +2519,7 @@ library ReserveConfiguration {
     bool borrowable
   ) internal pure {
     self.data =
-      (self.data & ~BORROWABLE_IN_ISOLATION_MASK) |
+      (self.data & BORROWABLE_IN_ISOLATION_MASK) |
       (uint256(borrowable ? 1 : 0) << BORROWABLE_IN_ISOLATION_START_BIT_POSITION);
   }
 
@@ -2620,7 +2535,7 @@ library ReserveConfiguration {
   function getBorrowableInIsolation(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (bool) {
-    return (self.data & BORROWABLE_IN_ISOLATION_MASK) != 0;
+    return (self.data & ~BORROWABLE_IN_ISOLATION_MASK) != 0;
   }
 
   /**
@@ -2634,7 +2549,7 @@ library ReserveConfiguration {
     bool siloed
   ) internal pure {
     self.data =
-      (self.data & ~SILOED_BORROWING_MASK) |
+      (self.data & SILOED_BORROWING_MASK) |
       (uint256(siloed ? 1 : 0) << SILOED_BORROWING_START_BIT_POSITION);
   }
 
@@ -2647,7 +2562,7 @@ library ReserveConfiguration {
   function getSiloedBorrowing(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (bool) {
-    return (self.data & SILOED_BORROWING_MASK) != 0;
+    return (self.data & ~SILOED_BORROWING_MASK) != 0;
   }
 
   /**
@@ -2660,7 +2575,7 @@ library ReserveConfiguration {
     bool enabled
   ) internal pure {
     self.data =
-      (self.data & ~BORROWING_MASK) |
+      (self.data & BORROWING_MASK) |
       (uint256(enabled ? 1 : 0) << BORROWING_ENABLED_START_BIT_POSITION);
   }
 
@@ -2672,7 +2587,7 @@ library ReserveConfiguration {
   function getBorrowingEnabled(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (bool) {
-    return (self.data & BORROWING_MASK) != 0;
+    return (self.data & ~BORROWING_MASK) != 0;
   }
 
   /**
@@ -2687,7 +2602,7 @@ library ReserveConfiguration {
     require(reserveFactor <= MAX_VALID_RESERVE_FACTOR, Errors.INVALID_RESERVE_FACTOR);
 
     self.data =
-      (self.data & ~RESERVE_FACTOR_MASK) |
+      (self.data & RESERVE_FACTOR_MASK) |
       (reserveFactor << RESERVE_FACTOR_START_BIT_POSITION);
   }
 
@@ -2699,7 +2614,7 @@ library ReserveConfiguration {
   function getReserveFactor(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & RESERVE_FACTOR_MASK) >> RESERVE_FACTOR_START_BIT_POSITION;
+    return (self.data & ~RESERVE_FACTOR_MASK) >> RESERVE_FACTOR_START_BIT_POSITION;
   }
 
   /**
@@ -2713,7 +2628,7 @@ library ReserveConfiguration {
   ) internal pure {
     require(borrowCap <= MAX_VALID_BORROW_CAP, Errors.INVALID_BORROW_CAP);
 
-    self.data = (self.data & ~BORROW_CAP_MASK) | (borrowCap << BORROW_CAP_START_BIT_POSITION);
+    self.data = (self.data & BORROW_CAP_MASK) | (borrowCap << BORROW_CAP_START_BIT_POSITION);
   }
 
   /**
@@ -2724,7 +2639,7 @@ library ReserveConfiguration {
   function getBorrowCap(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & BORROW_CAP_MASK) >> BORROW_CAP_START_BIT_POSITION;
+    return (self.data & ~BORROW_CAP_MASK) >> BORROW_CAP_START_BIT_POSITION;
   }
 
   /**
@@ -2738,7 +2653,7 @@ library ReserveConfiguration {
   ) internal pure {
     require(supplyCap <= MAX_VALID_SUPPLY_CAP, Errors.INVALID_SUPPLY_CAP);
 
-    self.data = (self.data & ~SUPPLY_CAP_MASK) | (supplyCap << SUPPLY_CAP_START_BIT_POSITION);
+    self.data = (self.data & SUPPLY_CAP_MASK) | (supplyCap << SUPPLY_CAP_START_BIT_POSITION);
   }
 
   /**
@@ -2749,7 +2664,7 @@ library ReserveConfiguration {
   function getSupplyCap(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & SUPPLY_CAP_MASK) >> SUPPLY_CAP_START_BIT_POSITION;
+    return (self.data & ~SUPPLY_CAP_MASK) >> SUPPLY_CAP_START_BIT_POSITION;
   }
 
   /**
@@ -2763,7 +2678,7 @@ library ReserveConfiguration {
   ) internal pure {
     require(ceiling <= MAX_VALID_DEBT_CEILING, Errors.INVALID_DEBT_CEILING);
 
-    self.data = (self.data & ~DEBT_CEILING_MASK) | (ceiling << DEBT_CEILING_START_BIT_POSITION);
+    self.data = (self.data & DEBT_CEILING_MASK) | (ceiling << DEBT_CEILING_START_BIT_POSITION);
   }
 
   /**
@@ -2774,7 +2689,7 @@ library ReserveConfiguration {
   function getDebtCeiling(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & DEBT_CEILING_MASK) >> DEBT_CEILING_START_BIT_POSITION;
+    return (self.data & ~DEBT_CEILING_MASK) >> DEBT_CEILING_START_BIT_POSITION;
   }
 
   /**
@@ -2792,7 +2707,7 @@ library ReserveConfiguration {
     );
 
     self.data =
-      (self.data & ~LIQUIDATION_PROTOCOL_FEE_MASK) |
+      (self.data & LIQUIDATION_PROTOCOL_FEE_MASK) |
       (liquidationProtocolFee << LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION);
   }
 
@@ -2805,7 +2720,7 @@ library ReserveConfiguration {
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
     return
-      (self.data & LIQUIDATION_PROTOCOL_FEE_MASK) >> LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION;
+      (self.data & ~LIQUIDATION_PROTOCOL_FEE_MASK) >> LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION;
   }
 
   /**
@@ -2820,7 +2735,7 @@ library ReserveConfiguration {
     require(unbackedMintCap <= MAX_VALID_UNBACKED_MINT_CAP, Errors.INVALID_UNBACKED_MINT_CAP);
 
     self.data =
-      (self.data & ~UNBACKED_MINT_CAP_MASK) |
+      (self.data & UNBACKED_MINT_CAP_MASK) |
       (unbackedMintCap << UNBACKED_MINT_CAP_START_BIT_POSITION);
   }
 
@@ -2832,7 +2747,7 @@ library ReserveConfiguration {
   function getUnbackedMintCap(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & UNBACKED_MINT_CAP_MASK) >> UNBACKED_MINT_CAP_START_BIT_POSITION;
+    return (self.data & ~UNBACKED_MINT_CAP_MASK) >> UNBACKED_MINT_CAP_START_BIT_POSITION;
   }
 
   /**
@@ -2845,7 +2760,7 @@ library ReserveConfiguration {
     bool flashLoanEnabled
   ) internal pure {
     self.data =
-      (self.data & ~FLASHLOAN_ENABLED_MASK) |
+      (self.data & FLASHLOAN_ENABLED_MASK) |
       (uint256(flashLoanEnabled ? 1 : 0) << FLASHLOAN_ENABLED_START_BIT_POSITION);
   }
 
@@ -2857,7 +2772,7 @@ library ReserveConfiguration {
   function getFlashLoanEnabled(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (bool) {
-    return (self.data & FLASHLOAN_ENABLED_MASK) != 0;
+    return (self.data & ~FLASHLOAN_ENABLED_MASK) != 0;
   }
 
   /**
@@ -2870,24 +2785,21 @@ library ReserveConfiguration {
     bool active
   ) internal pure {
     self.data =
-      (self.data & ~VIRTUAL_ACC_ACTIVE_MASK) |
+      (self.data & VIRTUAL_ACC_ACTIVE_MASK) |
       (uint256(active ? 1 : 0) << VIRTUAL_ACC_START_BIT_POSITION);
   }
 
   /**
    * @notice Gets the virtual account active/not state of the reserve
    * @dev The state should be true for all normal assets and should be false
-   * Virtual accounting being disabled means that the asset:
-   * - is GHO
-   * - can never be supplied
-   * - the interest rate strategy is not influenced by the virtual balance
+   *  only in special cases (ex. GHO) where an asset is minted instead of supplied.
    * @param self The reserve configuration
    * @return The active state
    */
   function getIsVirtualAccActive(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (bool) {
-    return (self.data & VIRTUAL_ACC_ACTIVE_MASK) != 0;
+    return (self.data & ~VIRTUAL_ACC_ACTIVE_MASK) != 0;
   }
 
   /**
@@ -2904,10 +2816,10 @@ library ReserveConfiguration {
     uint256 dataLocal = self.data;
 
     return (
-      (dataLocal & ACTIVE_MASK) != 0,
-      (dataLocal & FROZEN_MASK) != 0,
-      (dataLocal & BORROWING_MASK) != 0,
-      (dataLocal & PAUSED_MASK) != 0
+      (dataLocal & ~ACTIVE_MASK) != 0,
+      (dataLocal & ~FROZEN_MASK) != 0,
+      (dataLocal & ~BORROWING_MASK) != 0,
+      (dataLocal & ~PAUSED_MASK) != 0
     );
   }
 
@@ -2926,11 +2838,11 @@ library ReserveConfiguration {
     uint256 dataLocal = self.data;
 
     return (
-      dataLocal & LTV_MASK,
-      (dataLocal & LIQUIDATION_THRESHOLD_MASK) >> LIQUIDATION_THRESHOLD_START_BIT_POSITION,
-      (dataLocal & LIQUIDATION_BONUS_MASK) >> LIQUIDATION_BONUS_START_BIT_POSITION,
-      (dataLocal & DECIMALS_MASK) >> RESERVE_DECIMALS_START_BIT_POSITION,
-      (dataLocal & RESERVE_FACTOR_MASK) >> RESERVE_FACTOR_START_BIT_POSITION
+      dataLocal & ~LTV_MASK,
+      (dataLocal & ~LIQUIDATION_THRESHOLD_MASK) >> LIQUIDATION_THRESHOLD_START_BIT_POSITION,
+      (dataLocal & ~LIQUIDATION_BONUS_MASK) >> LIQUIDATION_BONUS_START_BIT_POSITION,
+      (dataLocal & ~DECIMALS_MASK) >> RESERVE_DECIMALS_START_BIT_POSITION,
+      (dataLocal & ~RESERVE_FACTOR_MASK) >> RESERVE_FACTOR_START_BIT_POSITION
     );
   }
 
@@ -2946,13 +2858,13 @@ library ReserveConfiguration {
     uint256 dataLocal = self.data;
 
     return (
-      (dataLocal & BORROW_CAP_MASK) >> BORROW_CAP_START_BIT_POSITION,
-      (dataLocal & SUPPLY_CAP_MASK) >> SUPPLY_CAP_START_BIT_POSITION
+      (dataLocal & ~BORROW_CAP_MASK) >> BORROW_CAP_START_BIT_POSITION,
+      (dataLocal & ~SUPPLY_CAP_MASK) >> SUPPLY_CAP_START_BIT_POSITION
     );
   }
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/interfaces/IDefaultInterestRateStrategyV2.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/interfaces/IDefaultInterestRateStrategyV2.sol
 
 /**
  * @title IDefaultInterestRateStrategyV2
@@ -3110,7 +3022,7 @@ interface IDefaultInterestRateStrategyV2 is IReserveInterestRateStrategy {
   function setInterestRateParams(address reserve, InterestRateData calldata rateData) external;
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
 
 /**
  * @title UserConfiguration library
@@ -3342,7 +3254,7 @@ library UserConfiguration {
   }
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/interfaces/IInitializableAToken.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/interfaces/IInitializableAToken.sol
 
 /**
  * @title IInitializableAToken
@@ -3395,7 +3307,7 @@ interface IInitializableAToken {
   ) external;
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/interfaces/IInitializableDebtToken.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/interfaces/IInitializableDebtToken.sol
 
 /**
  * @title IInitializableDebtToken
@@ -3444,7 +3356,7 @@ interface IInitializableDebtToken {
   ) external;
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/interfaces/IVariableDebtToken.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/interfaces/IVariableDebtToken.sol
 
 /**
  * @title IVariableDebtToken
@@ -3487,7 +3399,7 @@ interface IVariableDebtToken is IScaledBalanceToken, IInitializableDebtToken {
   function UNDERLYING_ASSET_ADDRESS() external view returns (address);
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/interfaces/IAToken.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/interfaces/IAToken.sol
 
 /**
  * @title IAToken
@@ -3621,7 +3533,7 @@ interface IAToken is IERC20, IScaledBalanceToken, IInitializableAToken {
   function rescueTokens(address token, address to, uint256 amount) external;
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/helpers/AaveProtocolDataProvider.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/helpers/AaveProtocolDataProvider.sol
 
 /**
  * @title AaveProtocolDataProvider
@@ -3675,10 +3587,10 @@ contract AaveProtocolDataProvider is IPoolDataProvider {
     address[] memory reserves = pool.getReservesList();
     TokenData[] memory aTokens = new TokenData[](reserves.length);
     for (uint256 i = 0; i < reserves.length; i++) {
-      address aTokenAddress = pool.getReserveAToken(reserves[i]);
+      DataTypes.ReserveDataLegacy memory reserveData = pool.getReserveData(reserves[i]);
       aTokens[i] = TokenData({
-        symbol: IERC20Detailed(aTokenAddress).symbol(),
-        tokenAddress: aTokenAddress
+        symbol: IERC20Detailed(reserveData.aTokenAddress).symbol(),
+        tokenAddress: reserveData.aTokenAddress
       });
     }
     return aTokens;
@@ -3766,12 +3678,12 @@ contract AaveProtocolDataProvider is IPoolDataProvider {
       uint256 unbacked,
       uint256 accruedToTreasuryScaled,
       uint256 totalAToken,
-      uint256,
+      uint256 totalStableDebt,
       uint256 totalVariableDebt,
       uint256 liquidityRate,
       uint256 variableBorrowRate,
-      uint256,
-      uint256,
+      uint256 stableBorrowRate,
+      uint256 averageStableBorrowRate,
       uint256 liquidityIndex,
       uint256 variableBorrowIndex,
       uint40 lastUpdateTimestamp
@@ -3800,15 +3712,18 @@ contract AaveProtocolDataProvider is IPoolDataProvider {
 
   /// @inheritdoc IPoolDataProvider
   function getATokenTotalSupply(address asset) external view override returns (uint256) {
-    address aTokenAddress = IPool(ADDRESSES_PROVIDER.getPool()).getReserveAToken(asset);
-    return IERC20Detailed(aTokenAddress).totalSupply();
+    DataTypes.ReserveDataLegacy memory reserve = IPool(ADDRESSES_PROVIDER.getPool()).getReserveData(
+      asset
+    );
+    return IERC20Detailed(reserve.aTokenAddress).totalSupply();
   }
 
   /// @inheritdoc IPoolDataProvider
   function getTotalDebt(address asset) external view override returns (uint256) {
-    address variableDebtTokenAddress = IPool(ADDRESSES_PROVIDER.getPool())
-      .getReserveVariableDebtToken(asset);
-    return IERC20Detailed(variableDebtTokenAddress).totalSupply();
+    DataTypes.ReserveDataLegacy memory reserve = IPool(ADDRESSES_PROVIDER.getPool()).getReserveData(
+      asset
+    );
+    return IERC20Detailed(reserve.variableDebtTokenAddress).totalSupply();
   }
 
   /// @inheritdoc IPoolDataProvider
@@ -3862,10 +3777,12 @@ contract AaveProtocolDataProvider is IPoolDataProvider {
       address variableDebtTokenAddress
     )
   {
-    IPool pool = IPool(ADDRESSES_PROVIDER.getPool());
+    DataTypes.ReserveDataLegacy memory reserve = IPool(ADDRESSES_PROVIDER.getPool()).getReserveData(
+      asset
+    );
 
     // @notice all stable debt related parameters deprecated in v3.2.0
-    return (pool.getReserveAToken(asset), address(0), pool.getReserveVariableDebtToken(asset));
+    return (reserve.aTokenAddress, address(0), reserve.variableDebtTokenAddress);
   }
 
   /// @inheritdoc IPoolDataProvider
@@ -3899,28 +3816,23 @@ contract AaveProtocolDataProvider is IPoolDataProvider {
   function getVirtualUnderlyingBalance(address asset) external view override returns (uint256) {
     return IPool(ADDRESSES_PROVIDER.getPool()).getVirtualUnderlyingBalance(asset);
   }
-
-  /// @inheritdoc IPoolDataProvider
-  function getReserveDeficit(address asset) external view override returns (uint256) {
-    return IPool(ADDRESSES_PROVIDER.getPool()).getReserveDeficit(asset);
-  }
 }
 
-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/helpers/UiPoolDataProviderV3.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/helpers/UiPoolDataProviderV3.sol
 
 contract UiPoolDataProviderV3 is IUiPoolDataProviderV3 {
   using WadRayMath for uint256;
   using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
   using UserConfiguration for DataTypes.UserConfigurationMap;
 
-  AggregatorInterface public immutable networkBaseTokenPriceInUsdProxyAggregator;
-  AggregatorInterface public immutable marketReferenceCurrencyPriceInUsdProxyAggregator;
+  IEACAggregatorProxy public immutable networkBaseTokenPriceInUsdProxyAggregator;
+  IEACAggregatorProxy public immutable marketReferenceCurrencyPriceInUsdProxyAggregator;
   uint256 public constant ETH_CURRENCY_UNIT = 1 ether;
   address public constant MKR_ADDRESS = 0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2;
 
   constructor(
-    AggregatorInterface _networkBaseTokenPriceInUsdProxyAggregator,
-    AggregatorInterface _marketReferenceCurrencyPriceInUsdProxyAggregator
+    IEACAggregatorProxy _networkBaseTokenPriceInUsdProxyAggregator,
+    IEACAggregatorProxy _marketReferenceCurrencyPriceInUsdProxyAggregator
   ) {
     networkBaseTokenPriceInUsdProxyAggregator = _networkBaseTokenPriceInUsdProxyAggregator;
     marketReferenceCurrencyPriceInUsdProxyAggregator = _marketReferenceCurrencyPriceInUsdProxyAggregator;
@@ -4018,7 +3930,6 @@ contract UiPoolDataProviderV3 is IUiPoolDataProviderV3 {
       } catch {}
 
       // v3 only
-      reserveData.deficit = uint128(pool.getReserveDeficit(reserveData.underlyingAsset));
       reserveData.debtCeiling = reserveConfigurationMap.getDebtCeiling();
       reserveData.debtCeilingDecimals = poolDataProvider.getDebtCeilingDecimals();
       (reserveData.borrowCap, reserveData.supplyCap) = reserveConfigurationMap.getCaps();
```
