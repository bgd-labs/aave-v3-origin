// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IPool} from 'src/core/contracts/interfaces/IPool.sol';
import {Create2Utils} from 'src/deployments/contracts/utilities/Create2Utils.sol';
import {BorrowLogic} from 'src/core/contracts/protocol/libraries/logic/BorrowLogic.sol';
import {AaveV3LibrariesBatch2} from 'src/deployments/projects/aave-v3-libraries/AaveV3LibrariesBatch2.sol';
import 'forge-std/Test.sol';

contract PoolTests is Test {
  // address FlashLoanLogicLib;

  function setUp() public {
    // address BorrowLogicLib = Create2Utils._create2Deploy(type(BorrowLogic).creationCode);
    // address BridgeLogicLib = Create2Utils._create2Deploy(type(BridgeLogic).creationCode);
    // address ConfiguratorLogicLib = Create2Utils._create2Deploy(type(ConfiguratorLogic).creationCode);
    // address EModeLogicLib = Create2Utils._create2Deploy(type(EModeLogic).creationCode);
    // FlashLoanLogicLib = Create2Utils._create2Deploy(type(FlashLoanLogic).creationCode);
    // console.log('FlashLoanLogicLib', FlashLoanLogicLib);
    // address LiquidationLogicLib = Create2Utils._create2Deploy(type(LiquidationLogic).creationCode);
    // address PoolLogicLib = Create2Utils._create2Deploy(type(PoolLogic).creationCode);
    // address SupplyLogicLib = Create2Utils._create2Deploy(type(SupplyLogic).creationCode);
  }

  function test_deployPool() public {
    // Create2Utils._create2Deploy('salt', type(BorrowLogic).creationCode);
    new AaveV3LibrariesBatch2();
  }

  function test_deploy_libs() public {
    // address BorrowLogicLib = Create2Utils._create2Deploy(type(BorrowLogic).creationCode);
    // address BridgeLogicLib = Create2Utils._create2Deploy(type(BridgeLogic).creationCode);
    // address ConfiguratorLogicLib = Create2Utils._create2Deploy(type(ConfiguratorLogic).creationCode);
    // address EModeLogicLib = Create2Utils._create2Deploy(type(EModeLogic).creationCode);
    // address FlashLoanLogicLib = Create2Utils._create2Deploy(type(FlashLoanLogic).creationCode);
    // address LiquidationLogicLib = Create2Utils._create2Deploy(type(LiquidationLogic).creationCode);
    // address PoolLogicLib = Create2Utils._create2Deploy(type(PoolLogic).creationCode);
    // address SupplyLogicLib = Create2Utils._create2Deploy(type(SupplyLogic).creationCode);

    // vm.etch(address(0x2863ABc4aF1deB62DDC0B4ff3BEAAcBc045b6426), type(BorrowLogic).creationCode);
    // vm.etch(address(0xcB1478d52628Fa08CF8052f1f7AEe880A17F7D07), type(BridgeLogic).creationCode);
    // vm.etch(address(0x7a4E8Ae07dce3B396963F83f86452fEe5e1cdb6C), type(ConfiguratorLogic).creationCode);
    // vm.etch(address(0xFE5284bb5949b6CAbeb6628220330BaFf2Fab048), type(EModeLogic).creationCode);
    // vm.etch(address(0x4eB3ABC3B010ee4df2506D8D19D05Ff77A0621A3), type(FlashLoanLogic).creationCode);
    // vm.etch(address(0xc52671820Ba91D361Ca79dAAa5ad5a8000f780FF), type(LiquidationLogic).creationCode);
    // vm.etch(address(0x36b6C3A7d9777DA79651558aCBC11BB8A3145858), type(PoolLogic).creationCode);
    // vm.etch(address(0x6F01b9c95D30177eC853490f282aB0c2a0734c86), type(SupplyLogic).creationCode);

    // console.log('BorrowLogic', BorrowLogic);
    // console.log('BridgeLogicLib', BridgeLogicLib);
    // console.log('ConfiguratorLogicLib', ConfiguratorLogicLib);
    // console.log('EModeLogicLib', EModeLogicLib);
    // console.log('FlashLoanLogicLib', FlashLoanLogicLib);
    // console.log('LiquidationLogicLib', LiquidationLogicLib);
    // console.log('PoolLogicLib', PoolLogicLib);
    // console.log('SupplyLogicLib', SupplyLogicLib);
  }
}
