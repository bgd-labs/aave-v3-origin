
// aave imports
import "aux/aToken.spec";
//import "AddressProvider.spec";

methods {
  function getReserveDataExtended(address) external returns (DataTypes.ReserveData memory) envfree;
  function getReserveData(address) external returns (DataTypes.ReserveDataLegacy memory) envfree;

  function ValidationLogic.validateLiquidationCall(
                                                   DataTypes.UserConfigurationMap storage userConfig,
                                                   DataTypes.ReserveData storage collateralReserve,
                                                   DataTypes.ReserveData storage debtReserve,
                                                   DataTypes.ValidateLiquidationCallParams memory params
  ) internal => NONDET;

  function GenericLogic.calculateUserAccountData(
                                                 mapping(address => DataTypes.ReserveData) storage reservesData,
                                                 mapping(uint256 => address) storage reservesList,
                                                 mapping(uint8 => DataTypes.EModeCategory) storage eModeCategories,
                                                 DataTypes.CalculateUserAccountDataParams memory params
  ) internal returns (uint256, uint256, uint256, uint256, uint256, bool) => NONDET;

  function LiquidationLogic._calculateDebt(
                                           DataTypes.ReserveCache memory debtReserveCache,
                                           DataTypes.ExecuteLiquidationCallParams memory params,
                                           uint256 healthFactor
  ) internal returns (uint256, uint256) => NONDET;

  function LiquidationLogic._calculateAvailableCollateralToLiquidate(
                                                                     DataTypes.ReserveData storage collateralReserve,
                                                                     DataTypes.ReserveCache memory debtReserveCache,
                                                                     address collateralAsset,
                                                                     address debtAsset,
                                                                     uint256 debtToCover,
                                                                     uint256 userCollateralBalance,
                                                                     uint256 liquidationBonus,
                                                                     address // IPriceOracleGetter 
  ) internal returns (uint256,uint256,uint256) => NONDET;
}




function init_state() {
  // based on aTokensAreNotUnderlyings
  require forall address a. 
    a == 0 // nothing-token
    || aTokenToUnderlying[a] == 0 // underlying
    || aTokenToUnderlying[aTokenToUnderlying[a]] == 0 // aTokens map to underlyings which map to 0
    ;

  require forall address a. tokenToSort[currentContract._reserves[a].aTokenAddress] == AToken_token();
  require forall address a. tokenToSort[currentContract._reserves[a].variableDebtTokenAddress] == VariableDebtToken_token();
}


hook Sstore _reserves[KEY address a].__deprecatedStableBorrowRate uint128 rate (uint128 old_rate) {
  assert false, "writing the field __deprecatedStableBorrowRate";
}

hook Sstore _reserves[KEY address a].__deprecatedStableDebtTokenAddress address stable (address old_stable) {
  assert false, "writing the field __deprecatedStableDebtTokenAddress";
}


/*=====================================================================================
  Rule: stableFieldsUntouched:
  We check that the values in the depricated fields:
  __deprecatedStableBorrowRate, __deprecatedStableDebtTokenAddress (of the struct DataTypes.ReserveData)
  are not changed. Moreover we also check that these fields are not accessed for writing -
  see the above hooks.

  Status: PASS
  Link: 
  =====================================================================================*/
rule stableFieldsUntouched(method f, env e, address _asset)
  filtered {f -> f.selector != sig:dropReserve(address).selector}
{
  init_state();
  require forall address asset. 
    aTokenToUnderlying[currentContract._reserves[asset].aTokenAddress]==asset
    &&
    aTokenToUnderlying[currentContract._reserves[asset].variableDebtTokenAddress]==asset;
  
  DataTypes.ReserveData reserve = getReserveDataExtended(_asset);
  DataTypes.ReserveDataLegacy reserveLegasy = getReserveData(_asset);

  uint128 __deprecatedStableBorrowRate_BEFORE = reserve.__deprecatedStableBorrowRate;
  address __deprecatedStableDebtTokenAddress_BEFORE = reserve.__deprecatedStableDebtTokenAddress;
  uint128 currentStableBorrowRate_BEFORE = reserveLegasy.currentStableBorrowRate;
  address stableDebtTokenAddress_BEFORE = reserveLegasy.stableDebtTokenAddress;
  
  calldataarg args;
  f(e,args);
  
  DataTypes.ReserveData reserve2 = getReserveDataExtended(_asset);
  DataTypes.ReserveDataLegacy reserveLegasy2 = getReserveData(_asset);

  uint128 __deprecatedStableBorrowRate_AFTER = reserve2.__deprecatedStableBorrowRate;
  address __deprecatedStableDebtTokenAddress_AFTER = reserve2.__deprecatedStableDebtTokenAddress;
  uint128 currentStableBorrowRate_AFTER = reserveLegasy2.currentStableBorrowRate;
  address stableDebtTokenAddress_AFTER = reserveLegasy2.stableDebtTokenAddress;

  assert __deprecatedStableBorrowRate_BEFORE == __deprecatedStableBorrowRate_AFTER;
  assert __deprecatedStableDebtTokenAddress_BEFORE == __deprecatedStableDebtTokenAddress_AFTER;
  assert currentStableBorrowRate_BEFORE == currentStableBorrowRate_AFTER;
  assert stableDebtTokenAddress_BEFORE == stableDebtTokenAddress_AFTER;
         
}