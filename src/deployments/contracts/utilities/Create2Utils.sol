// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

library Create2Utils {
  function _create2Deploy(bytes32 salt, bytes memory bytecode) internal returns (address) {
    address deployedAt;
    assembly {
      deployedAt := create2(0, add(bytecode, 32), mload(bytecode), salt)
    }
    require(deployedAt != address(0), "Create2: Failed on deploy");
    return deployedAt;
  }
}
