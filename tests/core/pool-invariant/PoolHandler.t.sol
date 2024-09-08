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

  mapping(address => uint256) internal supplySuccessCalls;
  mapping(address => uint256) internal borrowSuccessCalls;
  mapping(address => uint256) internal borrowFailCalls;
  mapping(address => uint256) internal withdrawSuccessCalls;
  mapping(address => uint256) internal withdrawFailCalls;
  mapping(address => uint256) internal repaySuccessCalls;
  mapping(address => uint256) internal repayFailCalls;

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
    vm.expectRevert();
    contracts.poolProxy.supply(token, amount, user, 0);

    supplySuccessCalls[token]++;
    vm.stopPrank();
  }

  function borrow(uint8 tokenIndex, uint128 amount) public {
    vm.assume(amount > LOWER_BOUND_FUZZED_INPUT);
    vm.startPrank(user);
    address token = _getTokenAddressFromIndex(tokenIndex);

    if (_validateAmountToBorrow(token, amount)) {
      vm.expectRevert();
      contracts.poolProxy.borrow(token, amount, 2, 0, user);
      borrowSuccessCalls[token]++;
    } else {
      // vm.expectRevert();
      contracts.poolProxy.borrow(token, amount, 2, 0, user);
      borrowFailCalls[token]++;
    }

    vm.stopPrank();
  }

  function withdraw(uint8 tokenIndex, uint128 amount) public {
    vm.assume(amount > LOWER_BOUND_FUZZED_INPUT);

    vm.startPrank(user);
    address token = _getTokenAddressFromIndex(tokenIndex);

    if (_validateAmountToWithdraw(token, amount)) {
      vm.expectRevert();
      contracts.poolProxy.withdraw(token, amount, user);
      withdrawSuccessCalls[token]++;
    } else {
      // vm.expectRevert();
      contracts.poolProxy.withdraw(token, amount, user);
      withdrawFailCalls[token]++;
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
      vm.expectRevert();
      contracts.poolProxy.repay(token, amount, 2, user);
      repaySuccessCalls[token]++;
    } else {
      // vm.expectRevert();
      contracts.poolProxy.repay(token, amount, 2, user);
      repayFailCalls[token]++;
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

    // user has not supplied enough token to withdraw
    if (IERC20(aToken).balanceOf(user) < amountToWithdraw) return false;
    (uint256 usdxLt, uint256 wethLt, uint256 wbtcLt) = _getLT();

    if (token == tokens.usdx) {
      userPosition.usdxCollateralUsd = userPosition.usdxCollateralUsd - amountToWithdrawUsd;
    } else if (token == tokens.weth) {
      userPosition.wethCollateralUsd = userPosition.wethCollateralUsd - amountToWithdrawUsd;
    } else if (token == tokens.wbtc) {
      userPosition.wbtcCollateralUsd = userPosition.wbtcCollateralUsd - amountToWithdrawUsd;
    }
    uint256 totalDebtInUsd = userPosition.usdxBorrowsUsd + userPosition.wethBorrowsUsd + userPosition.wbtcBorrowsUsd;
    uint256 totalWithdrawableAmountInUsd = ((userPosition.usdxCollateralUsd * usdxLt) + (userPosition.wethCollateralUsd * wethLt) + (userPosition.wbtcCollateralUsd * wbtcLt)) / 10 ** LT_DECIMALS;

    return (totalWithdrawableAmountInUsd > totalDebtInUsd) && (IERC20(token).balanceOf(aToken) >= amountToWithdraw);
  }

  function summary() external view {
    console.log("Supply Success Calls USDX: %s", supplySuccessCalls[tokens.usdx]);
    console.log("Borrow Success Calls USDX: %s", borrowSuccessCalls[tokens.usdx]);
    console.log("Borrow Fail Calls USDX: %s", borrowFailCalls[tokens.usdx]);
    console.log("Withdraw Success Calls USDX: %s", withdrawSuccessCalls[tokens.usdx]);
    console.log("Withdraw Fail Calls USDX: %s", withdrawFailCalls[tokens.usdx]);
    console.log("Repay Success Calls USDX: %s", repaySuccessCalls[tokens.usdx]);
    console.log("Repay Fail Calls USDX: %s", repayFailCalls[tokens.usdx]);
    console.log();
    console.log("Supply Success Calls WETH: %s", supplySuccessCalls[tokens.weth]);
    console.log("Borrow Success Calls WETH: %s", borrowSuccessCalls[tokens.weth]);
    console.log("Borrow Fail Calls WETH: %s", borrowFailCalls[tokens.weth]);
    console.log("Withdraw Success Calls WETH: %s", withdrawSuccessCalls[tokens.weth]);
    console.log("Withdraw Fail Calls WETH: %s", withdrawFailCalls[tokens.weth]);
    console.log("Repay Success Calls WETH: %s", repaySuccessCalls[tokens.weth]);
    console.log("Repay Fail Calls WETH: %s", repayFailCalls[tokens.weth]);
    console.log();
    console.log("Supply Success Calls WBTC: %s", supplySuccessCalls[tokens.wbtc]);
    console.log("Borrow Success Calls WBTC: %s", borrowSuccessCalls[tokens.wbtc]);
    console.log("Borrow Fail Calls WBTC: %s", borrowFailCalls[tokens.wbtc]);
    console.log("Withdraw Success Calls WBTC: %s", withdrawSuccessCalls[tokens.wbtc]);
    console.log("Withdraw Fail Calls WBTC: %s", withdrawFailCalls[tokens.wbtc]);
    console.log("Repay Success Calls WBTC: %s", repaySuccessCalls[tokens.wbtc]);
    console.log("Repay Fail Calls WBTC: %s", repayFailCalls[tokens.wbtc]);
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
