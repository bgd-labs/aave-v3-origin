// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.10;

import {IERC20Metadata, IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {AaveProtocolDataProvider} from '../../src/contracts/helpers/AaveProtocolDataProvider.sol';
import {TestnetProcedures} from '../utils/TestnetProcedures.sol';

/**
 * @title AaveProtocolDataProviderTests
 * @notice Tests for AaveProtocolDataProvider, focused on the getLiquidityRate helper.
 *
 * Motivation: on-chain integrators (ERC-4626 strategies, yield aggregators, rebalancers)
 * need to read the current supply APR for a reserve in a single typed call.  The only
 * prior path was decoding either the 12-field tuple from getReserveData() or the
 * DataTypes.ReserveDataLegacy struct from IPool.getReserveData() directly — both require
 * multi-word return handling that is error-prone outside of Solidity.
 */
contract AaveProtocolDataProviderTests is TestnetProcedures {
  AaveProtocolDataProvider internal dataProvider;

  // Liquidity and collateral amounts sized to stay well within any
  // oracle-price and LTV ceiling the testnet environment configures.
  uint256 internal constant USDX_SUPPLY = 50_000e18;
  uint256 internal constant WETH_COLLATERAL = 100e18;
  uint256 internal constant USDX_BORROW = 100e18;

  function setUp() public {
    initTestEnvironment(false);
    dataProvider = AaveProtocolDataProvider(report.protocolDataProvider);
  }

  // ------------------------------------------------------------------
  //                       getLiquidityRate
  // ------------------------------------------------------------------

  function test_getLiquidityRate_zeroForFreshReserve() public view {
    // No borrows at deployment → currentLiquidityRate must be 0.
    // Verifies the zero-utilisation base case and that the function does
    // not revert for a valid listed asset.
    assertEq(
      dataProvider.getLiquidityRate(tokenList.usdx),
      0,
      'rate should be zero before any borrow'
    );
  }

  function test_getLiquidityRate_nonzeroAfterBorrow() public {
    // Supply USDX liquidity, then borrow against WETH collateral.
    // After utilisation > 0, the interest rate model must produce a
    // nonzero supply APR — confirming the helper reflects live state.
    _setupBorrow();

    assertGt(
      dataProvider.getLiquidityRate(tokenList.usdx),
      0,
      'rate should be nonzero after borrow'
    );
  }

  function test_getLiquidityRate_matchesGetReserveData() public {
    // getLiquidityRate must return exactly the liquidityRate field from the
    // full getReserveData() tuple — the single-word view is not an approximation.
    _setupBorrow();

    (, , , , , uint256 expectedRate, , , , , , ) = dataProvider.getReserveData(tokenList.usdx);
    assertEq(
      dataProvider.getLiquidityRate(tokenList.usdx),
      expectedRate,
      'getLiquidityRate must equal getReserveData liquidityRate field'
    );
  }

  // ------------------------------------------------------------------
  //                           Helpers
  // ------------------------------------------------------------------

  /**
   * @dev Establishes nonzero USDX utilisation:
   *   alice  — supplies USDX (creates borrowable liquidity)
   *   bob    — deposits WETH collateral, borrows USDX variable-rate
   */
  function _setupBorrow() internal {
    deal(tokenList.usdx, alice, USDX_SUPPLY);
    vm.startPrank(alice);
    IERC20(tokenList.usdx).approve(address(contracts.poolProxy), USDX_SUPPLY);
    contracts.poolProxy.deposit(tokenList.usdx, USDX_SUPPLY, alice, 0);
    vm.stopPrank();

    deal(tokenList.weth, bob, WETH_COLLATERAL);
    vm.startPrank(bob);
    IERC20(tokenList.weth).approve(address(contracts.poolProxy), WETH_COLLATERAL);
    contracts.poolProxy.deposit(tokenList.weth, WETH_COLLATERAL, bob, 0);
    contracts.poolProxy.borrow(tokenList.usdx, USDX_BORROW, 2, 0, bob); // mode 2 = VARIABLE
    vm.stopPrank();
  }
}
