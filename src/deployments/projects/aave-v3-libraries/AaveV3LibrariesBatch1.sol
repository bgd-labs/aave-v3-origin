// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../../contracts/LibraryReportStorage.sol';
import {Create2Utils} from '../../contracts/utilities/Create2Utils.sol';
import {BorrowLogic} from 'aave-v3-core/contracts/protocol/libraries/logic/BorrowLogic.sol';
import {BridgeLogic} from 'aave-v3-core/contracts/protocol/libraries/logic/BridgeLogic.sol';
import {ConfiguratorLogic} from 'aave-v3-core/contracts/protocol/libraries/logic/ConfiguratorLogic.sol';
import {EModeLogic} from 'aave-v3-core/contracts/protocol/libraries/logic/EModeLogic.sol';

contract AaveV3LibrariesBatch1 is LibraryReportStorage {
  constructor(address create2Factory) {
    _librariesReport = _deployAaveV3Libraries(create2Factory);
  }

  function _deployAaveV3Libraries(address create2Factory) internal returns (LibrariesReport memory libReport) {
    bytes32 salt = keccak256('AAVE_V3_LIBRARIES_BATCH');

    libReport.borrowLogic = Create2Utils._create2Deploy(create2Factory, salt, type(BorrowLogic).creationCode);
    libReport.bridgeLogic = Create2Utils._create2Deploy(create2Factory, salt, type(BridgeLogic).creationCode);
    libReport.configuratorLogic = Create2Utils._create2Deploy(
      create2Factory,
      salt,
      type(ConfiguratorLogic).creationCode
    );
    libReport.eModeLogic = Create2Utils._create2Deploy(create2Factory, salt, type(EModeLogic).creationCode);
    return libReport;
  }
}
