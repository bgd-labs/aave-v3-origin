// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.10;

import {IStaticATokenLM} from './interfaces/IStaticATokenLM.sol';
import {IStataOracle} from './interfaces/IStataOracle.sol';

/**
 * @title StataOracle
 * @author BGD Labs
 * @notice Contract to get asset prices of stata tokens
 */
contract StataOracle is IStataOracle {
  /// @inheritdoc IStataOracle
  function getAssetPrice(address asset) public view returns (uint256) {
    return uint256(IStaticATokenLM(asset).latestAnswer());
  }

  /// @inheritdoc IStataOracle
  function getAssetsPrices(address[] calldata assets) external view returns (uint256[] memory) {
    uint256[] memory prices = new uint256[](assets.length);
    for (uint256 i = 0; i < assets.length; i++) {
      prices[i] = uint256(IStaticATokenLM(assets[i]).latestAnswer());
    }
    return prices;
  }
}
