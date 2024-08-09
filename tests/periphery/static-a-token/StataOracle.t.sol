// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.10;

import {StataOracle} from '../../../src/periphery/contracts/static-a-token/StataOracle.sol';
import {StaticATokenLM} from '../../../src/periphery/contracts/static-a-token/StaticATokenLM.sol';
import {BaseTest} from './TestBase.sol';
import {IPool} from '../../../src/core/contracts/interfaces/IPool.sol';

contract StataOracleTest is BaseTest {
  StataOracle public oracle;

  function setUp() public override {
    super.setUp();
    oracle = new StataOracle(contracts.poolAddressesProvider);

    vm.prank(address(roleList.marketOwner));
    contracts.poolConfiguratorProxy.setSupplyCap(UNDERLYING, 1_000_000);
  }

  // ### tests for the dedicated oracle aggregator
  function test_assetPrice() public view {
    uint256 stataPrice = oracle.getAssetPrice(address(staticATokenLM));
    uint256 underlyingPrice = contracts.aaveOracle.getAssetPrice(UNDERLYING);
    assertGe(stataPrice, underlyingPrice);
    assertEq(stataPrice, (underlyingPrice * staticATokenLM.convertToAssets(1e18)) / 1e18);
  }

  function test_assetsPrices() public view {
    address[] memory staticATokens = factory.getStaticATokens();
    uint256[] memory stataPrices = oracle.getAssetsPrices(staticATokens);

    for (uint256 i = 0; i < staticATokens.length; i++) {
      address staticAToken = staticATokens[i];
      uint256 stataPrice = stataPrices[i];

      address underlying = StaticATokenLM(staticAToken).asset();
      uint256 underlyingPrice = contracts.aaveOracle.getAssetPrice(underlying);

      assertGe(stataPrice, underlyingPrice);
      assertEq(
        stataPrice,
        (underlyingPrice * StaticATokenLM(staticAToken).convertToAssets(1e18)) / 1e18
      );
    }
  }

  function test_error(uint256 shares) public view {
    vm.assume(shares <= staticATokenLM.maxMint(address(0)));
    uint256 pricePerShare = oracle.getAssetPrice(address(staticATokenLM));
    uint256 pricePerAsset = contracts.aaveOracle.getAssetPrice(UNDERLYING);
    uint256 assets = staticATokenLM.convertToAssets(shares);

    assertApproxEqAbs(
      (pricePerShare * shares) / 1e18,
      (pricePerAsset * assets) / 1e18,
      (assets / 1e18) + 1 // there can be imprecision of 1 wei, which will accumulate for each asset
    );
  }

  // ### tests for the token internal oracle
  function test_latestAnswer_priceShouldBeEqualOnDefaultIndex() public {
    vm.mockCall(
      address(POOL),
      abi.encodeWithSelector(IPool.getReserveNormalizedIncome.selector),
      abi.encode(1e27)
    );
    uint256 stataPrice = uint256(staticATokenLM.latestAnswer());
    uint256 underlyingPrice = contracts.aaveOracle.getAssetPrice(UNDERLYING);
    assertEq(stataPrice, underlyingPrice);
  }

  function test_latestAnswer_priceShouldReflectIndexAccrual(uint256 liquidityIndex) public {
    liquidityIndex = bound(liquidityIndex, 1e27, 1e29);
    vm.mockCall(
      address(POOL),
      abi.encodeWithSelector(IPool.getReserveNormalizedIncome.selector),
      abi.encode(liquidityIndex)
    );
    uint256 stataPrice = uint256(staticATokenLM.latestAnswer());
    uint256 underlyingPrice = contracts.aaveOracle.getAssetPrice(UNDERLYING);
    uint256 expectedStataPrice = (underlyingPrice * liquidityIndex) / 1e27;
    assertEq(stataPrice, expectedStataPrice);

    // reverse the math to ensure precision loss is within bounds
    uint256 reversedUnderlying = (stataPrice * 1e27) / liquidityIndex;
    assertApproxEqAbs(underlyingPrice, reversedUnderlying, 1);
  }
}
