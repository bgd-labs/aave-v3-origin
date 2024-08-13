// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IERC20} from 'openzeppelin-contracts/contracts/interfaces/IERC20.sol';

interface IStata4626 {
  // TODO: cleanup
  struct SignatureParams {
    uint8 v;
    bytes32 r;
    bytes32 s;
  }

  struct PermitParams {
    uint256 value;
    uint256 deadline;
    uint8 v;
    bytes32 r;
    bytes32 s;
  }

  error StaticATokenInvalidZeroShares();

  error OnlyPauseGuardian(address caller);

  /**
   * @notice Burns `shares` of static aToken, with receiver receiving the corresponding amount of aToken
   * @param shares The shares to withdraw, in static balance of StaticAToken
   * @param receiver The address that will receive the amount of `ASSET` withdrawn from the Aave protocol
   * @return amountToWithdraw: aToken send to `receiver`, dynamic balance
   **/
  function redeemATokens(
    uint256 shares,
    address receiver,
    address owner
  ) external returns (uint256);

  /**
   * @notice Deposits aTokens and mints static aTokens to msg.sender
   * @param assets The amount of aTokens to deposit (e.g. deposit of 100 aUSDC)
   * @param receiver The address that will receive the static aTokens
   * @return uint256 The amount of StaticAToken minted, static balance
   **/
  function depositATokens(uint256 assets, address receiver) external returns (uint256);

  /**
   * @notice The aToken used inside the 4626 vault.
   * @return IERC20 The aToken IERC20.
   */
  function aToken() external view returns (IERC20);

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

  /**
   * @notice Returns the current asset price of the stataToken.
   * The price is calculated as `underlying_price * exchangeRate`.
   * It is important to note that:
   * - `underlying_price` is the price obtained by the aave-oracle and is subject to it's internal pricing mechanisms.
   * - as the price is scaled over the exchangeRate, but maintains the same precision as the underlying the price might be underestimated by 1 unit.
   * - when pricing multiple `shares` as `shares * price` keep in mind that the error compounds.
   * @return price the current asset price.
   */
  function latestAnswer() external view returns (int256);
}
