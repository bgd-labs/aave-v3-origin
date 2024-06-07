// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

library Create2Utils {
  function _create2Deploy(address create2Factory, bytes32 salt, bytes memory bytecode) internal returns (address) {
    address computed = computeCreate2Address(create2Factory, salt, bytecode);

    if (isContractDeployed(computed)) {
      return computed;
    } else {
      bytes memory creationBytecode = abi.encodePacked(salt, bytecode);
      bytes memory returnData;
      (, returnData) = create2Factory.call(creationBytecode);
      address deployedAt = address(uint160(bytes20(returnData)));
      require(deployedAt == computed, 'failure at create2 address derivation');
      return deployedAt;
    }
  }

  function isContractDeployed(address _addr) internal view returns (bool isContract) {
    return (_addr.code.length > 0);
  }

  function computeCreate2Address(
    address create2Factory,
    bytes32 salt,
    bytes32 initcodeHash
  ) internal pure returns (address) {
    return
      addressFromLast20Bytes(
        keccak256(abi.encodePacked(bytes1(0xff), create2Factory, salt, initcodeHash))
      );
  }

  function computeCreate2Address(
    address create2Factory,
    bytes32 salt,
    bytes memory bytecode
  ) internal pure returns (address) {
    return computeCreate2Address(create2Factory, salt, keccak256(abi.encodePacked(bytecode)));
  }

  function addressFromLast20Bytes(bytes32 bytesValue) internal pure returns (address) {
    return address(uint160(uint256(bytesValue)));
  }
}
