// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {AaveV3LibrariesBatch2} from '../../src/deployments/projects/aave-v3-libraries/AaveV3LibrariesBatch2.sol';
import {IMetadataReporter} from '../../src/deployments/interfaces/IMetadataReporter.sol';

/**
 * @dev Deploy libraries in batch using CREATE2, this optional
 *      script allows to deploy the next 4 libraries of Aave V3 protocol
 */
contract LibraryPreCompileTwo is Script {
  function run() external {
    _deploy();
  }

  function _deploy() internal {
    vm.startBroadcast();
    new AaveV3LibrariesBatch2();
    vm.stopBroadcast();
  }
}
