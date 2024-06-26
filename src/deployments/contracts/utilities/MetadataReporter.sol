// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'forge-std/StdJson.sol';
import 'forge-std/Vm.sol';
import '../../interfaces/IMarketReportTypes.sol';
import {IMetadataReporter} from '../../interfaces/IMetadataReporter.sol';

contract MetadataReporter is IMetadataReporter {
  using stdJson for string;

  Vm private constant vm = Vm(address(bytes20(uint160(uint256(keccak256('hevm cheat code'))))));

  function writeJsonReportLibraryBatch1(LibrariesReport memory libraries) external {
    string memory factoryV3Commit;
    string memory factoryV3Branch;

    string memory timestamp = getTimestamp();
    (factoryV3Commit, factoryV3Branch) = getGitModuleVersion();

    string memory jsonReport = 'lib-report-1';

    vm.serializeAddress(jsonReport, 'borrowLogic', libraries.borrowLogic);
    vm.serializeAddress(jsonReport, 'bridgeLogic', libraries.bridgeLogic);
    vm.serializeAddress(jsonReport, 'configuratorLogic', libraries.configuratorLogic);

    string memory output = vm.serializeAddress(jsonReport, 'eModeLogic', libraries.eModeLogic);

    vm.writeJson(output, string.concat('./reports/', timestamp, '-library-1-deployment.json'));
  }

  function writeJsonReportLibraryBatch2(LibrariesReport memory libraries) external {
    string memory factoryV3Commit;
    string memory factoryV3Branch;

    string memory timestamp = getTimestamp();
    (factoryV3Commit, factoryV3Branch) = getGitModuleVersion();

    string memory jsonReport = 'lib-report-2';

    vm.serializeAddress(jsonReport, 'flashLoanLogic', libraries.flashLoanLogic);
    vm.serializeAddress(jsonReport, 'liquidationLogic', libraries.liquidationLogic);
    vm.serializeAddress(jsonReport, 'poolLogic', libraries.poolLogic);

    string memory output = vm.serializeAddress(jsonReport, 'supplyLogic', libraries.supplyLogic);

    vm.writeJson(output, string.concat('./reports/', timestamp, '-library-2-deployment.json'));
  }

  function getTimestamp() public returns (string memory result) {
    string[] memory command = new string[](3);

    command[0] = 'bash';
    command[1] = '-c';
    command[2] = 'response="$(date +%s)"; cast abi-encode "response(string)" $response;';
    bytes memory timestamp = vm.ffi(command);
    (result) = abi.decode(timestamp, (string));

    return result;
  }

  function getGitModuleVersion() public returns (string memory commit, string memory branch) {
    string[] memory commitCommand = new string[](3);
    string[] memory branchCommand = new string[](3);

    commitCommand[0] = 'bash';
    commitCommand[1] = '-c';
    commitCommand[
      2
    ] = 'response="$(echo -n $(git rev-parse HEAD))"; cast abi-encode "response(string)" "$response"';

    bytes memory commitResponse = vm.ffi(commitCommand);

    (commit) = abi.decode(commitResponse, (string));

    branchCommand[0] = 'bash';
    branchCommand[1] = '-c';
    branchCommand[
      2
    ] = 'response="$(echo -n $(git branch --show-current))"; cast abi-encode "response(string)" "$response"';

    bytes memory response = vm.ffi(branchCommand);

    (branch) = abi.decode(response, (string));

    return (commit, branch);
  }
}
