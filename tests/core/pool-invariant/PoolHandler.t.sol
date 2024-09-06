// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {PoolInvariants} from "./PoolInvariants.t.sol";
import {TestnetProcedures, ContractsReport, IERC20} from 'tests/utils/TestnetProcedures.sol';
import {IERC20Metadata} from 'solidity-utils/contracts/oz-common/interfaces/IERC20Metadata.sol';
import "forge-std/Test.sol";

contract PoolHandler is Test {
  address internal user;
  TestnetProcedures.TokenList internal tokens;
  ContractsReport internal contracts;

  uint256 internal supplySuccessCalls;
  uint256 internal borrowSuccessCalls;
  uint256 internal borrowFailCalls;
  uint256 internal withdrawSuccessCalls;
  uint256 internal withdrawFailCalls;
  uint256 internal repaySuccessCalls;
  uint256 internal repayFailCalls;

  struct UserPositionUsd {
    uint256 usdxCollateralUsd;
    uint256 wethCollateralUsd;
    uint256 wbtcCollateralUsd;
    uint256 usdxBorrowsUsd;
    uint256 wethBorrowsUsd;
    uint256 wbtcBorrowsUsd;
  }

  uint256 LT_DECIMALS = 4;
  uint256 UPPER_BOUND_FUZZED_INPUT = 100_000_000_000 ether;
  uint256 LOWER_BOUND_FUZZED_INPUT = 1e6;

  constructor(
    address _user,
    TestnetProcedures.TokenList memory _tokenList,
    ContractsReport memory _contracts
  ) {
    user = _user;
    tokens = _tokenList;
    contracts = _contracts;
  }

  function supply(uint8 tokenIndex, uint128 amount) public {
    vm.assume(amount > LOWER_BOUND_FUZZED_INPUT && amount < UPPER_BOUND_FUZZED_INPUT);
    vm.startPrank(user);
    address token = _getTokenAddressFromIndex(tokenIndex);

    deal(token, user, amount);
    IERC20(token).approve(address(contracts.poolProxy), amount);

    contracts.poolProxy.supply(token, amount, user, 0);

    supplySuccessCalls++;
    vm.stopPrank();
  }

  function borrow(uint8 tokenIndex, uint128 amount) public {
    vm.assume(amount > LOWER_BOUND_FUZZED_INPUT);
    vm.startPrank(user);
    address token = _getTokenAddressFromIndex(tokenIndex);

    if (_validateAmountToBorrow(token, amount)) {
      contracts.poolProxy.borrow(token, amount, 2, 0, user);
      borrowSuccessCalls++;
    } else {
      vm.expectRevert();
      contracts.poolProxy.borrow(token, amount, 2, 0, user);
      borrowFailCalls++;
    }

    vm.stopPrank();
  }

  function withdraw(uint8 tokenIndex, uint128 amount) public {
    vm.assume(amount > LOWER_BOUND_FUZZED_INPUT);

    vm.startPrank(user);
    address token = _getTokenAddressFromIndex(tokenIndex);

    if (_validateAmountToWithdraw(token, amount)) {
      contracts.poolProxy.withdraw(token, amount, user);
      withdrawSuccessCalls++;
    } else {
      vm.expectRevert();
      contracts.poolProxy.withdraw(token, amount, user);
      withdrawFailCalls++;
    }

    vm.stopPrank();
  }

  function repay(uint8 tokenIndex, uint128 amount) public {
    vm.assume(amount > 0);
    vm.startPrank(user);
    address token = _getTokenAddressFromIndex(tokenIndex);

    deal(token, user, amount);
    IERC20(token).approve(address(contracts.poolProxy), amount);

    if (_validateAmountToRepay(token)) {
      contracts.poolProxy.repay(token, amount, 2, user);
      repaySuccessCalls++;
    } else {
      vm.expectRevert();
      contracts.poolProxy.repay(token, amount, 2, user);
      repayFailCalls++;
    }

    vm.stopPrank();
  }

  function _validateAmountToBorrow(address token, uint256 amountToBorrow) internal view returns (bool) {
    UserPositionUsd memory userPosition = _getUserCollateralAndDebtInUsd();
    (uint256 usdxLtv, uint256 wethLtv, uint256 wbtcLtv) = _getLTV();

    uint256 totalBorrowableAmountInUsd = ((userPosition.usdxCollateralUsd * usdxLtv) + (userPosition.wethCollateralUsd * wethLtv) + (userPosition.wbtcCollateralUsd * wbtcLtv)) / 10000;
    uint256 totalDebtInUsd = userPosition.usdxBorrowsUsd + userPosition.wethBorrowsUsd + userPosition.wbtcBorrowsUsd;
    totalBorrowableAmountInUsd = totalBorrowableAmountInUsd > totalDebtInUsd ? totalBorrowableAmountInUsd - (userPosition.usdxBorrowsUsd + userPosition.wethBorrowsUsd + userPosition.wbtcBorrowsUsd) : 0;

    uint256 tokenPrice = contracts.aaveOracle.getAssetPrice(token);
    (address aToken, ,) = contracts.protocolDataProvider.getReserveTokensAddresses(token);

    uint256 amountInUsdToBorrow = (amountToBorrow * tokenPrice) / 10 ** IERC20Metadata(token).decimals();
    return (amountInUsdToBorrow < totalBorrowableAmountInUsd) && (IERC20(token).balanceOf(aToken) >= amountToBorrow);
  }

  function _validateAmountToWithdraw(address token,  uint256 amountToWithdraw) internal view returns (bool) {
    UserPositionUsd memory userPosition = _getUserCollateralAndDebtInUsd();

    uint256 tokenPrice = contracts.aaveOracle.getAssetPrice(token);
    (address aToken, ,) = contracts.protocolDataProvider.getReserveTokensAddresses(token);
    uint256 amountToWithdrawUsd = (amountToWithdraw * tokenPrice) / 10 ** IERC20Metadata(token).decimals();

    (uint256 usdxLt, uint256 wethLt, uint256 wbtcLt) = _getLT();

    uint256 totalWithdrawableAmountInUsd = (
        ((token == tokens.usdx && (userPosition.usdxCollateralUsd > (amountToWithdrawUsd))) ? (userPosition.usdxCollateralUsd - (amountToWithdrawUsd)) * usdxLt : userPosition.usdxCollateralUsd * usdxLt) +
        ((token == tokens.weth && (userPosition.wethCollateralUsd > (amountToWithdrawUsd))) ? (userPosition.wethCollateralUsd - (amountToWithdrawUsd)) * wethLt : userPosition.wethCollateralUsd * wethLt) +
        ((token == tokens.wbtc && (userPosition.wbtcCollateralUsd > (amountToWithdrawUsd))) ? (userPosition.wbtcCollateralUsd - (amountToWithdrawUsd)) * wbtcLt : userPosition.wbtcCollateralUsd * wbtcLt)
      ) / 10 ** LT_DECIMALS;
    return (totalWithdrawableAmountInUsd > (userPosition.usdxBorrowsUsd + userPosition.wethBorrowsUsd + userPosition.wbtcBorrowsUsd)) && (IERC20(token).balanceOf(aToken) >= amountToWithdraw);
  }

  function summary() external view {
    console.log("Supply Success Calls: %s", supplySuccessCalls);

    console.log("Borrow Success Calls: %s", borrowSuccessCalls);
    console.log("Borrow Success Calls: %s", borrowFailCalls);

    console.log("Withdraw Success Calls: %s", withdrawSuccessCalls);
    console.log("Withdraw Success Calls: %s", withdrawFailCalls);

    console.log("Repay Success Calls: %s", repaySuccessCalls);
    console.log("Repay Success Calls: %s", repayFailCalls);
  }

  // @dev returns true if the user has some debt for the token
  function _validateAmountToRepay(address token) internal view returns (bool) {
    (,,address variableDebtToken) = contracts.protocolDataProvider.getReserveTokensAddresses(token);
    if (IERC20(variableDebtToken).balanceOf(user) != 0) {
      return true;
    } else {
      return false;
    }
  }

  function _getUserCollateralAndDebtInUsd() internal view returns (UserPositionUsd memory userPosition) {
    (address aUSDX, , address variableDebtUSDX) = contracts.protocolDataProvider.getReserveTokensAddresses(tokens.usdx);
    (address aWETH, , address variableDebtWETH) = contracts.protocolDataProvider.getReserveTokensAddresses(tokens.weth);
    (address aWBTC, , address variableDebtWBTC) = contracts.protocolDataProvider.getReserveTokensAddresses(tokens.wbtc);

    uint256 usdxPrice = contracts.aaveOracle.getAssetPrice(tokens.usdx);
    uint256 wethPrice = contracts.aaveOracle.getAssetPrice(tokens.weth);
    uint256 wbtcPrice = contracts.aaveOracle.getAssetPrice(tokens.wbtc);

    userPosition.usdxCollateralUsd = (usdxPrice * IERC20(aUSDX).balanceOf(user)) / 10 ** IERC20Metadata(tokens.usdx).decimals();
    userPosition.wethCollateralUsd = (wethPrice * IERC20(aWETH).balanceOf(user)) / 10 ** IERC20Metadata(tokens.weth).decimals();
    userPosition.wbtcCollateralUsd = (wbtcPrice * IERC20(aWBTC).balanceOf(user)) / 10 ** IERC20Metadata(tokens.wbtc).decimals();
    userPosition.usdxBorrowsUsd = (usdxPrice * IERC20(variableDebtUSDX).balanceOf(user)) / 10 ** IERC20Metadata(tokens.usdx).decimals();
    userPosition.wethBorrowsUsd = (wethPrice * IERC20(variableDebtWETH).balanceOf(user)) / 10 ** IERC20Metadata(tokens.weth).decimals();
    userPosition.wbtcBorrowsUsd = (wbtcPrice * IERC20(variableDebtWBTC).balanceOf(user)) / 10 ** IERC20Metadata(tokens.wbtc).decimals();

    return userPosition;
  }

  function _getLT() internal view returns (uint256 usdxLt, uint256 wethLt, uint256 wbtcLt) {
    (,, usdxLt,,,,,,,) = contracts.protocolDataProvider.getReserveConfigurationData(tokens.usdx);
    (,, wethLt,,,,,,,) = contracts.protocolDataProvider.getReserveConfigurationData(tokens.weth);
    (,, wbtcLt,,,,,,,) = contracts.protocolDataProvider.getReserveConfigurationData(tokens.wbtc);
  }

  function _getLTV() internal view returns (uint256 usdxLtv, uint256 wethLtv, uint256 wbtcLtv) {
    (,usdxLtv,,,,,,,,) = contracts.protocolDataProvider.getReserveConfigurationData(tokens.usdx);
    (,wethLtv,,,,,,,,) = contracts.protocolDataProvider.getReserveConfigurationData(tokens.weth);
    (,wbtcLtv,,,,,,,,) = contracts.protocolDataProvider.getReserveConfigurationData(tokens.wbtc);
  }

  // to get random asset from index
  function _getTokenAddressFromIndex(uint8 tokenIndex) internal view returns (address) {
    address[3] memory tokensArray = [tokens.usdx, tokens.weth, tokens.wbtc];
    tokenIndex = tokenIndex % 3;
    return tokensArray[tokenIndex];
  }
}
