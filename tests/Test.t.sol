// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {BorrowLogic} from 'src/core/contracts/protocol/libraries/logic/BorrowLogic.sol';
import {Create2Factory} from 'src/deployments/contracts/utilities/Create2Factory.sol';

contract MiscTest is Test {
  Create2Factory factory = Create2Factory(0xB1DDc8cfcB1A46095C6d5F81ad76F69188B381b8);

  function setUp() public {
    vm.createSelectFork('zksync');
  }

  function test_computedAddress() public {
    address computedAddress = factory.computeAddress(
      bytes32(0),
      type(BorrowLogic).creationCode
    );
    console.log('computedAddress', computedAddress);

    // tx: https://era.zksync.network/tx/0xb124c8db400f8541ce4204436ed571d1da1180a8e996853fa030a950982bd0f9
    console.log('address deployed using the same salt and factory', 0x9474b4492D73f13cc3fa781Aa8e2eF7CBeB11F80);
  }
}
