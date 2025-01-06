import {AaveV3Linea, AaveV3Arbitrum} from '@bgd-labs/aave-address-book';

enum Networks {
  ARBITRUM = 'ARBITRUM',
  LINEA = 'LINEA',
  FACTORY_LOCAL = 'FACTORY_LOCAL'
}

const CONTRACTS: ContractsType = {
  [Networks.ARBITRUM]: {
    POOL_ADDRESSES_PROVIDER: {
      name: 'PoolAddressesProvider',
      path: 'PoolAddressesProvider/@aave/core-v3/contracts/protocol/configuration/PoolAddressesProvider.sol',
      address: AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER,
    },
    L2_POOL: {
      name: 'L2Pool',
      path: 'L2PoolInstance/lib/aave-v3-origin/src/contracts/instances/L2PoolInstance.sol',
      address: AaveV3Arbitrum.POOL,
    },
    POOL_CONFIGURATOR: {
      name: 'PoolConfigurator',
      path: 'PoolConfiguratorInstance/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/instances/PoolConfiguratorInstance.sol',
      address: AaveV3Arbitrum.POOL_CONFIGURATOR,
    },
    ORACLE: {
      name: 'AaveOracle',
      path: 'AaveOracle/@aave/core-v3/contracts/misc/AaveOracle.sol',
      address: AaveV3Arbitrum.ORACLE,
    },
    AAVE_PROTOCOL_DATA_PROVIDER: {
      name: 'AaveProtocolDataProvider',
      path: 'AaveProtocolDataProvider/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/helpers/AaveProtocolDataProvider.sol',
      address: AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER,
    },
    ACL_MANAGER: {
      name: 'ACLManager',
      path: 'ACLManager/@aave/core-v3/contracts/protocol/configuration/ACLManager.sol',
      address: AaveV3Arbitrum.ACL_MANAGER,
    },
    COLLECTOR: {
      name: 'Collector',
      path: 'Collector/src/contracts/Collector.sol',
      address: AaveV3Arbitrum.COLLECTOR,
    },
    DEFAULT_INCENTIVES_CONTROLLER: {
      name: 'RewardsController',
      path: 'RewardsController/lib/aave-v3-periphery/contracts/rewards/RewardsController.sol',
      address: AaveV3Arbitrum.DEFAULT_INCENTIVES_CONTROLLER,
    },
    DEFAULT_A_TOKEN_IMPL: {
      name: 'AToken',
      path: 'AToken/lib/aave-v3-core/contracts/protocol/tokenization/AToken.sol',
      address: AaveV3Arbitrum.DEFAULT_A_TOKEN_IMPL_REV_2,
    },
    DEFAULT_VARIABLE_DEBT_TOKEN_IMPL: {
      name: 'VariableDebtToken',
      path: 'VariableDebtToken/lib/aave-v3-core/contracts/protocol/tokenization/VariableDebtToken.sol',
      address: AaveV3Arbitrum.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2,
    },
    EMISSION_MANAGER: {
      name: 'EmissionManager',
      path: 'EmissionManager/@aave/periphery-v3/contracts/rewards/EmissionManager.sol',
      address: AaveV3Arbitrum.EMISSION_MANAGER,
    },
    POOL_ADDRESSES_PROVIDER_REGISTRY: {
      name: 'PoolAddressesProviderRegistry',
      path: 'PoolAddressesProviderRegistry/@aave/core-v3/contracts/protocol/configuration/PoolAddressesProviderRegistry.sol',
      address: AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER_REGISTRY,
    },
    WETH_GATEWAY: {
      name: 'WrappedTokenGatewayV3',
      path: 'WrappedTokenGatewayV3/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/helpers/WrappedTokenGatewayV3.sol',
      address: AaveV3Arbitrum.WETH_GATEWAY,
    },
    WALLET_BALANCE_PROVIDER: {
      name: 'WalletBalanceProvider',
      path: 'WalletBalanceProvider/@aave/periphery-v3/contracts/misc/WalletBalanceProvider.sol',
      address: AaveV3Arbitrum.WALLET_BALANCE_PROVIDER,
    },
    UI_POOL_DATA_PROVIDER: {
      name: 'UiPoolDataProviderV3',
      path: 'UiPoolDataProviderV3/src/contracts/helpers/UiPoolDataProviderV3.sol',
      address: AaveV3Arbitrum.UI_POOL_DATA_PROVIDER,
    },
    UI_INCENTIVE_DATA_PROVIDER: {
      name: 'UiIncentiveDataProviderV3',
      path: 'UiIncentiveDataProviderV3/src/contracts/helpers/UiIncentiveDataProviderV3.sol',
      address: AaveV3Arbitrum.UI_INCENTIVE_DATA_PROVIDER,
    },
    L2_ENCODER: {
      name: 'L2Encoder',
      path: 'L2Encoder/@aave/core-v3/contracts/misc/L2Encoder.sol',
      address: AaveV3Arbitrum.L2_ENCODER,
    },
    BORROW_LOGIC: {
      name: 'BorrowLogic',
      path: 'BorrowLogic/src/contracts/protocol/libraries/logic/BorrowLogic.sol',
      address: '0x4c52FE2162200bf26c314d7bbd8611699139d553',
    },
    BRIDGE_LOGIC: {
      name: 'BridgeLogic',
      path: 'BridgeLogic/src/contracts/protocol/libraries/logic/BridgeLogic.sol',
      address: '0x97dCbFaE5372A63128F141E8C0BC2c871Ca5F604',
    },
    CONFIGURATOR_LOGIC: {
      name: 'ConfiguratorLogic',
      path: 'ConfiguratorLogic/src/core/contracts/protocol/libraries/logic/ConfiguratorLogic.sol',
      address: '0x6F4964Db83CeCCDc98164796221d5259b922313C',
    },
    EMODE_LOGIC: {
      name: 'EModeLogic',
      path: 'EModeLogic/src/contracts/protocol/libraries/logic/EModeLogic.sol',
      address: '0x88F864670De467aA73CD45325F9652C578C8AB85',
    },
    FLASHLOAN_LOGIC: {
      name: 'FlashLoanLogic',
      path: 'FlashLoanLogic/src/contracts/protocol/libraries/logic/FlashLoanLogic.sol',
      address: '0xb32381feFFF45eE9F47fD2f2cF83C832637d6EF0',
    },
    LIQUIDATION_LOGIC: {
      name: 'LiquidationLogic',
      path: 'LiquidationLogic/src/contracts/protocol/libraries/logic/LiquidationLogic.sol',
      address: '0x80d16970B31243Fe67DaB028115f3E4c3E3510Ad',
    },
    POOL_LOGIC: {
      name: 'PoolLogic',
      path: 'PoolLogic/src/contracts/protocol/libraries/logic/PoolLogic.sol',
      address: '0xA58FB47bE9074828215A173564C0CD10f6F249bf',
    },
    SUPPLY_LOGIC: {
      name: 'SupplyLogic',
      path: 'SupplyLogic/src/contracts/protocol/libraries/logic/SupplyLogic.sol',
      address: '0x2b22E425C1322fbA0DbF17bb1dA25d71811EE7ba',
    },
  },
  [Networks.LINEA]: {
    POOL_ADDRESSES_PROVIDER: {
      name: 'PoolAddressesProvider',
      path: 'PoolAddressesProvider/src/contracts/protocol/configuration/PoolAddressesProvider.sol',
      address: AaveV3Linea.POOL_ADDRESSES_PROVIDER,
    },
    L2_POOL: {
      name: 'L2Pool',
      path: 'L2PoolInstance/src/contracts/instances/L2PoolInstance.sol',
      address: AaveV3Linea.POOL,
    },
    POOL_CONFIGURATOR: {
      name: 'PoolConfigurator',
      path: 'PoolConfiguratorInstance/src/contracts/instances/PoolConfiguratorInstance.sol',
      address: AaveV3Linea.POOL_CONFIGURATOR,
    },
    ORACLE: {
      name: 'AaveOracle',
      path: 'AaveOracle/src/contracts/misc/AaveOracle.sol',
      address: AaveV3Linea.ORACLE,
    },
    AAVE_PROTOCOL_DATA_PROVIDER: {
      name: 'AaveProtocolDataProvider',
      path: 'AaveProtocolDataProvider/src/contracts/helpers/AaveProtocolDataProvider.sol',
      address: AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER,
    },
    ACL_MANAGER: {
      name: 'ACLManager',
      path: 'ACLManager/src/contracts/protocol/configuration/ACLManager.sol',
      address: AaveV3Linea.ACL_MANAGER,
    },
    COLLECTOR: {
      name: 'Collector',
      path: 'Collector/src/contracts/treasury/Collector.sol',
      address: '0x86E2938daE289763D4e09a7e42c5cCcA62Cf9809',
    },
    DEFAULT_INCENTIVES_CONTROLLER: {
      name: 'RewardsController',
      path: 'RewardsController/src/contracts/rewards/RewardsController.sol',
      address: AaveV3Linea.DEFAULT_INCENTIVES_CONTROLLER,
    },
    DEFAULT_A_TOKEN_IMPL: {
      name: 'AToken',
      path: 'ATokenInstance/src/contracts/instances/ATokenInstance.sol',
      address: '0x589750BA8aF186cE5B55391B0b7148cAD43a1619',
    },
    DEFAULT_VARIABLE_DEBT_TOKEN_IMPL: {
      name: 'VariableDebtToken',
      path: 'VariableDebtTokenInstance/src/contracts/instances/VariableDebtTokenInstance.sol',
      address: '0xBeC519531F0E78BcDdB295242fA4EC5251B38574',
    },
    EMISSION_MANAGER: {
      name: 'EmissionManager',
      path: 'EmissionManager/src/contracts/rewards/EmissionManager.sol',
      address: AaveV3Linea.EMISSION_MANAGER,
    },
    POOL_ADDRESSES_PROVIDER_REGISTRY: {
      name: 'PoolAddressesProviderRegistry',
      path: 'PoolAddressesProviderRegistry/src/contracts/protocol/configuration/PoolAddressesProviderRegistry.sol',
      address: AaveV3Linea.POOL_ADDRESSES_PROVIDER_REGISTRY,
    },
    WETH_GATEWAY: {
      name: 'WrappedTokenGatewayV3',
      path: 'WrappedTokenGatewayV3/src/contracts/helpers/WrappedTokenGatewayV3.sol',
      address: AaveV3Linea.WETH_GATEWAY,
    },
    WALLET_BALANCE_PROVIDER: {
      name: 'WalletBalanceProvider',
      path: 'WalletBalanceProvider/src/contracts/helpers/WalletBalanceProvider.sol',
      address: AaveV3Linea.WALLET_BALANCE_PROVIDER,
    },
    UI_POOL_DATA_PROVIDER: {
      name: 'UiPoolDataProviderV3',
      path: 'UiPoolDataProviderV3/src/contracts/helpers/UiPoolDataProviderV3.sol',
      address: AaveV3Linea.UI_POOL_DATA_PROVIDER,
    },
    UI_INCENTIVE_DATA_PROVIDER: {
      name: 'UiIncentiveDataProviderV3',
      path: 'UiIncentiveDataProviderV3/src/contracts/helpers/UiIncentiveDataProviderV3.sol',
      address: AaveV3Linea.UI_INCENTIVE_DATA_PROVIDER,
    },
    L2_ENCODER: {
      name: 'L2Encoder',
      path: 'L2Encoder/src/contracts/helpers/L2Encoder.sol',
      address: '0x01d678F1bbE148C96e7501F1Ac41661904F84F61',
    },
    BORROW_LOGIC: {
      name: 'BorrowLogic',
      path: 'BorrowLogic/src/contracts/protocol/libraries/logic/BorrowLogic.sol',
      address: '0xbFEDA4cC9184727Ac7546Ce529D306bB5CffcB4F',
    },
    BRIDGE_LOGIC: {
      name: 'BridgeLogic',
      path: 'BridgeLogic/src/contracts/protocol/libraries/logic/BridgeLogic.sol',
      address: '0x3f399651Fc3FE274F7754Bb240BC80e096c0d1c5',
    },
    CONFIGURATOR_LOGIC: {
      name: 'ConfiguratorLogic',
      path: 'ConfiguratorLogic/src/contracts/protocol/libraries/logic/ConfiguratorLogic.sol',
      address: '0x1C39F5E734625F34eAf11a8B43c71DAB832936b5',
    },
    EMODE_LOGIC: {
      name: 'EModeLogic',
      path: 'EModeLogic/src/contracts/protocol/libraries/logic/EModeLogic.sol',
      address: '0x848eD9932047Fae0baf74d645450018F424A4367',
    },
    FLASHLOAN_LOGIC: {
      name: 'FlashLoanLogic',
      path: 'FlashLoanLogic/src/contracts/protocol/libraries/logic/FlashLoanLogic.sol',
      address: '0x6990DFae5c227F1aC5D486b1AC0eecAcC2B3e68d',
    },
    LIQUIDATION_LOGIC: {
      name: 'LiquidationLogic',
      path: 'LiquidationLogic/src/contracts/protocol/libraries/logic/LiquidationLogic.sol',
      address: '0xB84A9FBa16902e990EbCb63A22bB46996E9CfABe',
    },
    POOL_LOGIC: {
      name: 'PoolLogic',
      path: 'PoolLogic/src/contracts/protocol/libraries/logic/PoolLogic.sol',
      address: '0x7Cc1def95a7eCfb5afF91425D5e828802A8d914E',
    },
    SUPPLY_LOGIC: {
      name: 'SupplyLogic',
      path: 'SupplyLogic/src/contracts/protocol/libraries/logic/SupplyLogic.sol',
      address: '0x3c012c5d3Be847F46a1428A3Bc53d70dFe691194',
    },
  },
  [Networks.FACTORY_LOCAL]: {}
};

interface ContractInfo {
  name: string;
  path: string;
  address?: string;
}

type ContractsType = {
  [key in Networks]: {
    [contractName: string]: ContractInfo;
  };
};

const PROXIES = [
  'DEFAULT_INCENTIVES_CONTROLLER',
  'POOL',
  'POOL_CONFIGURATOR',
  'L2_POOL',
  'COLLECTOR',
];

const CHAIN_ID = {
  [Networks.ARBITRUM]: 42161,
  [Networks.LINEA]: 59144,
  [Networks.FACTORY_LOCAL]: undefined
};

export {CONTRACTS, PROXIES, CHAIN_ID, Networks};
