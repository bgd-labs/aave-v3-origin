// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';

import '../../src/deployments/interfaces/IMarketReportTypes.sol';
import {IMetadataReporter} from '../../src/deployments/interfaces/IMetadataReporter.sol';
import {DeployUtils} from '../../src/deployments/contracts/utilities/DeployUtils.sol';
import {AaveV3BatchOrchestration} from '../../src/deployments/projects/aave-v3-batched/AaveV3BatchOrchestration.sol';
import {MarketInput} from '../../src/deployments/inputs/MarketInput.sol';

abstract contract DeployAaveV3MarketBatchedBase is MarketInput, Script {

  function run() external {
    Roles memory roles;
    MarketConfig memory config;
    DeployFlags memory flags;
    MarketReport memory report;

    (roles, config, flags, report) = _getMarketInput(msg.sender);

    vm.startBroadcast();
    report = AaveV3BatchOrchestration.deployAaveV3(msg.sender, roles, config, flags, report);
    vm.stopBroadcast();
  }
}
