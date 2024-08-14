// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IStataTokenV2 {
  /**
   * @notice Checks if the passed actor is permissioned emergency admin.
   * @param actor The reward to claim
   * @return bool signaling if actor can pause the vault.
   */
  function canPause(address actor) external view returns (bool);

  /**
   * @notice Pauses/unpauses all system's operations
   * @param paused boolean determining if the token should be paused or unpaused
   */
  function setPaused(bool paused) external;
}
