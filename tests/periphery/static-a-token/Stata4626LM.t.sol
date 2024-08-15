// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.10;

import {IRescuable} from 'solidity-utils/contracts/utils/Rescuable.sol';
import {ERC20PermitUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC20PermitUpgradeable.sol';
import {Initializable} from 'openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol';
import {IERC20Metadata, IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';

import {AToken} from '../../../src/core/contracts/protocol/tokenization/AToken.sol';
import {DataTypes} from '../../../src/core/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {Math} from '../../../src/periphery/contracts/static-a-token/ERC4626StataTokenUpgradeable.sol';
import {StataTokenV2} from '../../../src/periphery/contracts/static-a-token/StataTokenV2.sol'; // TODO: change import to isolate to 4626
import {SigUtils} from '../../utils/SigUtils.sol';
import {BaseTest, TestnetERC20} from './TestBase.sol';
import {IPool} from '../../../src/core/contracts/interfaces/IPool.sol';

contract Stata4626LMTest is BaseTest {
  function test_initializeShouldRevert() public {
    address impl = factory.STATIC_A_TOKEN_IMPL();
    vm.expectRevert(Initializable.InvalidInitialization.selector);
    StataTokenV2(impl).initialize(aToken, 'hey', 'ho');
  }

  function test_getters() public view {
    assertEq(stataTokenV2.name(), 'Static Aave Local WETH');
    assertEq(stataTokenV2.symbol(), 'stataLocWETH');

    address referenceAsset = stataTokenV2.getReferenceAsset();
    assertEq(referenceAsset, aToken);

    address underlyingAddress = address(stataTokenV2.asset());
    assertEq(underlyingAddress, underlying);

    IERC20Metadata underlying = IERC20Metadata(underlyingAddress);
    assertEq(stataTokenV2.decimals(), underlying.decimals());

    assertEq(
      address(stataTokenV2.INCENTIVES_CONTROLLER()),
      address(AToken(aToken).getIncentivesController())
    );
  }

  function test_convertersAndPreviews() public view {
    uint128 amount = 5 ether;
    uint256 shares = stataTokenV2.convertToShares(amount);
    assertLe(shares, amount, 'SHARES LOWER');
    assertEq(shares, stataTokenV2.previewDeposit(amount), 'PREVIEW_DEPOSIT');
    assertLe(shares, stataTokenV2.previewWithdraw(amount), 'PREVIEW_WITHDRAW');
    uint256 assets = stataTokenV2.convertToAssets(amount);
    assertGe(assets, shares, 'ASSETS GREATER');
    assertLe(assets, stataTokenV2.previewMint(amount), 'PREVIEW_MINT');
    assertEq(assets, stataTokenV2.previewRedeem(amount), 'PREVIEW_REDEEM');
  }

  // Redeem tests
  function test_redeem() public {
    uint128 amountToDeposit = 5 ether;

    _fund4626(amountToDeposit, user);

    assertEq(stataTokenV2.maxRedeem(user), stataTokenV2.balanceOf(user));
    stataTokenV2.redeem(stataTokenV2.maxRedeem(user), user, user);
    assertEq(stataTokenV2.balanceOf(user), 0);
    assertLe(IERC20(underlying).balanceOf(user), amountToDeposit);
    assertApproxEqAbs(IERC20(underlying).balanceOf(user), amountToDeposit, 1);
  }

  function test_redeemAToken() public {
    uint128 amountToDeposit = 5 ether;
    _fund4626(amountToDeposit, user);

    assertEq(stataTokenV2.maxRedeem(user), stataTokenV2.balanceOf(user));
    stataTokenV2.redeemATokens(stataTokenV2.maxRedeem(user), user, user);
    assertEq(stataTokenV2.balanceOf(user), 0);
    assertLe(IERC20(aToken).balanceOf(user), amountToDeposit);
    assertApproxEqAbs(IERC20(aToken).balanceOf(user), amountToDeposit, 1);
  }

  // Withdraw tests
  function test_withdraw() public {
    uint128 amountToDeposit = 5 ether;
    _fund4626(amountToDeposit, user);

    assertLe(stataTokenV2.maxWithdraw(user), amountToDeposit);
    stataTokenV2.withdraw(stataTokenV2.maxWithdraw(user), user, user);
    assertEq(stataTokenV2.balanceOf(user), 0);
    assertLe(IERC20(underlying).balanceOf(user), amountToDeposit);
    assertApproxEqAbs(IERC20(underlying).balanceOf(user), amountToDeposit, 1);
  }

  function testFail_withdrawAboveBalance() public {
    uint128 amountToDeposit = 5 ether;

    _fundAToken(amountToDeposit, user);
    _fundAToken(amountToDeposit, user1);

    assertEq(stataTokenV2.maxWithdraw(user), amountToDeposit);
    stataTokenV2.withdraw(stataTokenV2.maxWithdraw(user) + 1, user, user);
  }

  // mint
  function test_mint() public {
    vm.stopPrank();

    // set supply cap to non-zero
    vm.startPrank(poolAdmin);
    contracts.poolConfiguratorProxy.setSupplyCap(underlying, 15_000);
    vm.stopPrank();

    vm.startPrank(user);

    uint128 amountToDeposit = 5 ether;
    _fundUnderlying(amountToDeposit, user);

    IERC20(underlying).approve(address(stataTokenV2), amountToDeposit);
    uint256 shares = 1 ether;
    stataTokenV2.mint(shares, user);
    assertEq(shares, stataTokenV2.balanceOf(user));
  }

  function testFail_mintAboveBalance() public {
    uint128 amountToDeposit = 5 ether;
    _fund4626(amountToDeposit, user);

    IERC20(aToken).approve(address(stataTokenV2), amountToDeposit);
    stataTokenV2.mint(amountToDeposit, user);
  }
}
