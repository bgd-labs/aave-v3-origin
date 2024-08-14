// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {ERC20Upgradeable, ERC20PermitUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC20PermitUpgradeable.sol';
import {PausableUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol';
import {IRescuable, Rescuable} from 'solidity-utils/contracts/utils/Rescuable.sol';

import {IACLManager} from '../../../core/contracts/interfaces/IACLManager.sol';
import {ERC4626Upgradeable, Stata4626Upgradable, IPool} from './Stata4626Upgradable.sol';
import {ERC20AaveLMUpgradable, IRewardsController} from './ERC20AaveLMUpgradable.sol';
import {IStataMerger} from './interfaces/IStataMerger.sol';

contract StataMerger is
  ERC20PermitUpgradeable,
  ERC20AaveLMUpgradable,
  Stata4626Upgradable,
  PausableUpgradeable,
  Rescuable,
  IStataMerger
{
  constructor(
    IPool pool,
    IRewardsController rewardsController
  ) ERC20AaveLMUpgradable(rewardsController) Stata4626Upgradable(pool) {}
  modifier onlyPauseGuardian() {
    if (!canPause(_msgSender())) revert OnlyPauseGuardian(_msgSender());
    _;
  }

  function initialize(
    address aToken,
    string calldata staticATokenName,
    string calldata staticATokenSymbol
  ) external initializer {
    __ERC20_init(staticATokenName, staticATokenSymbol);
    __ERC20Permit_init(staticATokenName);
    __ERC20AaveLM_init(aToken);
    __Stata4626_init(aToken);
    __Pausable_init();
  }

  ///@inheritdoc IStataMerger
  function setPaused(bool paused) external onlyPauseGuardian {
    if (paused) _pause();
    else _unpause();
  }

  /// @inheritdoc IRescuable
  function whoCanRescue() public view override returns (address) {
    return POOL_ADDRESSES_PROVIDER.getACLAdmin();
  }

  ///@inheritdoc IStataMerger
  function canPause(address actor) public view returns (bool) {
    return IACLManager(POOL_ADDRESSES_PROVIDER.getACLManager()).isEmergencyAdmin(actor);
  }

  function decimals() public view override(ERC20Upgradeable, ERC4626Upgradeable) returns (uint8) {
    return ERC4626Upgradeable.decimals();
  }

  function _claimRewardsOnBehalf(
    address onBehalfOf,
    address receiver,
    address[] memory rewards
  ) internal virtual override whenNotPaused {
    super._claimRewardsOnBehalf(onBehalfOf, receiver, rewards);
  }

  // TODO: double check
  function _update(
    address from,
    address to,
    uint256 amount
  ) internal virtual override(ERC20AaveLMUpgradable, ERC20Upgradeable) whenNotPaused {
    ERC20AaveLMUpgradable._update(from, to, amount);
  }
}
