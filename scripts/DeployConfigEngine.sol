// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import '../src/deployments/interfaces/IMarketReportTypes.sol';
import {AaveV3ConfigEngine, IAaveV3ConfigEngine, ListingEngine, ListingEngine, EModeEngine, BorrowEngine ,CollateralEngine, PriceFeedEngine, RateEngine, CapsEngine} from '../src/periphery/contracts/v3-config-engine/AaveV3ConfigEngine.sol';
import {Create2Utils} from '../src/deployments/contracts/utilities/Create2Utils.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';
import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';

library DeployConfigEngineLib {
  struct ConfigEngineReport {
    address configEngine;
    address listingEngine;
    address eModeEngine;
    address borrowEngine;
    address collateralEngine;
    address priceFeedEngine;
    address rateEngine;
    address capsEngine;
  }

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
        listingEngine: Create2Utils._create2Deploy('v1', type(ListingEngine).creationCode),
        eModeEngine: Create2Utils._create2Deploy('v1', type(EModeEngine).creationCode),
        borrowEngine: Create2Utils._create2Deploy('v1', type(BorrowEngine).creationCode),
        collateralEngine: Create2Utils._create2Deploy('v1', type(CollateralEngine).creationCode),
        priceFeedEngine: Create2Utils._create2Deploy('v1', type(PriceFeedEngine).creationCode),
        rateEngine: Create2Utils._create2Deploy('v1', type(RateEngine).creationCode),
        capsEngine: Create2Utils._create2Deploy('v1', type(CapsEngine).creationCode)
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
      new AaveV3ConfigEngine(
        aTokenImpl,
        vTokenImpl,
        sTokenImpl,
        engineConstants,
        engineLibraries
      )
    );
    return configEngineReport;
  }
}

// deploy-command: make deploy-ledger contract=scripts/DeployConfigEngine.sol:DeployEngineEth chain=mainnet
contract DeployEngineEth is Script {
  function run() external {
    vm.startBroadcast();
    DeployConfigEngineLib._deployConfigEngine(
      address(AaveV3Ethereum.POOL),
      address(AaveV3Ethereum.POOL_CONFIGURATOR),
      address(0), // TODO: please add the newly deployed interest rate strategy here
      address(AaveV3Ethereum.ORACLE),
      address(AaveV3Ethereum.DEFAULT_INCENTIVES_CONTROLLER),
      address(AaveV3Ethereum.COLLECTOR),
      AaveV3Ethereum.DEFAULT_A_TOKEN_IMPL_REV_1,
      AaveV3Ethereum.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1,
      AaveV3Ethereum.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_1
    );
    vm.stopBroadcast();
  }
}

// deploy-command: make deploy-ledger contract=scripts/DeployConfigEngine.sol:DeployEnginePol chain=polygon
contract DeployEnginePol is Script {
  function run() external {
    vm.startBroadcast();
    DeployConfigEngineLib._deployConfigEngine(
      address(AaveV3Polygon.POOL),
      address(AaveV3Polygon.POOL_CONFIGURATOR),
      address(0), // TODO: please add the newly deployed interest rate strategy here
      address(AaveV3Polygon.ORACLE),
      address(AaveV3Polygon.DEFAULT_INCENTIVES_CONTROLLER),
      address(AaveV3Polygon.COLLECTOR),
      AaveV3Polygon.DEFAULT_A_TOKEN_IMPL_REV_2,
      AaveV3Polygon.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2,
      AaveV3Polygon.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_3
    );
    vm.stopBroadcast();
  }
}

// deploy-command: make deploy-ledger contract=scripts/DeployConfigEngine.sol:DeployEngineAva chain=avalanche
contract DeployEngineAva is Script {
  function run() external {
    vm.startBroadcast();
    DeployConfigEngineLib._deployConfigEngine(
      address(AaveV3Avalanche.POOL),
      address(AaveV3Avalanche.POOL_CONFIGURATOR),
      address(0), // TODO: please add the newly deployed interest rate strategy here
      address(AaveV3Avalanche.ORACLE),
      address(AaveV3Avalanche.DEFAULT_INCENTIVES_CONTROLLER),
      address(AaveV3Avalanche.COLLECTOR),
      AaveV3Avalanche.DEFAULT_A_TOKEN_IMPL_REV_2,
      AaveV3Avalanche.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2,
      AaveV3Avalanche.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_3
    );
    vm.stopBroadcast();
  }
}

// deploy-command: make deploy-ledger contract=scripts/DeployConfigEngine.sol:DeployEngineArb chain=arbitrum
contract DeployEngineArb is Script {
  function run() external {
    vm.startBroadcast();
    DeployConfigEngineLib._deployConfigEngine(
      address(AaveV3Arbitrum.POOL),
      address(AaveV3Arbitrum.POOL_CONFIGURATOR),
      address(0), // TODO: please add the newly deployed interest rate strategy here
      address(AaveV3Arbitrum.ORACLE),
      address(AaveV3Arbitrum.DEFAULT_INCENTIVES_CONTROLLER),
      address(AaveV3Arbitrum.COLLECTOR),
      AaveV3Arbitrum.DEFAULT_A_TOKEN_IMPL_REV_2,
      AaveV3Arbitrum.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2,
      AaveV3Arbitrum.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_3
    );
    vm.stopBroadcast();
  }
}

