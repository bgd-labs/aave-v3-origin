// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/interfaces/IERC20.sol';
import {IPriceOracleGetter} from '../../src/contracts/interfaces/IPriceOracleGetter.sol';
import {TestnetProcedures} from '../utils/TestnetProcedures.sol';

contract Testhelpers is TestnetProcedures {
  address rando = makeAddr('randomUser');

  function setUp() public virtual {
    initTestEnvironment(false);

    // supply and borrow some on reserve with a random user as "some" interest accrual
    // is the realisitc usecase we want to check in gas snapshots
    _supplyOnReserve(rando, 100 ether, tokenList.weth);
    _supplyOnReserve(rando, 1_000_000e6, tokenList.usdx);
    _supplyOnReserve(rando, 100e8, tokenList.wbtc);
    vm.startPrank(rando);
    contracts.poolProxy.borrow(tokenList.weth, 1 ether, 2, 0, rando);
    contracts.poolProxy.borrow(tokenList.usdx, 1000e6, 2, 0, rando);
    contracts.poolProxy.borrow(tokenList.wbtc, 1e8, 2, 0, rando);
    vm.stopPrank();
    _skip(100); // skip some blocks to allow interest to accrue & the block to be not cached
  }

  /**
   * Supplies the specified amount of asset to the reserve.
   */
  function _supplyOnReserve(address user, uint256 amount, address asset) internal {
    vm.startPrank(user);
    deal(asset, user, amount);
    IERC20(asset).approve(report.poolProxy, amount);
    contracts.poolProxy.supply(asset, amount, user, 0);
    vm.stopPrank();
  }

  // assumes that the caller has at least one unit of collateralAsset that is not the borrowAsset
  function _borrowArbitraryAmount(address borrower, uint256 amount, address asset) internal {
    // set the oracle price of the borrow asset to 0
    vm.mockCall(
      address(contracts.aaveOracle),
      abi.encodeWithSelector(IPriceOracleGetter.getAssetPrice.selector, address(asset)),
      abi.encode(0)
    );
    // borrow the full emount of the asset
    vm.prank(borrower);
    contracts.poolProxy.borrow(asset, amount, 2, 0, borrower);
    // revert the oracle price
    vm.clearMockedCalls();
  }

  /**
   * Skips the specified amount of blocks and adjusts the time accordingly.
   * Using vm. methods for --via-ir compat.
   */
  function _skip(uint256 amount) internal {
    vm.warp(vm.getBlockTimestamp() + amount * 12);
    vm.roll(vm.getBlockNumber() + amount);
  }
}