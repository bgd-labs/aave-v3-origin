// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './MarketInput.sol';

contract ZkSyncInput is MarketInput {
  address public constant GUARDIAN = 0xba845c27903F7dDB5c676e5b74728C871057E000;
  address public constant EXECUTOR_LVL_1 = 0x04cE39789e11a49595cD0ECEf6f4Bd54ABF4d020;

  function _getMarketInput(
    address
  )
    internal
    pure
    override
    returns (
      Roles memory roles,
      MarketConfig memory config,
      DeployFlags memory flags,
      MarketReport memory deployedContracts
    )
  {
    roles.marketOwner = EXECUTOR_LVL_1;
    roles.emergencyAdmin = GUARDIAN;
    roles.poolAdmin = EXECUTOR_LVL_1;

    flags.l2 = false;

    config.marketId = 'Aave V3 ZkSync Market';
    config.providerId = 44;
    config.oracleDecimals = 8;
    // eth-usd chainlink price feed
    config
      .marketReferenceCurrencyPriceInUsdProxyAggregator = 0x6D41d1dc818112880b40e26BD6FD347E41008eDA;
    // eth-usd chainlink price feed
    config.networkBaseTokenPriceInUsdProxyAggregator = 0x6D41d1dc818112880b40e26BD6FD347E41008eDA;
    config.wrappedNativeToken = 0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91;
    config.flashLoanPremiumTotal = 0.0005e4;
    config.flashLoanPremiumToProtocol = 0.0004e4;

    return (roles, config, flags, deployedContracts);
  }
}