// deploy-command: make deploy-ledger contract=scripts/DeployConfigEngine.sol:DeployEngineOpt chain=optimism
contract DeployEngineOpt is Script {
  function run() external {
    vm.startBroadcast();
    DeployConfigEngineLib._deployConfigEngine(
      address(AaveV3Optimism.POOL),
      address(AaveV3Optimism.POOL_CONFIGURATOR),
      address(0), // TODO: please add the newly deployed interest rate strategy here
      address(AaveV3Optimism.ORACLE),
      address(AaveV3Optimism.DEFAULT_INCENTIVES_CONTROLLER),
      address(AaveV3Optimism.COLLECTOR),
      AaveV3Optimism.DEFAULT_A_TOKEN_IMPL_REV_2,
      AaveV3Optimism.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2,
      AaveV3Optimism.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_3
    );
    vm.stopBroadcast();
  }
}


// deploy-command: make deploy-ledger contract=scripts/DeployConfigEngine.sol:DeployEngineBase chain=base
contract DeployEngineBase is Script {
  function run() external {
    vm.startBroadcast();
    DeployConfigEngineLib._deployConfigEngine(
      address(AaveV3Base.POOL),
      address(AaveV3Base.POOL_CONFIGURATOR),
      address(0), // TODO: please add the newly deployed interest rate strategy here
      address(AaveV3Base.ORACLE),
      address(AaveV3Base.DEFAULT_INCENTIVES_CONTROLLER),
      address(AaveV3Base.COLLECTOR),
      AaveV3Base.DEFAULT_A_TOKEN_IMPL_REV_1,
      AaveV3Base.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1,
      AaveV3Base.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_1
    );
    vm.stopBroadcast();
  }
}

// deploy-command: make deploy-ledger contract=scripts/DeployConfigEngine.sol:DeployEngineGno chain=gnosis
contract DeployEngineGno is Script {
  function run() external {
    vm.startBroadcast();
    DeployConfigEngineLib._deployConfigEngine(
      address(AaveV3Gnosis.POOL),
      address(AaveV3Gnosis.POOL_CONFIGURATOR),
      address(0), // TODO: please add the newly deployed interest rate strategy here
      address(AaveV3Gnosis.ORACLE),
      address(AaveV3Gnosis.DEFAULT_INCENTIVES_CONTROLLER),
      address(AaveV3Gnosis.COLLECTOR),
      AaveV3Gnosis.DEFAULT_A_TOKEN_IMPL_REV_1,
      AaveV3Gnosis.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1,
      AaveV3Gnosis.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_1
    );
    vm.stopBroadcast();
  }
}

// deploy-command: make deploy-ledger contract=scripts/DeployConfigEngine.sol:DeployEngineMetis chain=metis
contract DeployEngineMetis is Script {
  function run() external {
    vm.startBroadcast();
    DeployConfigEngineLib._deployConfigEngine(
      address(AaveV3Metis.POOL),
      address(AaveV3Metis.POOL_CONFIGURATOR),
      address(0), // TODO: please add the newly deployed interest rate strategy here
      address(AaveV3Metis.ORACLE),
      address(AaveV3Metis.DEFAULT_INCENTIVES_CONTROLLER),
      address(AaveV3Metis.COLLECTOR),
      AaveV3Metis.DEFAULT_A_TOKEN_IMPL_REV_1,
      AaveV3Metis.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1,
      AaveV3Metis.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_1
    );
    vm.stopBroadcast();
  }
}

// deploy-command: make deploy-ledger contract=scripts/DeployConfigEngine.sol:DeployEngineBNB chain=bnb
contract DeployEngineBNB is Script {
  function run() external {
    vm.startBroadcast();
    DeployConfigEngineLib._deployConfigEngine(
      address(AaveV3BNB.POOL),
      address(AaveV3BNB.POOL_CONFIGURATOR),
      address(0), // TODO: please add the newly deployed interest rate strategy here
      address(AaveV3BNB.ORACLE),
      address(AaveV3BNB.DEFAULT_INCENTIVES_CONTROLLER),
      address(AaveV3BNB.COLLECTOR),
      AaveV3BNB.DEFAULT_A_TOKEN_IMPL_REV_1,
      AaveV3BNB.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1,
      AaveV3BNB.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_1
    );
    vm.stopBroadcast();
  }
}

// deploy-command: make deploy-ledger contract=scripts/DeployConfigEngine.sol:DeployEngineScroll chain=scroll
contract DeployEngineScroll is Script {
  function run() external {
    vm.startBroadcast();
    DeployConfigEngineLib._deployConfigEngine(
      address(AaveV3Scroll.POOL),
      address(AaveV3Scroll.POOL_CONFIGURATOR),
      address(0), // TODO: please add the newly deployed interest rate strategy here
      address(AaveV3Scroll.ORACLE),
      address(AaveV3Scroll.DEFAULT_INCENTIVES_CONTROLLER),
      address(AaveV3Scroll.COLLECTOR),
      AaveV3Scroll.DEFAULT_A_TOKEN_IMPL_REV_1,
      AaveV3Scroll.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1,
      AaveV3Scroll.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_1
    );
    vm.stopBroadcast();
  }
}
