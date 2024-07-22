// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

library Create2Utils {
  address public constant CREATE2_FACTORY = 0xaECDbB0a3B1C6D1Fe1755866e330D82eC81fD4FD;

  function create2Deploy(bytes32 salt, bytes memory bytecode) internal {
    bytes memory creationBytecode = abi.encodePacked(salt, bytecode);
    (bool success, bytes memory returnData) = CREATE2_FACTORY.call(creationBytecode);
  }

  /**
   * @dev Returns the address where a contract will be stored if deployed via {deploy}. Any change in the `bytecode`
   * or `salt` will result in a new destination address.
   */
  function computeAddress(bytes32 salt, bytes memory bytecode) internal view returns (address) {
    return computeAddress(salt, bytecode, address(this));
  }

  /**
   * @dev Returns the address where a contract will be stored if deployed via {deploy} from a contract located at
   * `deployer`. If `deployer` is this contract's address, returns the same value as {computeAddress}.
   */
  function computeAddress(
    bytes32 salt,
    bytes memory bytecode,
    address deployer
  ) internal pure returns (address) {
    bytes32 bytecodeHash = keccak256(bytecode);
    bytes32 _data = keccak256(abi.encodePacked(bytes1(0xff), deployer, salt, bytecodeHash));
    return address(bytes20(_data << 96));
  }
}
