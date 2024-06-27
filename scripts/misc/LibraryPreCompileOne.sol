// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import 'forge-std/console.sol';
import '../../src/deployments/interfaces/IMarketReportTypes.sol';
import {AaveV3LibrariesBatch1} from '../../src/deployments/projects/aave-v3-libraries/AaveV3LibrariesBatch1.sol';
import {FfiUtils} from '../../src/deployments/contracts/utilities/FfiUtils.sol';
import {IMetadataReporter} from '../../src/deployments/interfaces/IMetadataReporter.sol';
import {DeployUtils} from '../../src/deployments/contracts/utilities/DeployUtils.sol';

/**
 * @dev Deploy libraries in batch using CREATE2, this optional
 *      script allows to deploy the first 4 libraries of Aave V3 protocol.
 */
contract LibraryPreCompileOne is Script {
  function run() external {
    _deploy();
  }

  function _deploy() internal {
    vm.startBroadcast();
    new AaveV3LibrariesBatch1();
    vm.stopBroadcast();
  }
}
