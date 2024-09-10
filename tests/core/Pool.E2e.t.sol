// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {Errors} from 'aave-v3-core/contracts/protocol/libraries/helpers/Errors.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';
import {TestnetProcedures} from '../utils/TestnetProcedures.sol';

contract PoolE2ETests is TestnetProcedures {
  function setUp() public {
    initTestEnvironment();

    vm.startPrank(carol);
    contracts.poolProxy.supply(tokenList.usdx, 100_000e6, carol, 0);
    vm.stopPrank();
  }

  function test_supply_withdrawAll() public {
    uint256 supplyAmount = 0.2e8;

    vm.startPrank(alice);
    contracts.poolProxy.supply(tokenList.wbtc, supplyAmount, alice, 0);
    contracts.poolProxy.withdraw(tokenList.wbtc, supplyAmount, alice);
  }

  function test_supply_withdrawAll_borrow_reverts() public {
    uint256 supplyAmount = 0.2e8;

    vm.startPrank(alice);
    contracts.poolProxy.supply(tokenList.wbtc, supplyAmount, alice, 0);
    contracts.poolProxy.withdraw(tokenList.wbtc, supplyAmount, alice);

    vm.expectRevert(bytes(Errors.COLLATERAL_BALANCE_IS_ZERO));
    contracts.poolProxy.borrow(tokenList.usdx, 10e6, 2, 0, alice);
  }

  function test_supply_transferATokenOut_borrow_reverts() public {
    uint256 supplyAmount = 0.2e8;

    vm.startPrank(alice);
    contracts.poolProxy.supply(tokenList.wbtc, supplyAmount, alice, 0);
    (address aWBTC, , ) = contracts.protocolDataProvider.getReserveTokensAddresses(tokenList.wbtc);
    IERC20(aWBTC).transfer(carol, supplyAmount);

    vm.expectRevert(bytes(Errors.COLLATERAL_BALANCE_IS_ZERO));
    contracts.poolProxy.borrow(tokenList.usdx, 10e6, 2, 0, alice);
  }

  function test_supply_borrow_withdrawAll_reverts() public {
    uint256 supplyAmount = 0.2e8;
    uint256 borrowAmount = 1_000e6;

    vm.startPrank(alice);
    contracts.poolProxy.supply(tokenList.wbtc, supplyAmount, alice, 0);
    contracts.poolProxy.borrow(tokenList.usdx, borrowAmount, 2, 0, alice);

    vm.expectRevert(bytes(Errors.HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD));
    contracts.poolProxy.withdraw(tokenList.wbtc, supplyAmount, alice);
  }

  function test_supply_borrow_repayAll_withdrawAll() public {
    uint256 supplyAmount = 0.2e8;
    uint256 borrowAmount = 1_000e6;

    vm.startPrank(alice);
    contracts.poolProxy.supply(tokenList.wbtc, supplyAmount, alice, 0);
    contracts.poolProxy.borrow(tokenList.usdx, borrowAmount, 2, 0, alice);
    contracts.poolProxy.repay(tokenList.usdx, UINT256_MAX, 2, alice);
    contracts.poolProxy.withdraw(tokenList.wbtc, supplyAmount, alice);
  }

  function test_supply_borrow_repay_withdrawAll_reverts() public {
    uint256 supplyAmount = 0.2e8;
    uint256 borrowAmount = 1_000e6;
    uint256 repayAmount = 500e6;

    vm.startPrank(alice);
    contracts.poolProxy.supply(tokenList.wbtc, supplyAmount, alice, 0);
    contracts.poolProxy.borrow(tokenList.usdx, borrowAmount, 2, 0, alice);
    contracts.poolProxy.repay(tokenList.usdx, repayAmount, 2, alice);

    vm.expectRevert(bytes(Errors.HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD));
    contracts.poolProxy.withdraw(tokenList.wbtc, supplyAmount, alice);
  }

  function test_multipleSupply_multipleBorrow_repay_withdrawAll_reverts() public {
    uint256 supplyAmountWBTC = 0.2e8;
    uint256 supplyAmountUSDX = 1_000e6;
    uint256 supplyAmountWETH = 0.2e18;
    uint256 borrowAmountUSDX = 5_000e6;
    uint256 borrowAmountWETH = 0.1e18;

    vm.startPrank(alice);
    contracts.poolProxy.supply(tokenList.wbtc, supplyAmountWBTC, alice, 0);
    contracts.poolProxy.supply(tokenList.usdx, supplyAmountUSDX, alice, 0);
    contracts.poolProxy.supply(tokenList.weth, supplyAmountWETH, alice, 0);

    contracts.poolProxy.borrow(tokenList.usdx, borrowAmountUSDX, 2, 0, alice);
    contracts.poolProxy.borrow(tokenList.weth, borrowAmountWETH, 2, 0, alice);

    contracts.poolProxy.repay(tokenList.weth, UINT256_MAX, 2, alice);

    vm.expectRevert(bytes(Errors.HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD));
    contracts.poolProxy.withdraw(tokenList.wbtc, supplyAmountWBTC, alice);
  }

  function test_multipleSupply_multipleBorrow_repayAll_multipleBorrow_repay_withdrawAll_reverts() public {
    uint256 supplyAmountWBTC = 0.2e8;
    uint256 supplyAmountUSDX = 1_000e6;
    uint256 supplyAmountWETH = 0.2e18;
    uint256 borrowAmountUSDX = 5_000e6;
    uint256 borrowAmountWETH = 0.1e18;

    vm.startPrank(alice);
    contracts.poolProxy.supply(tokenList.wbtc, supplyAmountWBTC, alice, 0);
    contracts.poolProxy.supply(tokenList.usdx, supplyAmountUSDX, alice, 0);
    contracts.poolProxy.supply(tokenList.weth, supplyAmountWETH, alice, 0);

    contracts.poolProxy.borrow(tokenList.usdx, borrowAmountUSDX, 2, 0, alice);
    contracts.poolProxy.borrow(tokenList.weth, borrowAmountWETH, 2, 0, alice);

    contracts.poolProxy.repay(tokenList.weth, UINT256_MAX, 2, alice);
    contracts.poolProxy.repay(tokenList.usdx, UINT256_MAX, 2, alice);

    contracts.poolProxy.borrow(tokenList.usdx, borrowAmountUSDX, 2, 0, alice);
    contracts.poolProxy.borrow(tokenList.weth, borrowAmountWETH, 2, 0, alice);

    contracts.poolProxy.repay(tokenList.weth, UINT256_MAX, 2, alice);

    vm.expectRevert(bytes(Errors.HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD));
    contracts.poolProxy.withdraw(tokenList.wbtc, supplyAmountWBTC, alice);
  }

  function test_multipleSupply_multipleBorrow_repayAll_withdrawAll() public {
    uint256 supplyAmountWBTC = 0.2e8;
    uint256 supplyAmountUSDX = 1_000e6;
    uint256 supplyAmountWETH = 0.2e18;
    uint256 borrowAmountWBTC = 0.12e6;
    uint256 borrowAmountUSDX = 5_000e6;
    uint256 borrowAmountWETH = 0.1e18;

    vm.startPrank(alice);
    contracts.poolProxy.supply(tokenList.wbtc, supplyAmountWBTC, alice, 0);
    contracts.poolProxy.supply(tokenList.usdx, supplyAmountUSDX, alice, 0);
    contracts.poolProxy.supply(tokenList.weth, supplyAmountWETH, alice, 0);

    contracts.poolProxy.borrow(tokenList.wbtc, borrowAmountWBTC, 2, 0, alice);
    contracts.poolProxy.borrow(tokenList.usdx, borrowAmountUSDX, 2, 0, alice);
    contracts.poolProxy.borrow(tokenList.weth, borrowAmountWETH, 2, 0, alice);

    contracts.poolProxy.repay(tokenList.wbtc, UINT256_MAX, 2, alice);
    contracts.poolProxy.repay(tokenList.usdx, UINT256_MAX, 2, alice);
    contracts.poolProxy.repay(tokenList.weth, UINT256_MAX, 2, alice);

    contracts.poolProxy.withdraw(tokenList.wbtc, supplyAmountWBTC, alice);
    contracts.poolProxy.withdraw(tokenList.usdx, supplyAmountUSDX, alice);
    contracts.poolProxy.withdraw(tokenList.weth, supplyAmountWETH, alice);
  }

  function test_supply_borrow_emode() public {
    uint8 emodeId = _setEMode();

    vm.startPrank(alice);
    contracts.poolProxy.setUserEMode(emodeId);
    contracts.poolProxy.supply(tokenList.weth, 1e18, alice, 0);
    contracts.poolProxy.borrow(tokenList.usdx, 1_700e6, 2, 0, alice);
  }

  function test_supply_borrow_emode_withdrawAll_reverts() public {
    uint8 emodeId = _setEMode();

    vm.startPrank(alice);
    contracts.poolProxy.setUserEMode(emodeId);
    contracts.poolProxy.supply(tokenList.weth, 1e18, alice, 0);
    contracts.poolProxy.borrow(tokenList.usdx, 1_700e6, 2, 0, alice);

    vm.expectRevert(bytes(Errors.HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD));
    contracts.poolProxy.withdraw(tokenList.weth, 1e18, alice);
  }

  function test_supply_borrow_repayAll_emode_withdrawAll() public {
    uint8 emodeId = _setEMode();

    vm.startPrank(alice);
    contracts.poolProxy.setUserEMode(emodeId);
    contracts.poolProxy.supply(tokenList.weth, 1e18, alice, 0);
    contracts.poolProxy.borrow(tokenList.usdx, 1_700e6, 2, 0, alice);
    contracts.poolProxy.repay(tokenList.usdx, 1_700e6, 2, alice);
    contracts.poolProxy.withdraw(tokenList.weth, 1e18, alice);
  }

  function _setEMode() internal returns (uint8 id) {
    EModeCategoryInput memory ct = _genCategoryOne();

    vm.startPrank(poolAdmin);
    contracts.poolConfiguratorProxy.setEModeCategory(
      ct.id,
      ct.ltv,
      ct.lt,
      ct.lb,
      ct.oracle,
      ct.label
    );
    contracts.poolConfiguratorProxy.setAssetEModeCategory(tokenList.weth, ct.id);
    contracts.poolConfiguratorProxy.setAssetEModeCategory(tokenList.usdx, ct.id);
    vm.stopPrank();

    return ct.id;
  }
}
