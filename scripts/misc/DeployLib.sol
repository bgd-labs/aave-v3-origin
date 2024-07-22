// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {Script} from 'forge-std/Script.sol';
import {Create2Utils} from 'src/deployments/contracts/utilities/Create2Utils.sol';
import {BorrowLogic} from 'src/core/contracts/protocol/libraries/logic/BorrowLogic.sol';

contract DeployLib is Script {
  function run() external {
    _deploy();
  }

  function _deploy() internal {
    vm.startBroadcast();
    // Create2 Factory using: https://github.com/safe-global/safe-singleton-factory/blob/main/contracts-zk/SafeSingeltonFactory.sol

    Create2Utils.create2Deploy(
      bytes32(0), // salt
      (type(BorrowLogic).creationCode)
    );
    vm.stopBroadcast();
  }
}
