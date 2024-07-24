// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {Script} from 'forge-std/Script.sol';
import {BorrowLogic} from 'src/core/contracts/protocol/libraries/logic/BorrowLogic.sol';
import {Create2Factory} from 'src/deployments/contracts/utilities/Create2Factory.sol';

contract ZkDeployLib is Script {
  function run() public {
    vm.startBroadcast();
    new DeployLib().run();
    vm.stopBroadcast();
  }
}

contract DeployLib is Script {
  address public constant CREATE_2_FACTORY = 0xB1DDc8cfcB1A46095C6d5F81ad76F69188B381b8;
  bytes public BYTECODE;

  function run() external {
    _deploy();
  }

  function _deploy() internal {
    // Create2 Factory using: https://github.com/matter-labs/zksync/blob/master/contracts/contracts/Create2Factory.sol
    Create2Factory(CREATE_2_FACTORY).deploy(
      bytes32(0), // salt
      (type(BorrowLogic).creationCode)
    );
  }
}
