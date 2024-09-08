// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TestnetProcedures} from 'tests/utils/TestnetProcedures.sol';
import {PoolHandler} from "./PoolHandler.t.sol";

contract PoolInvariants is TestnetProcedures {
  PoolHandler internal s_poolHandler;

  function setUp() public {
    initTestEnvironment();
    s_poolHandler = new PoolHandler(
      alice,
      tokenList,
      contracts
    );

    // add the handler selectors to the fuzzing targets
    bytes4[] memory selectors = new bytes4[](4);
    selectors[0] = PoolHandler.supply.selector;
    selectors[1] = PoolHandler.borrow.selector;
    selectors[2] = PoolHandler.withdraw.selector;
    selectors[3] = PoolHandler.repay.selector;

    targetSelector(FuzzSelector({addr: address(s_poolHandler), selectors: selectors}));
    targetContract(address(s_poolHandler));
  }

  function invariant_checkHealthFactor() public {
    (,,,,,uint256 healthFactor) = contracts.poolProxy.getUserAccountData(alice);
    assertTrue(healthFactor > 1e18);
  }

  function invariant_summary() public view {
    s_poolHandler.summary();
  }
}
