// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {Create2UtilsZkSync} from 'solidity-utils/../zksync/src/contracts/utils/ScriptUtilsZkSync.sol';
import {ConfigEngineReport} from '../../interfaces/IMarketReportTypes.sol';
import {AaveV3ConfigEngine, IAaveV3ConfigEngine, CapsEngine, BorrowEngine, CollateralEngine, RateEngine, PriceFeedEngine, EModeEngine, ListingEngine} from 'aave-v3-periphery/contracts/v3-config-engine/AaveV3ConfigEngine.sol';
import {IPool} from 'aave-v3-core/contracts/interfaces/IPool.sol';
import {IPoolConfigurator} from 'aave-v3-core/contracts/interfaces/IPoolConfigurator.sol';
import {IAaveOracle} from 'aave-v3-core/contracts/interfaces/IAaveOracle.sol';

contract AaveV3HelpersProcedureOne {
  function _deployConfigEngine(
    address pool,
    address poolConfigurator,
    address defaultInterestRateStrategy,
    address aaveOracle,
    address rewardsController,
    address collector,
    address aTokenImpl,
    address vTokenImpl,
    address sTokenImpl
  ) internal returns (ConfigEngineReport memory configEngineReport) {
    IAaveV3ConfigEngine.EngineLibraries memory engineLibraries = IAaveV3ConfigEngine
      .EngineLibraries({
        listingEngine: Create2UtilsZkSync.create2Deploy('v1', type(ListingEngine).creationCode),
        eModeEngine: Create2UtilsZkSync.create2Deploy('v1', type(EModeEngine).creationCode),
        borrowEngine: Create2UtilsZkSync.create2Deploy('v1', type(BorrowEngine).creationCode),
        collateralEngine: Create2UtilsZkSync.create2Deploy('v1', type(CollateralEngine).creationCode),
        priceFeedEngine: Create2UtilsZkSync.create2Deploy('v1', type(PriceFeedEngine).creationCode),
        rateEngine: Create2UtilsZkSync.create2Deploy('v1', type(RateEngine).creationCode),
        capsEngine: Create2UtilsZkSync.create2Deploy('v1', type(CapsEngine).creationCode)
      });

    IAaveV3ConfigEngine.EngineConstants memory engineConstants = IAaveV3ConfigEngine
      .EngineConstants({
        pool: IPool(pool),
        poolConfigurator: IPoolConfigurator(poolConfigurator),
        defaultInterestRateStrategy: defaultInterestRateStrategy,
        oracle: IAaveOracle(aaveOracle),
        rewardsController: rewardsController,
        collector: collector
      });

    configEngineReport.listingEngine = engineLibraries.listingEngine;
    configEngineReport.eModeEngine = engineLibraries.eModeEngine;
    configEngineReport.borrowEngine = engineLibraries.borrowEngine;
    configEngineReport.collateralEngine = engineLibraries.collateralEngine;
    configEngineReport.priceFeedEngine = engineLibraries.priceFeedEngine;
    configEngineReport.rateEngine = engineLibraries.rateEngine;
    configEngineReport.capsEngine = engineLibraries.capsEngine;

    configEngineReport.configEngine = address(
      new AaveV3ConfigEngine(aTokenImpl, vTokenImpl, sTokenImpl, engineConstants, engineLibraries)
    );
    return configEngineReport;
  }
}
