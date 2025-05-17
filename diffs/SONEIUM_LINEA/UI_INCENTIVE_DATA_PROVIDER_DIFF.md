```diff
diff --git a/./downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER.sol b/./downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER.sol
index cf5f34b..116b0dd 100644
--- a/./downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER.sol
+++ b/./downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER.sol
@@ -1,55 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/dependencies/chainlink/AggregatorInterface.sol
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
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/dependencies/openzeppelin/contracts/Context.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/dependencies/openzeppelin/contracts/Context.sol
 
 /*
  * @dev Provides information about the current execution context, including the
@@ -72,7 +24,7 @@ abstract contract Context {
   }
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/protocol/libraries/types/DataTypes.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/protocol/libraries/types/DataTypes.sol
 
 library DataTypes {
   /**
@@ -123,9 +75,8 @@ library DataTypes {
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
@@ -291,11 +242,6 @@ library DataTypes {
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
@@ -402,7 +348,7 @@ library DataTypes {
   }
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/protocol/libraries/helpers/Errors.sol
 
 /**
  * @title Errors library
@@ -503,13 +449,9 @@ library Errors {
   string public constant INVALID_GRACE_PERIOD = '98'; // Grace period above a valid range
   string public constant INVALID_FREEZE_STATE = '99'; // Reserve is already in the passed freeze state
   string public constant NOT_BORROWABLE_IN_EMODE = '100'; // Asset not borrowable in eMode
-  string public constant CALLER_NOT_UMBRELLA = '101'; // The caller of the function is not the umbrella contract
-  string public constant RESERVE_NOT_IN_DEFICIT = '102'; // The reserve is not in deficit
-  string public constant MUST_NOT_LEAVE_DUST = '103'; // Below a certain threshold liquidators need to take the full position
-  string public constant USER_CANNOT_HAVE_DEBT = '104'; // Thrown when a user tries to interact with a method that requires a position without debt
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/interfaces/IAaveIncentivesController.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/interfaces/IAaveIncentivesController.sol
 
 /**
  * @title IAaveIncentivesController
@@ -528,7 +470,26 @@ interface IAaveIncentivesController {
   function handleAction(address user, uint256 totalSupply, uint256 userBalance) external;
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/helpers/interfaces/IEACAggregatorProxy.sol
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
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
 
 /**
  * @dev Interface of the ERC20 standard as defined in the EIP.
@@ -604,7 +565,7 @@ interface IERC20 {
   event Approval(address indexed owner, address indexed spender, uint256 value);
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -831,7 +792,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/rewards/interfaces/IRewardsDistributor.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/rewards/interfaces/IRewardsDistributor.sol
 
 /**
  * @title IRewardsDistributor
@@ -1008,7 +969,7 @@ interface IRewardsDistributor {
   function getEmissionManager() external view returns (address);
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/rewards/interfaces/ITransferStrategyBase.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/rewards/interfaces/ITransferStrategyBase.sol
 
 interface ITransferStrategyBase {
   event EmergencyWithdrawal(
@@ -1046,7 +1007,7 @@ interface ITransferStrategyBase {
   function emergencyWithdrawal(address token, address to, uint256 amount) external;
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
 
 // OpenZeppelin Contracts v4.4.1 (utils/math/SafeCast.sol)
 
@@ -1302,7 +1263,7 @@ library SafeCast {
   }
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/protocol/libraries/math/WadRayMath.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/protocol/libraries/math/WadRayMath.sol
 
 /**
  * @title WadRayMath library
@@ -1428,7 +1389,7 @@ library WadRayMath {
   }
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/interfaces/IACLManager.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/interfaces/IACLManager.sol
 
 /**
  * @title IACLManager
@@ -1601,7 +1562,7 @@ interface IACLManager {
   function isAssetListingAdmin(address admin) external view returns (bool);
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
 
 interface IERC20Detailed is IERC20 {
   function name() external view returns (string memory);
@@ -1611,7 +1572,7 @@ interface IERC20Detailed is IERC20 {
   function decimals() external view returns (uint8);
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/helpers/interfaces/IUiIncentiveDataProviderV3.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/helpers/interfaces/IUiIncentiveDataProviderV3.sol
 
 interface IUiIncentiveDataProviderV3 {
   struct AggregatedReserveIncentiveData {
@@ -1682,7 +1643,7 @@ interface IUiIncentiveDataProviderV3 {
     returns (AggregatedReserveIncentiveData[] memory, UserReserveIncentiveData[] memory);
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/interfaces/IPool.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/interfaces/IPool.sol
 
 /**
  * @title IPool
@@ -1865,14 +1826,6 @@ interface IPool {
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
@@ -1880,14 +1833,6 @@ interface IPool {
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
@@ -2255,6 +2200,16 @@ interface IPool {
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
@@ -2429,7 +2384,7 @@ interface IPool {
    * @param asset The address of the underlying asset
    * @return Timestamp when the liquidation grace period will end
    **/
-  function getLiquidationGracePeriod(address asset) external view returns (uint40);
+  function getLiquidationGracePeriod(address asset) external returns (uint40);
 
   /**
    * @notice Returns the total fee on flash loans
@@ -2483,37 +2438,6 @@ interface IPool {
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
@@ -2550,7 +2474,7 @@ interface IPool {
   function getSupplyLogic() external view returns (address);
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
 
 /**
  * @title ReserveConfiguration library
@@ -2558,26 +2482,26 @@ interface IPool {
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
@@ -2621,7 +2545,7 @@ library ReserveConfiguration {
   function setLtv(DataTypes.ReserveConfigurationMap memory self, uint256 ltv) internal pure {
     require(ltv <= MAX_VALID_LTV, Errors.INVALID_LTV);
 
-    self.data = (self.data & ~LTV_MASK) | ltv;
+    self.data = (self.data & LTV_MASK) | ltv;
   }
 
   /**
@@ -2630,7 +2554,7 @@ library ReserveConfiguration {
    * @return The loan to value
    */
   function getLtv(DataTypes.ReserveConfigurationMap memory self) internal pure returns (uint256) {
-    return self.data & LTV_MASK;
+    return self.data & ~LTV_MASK;
   }
 
   /**
@@ -2645,7 +2569,7 @@ library ReserveConfiguration {
     require(threshold <= MAX_VALID_LIQUIDATION_THRESHOLD, Errors.INVALID_LIQ_THRESHOLD);
 
     self.data =
-      (self.data & ~LIQUIDATION_THRESHOLD_MASK) |
+      (self.data & LIQUIDATION_THRESHOLD_MASK) |
       (threshold << LIQUIDATION_THRESHOLD_START_BIT_POSITION);
   }
 
@@ -2657,7 +2581,7 @@ library ReserveConfiguration {
   function getLiquidationThreshold(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & LIQUIDATION_THRESHOLD_MASK) >> LIQUIDATION_THRESHOLD_START_BIT_POSITION;
+    return (self.data & ~LIQUIDATION_THRESHOLD_MASK) >> LIQUIDATION_THRESHOLD_START_BIT_POSITION;
   }
 
   /**
@@ -2672,7 +2596,7 @@ library ReserveConfiguration {
     require(bonus <= MAX_VALID_LIQUIDATION_BONUS, Errors.INVALID_LIQ_BONUS);
 
     self.data =
-      (self.data & ~LIQUIDATION_BONUS_MASK) |
+      (self.data & LIQUIDATION_BONUS_MASK) |
       (bonus << LIQUIDATION_BONUS_START_BIT_POSITION);
   }
 
@@ -2684,7 +2608,7 @@ library ReserveConfiguration {
   function getLiquidationBonus(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & LIQUIDATION_BONUS_MASK) >> LIQUIDATION_BONUS_START_BIT_POSITION;
+    return (self.data & ~LIQUIDATION_BONUS_MASK) >> LIQUIDATION_BONUS_START_BIT_POSITION;
   }
 
   /**
@@ -2698,7 +2622,7 @@ library ReserveConfiguration {
   ) internal pure {
     require(decimals <= MAX_VALID_DECIMALS, Errors.INVALID_DECIMALS);
 
-    self.data = (self.data & ~DECIMALS_MASK) | (decimals << RESERVE_DECIMALS_START_BIT_POSITION);
+    self.data = (self.data & DECIMALS_MASK) | (decimals << RESERVE_DECIMALS_START_BIT_POSITION);
   }
 
   /**
@@ -2709,7 +2633,7 @@ library ReserveConfiguration {
   function getDecimals(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & DECIMALS_MASK) >> RESERVE_DECIMALS_START_BIT_POSITION;
+    return (self.data & ~DECIMALS_MASK) >> RESERVE_DECIMALS_START_BIT_POSITION;
   }
 
   /**
@@ -2719,7 +2643,7 @@ library ReserveConfiguration {
    */
   function setActive(DataTypes.ReserveConfigurationMap memory self, bool active) internal pure {
     self.data =
-      (self.data & ~ACTIVE_MASK) |
+      (self.data & ACTIVE_MASK) |
       (uint256(active ? 1 : 0) << IS_ACTIVE_START_BIT_POSITION);
   }
 
@@ -2729,7 +2653,7 @@ library ReserveConfiguration {
    * @return The active state
    */
   function getActive(DataTypes.ReserveConfigurationMap memory self) internal pure returns (bool) {
-    return (self.data & ACTIVE_MASK) != 0;
+    return (self.data & ~ACTIVE_MASK) != 0;
   }
 
   /**
@@ -2739,7 +2663,7 @@ library ReserveConfiguration {
    */
   function setFrozen(DataTypes.ReserveConfigurationMap memory self, bool frozen) internal pure {
     self.data =
-      (self.data & ~FROZEN_MASK) |
+      (self.data & FROZEN_MASK) |
       (uint256(frozen ? 1 : 0) << IS_FROZEN_START_BIT_POSITION);
   }
 
@@ -2749,7 +2673,7 @@ library ReserveConfiguration {
    * @return The frozen state
    */
   function getFrozen(DataTypes.ReserveConfigurationMap memory self) internal pure returns (bool) {
-    return (self.data & FROZEN_MASK) != 0;
+    return (self.data & ~FROZEN_MASK) != 0;
   }
 
   /**
@@ -2759,7 +2683,7 @@ library ReserveConfiguration {
    */
   function setPaused(DataTypes.ReserveConfigurationMap memory self, bool paused) internal pure {
     self.data =
-      (self.data & ~PAUSED_MASK) |
+      (self.data & PAUSED_MASK) |
       (uint256(paused ? 1 : 0) << IS_PAUSED_START_BIT_POSITION);
   }
 
@@ -2769,7 +2693,7 @@ library ReserveConfiguration {
    * @return The paused state
    */
   function getPaused(DataTypes.ReserveConfigurationMap memory self) internal pure returns (bool) {
-    return (self.data & PAUSED_MASK) != 0;
+    return (self.data & ~PAUSED_MASK) != 0;
   }
 
   /**
@@ -2786,7 +2710,7 @@ library ReserveConfiguration {
     bool borrowable
   ) internal pure {
     self.data =
-      (self.data & ~BORROWABLE_IN_ISOLATION_MASK) |
+      (self.data & BORROWABLE_IN_ISOLATION_MASK) |
       (uint256(borrowable ? 1 : 0) << BORROWABLE_IN_ISOLATION_START_BIT_POSITION);
   }
 
@@ -2802,7 +2726,7 @@ library ReserveConfiguration {
   function getBorrowableInIsolation(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (bool) {
-    return (self.data & BORROWABLE_IN_ISOLATION_MASK) != 0;
+    return (self.data & ~BORROWABLE_IN_ISOLATION_MASK) != 0;
   }
 
   /**
@@ -2816,7 +2740,7 @@ library ReserveConfiguration {
     bool siloed
   ) internal pure {
     self.data =
-      (self.data & ~SILOED_BORROWING_MASK) |
+      (self.data & SILOED_BORROWING_MASK) |
       (uint256(siloed ? 1 : 0) << SILOED_BORROWING_START_BIT_POSITION);
   }
 
@@ -2829,7 +2753,7 @@ library ReserveConfiguration {
   function getSiloedBorrowing(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (bool) {
-    return (self.data & SILOED_BORROWING_MASK) != 0;
+    return (self.data & ~SILOED_BORROWING_MASK) != 0;
   }
 
   /**
@@ -2842,7 +2766,7 @@ library ReserveConfiguration {
     bool enabled
   ) internal pure {
     self.data =
-      (self.data & ~BORROWING_MASK) |
+      (self.data & BORROWING_MASK) |
       (uint256(enabled ? 1 : 0) << BORROWING_ENABLED_START_BIT_POSITION);
   }
 
@@ -2854,7 +2778,7 @@ library ReserveConfiguration {
   function getBorrowingEnabled(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (bool) {
-    return (self.data & BORROWING_MASK) != 0;
+    return (self.data & ~BORROWING_MASK) != 0;
   }
 
   /**
@@ -2869,7 +2793,7 @@ library ReserveConfiguration {
     require(reserveFactor <= MAX_VALID_RESERVE_FACTOR, Errors.INVALID_RESERVE_FACTOR);
 
     self.data =
-      (self.data & ~RESERVE_FACTOR_MASK) |
+      (self.data & RESERVE_FACTOR_MASK) |
       (reserveFactor << RESERVE_FACTOR_START_BIT_POSITION);
   }
 
@@ -2881,7 +2805,7 @@ library ReserveConfiguration {
   function getReserveFactor(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & RESERVE_FACTOR_MASK) >> RESERVE_FACTOR_START_BIT_POSITION;
+    return (self.data & ~RESERVE_FACTOR_MASK) >> RESERVE_FACTOR_START_BIT_POSITION;
   }
 
   /**
@@ -2895,7 +2819,7 @@ library ReserveConfiguration {
   ) internal pure {
     require(borrowCap <= MAX_VALID_BORROW_CAP, Errors.INVALID_BORROW_CAP);
 
-    self.data = (self.data & ~BORROW_CAP_MASK) | (borrowCap << BORROW_CAP_START_BIT_POSITION);
+    self.data = (self.data & BORROW_CAP_MASK) | (borrowCap << BORROW_CAP_START_BIT_POSITION);
   }
 
   /**
@@ -2906,7 +2830,7 @@ library ReserveConfiguration {
   function getBorrowCap(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & BORROW_CAP_MASK) >> BORROW_CAP_START_BIT_POSITION;
+    return (self.data & ~BORROW_CAP_MASK) >> BORROW_CAP_START_BIT_POSITION;
   }
 
   /**
@@ -2920,7 +2844,7 @@ library ReserveConfiguration {
   ) internal pure {
     require(supplyCap <= MAX_VALID_SUPPLY_CAP, Errors.INVALID_SUPPLY_CAP);
 
-    self.data = (self.data & ~SUPPLY_CAP_MASK) | (supplyCap << SUPPLY_CAP_START_BIT_POSITION);
+    self.data = (self.data & SUPPLY_CAP_MASK) | (supplyCap << SUPPLY_CAP_START_BIT_POSITION);
   }
 
   /**
@@ -2931,7 +2855,7 @@ library ReserveConfiguration {
   function getSupplyCap(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & SUPPLY_CAP_MASK) >> SUPPLY_CAP_START_BIT_POSITION;
+    return (self.data & ~SUPPLY_CAP_MASK) >> SUPPLY_CAP_START_BIT_POSITION;
   }
 
   /**
@@ -2945,7 +2869,7 @@ library ReserveConfiguration {
   ) internal pure {
     require(ceiling <= MAX_VALID_DEBT_CEILING, Errors.INVALID_DEBT_CEILING);
 
-    self.data = (self.data & ~DEBT_CEILING_MASK) | (ceiling << DEBT_CEILING_START_BIT_POSITION);
+    self.data = (self.data & DEBT_CEILING_MASK) | (ceiling << DEBT_CEILING_START_BIT_POSITION);
   }
 
   /**
@@ -2956,7 +2880,7 @@ library ReserveConfiguration {
   function getDebtCeiling(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & DEBT_CEILING_MASK) >> DEBT_CEILING_START_BIT_POSITION;
+    return (self.data & ~DEBT_CEILING_MASK) >> DEBT_CEILING_START_BIT_POSITION;
   }
 
   /**
@@ -2974,7 +2898,7 @@ library ReserveConfiguration {
     );
 
     self.data =
-      (self.data & ~LIQUIDATION_PROTOCOL_FEE_MASK) |
+      (self.data & LIQUIDATION_PROTOCOL_FEE_MASK) |
       (liquidationProtocolFee << LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION);
   }
 
@@ -2987,7 +2911,7 @@ library ReserveConfiguration {
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
     return
-      (self.data & LIQUIDATION_PROTOCOL_FEE_MASK) >> LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION;
+      (self.data & ~LIQUIDATION_PROTOCOL_FEE_MASK) >> LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION;
   }
 
   /**
@@ -3002,7 +2926,7 @@ library ReserveConfiguration {
     require(unbackedMintCap <= MAX_VALID_UNBACKED_MINT_CAP, Errors.INVALID_UNBACKED_MINT_CAP);
 
     self.data =
-      (self.data & ~UNBACKED_MINT_CAP_MASK) |
+      (self.data & UNBACKED_MINT_CAP_MASK) |
       (unbackedMintCap << UNBACKED_MINT_CAP_START_BIT_POSITION);
   }
 
@@ -3014,7 +2938,7 @@ library ReserveConfiguration {
   function getUnbackedMintCap(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (uint256) {
-    return (self.data & UNBACKED_MINT_CAP_MASK) >> UNBACKED_MINT_CAP_START_BIT_POSITION;
+    return (self.data & ~UNBACKED_MINT_CAP_MASK) >> UNBACKED_MINT_CAP_START_BIT_POSITION;
   }
 
   /**
@@ -3027,7 +2951,7 @@ library ReserveConfiguration {
     bool flashLoanEnabled
   ) internal pure {
     self.data =
-      (self.data & ~FLASHLOAN_ENABLED_MASK) |
+      (self.data & FLASHLOAN_ENABLED_MASK) |
       (uint256(flashLoanEnabled ? 1 : 0) << FLASHLOAN_ENABLED_START_BIT_POSITION);
   }
 
@@ -3039,7 +2963,7 @@ library ReserveConfiguration {
   function getFlashLoanEnabled(
     DataTypes.ReserveConfigurationMap memory self
   ) internal pure returns (bool) {
-    return (self.data & FLASHLOAN_ENABLED_MASK) != 0;
+    return (self.data & ~FLASHLOAN_ENABLED_MASK) != 0;
   }
 
   /**
@@ -3052,24 +2976,21 @@ library ReserveConfiguration {
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
@@ -3086,10 +3007,10 @@ library ReserveConfiguration {
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
 
@@ -3108,11 +3029,11 @@ library ReserveConfiguration {
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
 
@@ -3128,13 +3049,13 @@ library ReserveConfiguration {
     uint256 dataLocal = self.data;
 
     return (
-      (dataLocal & BORROW_CAP_MASK) >> BORROW_CAP_START_BIT_POSITION,
-      (dataLocal & SUPPLY_CAP_MASK) >> SUPPLY_CAP_START_BIT_POSITION
+      (dataLocal & ~BORROW_CAP_MASK) >> BORROW_CAP_START_BIT_POSITION,
+      (dataLocal & ~SUPPLY_CAP_MASK) >> SUPPLY_CAP_START_BIT_POSITION
     );
   }
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/rewards/libraries/RewardsDataTypes.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/rewards/libraries/RewardsDataTypes.sol
 
 library RewardsDataTypes {
   struct RewardsConfigInput {
@@ -3144,7 +3065,7 @@ library RewardsDataTypes {
     address asset;
     address reward;
     ITransferStrategyBase transferStrategy;
-    AggregatorInterface rewardOracle;
+    IEACAggregatorProxy rewardOracle;
   }
 
   struct UserAssetBalance {
@@ -3185,7 +3106,7 @@ library RewardsDataTypes {
   }
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/protocol/libraries/configuration/UserConfiguration.sol
 
 /**
  * @title UserConfiguration library
@@ -3417,7 +3338,7 @@ library UserConfiguration {
   }
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/rewards/interfaces/IRewardsController.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/rewards/interfaces/IRewardsController.sol
 
 /**
  * @title IRewardsController
@@ -3483,9 +3404,9 @@ interface IRewardsController is IRewardsDistributor {
    * This check is enforced for integrators to be able to show incentives at
    * the current Aave UI without the need to setup an external price registry
    * @param reward The address of the reward to set the price aggregator
-   * @param rewardOracle The address of price aggregator that follows AggregatorInterface interface
+   * @param rewardOracle The address of price aggregator that follows IEACAggregatorProxy interface
    */
-  function setRewardOracle(address reward, AggregatorInterface rewardOracle) external;
+  function setRewardOracle(address reward, IEACAggregatorProxy rewardOracle) external;
 
   /**
    * @dev Get the price aggregator oracle address
@@ -3517,8 +3438,8 @@ interface IRewardsController is IRewardsDistributor {
    *   address asset: The asset address to incentivize
    *   address reward: The reward token address
    *   ITransferStrategy transferStrategy: The TransferStrategy address with the install hook and claim logic.
-   *   AggregatorInterface rewardOracle: The Price Oracle of a reward to visualize the incentives at the UI Frontend.
-   *                                     Must follow Chainlink Aggregator AggregatorInterface interface to be compatible.
+   *   IEACAggregatorProxy rewardOracle: The Price Oracle of a reward to visualize the incentives at the UI Frontend.
+   *                                     Must follow Chainlink Aggregator IEACAggregatorProxy interface to be compatible.
    */
   function configureAssets(RewardsDataTypes.RewardsConfigInput[] memory config) external;
 
@@ -3615,7 +3536,7 @@ interface IRewardsController is IRewardsDistributor {
   ) external returns (address[] memory rewardsList, uint256[] memory claimedAmounts);
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/protocol/tokenization/base/IncentivizedERC20.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/protocol/tokenization/base/IncentivizedERC20.sol
 
 /**
  * @title IncentivizedERC20
@@ -3838,7 +3759,7 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
   }
 }
 
-// downloads/SONEIUM/UI_INCENTIVE_DATA_PROVIDER/src/contracts/helpers/UiIncentiveDataProviderV3.sol
+// downloads/LINEA/UI_INCENTIVE_DATA_PROVIDER/UiIncentiveDataProviderV3/src/contracts/helpers/UiIncentiveDataProviderV3.sol
 
 contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
   using UserConfiguration for DataTypes.UserConfigurationMap;
@@ -3913,10 +3834,10 @@ contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
           rewardInformation.rewardOracleAddress = aTokenIncentiveController.getRewardOracle(
             rewardInformation.rewardTokenAddress
           );
-          rewardInformation.priceFeedDecimals = AggregatorInterface(
+          rewardInformation.priceFeedDecimals = IEACAggregatorProxy(
             rewardInformation.rewardOracleAddress
           ).decimals();
-          rewardInformation.rewardPriceFeed = AggregatorInterface(
+          rewardInformation.rewardPriceFeed = IEACAggregatorProxy(
             rewardInformation.rewardOracleAddress
           ).latestAnswer();
 
@@ -3967,10 +3888,10 @@ contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
           rewardInformation.rewardOracleAddress = vTokenIncentiveController.getRewardOracle(
             rewardInformation.rewardTokenAddress
           );
-          rewardInformation.priceFeedDecimals = AggregatorInterface(
+          rewardInformation.priceFeedDecimals = IEACAggregatorProxy(
             rewardInformation.rewardOracleAddress
           ).decimals();
-          rewardInformation.rewardPriceFeed = AggregatorInterface(
+          rewardInformation.rewardPriceFeed = IEACAggregatorProxy(
             rewardInformation.rewardOracleAddress
           ).latestAnswer();
 
@@ -4047,10 +3968,10 @@ contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
           userRewardInformation.rewardOracleAddress = aTokenIncentiveController.getRewardOracle(
             userRewardInformation.rewardTokenAddress
           );
-          userRewardInformation.priceFeedDecimals = AggregatorInterface(
+          userRewardInformation.priceFeedDecimals = IEACAggregatorProxy(
             userRewardInformation.rewardOracleAddress
           ).decimals();
-          userRewardInformation.rewardPriceFeed = AggregatorInterface(
+          userRewardInformation.rewardPriceFeed = IEACAggregatorProxy(
             userRewardInformation.rewardOracleAddress
           ).latestAnswer();
 
@@ -4100,10 +4021,10 @@ contract UiIncentiveDataProviderV3 is IUiIncentiveDataProviderV3 {
           userRewardInformation.rewardOracleAddress = vTokenIncentiveController.getRewardOracle(
             userRewardInformation.rewardTokenAddress
           );
-          userRewardInformation.priceFeedDecimals = AggregatorInterface(
+          userRewardInformation.priceFeedDecimals = IEACAggregatorProxy(
             userRewardInformation.rewardOracleAddress
           ).decimals();
-          userRewardInformation.rewardPriceFeed = AggregatorInterface(
+          userRewardInformation.rewardPriceFeed = IEACAggregatorProxy(
             userRewardInformation.rewardOracleAddress
           ).latestAnswer();
 
```
