```diff
diff --git a/./downloads/SONEIUM/RISK_STEWARD.sol b/./downloads/LINEA/RISK_STEWARD.sol
index 49fe6f4..cc38507 100644
--- a/./downloads/SONEIUM/RISK_STEWARD.sol
+++ b/./downloads/LINEA/RISK_STEWARD.sol

-// downloads/SONEIUM/RISK_STEWARD/src/interfaces/IRiskSteward.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/src/interfaces/IRiskSteward.sol

 /**
  * @title IRiskSteward
@@ -7281,11 +5310,6 @@ interface IRiskSteward {
    */
   error AssetIsRestricted();

-  /**
-   * @notice The steward does not allow updates of risk param of a restricted eMode
-   */
-  error EModeIsRestricted();
-
   /**
    * @notice The steward does not allow updates of cap param of a restricted oracle
    */
@@ -7308,13 +5332,6 @@ interface IRiskSteward {
    */
   event AddressRestricted(address indexed contractAddress, bool indexed isRestricted);

-  /**
-   * @notice Emitted when the owner configures an eMode categoryId as restricted to be used by steward
-   * @param eModeCategoryId the id of the eMode category
-   * @param isRestricted true if eModeCategoryId is set as restricted, false otherwise
-   */
-  event EModeRestricted(uint8 indexed eModeCategoryId, bool indexed isRestricted);
-
   /**
    * @notice Emitted when the risk configuration for the risk params has been set
    * @param riskConfig struct containing the risk configurations
@@ -7322,7 +5339,7 @@ interface IRiskSteward {
   event RiskConfigSet(Config indexed riskConfig);

   /**
-   * @notice Struct storing the last update by the steward of risk param
+   * @notice Struct storing the last update by the steward of each risk param
    */
   struct Debounce {
     uint40 supplyCapLastUpdated;
@@ -7338,15 +5355,6 @@ interface IRiskSteward {
     uint40 priceCapLastUpdated;
   }

-  /**
-   * @notice Struct storing the last update by the steward of eMode risk param
-   */
-  struct EModeDebounce {
-    uint40 eModeLtvLastUpdated;
-    uint40 eModeLiquidationBonusLastUpdated;
-    uint40 eModeLiquidationThresholdLastUpdated;
-  }
-
   /**
    * @notice Struct storing the params used for validation of the risk param update
    * @param currentValue the current value of the risk param
@@ -7375,57 +5383,18 @@ interface IRiskSteward {
    * @notice Struct storing the risk configuration for all the risk param
    */
   struct Config {
-    CollateralConfig collateralConfig;
-    EmodeConfig eModeConfig;
-    RateConfig rateConfig;
-    CapConfig capConfig;
-    PriceCapConfig priceCapConfig;
-  }
-
-  /**
-   * @notice Struct storing the risk configuration for collateral side param
-   */
-  struct CollateralConfig {
     RiskParamConfig ltv;
     RiskParamConfig liquidationThreshold;
     RiskParamConfig liquidationBonus;
+    RiskParamConfig supplyCap;
+    RiskParamConfig borrowCap;
     RiskParamConfig debtCeiling;
-  }
-
-  /**
-   * @notice Struct storing the risk configuration for emode category param
-   */
-  struct EmodeConfig {
-    RiskParamConfig ltv;
-    RiskParamConfig liquidationThreshold;
-    RiskParamConfig liquidationBonus;
-  }
-
-  /**
-   * @notice Struct storing the risk configuration for rate param
-   */
-  struct RateConfig {
     RiskParamConfig baseVariableBorrowRate;
     RiskParamConfig variableRateSlope1;
     RiskParamConfig variableRateSlope2;
     RiskParamConfig optimalUsageRatio;
-  }
-
-  /**
-   * @notice Struct storing the risk configuration for cap param
-   */
-  struct CapConfig {
-    RiskParamConfig supplyCap;
-    RiskParamConfig borrowCap;
-  }
-
-  /**
-   * @notice Struct storing the risk configuration for price cap param
-   */
-  struct PriceCapConfig {
     RiskParamConfig priceCapLst;
     RiskParamConfig priceCapStable;
-    RiskParamConfig discountRatePendle;
   }

   /**
@@ -7444,23 +5413,15 @@ interface IRiskSteward {
     uint256 priceCap;
   }

-  /**
-   * @notice Struct used to update the pendle cap params
-   */
-  struct DiscountRatePendleUpdate {
-    address oracle;
-    uint256 discountRate;
-  }
-
   /**
    * @notice The config engine used to perform the cap update via delegatecall
    */
   function CONFIG_ENGINE() external view returns (IAaveV3ConfigEngine);

   /**
-   * @notice The aave pool of the instance steward controls
+   * @notice The pool data provider of the POOL the steward controls
    */
-  function POOL() external view returns (IPool);
+  function POOL_DATA_PROVIDER() external view returns (IPoolDataProvider);

   /**
    * @notice The safe controlling the steward
@@ -7491,14 +5452,6 @@ interface IRiskSteward {
    */
   function updateCollateralSide(IAaveV3ConfigEngine.CollateralUpdate[] calldata collateralUpdates) external;

-  /**
-   * @notice Allows updating eMode category params across multiple eMode ids
-   * @dev A eMode category update is only possible after minDelay has passed after last update
-   * @dev A eMode category increase / decrease is only allowed by a magnitude of maxPercentChange
-   * @param eModeCategoryUpdates struct containing new eMode category params to be updated
-   */
-  function updateEModeCategories(IAaveV3ConfigEngine.EModeCategoryUpdate[] calldata eModeCategoryUpdates) external;
-
   /**
    * @notice Allows updating lst price cap params across multiple oracles
    * @dev A price cap update is only possible after minDelay has passed after last update
@@ -7515,14 +5468,6 @@ interface IRiskSteward {
    */
   function updateStablePriceCaps(PriceCapStableUpdate[] calldata priceCapUpdates) external;

-  /**
-   * @notice Allows updating pendle price cap params (i.e discount rate) across multiple oracles
-   * @dev A price cap (i.e discount rate) update is only possible after minDelay has passed after last update
-   * @dev A price cap (i.e discount rate) increase / decrease is only allowed by a magnitude of maxPercentChange
-   * @param discountRateUpdates struct containing new price cap params (i.e discount rate) to be updated
-   */
-  function updatePendleDiscountRates(DiscountRatePendleUpdate[] calldata discountRateUpdates) external;
-
   /**
    * @notice method to check if an asset/oracle is restricted to be used by the risk stewards
    * @param contractAddress address of the underlying asset or oracle
@@ -7530,13 +5475,6 @@ interface IRiskSteward {
    */
   function isAddressRestricted(address contractAddress) external view returns (bool);

-  /**
-   * @notice method to check if an eMode category id is restricted to be used by the risk stewards
-   * @param eModeCategoryId the id of the eMode category
-   * @return bool if eModeCategoryId is restricted or not
-   */
-  function isEModeCategoryRestricted(uint8 eModeCategoryId) external view returns (bool);
-
   /**
    * @notice method called by the owner to set an asset/oracle as restricted
    * @param contractAddress address of the underlying asset or oracle
@@ -7544,27 +5482,13 @@ interface IRiskSteward {
    */
   function setAddressRestricted(address contractAddress, bool isRestricted) external;

-  /**
-   * @notice method called by the owner to set an eMode category as restricted
-   * @param eModeCategoryId the id of the eMode category
-   * @param isRestricted true if eModeCategoryId needs to be restricted, false otherwise
-   */
-  function setEModeCategoryRestricted(uint8 eModeCategoryId, bool isRestricted) external;
-
   /**
    * @notice Returns the timelock for a specific asset i.e the last updated timestamp
    * @param asset for which to fetch the timelock
-   * @return struct containing the latest updated timestamps of all the risk params by the steward per asset
+   * @return struct containing the latest updated timestamps of all the risk params by the steward
    */
   function getTimelock(address asset) external view returns (Debounce memory);

-  /**
-   * @notice Returns the timelock for a specific eMode category id i.e the last updated timestamp
-   * @param eModeCategoryId the eMode category for which to fetch the timelock
-   * @return struct containing the latest updated timestamps of eMode risk params by the steward
-   */
-  function getEModeTimelock(uint8 eModeCategoryId) external view returns (EModeDebounce memory);
-
   /**
    * @notice method to get the risk configuration set for all the risk params
    * @return struct containing the risk configurations
@@ -7578,7 +5502,7 @@ interface IRiskSteward {
   function setRiskConfig(Config memory riskConfig) external;
 }

-// downloads/SONEIUM/RISK_STEWARD/src/contracts/RiskSteward.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/src/contracts/RiskSteward.sol

 /**
  * @title RiskSteward
@@ -7587,8 +5511,6 @@ interface IRiskSteward {
  *         This contract can update the following risk params: caps, ltv, liqThreshold, liqBonus, debtCeiling, interest rates params.
  */
 contract RiskSteward is Ownable, IRiskSteward {
-  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
-  using Strings for string;
   using Address for address;
   using SafeCast for uint256;
   using SafeCast for int256;
@@ -7597,7 +5519,7 @@ contract RiskSteward is Ownable, IRiskSteward {
   IAaveV3ConfigEngine public immutable CONFIG_ENGINE;

   /// @inheritdoc IRiskSteward
-  IPool public immutable POOL;
+  IPoolDataProvider public immutable POOL_DATA_PROVIDER;

   /// @inheritdoc IRiskSteward
   address public immutable RISK_COUNCIL;
@@ -7608,12 +5530,8 @@ contract RiskSteward is Ownable, IRiskSteward {

   mapping(address => Debounce) internal _timelocks;

-  mapping(uint8 => EModeDebounce) internal _eModeTimelocks;
-
   mapping(address => bool) internal _restrictedAddresses;

-  mapping(uint8 => bool) internal _restrictedEModes;
-
   /**
    * @dev Modifier preventing anyone, but the council to update risk params.
    */
@@ -7623,21 +5541,19 @@ contract RiskSteward is Ownable, IRiskSteward {
   }

   /**
-   * @param pool The aave pool to be controlled by the steward
+   * @param poolDataProvider The pool data provider of the pool to be controlled by the steward
    * @param engine the config engine to be used by the steward
    * @param riskCouncil the safe address of the council being able to interact with the steward
-   * @param owner the owner of the risk steward being able to set configs and mark items as restricted
    * @param riskConfig the risk configuration to setup for each individual risk param
    */
   constructor(
-    address pool,
-    address engine,
+    IPoolDataProvider poolDataProvider,
+    IAaveV3ConfigEngine engine,
     address riskCouncil,
-    address owner,
     Config memory riskConfig
-  ) Ownable(owner) {
-    POOL = IPool(pool);
-    CONFIG_ENGINE = IAaveV3ConfigEngine(engine);
+  ) {
+    POOL_DATA_PROVIDER = poolDataProvider;
+    CONFIG_ENGINE = engine;
     RISK_COUNCIL = riskCouncil;
     _riskConfig = riskConfig;
   }
@@ -7664,14 +5580,6 @@ contract RiskSteward is Ownable, IRiskSteward {
     _updateCollateralSide(collateralUpdates);
   }

-  /// @inheritdoc IRiskSteward
-  function updateEModeCategories(
-    IAaveV3ConfigEngine.EModeCategoryUpdate[] calldata eModeCategoryUpdates
-  ) external virtual onlyRiskCouncil {
-    _validateEModeCategoryUpdate(eModeCategoryUpdates);
-    _updateEModeCategories(eModeCategoryUpdates);
-  }
-
   /// @inheritdoc IRiskSteward
   function updateLstPriceCaps(
     PriceCapLstUpdate[] calldata priceCapUpdates
@@ -7688,24 +5596,11 @@ contract RiskSteward is Ownable, IRiskSteward {
     _updateStablePriceCaps(priceCapUpdates);
   }

-  /// @inheritdoc IRiskSteward
-  function updatePendleDiscountRates(
-    DiscountRatePendleUpdate[] calldata discountRateUpdates
-  ) external virtual onlyRiskCouncil {
-    _validatePendleDiscountRateUpdate(discountRateUpdates);
-    _updatePendleDiscountRates(discountRateUpdates);
-  }
-
   /// @inheritdoc IRiskSteward
   function getTimelock(address asset) external view returns (Debounce memory) {
     return _timelocks[asset];
   }

-  /// @inheritdoc IRiskSteward
-  function getEModeTimelock(uint8 eModeCategoryId) external view returns (EModeDebounce memory) {
-    return _eModeTimelocks[eModeCategoryId];
-  }
-
   /// @inheritdoc IRiskSteward
   function setRiskConfig(Config calldata riskConfig) external onlyOwner {
     _riskConfig = riskConfig;
@@ -7728,17 +5623,6 @@ contract RiskSteward is Ownable, IRiskSteward {
     emit AddressRestricted(contractAddress, isRestricted);
   }

-  /// @inheritdoc IRiskSteward
-  function isEModeCategoryRestricted(uint8 eModeCategoryId) external view returns (bool) {
-    return _restrictedEModes[eModeCategoryId];
-  }
-
-  /// @inheritdoc IRiskSteward
-  function setEModeCategoryRestricted(uint8 eModeCategoryId, bool isRestricted) external onlyOwner {
-    _restrictedEModes[eModeCategoryId] = isRestricted;
-    emit EModeRestricted(eModeCategoryId, isRestricted);
-  }
-
   /**
    * @notice method to validate the caps update
    * @param capsUpdate list containing the new supply, borrow caps of the assets
@@ -7753,14 +5637,16 @@ contract RiskSteward is Ownable, IRiskSteward {
       if (capsUpdate[i].supplyCap == 0 || capsUpdate[i].borrowCap == 0)
         revert InvalidUpdateToZero();

-      (uint256 currentBorrowCap, uint256 currentSupplyCap) = POOL.getConfiguration(asset).getCaps();
+      (uint256 currentBorrowCap, uint256 currentSupplyCap) = POOL_DATA_PROVIDER.getReserveCaps(
+        capsUpdate[i].asset
+      );

       _validateParamUpdate(
         ParamUpdateValidationInput({
           currentValue: currentSupplyCap,
           newValue: capsUpdate[i].supplyCap,
           lastUpdated: _timelocks[asset].supplyCapLastUpdated,
-          riskConfig: _riskConfig.capConfig.supplyCap,
+          riskConfig: _riskConfig.supplyCap,
           isChangeRelative: true
         })
       );
@@ -7769,7 +5655,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentBorrowCap,
           newValue: capsUpdate[i].borrowCap,
           lastUpdated: _timelocks[asset].borrowCapLastUpdated,
-          riskConfig: _riskConfig.capConfig.borrowCap,
+          riskConfig: _riskConfig.borrowCap,
           isChangeRelative: true
         })
       );
@@ -7799,7 +5685,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentOptimalUsageRatio,
           newValue: ratesUpdate[i].params.optimalUsageRatio,
           lastUpdated: _timelocks[asset].optimalUsageRatioLastUpdated,
-          riskConfig: _riskConfig.rateConfig.optimalUsageRatio,
+          riskConfig: _riskConfig.optimalUsageRatio,
           isChangeRelative: false
         })
       );
@@ -7808,7 +5694,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentBaseVariableBorrowRate,
           newValue: ratesUpdate[i].params.baseVariableBorrowRate,
           lastUpdated: _timelocks[asset].baseVariableRateLastUpdated,
-          riskConfig: _riskConfig.rateConfig.baseVariableBorrowRate,
+          riskConfig: _riskConfig.baseVariableBorrowRate,
           isChangeRelative: false
         })
       );
@@ -7817,7 +5703,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentVariableRateSlope1,
           newValue: ratesUpdate[i].params.variableRateSlope1,
           lastUpdated: _timelocks[asset].variableRateSlope1LastUpdated,
-          riskConfig: _riskConfig.rateConfig.variableRateSlope1,
+          riskConfig: _riskConfig.variableRateSlope1,
           isChangeRelative: false
         })
       );
@@ -7826,7 +5712,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentVariableRateSlope2,
           newValue: ratesUpdate[i].params.variableRateSlope2,
           lastUpdated: _timelocks[asset].variableRateSlope2LastUpdated,
-          riskConfig: _riskConfig.rateConfig.variableRateSlope2,
+          riskConfig: _riskConfig.variableRateSlope2,
           isChangeRelative: false
         })
       );
@@ -7839,7 +5725,7 @@ contract RiskSteward is Ownable, IRiskSteward {
    */
   function _validateCollateralsUpdate(
     IAaveV3ConfigEngine.CollateralUpdate[] calldata collateralUpdates
-  ) internal view virtual {
+  ) internal view {
     if (collateralUpdates.length == 0) revert NoZeroUpdates();

     for (uint256 i = 0; i < collateralUpdates.length; i++) {
@@ -7855,22 +5741,26 @@ contract RiskSteward is Ownable, IRiskSteward {
         collateralUpdates[i].debtCeiling == 0
       ) revert InvalidUpdateToZero();

-      DataTypes.ReserveConfigurationMap memory configuration = POOL.getConfiguration(asset);
       (
+        ,
         uint256 currentLtv,
         uint256 currentLiquidationThreshold,
         uint256 currentLiquidationBonus,
         ,
+        ,
+        ,
+        ,
+        ,

-      ) = configuration.getParams();
-      uint256 currentDebtCeiling = configuration.getDebtCeiling();
+      ) = POOL_DATA_PROVIDER.getReserveConfigurationData(asset);
+      uint256 currentDebtCeiling = POOL_DATA_PROVIDER.getDebtCeiling(asset);

       _validateParamUpdate(
         ParamUpdateValidationInput({
           currentValue: currentLtv,
           newValue: collateralUpdates[i].ltv,
           lastUpdated: _timelocks[asset].ltvLastUpdated,
-          riskConfig: _riskConfig.collateralConfig.ltv,
+          riskConfig: _riskConfig.ltv,
           isChangeRelative: false
         })
       );
@@ -7879,7 +5769,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentLiquidationThreshold,
           newValue: collateralUpdates[i].liqThreshold,
           lastUpdated: _timelocks[asset].liquidationThresholdLastUpdated,
-          riskConfig: _riskConfig.collateralConfig.liquidationThreshold,
+          riskConfig: _riskConfig.liquidationThreshold,
           isChangeRelative: false
         })
       );
@@ -7888,7 +5778,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentLiquidationBonus - 100_00, // as the definition is 100% + x%, and config engine takes into account x% for simplicity.
           newValue: collateralUpdates[i].liqBonus,
           lastUpdated: _timelocks[asset].liquidationBonusLastUpdated,
-          riskConfig: _riskConfig.collateralConfig.liquidationBonus,
+          riskConfig: _riskConfig.liquidationBonus,
           isChangeRelative: false
         })
       );
@@ -7897,66 +5787,13 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentDebtCeiling / 100, // as the definition is with 2 decimals, and config engine does not take the decimals into account.
           newValue: collateralUpdates[i].debtCeiling,
           lastUpdated: _timelocks[asset].debtCeilingLastUpdated,
-          riskConfig: _riskConfig.collateralConfig.debtCeiling,
+          riskConfig: _riskConfig.debtCeiling,
           isChangeRelative: true
         })
       );
     }
   }

-  /**
-   * @notice method to validate the eMode category update
-   * @param eModeCategoryUpdates list containing the new eMode category updates
-   */
-  function _validateEModeCategoryUpdate(
-    IAaveV3ConfigEngine.EModeCategoryUpdate[] calldata eModeCategoryUpdates
-  ) internal view {
-    if (eModeCategoryUpdates.length == 0) revert NoZeroUpdates();
-
-    for (uint256 i = 0; i < eModeCategoryUpdates.length; i++) {
-      uint8 eModeId = eModeCategoryUpdates[i].eModeCategory;
-      if (_restrictedEModes[eModeId]) revert EModeIsRestricted();
-      if (!eModeCategoryUpdates[i].label.equal(EngineFlags.KEEP_CURRENT_STRING))
-        revert ParamChangeNotAllowed();
-
-      if (
-        eModeCategoryUpdates[i].ltv == 0 ||
-        eModeCategoryUpdates[i].liqThreshold == 0 ||
-        eModeCategoryUpdates[i].liqBonus == 0
-      ) revert InvalidUpdateToZero();
-
-      DataTypes.CollateralConfig memory currentEmodeConfig = POOL.getEModeCategoryCollateralConfig(eModeId);
-
-      _validateParamUpdate(
-        ParamUpdateValidationInput({
-          currentValue: currentEmodeConfig.ltv,
-          newValue: eModeCategoryUpdates[i].ltv,
-          lastUpdated: _eModeTimelocks[eModeId].eModeLtvLastUpdated,
-          riskConfig: _riskConfig.eModeConfig.ltv,
-          isChangeRelative: false
-        })
-      );
-      _validateParamUpdate(
-        ParamUpdateValidationInput({
-          currentValue: currentEmodeConfig.liquidationThreshold,
-          newValue: eModeCategoryUpdates[i].liqThreshold,
-          lastUpdated: _eModeTimelocks[eModeId].eModeLiquidationThresholdLastUpdated,
-          riskConfig: _riskConfig.eModeConfig.liquidationThreshold,
-          isChangeRelative: false
-        })
-      );
-      _validateParamUpdate(
-        ParamUpdateValidationInput({
-          currentValue: currentEmodeConfig.liquidationBonus - 100_00, // as the definition is 100% + x%, and config engine takes into account x% for simplicity.
-          newValue: eModeCategoryUpdates[i].liqBonus,
-          lastUpdated: _eModeTimelocks[eModeId].eModeLiquidationBonusLastUpdated,
-          riskConfig: _riskConfig.eModeConfig.liquidationBonus,
-          isChangeRelative: false
-        })
-      );
-    }
-  }
-
   /**
    * @notice method to validate the oracle price caps update
    * @param priceCapsUpdate list containing the new price cap params for the oracles
@@ -7988,7 +5825,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentMaxYearlyGrowthPercent,
           newValue: priceCapsUpdate[i].priceCapUpdateParams.maxYearlyRatioGrowthPercent,
           lastUpdated: _timelocks[oracle].priceCapLastUpdated,
-          riskConfig: _riskConfig.priceCapConfig.priceCapLst,
+          riskConfig: _riskConfig.priceCapLst,
           isChangeRelative: true
         })
       );
@@ -8018,43 +5855,13 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentPriceCap.toUint256(),
           newValue: priceCapsUpdate[i].priceCap,
           lastUpdated: _timelocks[oracle].priceCapLastUpdated,
-          riskConfig: _riskConfig.priceCapConfig.priceCapStable,
+          riskConfig: _riskConfig.priceCapStable,
           isChangeRelative: true
         })
       );
     }
   }

-  /**
-   * @notice method to validate the pendle oracle discount rate update
-   * @param discountRateUpdate list containing the new discount rate values for the pendle oracles
-   */
-  function _validatePendleDiscountRateUpdate(
-    DiscountRatePendleUpdate[] calldata discountRateUpdate
-  ) internal view {
-    if (discountRateUpdate.length == 0) revert NoZeroUpdates();
-
-    for (uint256 i = 0; i < discountRateUpdate.length; i++) {
-      address oracle = discountRateUpdate[i].oracle;
-
-      if (_restrictedAddresses[oracle]) revert OracleIsRestricted();
-      if (discountRateUpdate[i].discountRate == 0) revert InvalidUpdateToZero();
-
-      // get current rate
-      uint256 currentDiscount = IPendlePriceCapAdapter(oracle).discountRatePerYear();
-
-      _validateParamUpdate(
-        ParamUpdateValidationInput({
-          currentValue: currentDiscount,
-          newValue: discountRateUpdate[i].discountRate,
-          lastUpdated: _timelocks[oracle].priceCapLastUpdated,
-          riskConfig: _riskConfig.priceCapConfig.discountRatePendle,
-          isChangeRelative: false
-        })
-      );
-    }
-  }
-
   /**
    * @notice method to validate the risk param update is within the allowed bound and the debounce is respected
    * @param validationParam struct containing values used for validation of the risk param update
@@ -8156,32 +5963,6 @@ contract RiskSteward is Ownable, IRiskSteward {
     );
   }

-  /**
-   * @notice method to update the eMode category params using the config engine and updates the debounce
-   * @param eModeCategoryUpdates list containing the new eMode category params of the eMode category id
-   */
-  function _updateEModeCategories(IAaveV3ConfigEngine.EModeCategoryUpdate[] calldata eModeCategoryUpdates) internal {
-    for (uint256 i = 0; i < eModeCategoryUpdates.length; i++) {
-      uint8 eModeId = eModeCategoryUpdates[i].eModeCategory;
-
-      if (eModeCategoryUpdates[i].ltv != EngineFlags.KEEP_CURRENT) {
-        _eModeTimelocks[eModeId].eModeLtvLastUpdated = uint40(block.timestamp);
-      }
-
-      if (eModeCategoryUpdates[i].liqThreshold != EngineFlags.KEEP_CURRENT) {
-        _eModeTimelocks[eModeId].eModeLiquidationThresholdLastUpdated = uint40(block.timestamp);
-      }
-
-      if (eModeCategoryUpdates[i].liqBonus != EngineFlags.KEEP_CURRENT) {
-        _eModeTimelocks[eModeId].eModeLiquidationBonusLastUpdated = uint40(block.timestamp);
-      }
-    }
-
-    address(CONFIG_ENGINE).functionDelegateCall(
-      abi.encodeWithSelector(CONFIG_ENGINE.updateEModeCategories.selector, eModeCategoryUpdates)
-    );
-  }
-
   /**
    * @notice method to update the oracle price caps update
    * @param priceCapsUpdate list containing the new price cap params for the oracles
@@ -8212,20 +5993,6 @@ contract RiskSteward is Ownable, IRiskSteward {
     }
   }

-  /**
-   * @notice method to update the pendle oracle discount rate
-   * @param discountRateUpdate list containing the new discount rate values for the pendle oracles
-   */
-  function _updatePendleDiscountRates(DiscountRatePendleUpdate[] calldata discountRateUpdate) internal {
-    for (uint256 i = 0; i < discountRateUpdate.length; i++) {
-      address oracle = discountRateUpdate[i].oracle;
-
-      _timelocks[oracle].priceCapLastUpdated = uint40(block.timestamp);
-
-      IPendlePriceCapAdapter(oracle).setDiscountRatePerYear(discountRateUpdate[i].discountRate.toUint64());
-    }
-  }
-
   /**
    * @notice method to fetch the current interest rate params of the asset
    * @param asset the address of the underlying asset
@@ -8246,7 +6013,7 @@ contract RiskSteward is Ownable, IRiskSteward {
       uint256 variableRateSlope2
     )
   {
-    address rateStrategyAddress = POOL.getReserveData(asset).interestRateStrategyAddress;
+    address rateStrategyAddress = POOL_DATA_PROVIDER.getInterestRateStrategyAddress(asset);
     IDefaultInterestRateStrategyV2.InterestRateData
       memory interestRateData = IDefaultInterestRateStrategyV2(rateStrategyAddress)
         .getInterestRateDataBps(asset);
```
