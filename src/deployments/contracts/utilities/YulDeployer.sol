// SPDX-License-Identifier: MIT
// Modified from https://github.com/CodeForcer/foundry-yul/blob/8addb24c31bcadcc0c3f8cf7616119575c491f48/test/lib/YulDeployer.sol by @CodeForcer
pragma solidity ^0.8.0;

import {Vm} from 'forge-std/Vm.sol';

/**
 * @notice Helper library to compile and deploy Yul contracts in foundry
 */
library YulDeployer {
  Vm private constant vm = Vm(address(bytes20(uint160(uint256(keccak256('hevm cheat code'))))));

  /**
   * @notice Compiles a Yul contract and returns the address that the contract was deployed to
   *         If deployment fails, an error will be thrown
   * @param filePath - The file path of the Yul contract
   * @return deployedAddress - The address that the contract was deployed to
   */
  function deployContract(string memory filePath) internal returns (address) {
    string memory bashCommand = string.concat('cast abi-encode "f(bytes)" $(solc --strict-assembly --optimize ', filePath, ' --bin | tail -1)');

    string[] memory inputs = new string[](3);
    inputs[0] = "bash";
    inputs[1] = "-c";
    inputs[2] = bashCommand;

    bytes memory bytecode = abi.decode(vm.ffi(inputs), (bytes));

    // deploy the bytecode with the create instruction
    address deployedAddress;
    assembly {
      deployedAddress := create(0, add(bytecode, 0x20), mload(bytecode))
    }

    // check that the deployment was successful
    require(
      deployedAddress != address(0),
      "YulDeployer could not deploy contract"
    );

    // return the address that the contract was deployed to
    return deployedAddress;
  }
}
