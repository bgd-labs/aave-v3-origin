// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// TODO: let's remove it tbh
/**
 * @title IInitializableStata4626LM
 * @notice Interface for the initialize function on Stata4626LM
 * @author Aave
 **/
interface IInitializableStata4626LM {
  /**
   * @dev Emitted when a Stata4626LM is initialized
   * @param aToken The address of the underlying aToken (aWETH)
   * @param staticATokenName The name of the Static aToken
   * @param staticATokenSymbol The symbol of the Static aToken
   **/
  event Initialized(address indexed aToken, string staticATokenName, string staticATokenSymbol);

  /**
   * @dev Initializes the Stata4626LM
   * @param aToken The address of the underlying aToken (aWETH)
   * @param staticATokenName The name of the Static aToken
   * @param staticATokenSymbol The symbol of the Static aToken
   */
  function initialize(
    address aToken,
    string calldata staticATokenName,
    string calldata staticATokenSymbol
  ) external;
}
