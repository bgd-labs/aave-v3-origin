// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {FfiUtils} from '../../src/deployments/contracts/utilities/FfiUtils.sol';
import {DeployUtils} from '../../src/deployments/contracts/utilities/DeployUtils.sol';
import {YulDeployer} from '../../src/deployments/contracts/utilities/YulDeployer.sol';
import 'forge-std/console.sol';

contract DeployCreate2Factory is FfiUtils, Script, DeployUtils {
  function run() external {
    bool found = _create2FactoryPathExists();
    if (found) {
      revert('CREATE_2_FACTORY already deployed and is set in the env. Please remove CREATE_2_FACTORY from env and try again');
    }

    _deployAndWriteCreate2Factory();
  }

  function _deployAndWriteCreate2Factory() internal {
    vm.startBroadcast();
    address create2Factory = YulDeployer.deployContract('src/deployments/contracts/utilities/Create2Factory.yul');
    vm.stopBroadcast();

    string memory sedCommand = string(
      abi.encodePacked('echo CREATE_2_FACTORY=', toAsciiString(create2Factory), ' >> .env')
    );
    string[] memory command = new string[](3);

    command[0] = 'bash';
    command[1] = '-c';
    command[2] = string(abi.encodePacked('response="$(', sedCommand, ')"; $response;'));
    vm.ffi(command);
  }

  function toAsciiString(address x) internal pure returns (string memory) {
    bytes memory s = new bytes(40);
    for (uint i = 0; i < 20; i++) {
      bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
      bytes1 hi = bytes1(uint8(b) / 16);
      bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
      s[2*i] = char(hi);
      s[2*i+1] = char(lo);
    }
    return string(s);
  }

  function char(bytes1 b) internal pure returns (bytes1 c) {
    if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
    else return bytes1(uint8(b) + 0x57);
  }
}
