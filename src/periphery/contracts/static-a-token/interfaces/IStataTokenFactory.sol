// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IStataTokenFactory {
  error NotListedUnderlying(address underlying);

  struct TokenPair {
    address underlying;
    address stataToken;
  }

  /**
   * @notice Creates new StataTokens
   * @param underlyings the addresses of the underlyings to create.
   * @return address[] addresses of the new StataTokens.
   */
  function createStataTokens(address[] memory underlyings) external returns (address[] memory);

  /**
   * @notice Returns all StataTokens deployed via this registry paired with the corresponding underlying.
   * @return address[] list of StataTokens
   */
  function getTokenPairs() external view returns (TokenPair[] memory);

  /**
   * @notice Returns the StataToken for a given underlying.
   * @param underlying the address of the underlying.
   * @return address the StataToken address.
   */
  function getStataToken(address underlying) external view returns (address);
}
