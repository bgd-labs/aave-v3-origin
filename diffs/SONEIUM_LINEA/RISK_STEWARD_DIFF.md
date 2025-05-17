```diff
diff --git a/./downloads/SONEIUM/RISK_STEWARD.sol b/./downloads/LINEA/RISK_STEWARD.sol
index 49fe6f4..cc38507 100644
--- a/./downloads/SONEIUM/RISK_STEWARD.sol
+++ b/./downloads/LINEA/RISK_STEWARD.sol
@@ -1,39 +1,259 @@
 // SPDX-License-Identifier: BUSL-1.1
-pragma solidity >=0.6.0 ^0.8.0 ^0.8.18 ^0.8.20;
+pragma solidity >=0.6.0 ^0.8.0 ^0.8.1 ^0.8.18;
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/dependencies/chainlink/AggregatorInterface.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/src/contracts/oz-common/Address.sol
 
-// Chainlink Contracts v0.8
+// OpenZeppelin Contracts (last updated v4.7.0) (utils/Address.sol)
+// From commit https://github.com/OpenZeppelin/openzeppelin-contracts/commit/8b778fa20d6d76340c5fac1ed66c80273f05b95a
 
-interface AggregatorInterface {
-  function decimals() external view returns (uint8);
+/**
+ * @dev Collection of functions related to the address type
+ */
+library Address {
+  /**
+   * @dev Returns true if `account` is a contract.
+   *
+   * [IMPORTANT]
+   * ====
+   * It is unsafe to assume that an address for which this function returns
+   * false is an externally-owned account (EOA) and not a contract.
+   *
+   * Among others, `isContract` will return false for the following
+   * types of addresses:
+   *
+   *  - an externally-owned account
+   *  - a contract in construction
+   *  - an address where a contract will be created
+   *  - an address where a contract lived, but was destroyed
+   * ====
+   *
+   * [IMPORTANT]
+   * ====
+   * You shouldn't rely on `isContract` to protect against flash loan attacks!
+   *
+   * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
+   * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
+   * constructor.
+   * ====
+   */
+  function isContract(address account) internal view returns (bool) {
+    // This method relies on extcodesize/address.code.length, which returns 0
+    // for contracts in construction, since the code is only stored at the end
+    // of the constructor execution.
 
-  function description() external view returns (string memory);
+    return account.code.length > 0;
+  }
 
-  function getRoundData(
-    uint80 _roundId
-  )
-    external
-    view
-    returns (
-      uint80 roundId,
-      int256 answer,
-      uint256 startedAt,
-      uint256 updatedAt,
-      uint80 answeredInRound
-    );
+  /**
+   * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
+   * `recipient`, forwarding all available gas and reverting on errors.
+   *
+   * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
+   * of certain opcodes, possibly making contracts go over the 2300 gas limit
+   * imposed by `transfer`, making them unable to receive funds via
+   * `transfer`. {sendValue} removes this limitation.
+   *
+   * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
+   *
+   * IMPORTANT: because control is transferred to `recipient`, care must be
+   * taken to not create reentrancy vulnerabilities. Consider using
+   * {ReentrancyGuard} or the
+   * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
+   */
+  function sendValue(address payable recipient, uint256 amount) internal {
+    require(address(this).balance >= amount, 'Address: insufficient balance');
 
-  function latestRoundData()
-    external
-    view
-    returns (
-      uint80 roundId,
-      int256 answer,
-      uint256 startedAt,
-      uint256 updatedAt,
-      uint80 answeredInRound
-    );
+    (bool success, ) = recipient.call{value: amount}('');
+    require(success, 'Address: unable to send value, recipient may have reverted');
+  }
+
+  /**
+   * @dev Performs a Solidity function call using a low level `call`. A
+   * plain `call` is an unsafe replacement for a function call: use this
+   * function instead.
+   *
+   * If `target` reverts with a revert reason, it is bubbled up by this
+   * function (like regular Solidity function calls).
+   *
+   * Returns the raw returned data. To convert to the expected return value,
+   * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
+   *
+   * Requirements:
+   *
+   * - `target` must be a contract.
+   * - calling `target` with `data` must not revert.
+   *
+   * _Available since v3.1._
+   */
+  function functionCall(address target, bytes memory data) internal returns (bytes memory) {
+    return functionCallWithValue(target, data, 0, 'Address: low-level call failed');
+  }
+
+  /**
+   * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
+   * `errorMessage` as a fallback revert reason when `target` reverts.
+   *
+   * _Available since v3.1._
+   */
+  function functionCall(
+    address target,
+    bytes memory data,
+    string memory errorMessage
+  ) internal returns (bytes memory) {
+    return functionCallWithValue(target, data, 0, errorMessage);
+  }
+
+  /**
+   * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
+   * but also transferring `value` wei to `target`.
+   *
+   * Requirements:
+   *
+   * - the calling contract must have an ETH balance of at least `value`.
+   * - the called Solidity function must be `payable`.
+   *
+   * _Available since v3.1._
+   */
+  function functionCallWithValue(
+    address target,
+    bytes memory data,
+    uint256 value
+  ) internal returns (bytes memory) {
+    return functionCallWithValue(target, data, value, 'Address: low-level call with value failed');
+  }
+
+  /**
+   * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
+   * with `errorMessage` as a fallback revert reason when `target` reverts.
+   *
+   * _Available since v3.1._
+   */
+  function functionCallWithValue(
+    address target,
+    bytes memory data,
+    uint256 value,
+    string memory errorMessage
+  ) internal returns (bytes memory) {
+    require(address(this).balance >= value, 'Address: insufficient balance for call');
+    (bool success, bytes memory returndata) = target.call{value: value}(data);
+    return verifyCallResultFromTarget(target, success, returndata, errorMessage);
+  }
+
+  /**
+   * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
+   * but performing a static call.
+   *
+   * _Available since v3.3._
+   */
+  function functionStaticCall(
+    address target,
+    bytes memory data
+  ) internal view returns (bytes memory) {
+    return functionStaticCall(target, data, 'Address: low-level static call failed');
+  }
+
+  /**
+   * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
+   * but performing a static call.
+   *
+   * _Available since v3.3._
+   */
+  function functionStaticCall(
+    address target,
+    bytes memory data,
+    string memory errorMessage
+  ) internal view returns (bytes memory) {
+    (bool success, bytes memory returndata) = target.staticcall(data);
+    return verifyCallResultFromTarget(target, success, returndata, errorMessage);
+  }
+
+  /**
+   * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
+   * but performing a delegate call.
+   *
+   * _Available since v3.4._
+   */
+  function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
+    return functionDelegateCall(target, data, 'Address: low-level delegate call failed');
+  }
+
+  /**
+   * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
+   * but performing a delegate call.
+   *
+   * _Available since v3.4._
+   */
+  function functionDelegateCall(
+    address target,
+    bytes memory data,
+    string memory errorMessage
+  ) internal returns (bytes memory) {
+    (bool success, bytes memory returndata) = target.delegatecall(data);
+    return verifyCallResultFromTarget(target, success, returndata, errorMessage);
+  }
+
+  /**
+   * @dev Tool to verify that a low level call to smart-contract was successful, and revert (either by bubbling
+   * the revert reason or using the provided one) in case of unsuccessful call or if target was not a contract.
+   *
+   * _Available since v4.8._
+   */
+  function verifyCallResultFromTarget(
+    address target,
+    bool success,
+    bytes memory returndata,
+    string memory errorMessage
+  ) internal view returns (bytes memory) {
+    if (success) {
+      if (returndata.length == 0) {
+        // only check isContract if the call was successful and the return data is empty
+        // otherwise we already know that it was a contract
+        require(isContract(target), 'Address: call to non-contract');
+      }
+      return returndata;
+    } else {
+      _revert(returndata, errorMessage);
+    }
+  }
+
+  /**
+   * @dev Tool to verify that a low level call was successful, and revert if it wasn't, either by bubbling the
+   * revert reason or using the provided one.
+   *
+   * _Available since v4.3._
+   */
+  function verifyCallResult(
+    bool success,
+    bytes memory returndata,
+    string memory errorMessage
+  ) internal pure returns (bytes memory) {
+    if (success) {
+      return returndata;
+    } else {
+      _revert(returndata, errorMessage);
+    }
+  }
+
+  function _revert(bytes memory returndata, string memory errorMessage) private pure {
+    // Look for revert reason and bubble it up if present
+    if (returndata.length > 0) {
+      // The easiest way to bubble the revert reason is using memory via assembly
+      /// @solidity memory-safe-assembly
+      assembly {
+        let returndata_size := mload(returndata)
+        revert(add(32, returndata), returndata_size)
+      }
+    } else {
+      revert(errorMessage);
+    }
+  }
+}
+
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/dependencies/chainlink/AggregatorInterface.sol
 
+// Chainlink Contracts v0.8
+
+interface AggregatorInterface {
   function latestAnswer() external view returns (int256);
 
   function latestTimestamp() external view returns (uint256);
@@ -49,7 +269,7 @@ interface AggregatorInterface {
   event NewRound(uint256 indexed roundId, address indexed startedBy, uint256 startedAt);
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/types/ConfiguratorInputTypes.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/types/ConfiguratorInputTypes.sol
 
 library ConfiguratorInputTypes {
   struct InitReserveInput {
@@ -88,9 +308,10 @@ library ConfiguratorInputTypes {
   }
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Context.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/src/contracts/oz-common/Context.sol
 
-// OpenZeppelin Contracts (last updated v5.0.1) (utils/Context.sol)
+// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)
+// From commit https://github.com/OpenZeppelin/openzeppelin-contracts/commit/8b778fa20d6d76340c5fac1ed66c80273f05b95a
 
 /**
  * @dev Provides information about the current execution context, including the
@@ -103,20 +324,16 @@ library ConfiguratorInputTypes {
  * This contract is only required for intermediate, library-like contracts.
  */
 abstract contract Context {
-    function _msgSender() internal view virtual returns (address) {
-        return msg.sender;
-    }
-
-    function _msgData() internal view virtual returns (bytes calldata) {
-        return msg.data;
-    }
+  function _msgSender() internal view virtual returns (address) {
+    return msg.sender;
+  }
 
-    function _contextSuffixLength() internal view virtual returns (uint256) {
-        return 0;
-    }
+  function _msgData() internal view virtual returns (bytes calldata) {
+    return msg.data;
+  }
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/types/DataTypes.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/types/DataTypes.sol
 
 library DataTypes {
   /**
@@ -167,9 +384,8 @@ library DataTypes {
     uint128 variableBorrowIndex;
     //the current variable borrow rate. Expressed in ray
     uint128 currentVariableBorrowRate;
-    /// @notice reused `__deprecatedStableBorrowRate` storage from pre 3.2
-    // the current accumulate deficit in underlying tokens
-    uint128 deficit;
+    // DEPRECATED on v3.2.0
+    uint128 __deprecatedStableBorrowRate;
     //timestamp of last update
     uint40 lastUpdateTimestamp;
     //the id of the reserve. Represents the position in the list of the active reserves
@@ -335,11 +551,6 @@ library DataTypes {
     uint8 userEModeCategory;
   }
 
-  struct ExecuteEliminateDeficitParams {
-    address asset;
-    uint256 amount;
-  }
-
   struct ExecuteSetUserEModeParams {
     uint256 reservesCount;
     address oracle;
@@ -446,7 +657,7 @@ library DataTypes {
   }
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/extensions/v3-config-engine/EngineFlags.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/extensions/v3-config-engine/EngineFlags.sol
 
 library EngineFlags {
   /// @dev magic value to be used as flag to keep unchanged any current configuration
@@ -480,48 +691,14 @@ library EngineFlags {
   }
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Errors.sol
-
-// OpenZeppelin Contracts (last updated v5.1.0) (utils/Errors.sol)
-
-/**
- * @dev Collection of common custom errors used in multiple contracts
- *
- * IMPORTANT: Backwards compatibility is not guaranteed in future versions of the library.
- * It is recommended to avoid relying on the error API for critical functionality.
- *
- * _Available since v5.1._
- */
-library Errors_0 {
-    /**
-     * @dev The ETH balance of the account is not enough to perform the operation.
-     */
-    error InsufficientBalance(uint256 balance, uint256 needed);
-
-    /**
-     * @dev A call to an address target failed. The target may have reverted.
-     */
-    error FailedCall();
-
-    /**
-     * @dev The deployment failed.
-     */
-    error FailedDeployment();
-
-    /**
-     * @dev A necessary precompile is missing.
-     */
-    error MissingPrecompile(address);
-}
-
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/helpers/Errors.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/helpers/Errors.sol
 
 /**
  * @title Errors library
  * @author Aave
  * @notice Defines the error messages emitted by the different contracts of the Aave protocol
  */
-library Errors_1 {
+library Errors {
   string public constant CALLER_NOT_POOL_ADMIN = '1'; // 'The caller of the function is not a pool admin'
   string public constant CALLER_NOT_EMERGENCY_ADMIN = '2'; // 'The caller of the function is not an emergency admin'
   string public constant CALLER_NOT_POOL_OR_EMERGENCY_ADMIN = '3'; // 'The caller of the function is not a pool or emergency admin'
@@ -615,13 +792,9 @@ library Errors_1 {
   string public constant INVALID_GRACE_PERIOD = '98'; // Grace period above a valid range
   string public constant INVALID_FREEZE_STATE = '99'; // Reserve is already in the passed freeze state
   string public constant NOT_BORROWABLE_IN_EMODE = '100'; // Asset not borrowable in eMode
-  string public constant CALLER_NOT_UMBRELLA = '101'; // The caller of the function is not the umbrella contract
-  string public constant RESERVE_NOT_IN_DEFICIT = '102'; // The reserve is not in deficit
-  string public constant MUST_NOT_LEAVE_DUST = '103'; // Below a certain threshold liquidators need to take the full position
-  string public constant USER_CANNOT_HAVE_DEBT = '104'; // Thrown when a user tries to interact with a method that requires a position without debt
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IAaveIncentivesController.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IAaveIncentivesController.sol
 
 /**
  * @title IAaveIncentivesController
@@ -640,7 +813,7 @@ interface IAaveIncentivesController {
   function handleAction(address user, uint256 totalSupply, uint256 userBalance) external;
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/lib/cl-synchronicity-price-adapter/src/interfaces/ICLSynchronicityPriceAdapter.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-capo/lib/cl-synchronicity-price-adapter/src/interfaces/ICLSynchronicityPriceAdapter.sol
 
 interface ICLSynchronicityPriceAdapter {
   /**
@@ -666,7 +839,7 @@ interface ICLSynchronicityPriceAdapter {
   error RatioOutOfBounds();
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/lib/cl-synchronicity-price-adapter/src/interfaces/IChainlinkAggregator.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-capo/lib/cl-synchronicity-price-adapter/src/interfaces/IChainlinkAggregator.sol
 
 interface IChainlinkAggregator {
   function decimals() external view returns (uint8);
@@ -685,12 +858,12 @@ interface IChainlinkAggregator {
   event NewRound(uint256 indexed roundId, address indexed startedBy);
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
 
 /**
  * @dev Interface of the ERC20 standard as defined in the EIP.
  */
-interface IERC20_0 {
+interface IERC20 {
   /**
    * @dev Returns the amount of tokens in existence.
    */
@@ -761,92 +934,7 @@ interface IERC20_0 {
   event Approval(address indexed owner, address indexed spender, uint256 value);
 }
 
-// lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol
-
-// OpenZeppelin Contracts (last updated v5.1.0) (token/ERC20/IERC20.sol)
-
-/**
- * @dev Interface of the ERC-20 standard as defined in the ERC.
- */
-interface IERC20_1 {
-    /**
-     * @dev Emitted when `value` tokens are moved from one account (`from`) to
-     * another (`to`).
-     *
-     * Note that `value` may be zero.
-     */
-    event Transfer(address indexed from, address indexed to, uint256 value);
-
-    /**
-     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
-     * a call to {approve}. `value` is the new allowance.
-     */
-    event Approval(address indexed owner, address indexed spender, uint256 value);
-
-    /**
-     * @dev Returns the value of tokens in existence.
-     */
-    function totalSupply() external view returns (uint256);
-
-    /**
-     * @dev Returns the value of tokens owned by `account`.
-     */
-    function balanceOf(address account) external view returns (uint256);
-
-    /**
-     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
-     *
-     * Returns a boolean value indicating whether the operation succeeded.
-     *
-     * Emits a {Transfer} event.
-     */
-    function transfer(address to, uint256 value) external returns (bool);
-
-    /**
-     * @dev Returns the remaining number of tokens that `spender` will be
-     * allowed to spend on behalf of `owner` through {transferFrom}. This is
-     * zero by default.
-     *
-     * This value changes when {approve} or {transferFrom} are called.
-     */
-    function allowance(address owner, address spender) external view returns (uint256);
-
-    /**
-     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
-     * caller's tokens.
-     *
-     * Returns a boolean value indicating whether the operation succeeded.
-     *
-     * IMPORTANT: Beware that changing an allowance with this method brings the risk
-     * that someone may use both the old and the new allowance by unfortunate
-     * transaction ordering. One possible solution to mitigate this race
-     * condition is to first reduce the spender's allowance to 0 and set the
-     * desired value afterwards:
-     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
-     *
-     * Emits an {Approval} event.
-     */
-    function approve(address spender, uint256 value) external returns (bool);
-
-    /**
-     * @dev Moves a `value` amount of tokens from `from` to `to` using the
-     * allowance mechanism. `value` is then deducted from the caller's
-     * allowance.
-     *
-     * Returns a boolean value indicating whether the operation succeeded.
-     *
-     * Emits a {Transfer} event.
-     */
-    function transferFrom(address from, address to, uint256 value) external returns (bool);
-}
-
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/src/interfaces/IPendlePrincipalToken.sol
-
-interface IPendlePrincipalToken {
-  function expiry() external view returns (uint256);
-}
-
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPoolAddressesProvider.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPoolAddressesProvider.sol
 
 /**
  * @title IPoolAddressesProvider
@@ -1073,7 +1161,7 @@ interface IPoolAddressesProvider {
   function setPoolDataProvider(address newDataProvider) external;
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPriceOracleGetter.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPriceOracleGetter.sol
 
 /**
  * @title IPriceOracleGetter
@@ -1103,7 +1191,7 @@ interface IPriceOracleGetter {
   function getAssetPrice(address asset) external view returns (uint256);
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IScaledBalanceToken.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IScaledBalanceToken.sol
 
 /**
  * @title IScaledBalanceToken
@@ -1175,70 +1263,13 @@ interface IScaledBalanceToken {
   function getPreviousIndex(address user) external view returns (uint256);
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Panic.sol
-
-// OpenZeppelin Contracts (last updated v5.1.0) (utils/Panic.sol)
-
-/**
- * @dev Helper library for emitting standardized panic codes.
- *
- * ```solidity
- * contract Example {
- *      using Panic for uint256;
- *
- *      // Use any of the declared internal constants
- *      function foo() { Panic.GENERIC.panic(); }
- *
- *      // Alternatively
- *      function foo() { Panic.panic(Panic.GENERIC); }
- * }
- * ```
- *
- * Follows the list from https://github.com/ethereum/solidity/blob/v0.8.24/libsolutil/ErrorCodes.h[libsolutil].
- *
- * _Available since v5.1._
- */
-// slither-disable-next-line unused-state
-library Panic {
-    /// @dev generic / unspecified error
-    uint256 internal constant GENERIC = 0x00;
-    /// @dev used by the assert() builtin
-    uint256 internal constant ASSERT = 0x01;
-    /// @dev arithmetic underflow or overflow
-    uint256 internal constant UNDER_OVERFLOW = 0x11;
-    /// @dev division or modulo by zero
-    uint256 internal constant DIVISION_BY_ZERO = 0x12;
-    /// @dev enum conversion error
-    uint256 internal constant ENUM_CONVERSION_ERROR = 0x21;
-    /// @dev invalid encoding in storage
-    uint256 internal constant STORAGE_ENCODING_ERROR = 0x22;
-    /// @dev empty array pop
-    uint256 internal constant EMPTY_ARRAY_POP = 0x31;
-    /// @dev array out of bounds access
-    uint256 internal constant ARRAY_OUT_OF_BOUNDS = 0x32;
-    /// @dev resource error (too large allocation or too large array)
-    uint256 internal constant RESOURCE_ERROR = 0x41;
-    /// @dev calling invalid internal function
-    uint256 internal constant INVALID_INTERNAL_FUNCTION = 0x51;
-
-    /// @dev Reverts with a panic code. Recommended to use with
-    /// the internal constants with predefined codes.
-    function panic(uint256 code) internal pure {
-        assembly ("memory-safe") {
-            mstore(0x00, 0x4e487b71)
-            mstore(0x20, code)
-            revert(0x1c, 0x24)
-        }
-    }
-}
-
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/src/contracts/oz-common/SafeCast.sol
 
-// OpenZeppelin Contracts (last updated v5.1.0) (utils/math/SafeCast.sol)
+// OpenZeppelin Contracts (last updated v4.8.0) (utils/math/SafeCast.sol)
 // This file was procedurally generated from scripts/generate/templates/SafeCast.js.
 
 /**
- * @dev Wrappers over Solidity's uintXX/intXX/bool casting operators with added overflow
+ * @dev Wrappers over Solidity's uintXX/intXX casting operators with added overflow
  * checks.
  *
  * Downcasting from uint256/int256 in Solidity does not revert on overflow. This can
@@ -1248,4336 +1279,2556 @@ library Panic {
  *
  * Using this library instead of the unchecked operations eliminates an entire
  * class of bugs, so it's recommended to use it always.
+ *
+ * Can be combined with {SafeMath} and {SignedSafeMath} to extend it to smaller types, by performing
+ * all math on `uint256` and `int256` and then downcasting.
  */
 library SafeCast {
-    /**
-     * @dev Value doesn't fit in an uint of `bits` size.
-     */
-    error SafeCastOverflowedUintDowncast(uint8 bits, uint256 value);
+  /**
+   * @dev Returns the downcasted uint248 from uint256, reverting on
+   * overflow (when the input is greater than largest uint248).
+   *
+   * Counterpart to Solidity's `uint248` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 248 bits
+   *
+   * _Available since v4.7._
+   */
+  function toUint248(uint256 value) internal pure returns (uint248) {
+    require(value <= type(uint248).max, "SafeCast: value doesn't fit in 248 bits");
+    return uint248(value);
+  }
 
-    /**
-     * @dev An int value doesn't fit in an uint of `bits` size.
-     */
-    error SafeCastOverflowedIntToUint(int256 value);
+  /**
+   * @dev Returns the downcasted uint240 from uint256, reverting on
+   * overflow (when the input is greater than largest uint240).
+   *
+   * Counterpart to Solidity's `uint240` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 240 bits
+   *
+   * _Available since v4.7._
+   */
+  function toUint240(uint256 value) internal pure returns (uint240) {
+    require(value <= type(uint240).max, "SafeCast: value doesn't fit in 240 bits");
+    return uint240(value);
+  }
 
-    /**
-     * @dev Value doesn't fit in an int of `bits` size.
-     */
-    error SafeCastOverflowedIntDowncast(uint8 bits, int256 value);
+  /**
+   * @dev Returns the downcasted uint232 from uint256, reverting on
+   * overflow (when the input is greater than largest uint232).
+   *
+   * Counterpart to Solidity's `uint232` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 232 bits
+   *
+   * _Available since v4.7._
+   */
+  function toUint232(uint256 value) internal pure returns (uint232) {
+    require(value <= type(uint232).max, "SafeCast: value doesn't fit in 232 bits");
+    return uint232(value);
+  }
 
-    /**
-     * @dev An uint value doesn't fit in an int of `bits` size.
-     */
-    error SafeCastOverflowedUintToInt(uint256 value);
+  /**
+   * @dev Returns the downcasted uint224 from uint256, reverting on
+   * overflow (when the input is greater than largest uint224).
+   *
+   * Counterpart to Solidity's `uint224` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 224 bits
+   *
+   * _Available since v4.2._
+   */
+  function toUint224(uint256 value) internal pure returns (uint224) {
+    require(value <= type(uint224).max, "SafeCast: value doesn't fit in 224 bits");
+    return uint224(value);
+  }
 
-    /**
-     * @dev Returns the downcasted uint248 from uint256, reverting on
-     * overflow (when the input is greater than largest uint248).
-     *
-     * Counterpart to Solidity's `uint248` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 248 bits
-     */
-    function toUint248(uint256 value) internal pure returns (uint248) {
-        if (value > type(uint248).max) {
-            revert SafeCastOverflowedUintDowncast(248, value);
-        }
-        return uint248(value);
-    }
+  /**
+   * @dev Returns the downcasted uint216 from uint256, reverting on
+   * overflow (when the input is greater than largest uint216).
+   *
+   * Counterpart to Solidity's `uint216` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 216 bits
+   *
+   * _Available since v4.7._
+   */
+  function toUint216(uint256 value) internal pure returns (uint216) {
+    require(value <= type(uint216).max, "SafeCast: value doesn't fit in 216 bits");
+    return uint216(value);
+  }
 
-    /**
-     * @dev Returns the downcasted uint240 from uint256, reverting on
-     * overflow (when the input is greater than largest uint240).
-     *
-     * Counterpart to Solidity's `uint240` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 240 bits
-     */
-    function toUint240(uint256 value) internal pure returns (uint240) {
-        if (value > type(uint240).max) {
-            revert SafeCastOverflowedUintDowncast(240, value);
-        }
-        return uint240(value);
-    }
+  /**
+   * @dev Returns the downcasted uint208 from uint256, reverting on
+   * overflow (when the input is greater than largest uint208).
+   *
+   * Counterpart to Solidity's `uint208` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 208 bits
+   *
+   * _Available since v4.7._
+   */
+  function toUint208(uint256 value) internal pure returns (uint208) {
+    require(value <= type(uint208).max, "SafeCast: value doesn't fit in 208 bits");
+    return uint208(value);
+  }
 
-    /**
-     * @dev Returns the downcasted uint232 from uint256, reverting on
-     * overflow (when the input is greater than largest uint232).
-     *
-     * Counterpart to Solidity's `uint232` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 232 bits
-     */
-    function toUint232(uint256 value) internal pure returns (uint232) {
-        if (value > type(uint232).max) {
-            revert SafeCastOverflowedUintDowncast(232, value);
-        }
-        return uint232(value);
-    }
+  /**
+   * @dev Returns the downcasted uint200 from uint256, reverting on
+   * overflow (when the input is greater than largest uint200).
+   *
+   * Counterpart to Solidity's `uint200` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 200 bits
+   *
+   * _Available since v4.7._
+   */
+  function toUint200(uint256 value) internal pure returns (uint200) {
+    require(value <= type(uint200).max, "SafeCast: value doesn't fit in 200 bits");
+    return uint200(value);
+  }
 
-    /**
-     * @dev Returns the downcasted uint224 from uint256, reverting on
-     * overflow (when the input is greater than largest uint224).
-     *
-     * Counterpart to Solidity's `uint224` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 224 bits
-     */
-    function toUint224(uint256 value) internal pure returns (uint224) {
-        if (value > type(uint224).max) {
-            revert SafeCastOverflowedUintDowncast(224, value);
-        }
-        return uint224(value);
-    }
+  /**
+   * @dev Returns the downcasted uint192 from uint256, reverting on
+   * overflow (when the input is greater than largest uint192).
+   *
+   * Counterpart to Solidity's `uint192` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 192 bits
+   *
+   * _Available since v4.7._
+   */
+  function toUint192(uint256 value) internal pure returns (uint192) {
+    require(value <= type(uint192).max, "SafeCast: value doesn't fit in 192 bits");
+    return uint192(value);
+  }
 
-    /**
-     * @dev Returns the downcasted uint216 from uint256, reverting on
-     * overflow (when the input is greater than largest uint216).
-     *
-     * Counterpart to Solidity's `uint216` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 216 bits
-     */
-    function toUint216(uint256 value) internal pure returns (uint216) {
-        if (value > type(uint216).max) {
-            revert SafeCastOverflowedUintDowncast(216, value);
-        }
-        return uint216(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint208 from uint256, reverting on
-     * overflow (when the input is greater than largest uint208).
-     *
-     * Counterpart to Solidity's `uint208` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 208 bits
-     */
-    function toUint208(uint256 value) internal pure returns (uint208) {
-        if (value > type(uint208).max) {
-            revert SafeCastOverflowedUintDowncast(208, value);
-        }
-        return uint208(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint200 from uint256, reverting on
-     * overflow (when the input is greater than largest uint200).
-     *
-     * Counterpart to Solidity's `uint200` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 200 bits
-     */
-    function toUint200(uint256 value) internal pure returns (uint200) {
-        if (value > type(uint200).max) {
-            revert SafeCastOverflowedUintDowncast(200, value);
-        }
-        return uint200(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint192 from uint256, reverting on
-     * overflow (when the input is greater than largest uint192).
-     *
-     * Counterpart to Solidity's `uint192` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 192 bits
-     */
-    function toUint192(uint256 value) internal pure returns (uint192) {
-        if (value > type(uint192).max) {
-            revert SafeCastOverflowedUintDowncast(192, value);
-        }
-        return uint192(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint184 from uint256, reverting on
-     * overflow (when the input is greater than largest uint184).
-     *
-     * Counterpart to Solidity's `uint184` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 184 bits
-     */
-    function toUint184(uint256 value) internal pure returns (uint184) {
-        if (value > type(uint184).max) {
-            revert SafeCastOverflowedUintDowncast(184, value);
-        }
-        return uint184(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint176 from uint256, reverting on
-     * overflow (when the input is greater than largest uint176).
-     *
-     * Counterpart to Solidity's `uint176` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 176 bits
-     */
-    function toUint176(uint256 value) internal pure returns (uint176) {
-        if (value > type(uint176).max) {
-            revert SafeCastOverflowedUintDowncast(176, value);
-        }
-        return uint176(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint168 from uint256, reverting on
-     * overflow (when the input is greater than largest uint168).
-     *
-     * Counterpart to Solidity's `uint168` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 168 bits
-     */
-    function toUint168(uint256 value) internal pure returns (uint168) {
-        if (value > type(uint168).max) {
-            revert SafeCastOverflowedUintDowncast(168, value);
-        }
-        return uint168(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint160 from uint256, reverting on
-     * overflow (when the input is greater than largest uint160).
-     *
-     * Counterpart to Solidity's `uint160` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 160 bits
-     */
-    function toUint160(uint256 value) internal pure returns (uint160) {
-        if (value > type(uint160).max) {
-            revert SafeCastOverflowedUintDowncast(160, value);
-        }
-        return uint160(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint152 from uint256, reverting on
-     * overflow (when the input is greater than largest uint152).
-     *
-     * Counterpart to Solidity's `uint152` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 152 bits
-     */
-    function toUint152(uint256 value) internal pure returns (uint152) {
-        if (value > type(uint152).max) {
-            revert SafeCastOverflowedUintDowncast(152, value);
-        }
-        return uint152(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint144 from uint256, reverting on
-     * overflow (when the input is greater than largest uint144).
-     *
-     * Counterpart to Solidity's `uint144` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 144 bits
-     */
-    function toUint144(uint256 value) internal pure returns (uint144) {
-        if (value > type(uint144).max) {
-            revert SafeCastOverflowedUintDowncast(144, value);
-        }
-        return uint144(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint136 from uint256, reverting on
-     * overflow (when the input is greater than largest uint136).
-     *
-     * Counterpart to Solidity's `uint136` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 136 bits
-     */
-    function toUint136(uint256 value) internal pure returns (uint136) {
-        if (value > type(uint136).max) {
-            revert SafeCastOverflowedUintDowncast(136, value);
-        }
-        return uint136(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint128 from uint256, reverting on
-     * overflow (when the input is greater than largest uint128).
-     *
-     * Counterpart to Solidity's `uint128` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 128 bits
-     */
-    function toUint128(uint256 value) internal pure returns (uint128) {
-        if (value > type(uint128).max) {
-            revert SafeCastOverflowedUintDowncast(128, value);
-        }
-        return uint128(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint120 from uint256, reverting on
-     * overflow (when the input is greater than largest uint120).
-     *
-     * Counterpart to Solidity's `uint120` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 120 bits
-     */
-    function toUint120(uint256 value) internal pure returns (uint120) {
-        if (value > type(uint120).max) {
-            revert SafeCastOverflowedUintDowncast(120, value);
-        }
-        return uint120(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint112 from uint256, reverting on
-     * overflow (when the input is greater than largest uint112).
-     *
-     * Counterpart to Solidity's `uint112` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 112 bits
-     */
-    function toUint112(uint256 value) internal pure returns (uint112) {
-        if (value > type(uint112).max) {
-            revert SafeCastOverflowedUintDowncast(112, value);
-        }
-        return uint112(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint104 from uint256, reverting on
-     * overflow (when the input is greater than largest uint104).
-     *
-     * Counterpart to Solidity's `uint104` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 104 bits
-     */
-    function toUint104(uint256 value) internal pure returns (uint104) {
-        if (value > type(uint104).max) {
-            revert SafeCastOverflowedUintDowncast(104, value);
-        }
-        return uint104(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint96 from uint256, reverting on
-     * overflow (when the input is greater than largest uint96).
-     *
-     * Counterpart to Solidity's `uint96` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 96 bits
-     */
-    function toUint96(uint256 value) internal pure returns (uint96) {
-        if (value > type(uint96).max) {
-            revert SafeCastOverflowedUintDowncast(96, value);
-        }
-        return uint96(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint88 from uint256, reverting on
-     * overflow (when the input is greater than largest uint88).
-     *
-     * Counterpart to Solidity's `uint88` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 88 bits
-     */
-    function toUint88(uint256 value) internal pure returns (uint88) {
-        if (value > type(uint88).max) {
-            revert SafeCastOverflowedUintDowncast(88, value);
-        }
-        return uint88(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint80 from uint256, reverting on
-     * overflow (when the input is greater than largest uint80).
-     *
-     * Counterpart to Solidity's `uint80` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 80 bits
-     */
-    function toUint80(uint256 value) internal pure returns (uint80) {
-        if (value > type(uint80).max) {
-            revert SafeCastOverflowedUintDowncast(80, value);
-        }
-        return uint80(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint72 from uint256, reverting on
-     * overflow (when the input is greater than largest uint72).
-     *
-     * Counterpart to Solidity's `uint72` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 72 bits
-     */
-    function toUint72(uint256 value) internal pure returns (uint72) {
-        if (value > type(uint72).max) {
-            revert SafeCastOverflowedUintDowncast(72, value);
-        }
-        return uint72(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint64 from uint256, reverting on
-     * overflow (when the input is greater than largest uint64).
-     *
-     * Counterpart to Solidity's `uint64` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 64 bits
-     */
-    function toUint64(uint256 value) internal pure returns (uint64) {
-        if (value > type(uint64).max) {
-            revert SafeCastOverflowedUintDowncast(64, value);
-        }
-        return uint64(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint56 from uint256, reverting on
-     * overflow (when the input is greater than largest uint56).
-     *
-     * Counterpart to Solidity's `uint56` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 56 bits
-     */
-    function toUint56(uint256 value) internal pure returns (uint56) {
-        if (value > type(uint56).max) {
-            revert SafeCastOverflowedUintDowncast(56, value);
-        }
-        return uint56(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint48 from uint256, reverting on
-     * overflow (when the input is greater than largest uint48).
-     *
-     * Counterpart to Solidity's `uint48` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 48 bits
-     */
-    function toUint48(uint256 value) internal pure returns (uint48) {
-        if (value > type(uint48).max) {
-            revert SafeCastOverflowedUintDowncast(48, value);
-        }
-        return uint48(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint40 from uint256, reverting on
-     * overflow (when the input is greater than largest uint40).
-     *
-     * Counterpart to Solidity's `uint40` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 40 bits
-     */
-    function toUint40(uint256 value) internal pure returns (uint40) {
-        if (value > type(uint40).max) {
-            revert SafeCastOverflowedUintDowncast(40, value);
-        }
-        return uint40(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint32 from uint256, reverting on
-     * overflow (when the input is greater than largest uint32).
-     *
-     * Counterpart to Solidity's `uint32` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 32 bits
-     */
-    function toUint32(uint256 value) internal pure returns (uint32) {
-        if (value > type(uint32).max) {
-            revert SafeCastOverflowedUintDowncast(32, value);
-        }
-        return uint32(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint24 from uint256, reverting on
-     * overflow (when the input is greater than largest uint24).
-     *
-     * Counterpart to Solidity's `uint24` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 24 bits
-     */
-    function toUint24(uint256 value) internal pure returns (uint24) {
-        if (value > type(uint24).max) {
-            revert SafeCastOverflowedUintDowncast(24, value);
-        }
-        return uint24(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint16 from uint256, reverting on
-     * overflow (when the input is greater than largest uint16).
-     *
-     * Counterpart to Solidity's `uint16` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 16 bits
-     */
-    function toUint16(uint256 value) internal pure returns (uint16) {
-        if (value > type(uint16).max) {
-            revert SafeCastOverflowedUintDowncast(16, value);
-        }
-        return uint16(value);
-    }
-
-    /**
-     * @dev Returns the downcasted uint8 from uint256, reverting on
-     * overflow (when the input is greater than largest uint8).
-     *
-     * Counterpart to Solidity's `uint8` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 8 bits
-     */
-    function toUint8(uint256 value) internal pure returns (uint8) {
-        if (value > type(uint8).max) {
-            revert SafeCastOverflowedUintDowncast(8, value);
-        }
-        return uint8(value);
-    }
-
-    /**
-     * @dev Converts a signed int256 into an unsigned uint256.
-     *
-     * Requirements:
-     *
-     * - input must be greater than or equal to 0.
-     */
-    function toUint256(int256 value) internal pure returns (uint256) {
-        if (value < 0) {
-            revert SafeCastOverflowedIntToUint(value);
-        }
-        return uint256(value);
-    }
-
-    /**
-     * @dev Returns the downcasted int248 from int256, reverting on
-     * overflow (when the input is less than smallest int248 or
-     * greater than largest int248).
-     *
-     * Counterpart to Solidity's `int248` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 248 bits
-     */
-    function toInt248(int256 value) internal pure returns (int248 downcasted) {
-        downcasted = int248(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(248, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int240 from int256, reverting on
-     * overflow (when the input is less than smallest int240 or
-     * greater than largest int240).
-     *
-     * Counterpart to Solidity's `int240` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 240 bits
-     */
-    function toInt240(int256 value) internal pure returns (int240 downcasted) {
-        downcasted = int240(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(240, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int232 from int256, reverting on
-     * overflow (when the input is less than smallest int232 or
-     * greater than largest int232).
-     *
-     * Counterpart to Solidity's `int232` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 232 bits
-     */
-    function toInt232(int256 value) internal pure returns (int232 downcasted) {
-        downcasted = int232(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(232, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int224 from int256, reverting on
-     * overflow (when the input is less than smallest int224 or
-     * greater than largest int224).
-     *
-     * Counterpart to Solidity's `int224` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 224 bits
-     */
-    function toInt224(int256 value) internal pure returns (int224 downcasted) {
-        downcasted = int224(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(224, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int216 from int256, reverting on
-     * overflow (when the input is less than smallest int216 or
-     * greater than largest int216).
-     *
-     * Counterpart to Solidity's `int216` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 216 bits
-     */
-    function toInt216(int256 value) internal pure returns (int216 downcasted) {
-        downcasted = int216(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(216, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int208 from int256, reverting on
-     * overflow (when the input is less than smallest int208 or
-     * greater than largest int208).
-     *
-     * Counterpart to Solidity's `int208` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 208 bits
-     */
-    function toInt208(int256 value) internal pure returns (int208 downcasted) {
-        downcasted = int208(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(208, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int200 from int256, reverting on
-     * overflow (when the input is less than smallest int200 or
-     * greater than largest int200).
-     *
-     * Counterpart to Solidity's `int200` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 200 bits
-     */
-    function toInt200(int256 value) internal pure returns (int200 downcasted) {
-        downcasted = int200(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(200, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int192 from int256, reverting on
-     * overflow (when the input is less than smallest int192 or
-     * greater than largest int192).
-     *
-     * Counterpart to Solidity's `int192` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 192 bits
-     */
-    function toInt192(int256 value) internal pure returns (int192 downcasted) {
-        downcasted = int192(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(192, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int184 from int256, reverting on
-     * overflow (when the input is less than smallest int184 or
-     * greater than largest int184).
-     *
-     * Counterpart to Solidity's `int184` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 184 bits
-     */
-    function toInt184(int256 value) internal pure returns (int184 downcasted) {
-        downcasted = int184(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(184, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int176 from int256, reverting on
-     * overflow (when the input is less than smallest int176 or
-     * greater than largest int176).
-     *
-     * Counterpart to Solidity's `int176` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 176 bits
-     */
-    function toInt176(int256 value) internal pure returns (int176 downcasted) {
-        downcasted = int176(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(176, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int168 from int256, reverting on
-     * overflow (when the input is less than smallest int168 or
-     * greater than largest int168).
-     *
-     * Counterpart to Solidity's `int168` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 168 bits
-     */
-    function toInt168(int256 value) internal pure returns (int168 downcasted) {
-        downcasted = int168(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(168, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int160 from int256, reverting on
-     * overflow (when the input is less than smallest int160 or
-     * greater than largest int160).
-     *
-     * Counterpart to Solidity's `int160` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 160 bits
-     */
-    function toInt160(int256 value) internal pure returns (int160 downcasted) {
-        downcasted = int160(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(160, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int152 from int256, reverting on
-     * overflow (when the input is less than smallest int152 or
-     * greater than largest int152).
-     *
-     * Counterpart to Solidity's `int152` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 152 bits
-     */
-    function toInt152(int256 value) internal pure returns (int152 downcasted) {
-        downcasted = int152(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(152, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int144 from int256, reverting on
-     * overflow (when the input is less than smallest int144 or
-     * greater than largest int144).
-     *
-     * Counterpart to Solidity's `int144` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 144 bits
-     */
-    function toInt144(int256 value) internal pure returns (int144 downcasted) {
-        downcasted = int144(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(144, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int136 from int256, reverting on
-     * overflow (when the input is less than smallest int136 or
-     * greater than largest int136).
-     *
-     * Counterpart to Solidity's `int136` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 136 bits
-     */
-    function toInt136(int256 value) internal pure returns (int136 downcasted) {
-        downcasted = int136(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(136, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int128 from int256, reverting on
-     * overflow (when the input is less than smallest int128 or
-     * greater than largest int128).
-     *
-     * Counterpart to Solidity's `int128` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 128 bits
-     */
-    function toInt128(int256 value) internal pure returns (int128 downcasted) {
-        downcasted = int128(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(128, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int120 from int256, reverting on
-     * overflow (when the input is less than smallest int120 or
-     * greater than largest int120).
-     *
-     * Counterpart to Solidity's `int120` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 120 bits
-     */
-    function toInt120(int256 value) internal pure returns (int120 downcasted) {
-        downcasted = int120(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(120, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int112 from int256, reverting on
-     * overflow (when the input is less than smallest int112 or
-     * greater than largest int112).
-     *
-     * Counterpart to Solidity's `int112` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 112 bits
-     */
-    function toInt112(int256 value) internal pure returns (int112 downcasted) {
-        downcasted = int112(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(112, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int104 from int256, reverting on
-     * overflow (when the input is less than smallest int104 or
-     * greater than largest int104).
-     *
-     * Counterpart to Solidity's `int104` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 104 bits
-     */
-    function toInt104(int256 value) internal pure returns (int104 downcasted) {
-        downcasted = int104(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(104, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int96 from int256, reverting on
-     * overflow (when the input is less than smallest int96 or
-     * greater than largest int96).
-     *
-     * Counterpart to Solidity's `int96` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 96 bits
-     */
-    function toInt96(int256 value) internal pure returns (int96 downcasted) {
-        downcasted = int96(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(96, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int88 from int256, reverting on
-     * overflow (when the input is less than smallest int88 or
-     * greater than largest int88).
-     *
-     * Counterpart to Solidity's `int88` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 88 bits
-     */
-    function toInt88(int256 value) internal pure returns (int88 downcasted) {
-        downcasted = int88(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(88, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int80 from int256, reverting on
-     * overflow (when the input is less than smallest int80 or
-     * greater than largest int80).
-     *
-     * Counterpart to Solidity's `int80` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 80 bits
-     */
-    function toInt80(int256 value) internal pure returns (int80 downcasted) {
-        downcasted = int80(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(80, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int72 from int256, reverting on
-     * overflow (when the input is less than smallest int72 or
-     * greater than largest int72).
-     *
-     * Counterpart to Solidity's `int72` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 72 bits
-     */
-    function toInt72(int256 value) internal pure returns (int72 downcasted) {
-        downcasted = int72(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(72, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int64 from int256, reverting on
-     * overflow (when the input is less than smallest int64 or
-     * greater than largest int64).
-     *
-     * Counterpart to Solidity's `int64` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 64 bits
-     */
-    function toInt64(int256 value) internal pure returns (int64 downcasted) {
-        downcasted = int64(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(64, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int56 from int256, reverting on
-     * overflow (when the input is less than smallest int56 or
-     * greater than largest int56).
-     *
-     * Counterpart to Solidity's `int56` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 56 bits
-     */
-    function toInt56(int256 value) internal pure returns (int56 downcasted) {
-        downcasted = int56(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(56, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int48 from int256, reverting on
-     * overflow (when the input is less than smallest int48 or
-     * greater than largest int48).
-     *
-     * Counterpart to Solidity's `int48` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 48 bits
-     */
-    function toInt48(int256 value) internal pure returns (int48 downcasted) {
-        downcasted = int48(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(48, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int40 from int256, reverting on
-     * overflow (when the input is less than smallest int40 or
-     * greater than largest int40).
-     *
-     * Counterpart to Solidity's `int40` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 40 bits
-     */
-    function toInt40(int256 value) internal pure returns (int40 downcasted) {
-        downcasted = int40(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(40, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int32 from int256, reverting on
-     * overflow (when the input is less than smallest int32 or
-     * greater than largest int32).
-     *
-     * Counterpart to Solidity's `int32` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 32 bits
-     */
-    function toInt32(int256 value) internal pure returns (int32 downcasted) {
-        downcasted = int32(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(32, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int24 from int256, reverting on
-     * overflow (when the input is less than smallest int24 or
-     * greater than largest int24).
-     *
-     * Counterpart to Solidity's `int24` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 24 bits
-     */
-    function toInt24(int256 value) internal pure returns (int24 downcasted) {
-        downcasted = int24(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(24, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int16 from int256, reverting on
-     * overflow (when the input is less than smallest int16 or
-     * greater than largest int16).
-     *
-     * Counterpart to Solidity's `int16` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 16 bits
-     */
-    function toInt16(int256 value) internal pure returns (int16 downcasted) {
-        downcasted = int16(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(16, value);
-        }
-    }
-
-    /**
-     * @dev Returns the downcasted int8 from int256, reverting on
-     * overflow (when the input is less than smallest int8 or
-     * greater than largest int8).
-     *
-     * Counterpart to Solidity's `int8` operator.
-     *
-     * Requirements:
-     *
-     * - input must fit into 8 bits
-     */
-    function toInt8(int256 value) internal pure returns (int8 downcasted) {
-        downcasted = int8(value);
-        if (downcasted != value) {
-            revert SafeCastOverflowedIntDowncast(8, value);
-        }
-    }
-
-    /**
-     * @dev Converts an unsigned uint256 into a signed int256.
-     *
-     * Requirements:
-     *
-     * - input must be less than or equal to maxInt256.
-     */
-    function toInt256(uint256 value) internal pure returns (int256) {
-        // Note: Unsafe cast below is okay because `type(int256).max` is guaranteed to be positive
-        if (value > uint256(type(int256).max)) {
-            revert SafeCastOverflowedUintToInt(value);
-        }
-        return int256(value);
-    }
-
-    /**
-     * @dev Cast a boolean (false or true) to a uint256 (0 or 1) with no jump.
-     */
-    function toUint(bool b) internal pure returns (uint256 u) {
-        assembly ("memory-safe") {
-            u := iszero(iszero(b))
-        }
-    }
-}
-
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol
-
-// OpenZeppelin Contracts (last updated v5.1.0) (utils/Address.sol)
-
-/**
- * @dev Collection of functions related to the address type
- */
-library Address {
-    /**
-     * @dev There's no code at `target` (it is not a contract).
-     */
-    error AddressEmptyCode(address target);
-
-    /**
-     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
-     * `recipient`, forwarding all available gas and reverting on errors.
-     *
-     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
-     * of certain opcodes, possibly making contracts go over the 2300 gas limit
-     * imposed by `transfer`, making them unable to receive funds via
-     * `transfer`. {sendValue} removes this limitation.
-     *
-     * https://consensys.net/diligence/blog/2019/09/stop-using-soliditys-transfer-now/[Learn more].
-     *
-     * IMPORTANT: because control is transferred to `recipient`, care must be
-     * taken to not create reentrancy vulnerabilities. Consider using
-     * {ReentrancyGuard} or the
-     * https://solidity.readthedocs.io/en/v0.8.20/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
-     */
-    function sendValue(address payable recipient, uint256 amount) internal {
-        if (address(this).balance < amount) {
-            revert Errors_0.InsufficientBalance(address(this).balance, amount);
-        }
-
-        (bool success, ) = recipient.call{value: amount}("");
-        if (!success) {
-            revert Errors_0.FailedCall();
-        }
-    }
-
-    /**
-     * @dev Performs a Solidity function call using a low level `call`. A
-     * plain `call` is an unsafe replacement for a function call: use this
-     * function instead.
-     *
-     * If `target` reverts with a revert reason or custom error, it is bubbled
-     * up by this function (like regular Solidity function calls). However, if
-     * the call reverted with no returned reason, this function reverts with a
-     * {Errors.FailedCall} error.
-     *
-     * Returns the raw returned data. To convert to the expected return value,
-     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
-     *
-     * Requirements:
-     *
-     * - `target` must be a contract.
-     * - calling `target` with `data` must not revert.
-     */
-    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
-        return functionCallWithValue(target, data, 0);
-    }
-
-    /**
-     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
-     * but also transferring `value` wei to `target`.
-     *
-     * Requirements:
-     *
-     * - the calling contract must have an ETH balance of at least `value`.
-     * - the called Solidity function must be `payable`.
-     */
-    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
-        if (address(this).balance < value) {
-            revert Errors_0.InsufficientBalance(address(this).balance, value);
-        }
-        (bool success, bytes memory returndata) = target.call{value: value}(data);
-        return verifyCallResultFromTarget(target, success, returndata);
-    }
-
-    /**
-     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
-     * but performing a static call.
-     */
-    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
-        (bool success, bytes memory returndata) = target.staticcall(data);
-        return verifyCallResultFromTarget(target, success, returndata);
-    }
-
-    /**
-     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
-     * but performing a delegate call.
-     */
-    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
-        (bool success, bytes memory returndata) = target.delegatecall(data);
-        return verifyCallResultFromTarget(target, success, returndata);
-    }
-
-    /**
-     * @dev Tool to verify that a low level call to smart-contract was successful, and reverts if the target
-     * was not a contract or bubbling up the revert reason (falling back to {Errors.FailedCall}) in case
-     * of an unsuccessful call.
-     */
-    function verifyCallResultFromTarget(
-        address target,
-        bool success,
-        bytes memory returndata
-    ) internal view returns (bytes memory) {
-        if (!success) {
-            _revert(returndata);
-        } else {
-            // only check if target is a contract if the call was successful and the return data is empty
-            // otherwise we already know that it was a contract
-            if (returndata.length == 0 && target.code.length == 0) {
-                revert AddressEmptyCode(target);
-            }
-            return returndata;
-        }
-    }
-
-    /**
-     * @dev Tool to verify that a low level call was successful, and reverts if it wasn't, either by bubbling the
-     * revert reason or with a default {Errors.FailedCall} error.
-     */
-    function verifyCallResult(bool success, bytes memory returndata) internal pure returns (bytes memory) {
-        if (!success) {
-            _revert(returndata);
-        } else {
-            return returndata;
-        }
-    }
-
-    /**
-     * @dev Reverts with returndata if present. Otherwise reverts with {Errors.FailedCall}.
-     */
-    function _revert(bytes memory returndata) private pure {
-        // Look for revert reason and bubble it up if present
-        if (returndata.length > 0) {
-            // The easiest way to bubble the revert reason is using memory via assembly
-            assembly ("memory-safe") {
-                let returndata_size := mload(returndata)
-                revert(add(32, returndata), returndata_size)
-            }
-        } else {
-            revert Errors_0.FailedCall();
-        }
-    }
-}
-
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IACLManager.sol
-
-/**
- * @title IACLManager
- * @author Aave
- * @notice Defines the basic interface for the ACL Manager
- */
-interface IACLManager_0 {
-  /**
-   * @notice Returns the contract address of the PoolAddressesProvider
-   * @return The address of the PoolAddressesProvider
-   */
-  function ADDRESSES_PROVIDER() external view returns (IPoolAddressesProvider);
-
-  /**
-   * @notice Returns the identifier of the PoolAdmin role
-   * @return The id of the PoolAdmin role
-   */
-  function POOL_ADMIN_ROLE() external view returns (bytes32);
-
-  /**
-   * @notice Returns the identifier of the EmergencyAdmin role
-   * @return The id of the EmergencyAdmin role
-   */
-  function EMERGENCY_ADMIN_ROLE() external view returns (bytes32);
-
-  /**
-   * @notice Returns the identifier of the RiskAdmin role
-   * @return The id of the RiskAdmin role
-   */
-  function RISK_ADMIN_ROLE() external view returns (bytes32);
-
-  /**
-   * @notice Returns the identifier of the FlashBorrower role
-   * @return The id of the FlashBorrower role
-   */
-  function FLASH_BORROWER_ROLE() external view returns (bytes32);
-
-  /**
-   * @notice Returns the identifier of the Bridge role
-   * @return The id of the Bridge role
-   */
-  function BRIDGE_ROLE() external view returns (bytes32);
-
-  /**
-   * @notice Returns the identifier of the AssetListingAdmin role
-   * @return The id of the AssetListingAdmin role
-   */
-  function ASSET_LISTING_ADMIN_ROLE() external view returns (bytes32);
-
-  /**
-   * @notice Set the role as admin of a specific role.
-   * @dev By default the admin role for all roles is `DEFAULT_ADMIN_ROLE`.
-   * @param role The role to be managed by the admin role
-   * @param adminRole The admin role
-   */
-  function setRoleAdmin(bytes32 role, bytes32 adminRole) external;
-
-  /**
-   * @notice Adds a new admin as PoolAdmin
-   * @param admin The address of the new admin
-   */
-  function addPoolAdmin(address admin) external;
-
-  /**
-   * @notice Removes an admin as PoolAdmin
-   * @param admin The address of the admin to remove
-   */
-  function removePoolAdmin(address admin) external;
-
-  /**
-   * @notice Returns true if the address is PoolAdmin, false otherwise
-   * @param admin The address to check
-   * @return True if the given address is PoolAdmin, false otherwise
-   */
-  function isPoolAdmin(address admin) external view returns (bool);
-
-  /**
-   * @notice Adds a new admin as EmergencyAdmin
-   * @param admin The address of the new admin
-   */
-  function addEmergencyAdmin(address admin) external;
-
-  /**
-   * @notice Removes an admin as EmergencyAdmin
-   * @param admin The address of the admin to remove
-   */
-  function removeEmergencyAdmin(address admin) external;
-
-  /**
-   * @notice Returns true if the address is EmergencyAdmin, false otherwise
-   * @param admin The address to check
-   * @return True if the given address is EmergencyAdmin, false otherwise
-   */
-  function isEmergencyAdmin(address admin) external view returns (bool);
-
-  /**
-   * @notice Adds a new admin as RiskAdmin
-   * @param admin The address of the new admin
-   */
-  function addRiskAdmin(address admin) external;
-
-  /**
-   * @notice Removes an admin as RiskAdmin
-   * @param admin The address of the admin to remove
-   */
-  function removeRiskAdmin(address admin) external;
+  /**
+   * @dev Returns the downcasted uint184 from uint256, reverting on
+   * overflow (when the input is greater than largest uint184).
+   *
+   * Counterpart to Solidity's `uint184` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 184 bits
+   *
+   * _Available since v4.7._
+   */
+  function toUint184(uint256 value) internal pure returns (uint184) {
+    require(value <= type(uint184).max, "SafeCast: value doesn't fit in 184 bits");
+    return uint184(value);
+  }
 
   /**
-   * @notice Returns true if the address is RiskAdmin, false otherwise
-   * @param admin The address to check
-   * @return True if the given address is RiskAdmin, false otherwise
-   */
-  function isRiskAdmin(address admin) external view returns (bool);
-
-  /**
-   * @notice Adds a new address as FlashBorrower
-   * @param borrower The address of the new FlashBorrower
+   * @dev Returns the downcasted uint176 from uint256, reverting on
+   * overflow (when the input is greater than largest uint176).
+   *
+   * Counterpart to Solidity's `uint176` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 176 bits
+   *
+   * _Available since v4.7._
    */
-  function addFlashBorrower(address borrower) external;
+  function toUint176(uint256 value) internal pure returns (uint176) {
+    require(value <= type(uint176).max, "SafeCast: value doesn't fit in 176 bits");
+    return uint176(value);
+  }
 
   /**
-   * @notice Removes an address as FlashBorrower
-   * @param borrower The address of the FlashBorrower to remove
+   * @dev Returns the downcasted uint168 from uint256, reverting on
+   * overflow (when the input is greater than largest uint168).
+   *
+   * Counterpart to Solidity's `uint168` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 168 bits
+   *
+   * _Available since v4.7._
    */
-  function removeFlashBorrower(address borrower) external;
+  function toUint168(uint256 value) internal pure returns (uint168) {
+    require(value <= type(uint168).max, "SafeCast: value doesn't fit in 168 bits");
+    return uint168(value);
+  }
 
   /**
-   * @notice Returns true if the address is FlashBorrower, false otherwise
-   * @param borrower The address to check
-   * @return True if the given address is FlashBorrower, false otherwise
+   * @dev Returns the downcasted uint160 from uint256, reverting on
+   * overflow (when the input is greater than largest uint160).
+   *
+   * Counterpart to Solidity's `uint160` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 160 bits
+   *
+   * _Available since v4.7._
    */
-  function isFlashBorrower(address borrower) external view returns (bool);
+  function toUint160(uint256 value) internal pure returns (uint160) {
+    require(value <= type(uint160).max, "SafeCast: value doesn't fit in 160 bits");
+    return uint160(value);
+  }
 
   /**
-   * @notice Adds a new address as Bridge
-   * @param bridge The address of the new Bridge
+   * @dev Returns the downcasted uint152 from uint256, reverting on
+   * overflow (when the input is greater than largest uint152).
+   *
+   * Counterpart to Solidity's `uint152` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 152 bits
+   *
+   * _Available since v4.7._
    */
-  function addBridge(address bridge) external;
+  function toUint152(uint256 value) internal pure returns (uint152) {
+    require(value <= type(uint152).max, "SafeCast: value doesn't fit in 152 bits");
+    return uint152(value);
+  }
 
   /**
-   * @notice Removes an address as Bridge
-   * @param bridge The address of the bridge to remove
+   * @dev Returns the downcasted uint144 from uint256, reverting on
+   * overflow (when the input is greater than largest uint144).
+   *
+   * Counterpart to Solidity's `uint144` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 144 bits
+   *
+   * _Available since v4.7._
    */
-  function removeBridge(address bridge) external;
+  function toUint144(uint256 value) internal pure returns (uint144) {
+    require(value <= type(uint144).max, "SafeCast: value doesn't fit in 144 bits");
+    return uint144(value);
+  }
 
   /**
-   * @notice Returns true if the address is Bridge, false otherwise
-   * @param bridge The address to check
-   * @return True if the given address is Bridge, false otherwise
+   * @dev Returns the downcasted uint136 from uint256, reverting on
+   * overflow (when the input is greater than largest uint136).
+   *
+   * Counterpart to Solidity's `uint136` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 136 bits
+   *
+   * _Available since v4.7._
    */
-  function isBridge(address bridge) external view returns (bool);
+  function toUint136(uint256 value) internal pure returns (uint136) {
+    require(value <= type(uint136).max, "SafeCast: value doesn't fit in 136 bits");
+    return uint136(value);
+  }
 
   /**
-   * @notice Adds a new admin as AssetListingAdmin
-   * @param admin The address of the new admin
+   * @dev Returns the downcasted uint128 from uint256, reverting on
+   * overflow (when the input is greater than largest uint128).
+   *
+   * Counterpart to Solidity's `uint128` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 128 bits
+   *
+   * _Available since v2.5._
    */
-  function addAssetListingAdmin(address admin) external;
+  function toUint128(uint256 value) internal pure returns (uint128) {
+    require(value <= type(uint128).max, "SafeCast: value doesn't fit in 128 bits");
+    return uint128(value);
+  }
 
   /**
-   * @notice Removes an admin as AssetListingAdmin
-   * @param admin The address of the admin to remove
+   * @dev Returns the downcasted uint120 from uint256, reverting on
+   * overflow (when the input is greater than largest uint120).
+   *
+   * Counterpart to Solidity's `uint120` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 120 bits
+   *
+   * _Available since v4.7._
    */
-  function removeAssetListingAdmin(address admin) external;
+  function toUint120(uint256 value) internal pure returns (uint120) {
+    require(value <= type(uint120).max, "SafeCast: value doesn't fit in 120 bits");
+    return uint120(value);
+  }
 
   /**
-   * @notice Returns true if the address is AssetListingAdmin, false otherwise
-   * @param admin The address to check
-   * @return True if the given address is AssetListingAdmin, false otherwise
+   * @dev Returns the downcasted uint112 from uint256, reverting on
+   * overflow (when the input is greater than largest uint112).
+   *
+   * Counterpart to Solidity's `uint112` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 112 bits
+   *
+   * _Available since v4.7._
    */
-  function isAssetListingAdmin(address admin) external view returns (bool);
-}
-
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/treasury/ICollector.sol
-
-interface ICollector {
-  struct Stream {
-    uint256 deposit;
-    uint256 ratePerSecond;
-    uint256 remainingBalance;
-    uint256 startTime;
-    uint256 stopTime;
-    address recipient;
-    address sender;
-    address tokenAddress;
-    bool isEntity;
+  function toUint112(uint256 value) internal pure returns (uint112) {
+    require(value <= type(uint112).max, "SafeCast: value doesn't fit in 112 bits");
+    return uint112(value);
   }
 
   /**
-   * @dev Withdraw amount exceeds available balance
+   * @dev Returns the downcasted uint104 from uint256, reverting on
+   * overflow (when the input is greater than largest uint104).
+   *
+   * Counterpart to Solidity's `uint104` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 104 bits
+   *
+   * _Available since v4.7._
    */
-  error BalanceExceeded();
+  function toUint104(uint256 value) internal pure returns (uint104) {
+    require(value <= type(uint104).max, "SafeCast: value doesn't fit in 104 bits");
+    return uint104(value);
+  }
 
   /**
-   * @dev Deposit smaller than time delta
+   * @dev Returns the downcasted uint96 from uint256, reverting on
+   * overflow (when the input is greater than largest uint96).
+   *
+   * Counterpart to Solidity's `uint96` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 96 bits
+   *
+   * _Available since v4.2._
    */
-  error DepositSmallerTimeDelta();
+  function toUint96(uint256 value) internal pure returns (uint96) {
+    require(value <= type(uint96).max, "SafeCast: value doesn't fit in 96 bits");
+    return uint96(value);
+  }
 
   /**
-   * @dev Deposit not multiple of time delta
+   * @dev Returns the downcasted uint88 from uint256, reverting on
+   * overflow (when the input is greater than largest uint88).
+   *
+   * Counterpart to Solidity's `uint88` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 88 bits
+   *
+   * _Available since v4.7._
    */
-  error DepositNotMultipleTimeDelta();
+  function toUint88(uint256 value) internal pure returns (uint88) {
+    require(value <= type(uint88).max, "SafeCast: value doesn't fit in 88 bits");
+    return uint88(value);
+  }
 
   /**
-   * @dev Recipient cannot be the contract itself or msg.sender
+   * @dev Returns the downcasted uint80 from uint256, reverting on
+   * overflow (when the input is greater than largest uint80).
+   *
+   * Counterpart to Solidity's `uint80` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 80 bits
+   *
+   * _Available since v4.7._
    */
-  error InvalidRecipient();
+  function toUint80(uint256 value) internal pure returns (uint80) {
+    require(value <= type(uint80).max, "SafeCast: value doesn't fit in 80 bits");
+    return uint80(value);
+  }
 
   /**
-   * @dev Start time cannot be before block.timestamp
+   * @dev Returns the downcasted uint72 from uint256, reverting on
+   * overflow (when the input is greater than largest uint72).
+   *
+   * Counterpart to Solidity's `uint72` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 72 bits
+   *
+   * _Available since v4.7._
    */
-  error InvalidStartTime();
+  function toUint72(uint256 value) internal pure returns (uint72) {
+    require(value <= type(uint72).max, "SafeCast: value doesn't fit in 72 bits");
+    return uint72(value);
+  }
 
   /**
-   * @dev Stop time must be greater than startTime
+   * @dev Returns the downcasted uint64 from uint256, reverting on
+   * overflow (when the input is greater than largest uint64).
+   *
+   * Counterpart to Solidity's `uint64` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 64 bits
+   *
+   * _Available since v2.5._
    */
-  error InvalidStopTime();
+  function toUint64(uint256 value) internal pure returns (uint64) {
+    require(value <= type(uint64).max, "SafeCast: value doesn't fit in 64 bits");
+    return uint64(value);
+  }
 
   /**
-   * @dev Provided address cannot be the zero-address
+   * @dev Returns the downcasted uint56 from uint256, reverting on
+   * overflow (when the input is greater than largest uint56).
+   *
+   * Counterpart to Solidity's `uint56` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 56 bits
+   *
+   * _Available since v4.7._
    */
-  error InvalidZeroAddress();
+  function toUint56(uint256 value) internal pure returns (uint56) {
+    require(value <= type(uint56).max, "SafeCast: value doesn't fit in 56 bits");
+    return uint56(value);
+  }
 
   /**
-   * @dev Amount cannot be zero
+   * @dev Returns the downcasted uint48 from uint256, reverting on
+   * overflow (when the input is greater than largest uint48).
+   *
+   * Counterpart to Solidity's `uint48` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 48 bits
+   *
+   * _Available since v4.7._
    */
-  error InvalidZeroAmount();
+  function toUint48(uint256 value) internal pure returns (uint48) {
+    require(value <= type(uint48).max, "SafeCast: value doesn't fit in 48 bits");
+    return uint48(value);
+  }
 
   /**
-   * @dev Only caller with FUNDS_ADMIN role can call
+   * @dev Returns the downcasted uint40 from uint256, reverting on
+   * overflow (when the input is greater than largest uint40).
+   *
+   * Counterpart to Solidity's `uint40` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 40 bits
+   *
+   * _Available since v4.7._
    */
-  error OnlyFundsAdmin();
+  function toUint40(uint256 value) internal pure returns (uint40) {
+    require(value <= type(uint40).max, "SafeCast: value doesn't fit in 40 bits");
+    return uint40(value);
+  }
 
   /**
-   * @dev Only caller with FUNDS_ADMIN role or stream recipient can call
+   * @dev Returns the downcasted uint32 from uint256, reverting on
+   * overflow (when the input is greater than largest uint32).
+   *
+   * Counterpart to Solidity's `uint32` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 32 bits
+   *
+   * _Available since v2.5._
    */
-  error OnlyFundsAdminOrRecipient();
+  function toUint32(uint256 value) internal pure returns (uint32) {
+    require(value <= type(uint32).max, "SafeCast: value doesn't fit in 32 bits");
+    return uint32(value);
+  }
 
   /**
-   * @dev The provided ID does not belong to an existing stream
+   * @dev Returns the downcasted uint24 from uint256, reverting on
+   * overflow (when the input is greater than largest uint24).
+   *
+   * Counterpart to Solidity's `uint24` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 24 bits
+   *
+   * _Available since v4.7._
    */
-  error StreamDoesNotExist();
-
-  /** @notice Emitted when the new stream is created
-   * @param streamId The identifier of the stream.
-   * @param sender The address of the collector.
-   * @param recipient The address towards which the money is streamed.
-   * @param deposit The amount of money to be streamed.
-   * @param tokenAddress The ERC20 token to use as streaming currency.
-   * @param startTime The unix timestamp for when the stream starts.
-   * @param stopTime The unix timestamp for when the stream stops.
-   **/
-  event CreateStream(
-    uint256 indexed streamId,
-    address indexed sender,
-    address indexed recipient,
-    uint256 deposit,
-    address tokenAddress,
-    uint256 startTime,
-    uint256 stopTime
-  );
+  function toUint24(uint256 value) internal pure returns (uint24) {
+    require(value <= type(uint24).max, "SafeCast: value doesn't fit in 24 bits");
+    return uint24(value);
+  }
 
   /**
-   * @notice Emmitted when withdraw happens from the contract to the recipient's account.
-   * @param streamId The id of the stream to withdraw tokens from.
-   * @param recipient The address towards which the money is streamed.
-   * @param amount The amount of tokens to withdraw.
+   * @dev Returns the downcasted uint16 from uint256, reverting on
+   * overflow (when the input is greater than largest uint16).
+   *
+   * Counterpart to Solidity's `uint16` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 16 bits
+   *
+   * _Available since v2.5._
    */
-  event WithdrawFromStream(uint256 indexed streamId, address indexed recipient, uint256 amount);
+  function toUint16(uint256 value) internal pure returns (uint16) {
+    require(value <= type(uint16).max, "SafeCast: value doesn't fit in 16 bits");
+    return uint16(value);
+  }
 
   /**
-   * @notice Emmitted when the stream is canceled.
-   * @param streamId The id of the stream to withdraw tokens from.
-   * @param sender The address of the collector.
-   * @param recipient The address towards which the money is streamed.
-   * @param senderBalance The sender's balance at the moment of cancelling.
-   * @param recipientBalance The recipient's balance at the moment of cancelling.
+   * @dev Returns the downcasted uint8 from uint256, reverting on
+   * overflow (when the input is greater than largest uint8).
+   *
+   * Counterpart to Solidity's `uint8` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 8 bits
+   *
+   * _Available since v2.5._
    */
-  event CancelStream(
-    uint256 indexed streamId,
-    address indexed sender,
-    address indexed recipient,
-    uint256 senderBalance,
-    uint256 recipientBalance
-  );
-
-  /**
-   * @notice FUNDS_ADMIN role granted by ACL Manager
-   **/
-  function FUNDS_ADMIN_ROLE() external view returns (bytes32);
-
-  /** @notice Returns the mock ETH reference address
-   * @return address The address
-   **/
-  function ETH_MOCK_ADDRESS() external pure returns (address);
-
-  /**
-   * @notice Checks if address is funds admin
-   * @return bool If the address has the funds admin role
-   **/
-  function isFundsAdmin(address admin) external view returns (bool);
+  function toUint8(uint256 value) internal pure returns (uint8) {
+    require(value <= type(uint8).max, "SafeCast: value doesn't fit in 8 bits");
+    return uint8(value);
+  }
 
   /**
-   * @notice Returns the available funds for the given stream id and address.
-   * @param streamId The id of the stream for which to query the balance.
-   * @param who The address for which to query the balance.
-   * @notice Returns the total funds allocated to `who` as uint256.
-   **/
-  function balanceOf(uint256 streamId, address who) external view returns (uint256 balance);
+   * @dev Converts a signed int256 into an unsigned uint256.
+   *
+   * Requirements:
+   *
+   * - input must be greater than or equal to 0.
+   *
+   * _Available since v3.0._
+   */
+  function toUint256(int256 value) internal pure returns (uint256) {
+    require(value >= 0, 'SafeCast: value must be positive');
+    return uint256(value);
+  }
 
   /**
-   * @dev Function for the funds admin to give ERC20 allowance to other parties
-   * @param token The address of the token to give allowance from
-   * @param recipient Allowance's recipient
-   * @param amount Allowance to approve
-   **/
-  function approve(IERC20_1 token, address recipient, uint256 amount) external;
+   * @dev Returns the downcasted int248 from int256, reverting on
+   * overflow (when the input is less than smallest int248 or
+   * greater than largest int248).
+   *
+   * Counterpart to Solidity's `int248` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 248 bits
+   *
+   * _Available since v4.7._
+   */
+  function toInt248(int256 value) internal pure returns (int248 downcasted) {
+    downcasted = int248(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 248 bits");
+  }
 
   /**
-   * @notice Function for the funds admin to transfer ERC20 tokens to other parties
-   * @param token The address of the token to transfer
-   * @param recipient Transfer's recipient
-   * @param amount Amount to transfer
-   **/
-  function transfer(IERC20_1 token, address recipient, uint256 amount) external;
+   * @dev Returns the downcasted int240 from int256, reverting on
+   * overflow (when the input is less than smallest int240 or
+   * greater than largest int240).
+   *
+   * Counterpart to Solidity's `int240` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 240 bits
+   *
+   * _Available since v4.7._
+   */
+  function toInt240(int256 value) internal pure returns (int240 downcasted) {
+    downcasted = int240(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 240 bits");
+  }
 
   /**
-   * @notice Creates a new stream funded by this contracts itself and paid towards `recipient`.
-   * @param recipient The address towards which the money is streamed.
-   * @param deposit The amount of money to be streamed.
-   * @param tokenAddress The ERC20 token to use as streaming currency.
-   * @param startTime The unix timestamp for when the stream starts.
-   * @param stopTime The unix timestamp for when the stream stops.
-   * @return streamId the uint256 id of the newly created stream.
+   * @dev Returns the downcasted int232 from int256, reverting on
+   * overflow (when the input is less than smallest int232 or
+   * greater than largest int232).
+   *
+   * Counterpart to Solidity's `int232` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 232 bits
+   *
+   * _Available since v4.7._
    */
-  function createStream(
-    address recipient,
-    uint256 deposit,
-    address tokenAddress,
-    uint256 startTime,
-    uint256 stopTime
-  ) external returns (uint256 streamId);
+  function toInt232(int256 value) internal pure returns (int232 downcasted) {
+    downcasted = int232(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 232 bits");
+  }
 
   /**
-   * @notice Returns the stream with all its properties.
-   * @dev Throws if the id does not point to a valid stream.
-   * @param streamId The id of the stream to query.
-   * @notice Returns the stream object.
+   * @dev Returns the downcasted int224 from int256, reverting on
+   * overflow (when the input is less than smallest int224 or
+   * greater than largest int224).
+   *
+   * Counterpart to Solidity's `int224` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 224 bits
+   *
+   * _Available since v4.7._
    */
-  function getStream(
-    uint256 streamId
-  )
-    external
-    view
-    returns (
-      address sender,
-      address recipient,
-      uint256 deposit,
-      address tokenAddress,
-      uint256 startTime,
-      uint256 stopTime,
-      uint256 remainingBalance,
-      uint256 ratePerSecond
-    );
+  function toInt224(int256 value) internal pure returns (int224 downcasted) {
+    downcasted = int224(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 224 bits");
+  }
 
   /**
-   * @notice Withdraws from the contract to the recipient's account.
-   * @param streamId The id of the stream to withdraw tokens from.
-   * @param amount The amount of tokens to withdraw.
-   * @return bool Returns true if successful.
+   * @dev Returns the downcasted int216 from int256, reverting on
+   * overflow (when the input is less than smallest int216 or
+   * greater than largest int216).
+   *
+   * Counterpart to Solidity's `int216` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 216 bits
+   *
+   * _Available since v4.7._
    */
-  function withdrawFromStream(uint256 streamId, uint256 amount) external returns (bool);
+  function toInt216(int256 value) internal pure returns (int216 downcasted) {
+    downcasted = int216(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 216 bits");
+  }
 
   /**
-   * @notice Cancels the stream and transfers the tokens back on a pro rata basis.
-   * @param streamId The id of the stream to cancel.
-   * @return bool Returns true if successful.
+   * @dev Returns the downcasted int208 from int256, reverting on
+   * overflow (when the input is less than smallest int208 or
+   * greater than largest int208).
+   *
+   * Counterpart to Solidity's `int208` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 208 bits
+   *
+   * _Available since v4.7._
    */
-  function cancelStream(uint256 streamId) external returns (bool);
+  function toInt208(int256 value) internal pure returns (int208 downcasted) {
+    downcasted = int208(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 208 bits");
+  }
 
   /**
-   * @notice Returns the next available stream id
-   * @return nextStreamId Returns the stream id.
+   * @dev Returns the downcasted int200 from int256, reverting on
+   * overflow (when the input is less than smallest int200 or
+   * greater than largest int200).
+   *
+   * Counterpart to Solidity's `int200` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 200 bits
+   *
+   * _Available since v4.7._
    */
-  function getNextStreamId() external view returns (uint256);
-}
-
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPoolDataProvider.sol
-
-/**
- * @title IPoolDataProvider
- * @author Aave
- * @notice Defines the basic interface of a PoolDataProvider
- */
-interface IPoolDataProvider {
-  struct TokenData {
-    string symbol;
-    address tokenAddress;
+  function toInt200(int256 value) internal pure returns (int200 downcasted) {
+    downcasted = int200(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 200 bits");
   }
 
   /**
-   * @notice Returns the address for the PoolAddressesProvider contract.
-   * @return The address for the PoolAddressesProvider contract
+   * @dev Returns the downcasted int192 from int256, reverting on
+   * overflow (when the input is less than smallest int192 or
+   * greater than largest int192).
+   *
+   * Counterpart to Solidity's `int192` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 192 bits
+   *
+   * _Available since v4.7._
    */
-  function ADDRESSES_PROVIDER() external view returns (IPoolAddressesProvider);
+  function toInt192(int256 value) internal pure returns (int192 downcasted) {
+    downcasted = int192(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 192 bits");
+  }
 
   /**
-   * @notice Returns the list of the existing reserves in the pool.
-   * @dev Handling MKR and ETH in a different way since they do not have standard `symbol` functions.
-   * @return The list of reserves, pairs of symbols and addresses
+   * @dev Returns the downcasted int184 from int256, reverting on
+   * overflow (when the input is less than smallest int184 or
+   * greater than largest int184).
+   *
+   * Counterpart to Solidity's `int184` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 184 bits
+   *
+   * _Available since v4.7._
    */
-  function getAllReservesTokens() external view returns (TokenData[] memory);
+  function toInt184(int256 value) internal pure returns (int184 downcasted) {
+    downcasted = int184(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 184 bits");
+  }
 
   /**
-   * @notice Returns the list of the existing ATokens in the pool.
-   * @return The list of ATokens, pairs of symbols and addresses
+   * @dev Returns the downcasted int176 from int256, reverting on
+   * overflow (when the input is less than smallest int176 or
+   * greater than largest int176).
+   *
+   * Counterpart to Solidity's `int176` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 176 bits
+   *
+   * _Available since v4.7._
    */
-  function getAllATokens() external view returns (TokenData[] memory);
+  function toInt176(int256 value) internal pure returns (int176 downcasted) {
+    downcasted = int176(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 176 bits");
+  }
 
   /**
-   * @notice Returns the configuration data of the reserve
-   * @dev Not returning borrow and supply caps for compatibility, nor pause flag
-   * @param asset The address of the underlying asset of the reserve
-   * @return decimals The number of decimals of the reserve
-   * @return ltv The ltv of the reserve
-   * @return liquidationThreshold The liquidationThreshold of the reserve
-   * @return liquidationBonus The liquidationBonus of the reserve
-   * @return reserveFactor The reserveFactor of the reserve
-   * @return usageAsCollateralEnabled True if the usage as collateral is enabled, false otherwise
-   * @return borrowingEnabled True if borrowing is enabled, false otherwise
-   * @return stableBorrowRateEnabled True if stable rate borrowing is enabled, false otherwise
-   * @return isActive True if it is active, false otherwise
-   * @return isFrozen True if it is frozen, false otherwise
+   * @dev Returns the downcasted int168 from int256, reverting on
+   * overflow (when the input is less than smallest int168 or
+   * greater than largest int168).
+   *
+   * Counterpart to Solidity's `int168` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 168 bits
+   *
+   * _Available since v4.7._
    */
-  function getReserveConfigurationData(
-    address asset
-  )
-    external
-    view
-    returns (
-      uint256 decimals,
-      uint256 ltv,
-      uint256 liquidationThreshold,
-      uint256 liquidationBonus,
-      uint256 reserveFactor,
-      bool usageAsCollateralEnabled,
-      bool borrowingEnabled,
-      bool stableBorrowRateEnabled,
-      bool isActive,
-      bool isFrozen
-    );
+  function toInt168(int256 value) internal pure returns (int168 downcasted) {
+    downcasted = int168(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 168 bits");
+  }
 
   /**
-   * @notice Returns the caps parameters of the reserve
-   * @param asset The address of the underlying asset of the reserve
-   * @return borrowCap The borrow cap of the reserve
-   * @return supplyCap The supply cap of the reserve
+   * @dev Returns the downcasted int160 from int256, reverting on
+   * overflow (when the input is less than smallest int160 or
+   * greater than largest int160).
+   *
+   * Counterpart to Solidity's `int160` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 160 bits
+   *
+   * _Available since v4.7._
    */
-  function getReserveCaps(
-    address asset
-  ) external view returns (uint256 borrowCap, uint256 supplyCap);
+  function toInt160(int256 value) internal pure returns (int160 downcasted) {
+    downcasted = int160(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 160 bits");
+  }
 
   /**
-   * @notice Returns if the pool is paused
-   * @param asset The address of the underlying asset of the reserve
-   * @return isPaused True if the pool is paused, false otherwise
+   * @dev Returns the downcasted int152 from int256, reverting on
+   * overflow (when the input is less than smallest int152 or
+   * greater than largest int152).
+   *
+   * Counterpart to Solidity's `int152` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 152 bits
+   *
+   * _Available since v4.7._
    */
-  function getPaused(address asset) external view returns (bool isPaused);
+  function toInt152(int256 value) internal pure returns (int152 downcasted) {
+    downcasted = int152(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 152 bits");
+  }
 
   /**
-   * @notice Returns the siloed borrowing flag
-   * @param asset The address of the underlying asset of the reserve
-   * @return True if the asset is siloed for borrowing
+   * @dev Returns the downcasted int144 from int256, reverting on
+   * overflow (when the input is less than smallest int144 or
+   * greater than largest int144).
+   *
+   * Counterpart to Solidity's `int144` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 144 bits
+   *
+   * _Available since v4.7._
    */
-  function getSiloedBorrowing(address asset) external view returns (bool);
+  function toInt144(int256 value) internal pure returns (int144 downcasted) {
+    downcasted = int144(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 144 bits");
+  }
 
   /**
-   * @notice Returns the protocol fee on the liquidation bonus
-   * @param asset The address of the underlying asset of the reserve
-   * @return The protocol fee on liquidation
+   * @dev Returns the downcasted int136 from int256, reverting on
+   * overflow (when the input is less than smallest int136 or
+   * greater than largest int136).
+   *
+   * Counterpart to Solidity's `int136` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 136 bits
+   *
+   * _Available since v4.7._
    */
-  function getLiquidationProtocolFee(address asset) external view returns (uint256);
+  function toInt136(int256 value) internal pure returns (int136 downcasted) {
+    downcasted = int136(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 136 bits");
+  }
 
   /**
-   * @notice Returns the unbacked mint cap of the reserve
-   * @param asset The address of the underlying asset of the reserve
-   * @return The unbacked mint cap of the reserve
+   * @dev Returns the downcasted int128 from int256, reverting on
+   * overflow (when the input is less than smallest int128 or
+   * greater than largest int128).
+   *
+   * Counterpart to Solidity's `int128` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 128 bits
+   *
+   * _Available since v3.1._
    */
-  function getUnbackedMintCap(address asset) external view returns (uint256);
+  function toInt128(int256 value) internal pure returns (int128 downcasted) {
+    downcasted = int128(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 128 bits");
+  }
 
   /**
-   * @notice Returns the debt ceiling of the reserve
-   * @param asset The address of the underlying asset of the reserve
-   * @return The debt ceiling of the reserve
+   * @dev Returns the downcasted int120 from int256, reverting on
+   * overflow (when the input is less than smallest int120 or
+   * greater than largest int120).
+   *
+   * Counterpart to Solidity's `int120` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 120 bits
+   *
+   * _Available since v4.7._
    */
-  function getDebtCeiling(address asset) external view returns (uint256);
+  function toInt120(int256 value) internal pure returns (int120 downcasted) {
+    downcasted = int120(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 120 bits");
+  }
 
   /**
-   * @notice Returns the debt ceiling decimals
-   * @return The debt ceiling decimals
+   * @dev Returns the downcasted int112 from int256, reverting on
+   * overflow (when the input is less than smallest int112 or
+   * greater than largest int112).
+   *
+   * Counterpart to Solidity's `int112` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 112 bits
+   *
+   * _Available since v4.7._
    */
-  function getDebtCeilingDecimals() external pure returns (uint256);
+  function toInt112(int256 value) internal pure returns (int112 downcasted) {
+    downcasted = int112(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 112 bits");
+  }
 
   /**
-   * @notice Returns the reserve data
-   * @param asset The address of the underlying asset of the reserve
-   * @return unbacked The amount of unbacked tokens
-   * @return accruedToTreasuryScaled The scaled amount of tokens accrued to treasury that is to be minted
-   * @return totalAToken The total supply of the aToken
-   * @return totalStableDebt The total stable debt of the reserve
-   * @return totalVariableDebt The total variable debt of the reserve
-   * @return liquidityRate The liquidity rate of the reserve
-   * @return variableBorrowRate The variable borrow rate of the reserve
-   * @return stableBorrowRate The stable borrow rate of the reserve
-   * @return averageStableBorrowRate The average stable borrow rate of the reserve
-   * @return liquidityIndex The liquidity index of the reserve
-   * @return variableBorrowIndex The variable borrow index of the reserve
-   * @return lastUpdateTimestamp The timestamp of the last update of the reserve
+   * @dev Returns the downcasted int104 from int256, reverting on
+   * overflow (when the input is less than smallest int104 or
+   * greater than largest int104).
+   *
+   * Counterpart to Solidity's `int104` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 104 bits
+   *
+   * _Available since v4.7._
    */
-  function getReserveData(
-    address asset
-  )
-    external
-    view
-    returns (
-      uint256 unbacked,
-      uint256 accruedToTreasuryScaled,
-      uint256 totalAToken,
-      uint256 totalStableDebt,
-      uint256 totalVariableDebt,
-      uint256 liquidityRate,
-      uint256 variableBorrowRate,
-      uint256 stableBorrowRate,
-      uint256 averageStableBorrowRate,
-      uint256 liquidityIndex,
-      uint256 variableBorrowIndex,
-      uint40 lastUpdateTimestamp
-    );
+  function toInt104(int256 value) internal pure returns (int104 downcasted) {
+    downcasted = int104(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 104 bits");
+  }
 
   /**
-   * @notice Returns the total supply of aTokens for a given asset
-   * @param asset The address of the underlying asset of the reserve
-   * @return The total supply of the aToken
+   * @dev Returns the downcasted int96 from int256, reverting on
+   * overflow (when the input is less than smallest int96 or
+   * greater than largest int96).
+   *
+   * Counterpart to Solidity's `int96` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 96 bits
+   *
+   * _Available since v4.7._
    */
-  function getATokenTotalSupply(address asset) external view returns (uint256);
+  function toInt96(int256 value) internal pure returns (int96 downcasted) {
+    downcasted = int96(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 96 bits");
+  }
 
   /**
-   * @notice Returns the total debt for a given asset
-   * @param asset The address of the underlying asset of the reserve
-   * @return The total debt for asset
+   * @dev Returns the downcasted int88 from int256, reverting on
+   * overflow (when the input is less than smallest int88 or
+   * greater than largest int88).
+   *
+   * Counterpart to Solidity's `int88` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 88 bits
+   *
+   * _Available since v4.7._
    */
-  function getTotalDebt(address asset) external view returns (uint256);
+  function toInt88(int256 value) internal pure returns (int88 downcasted) {
+    downcasted = int88(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 88 bits");
+  }
 
   /**
-   * @notice Returns the user data in a reserve
-   * @param asset The address of the underlying asset of the reserve
-   * @param user The address of the user
-   * @return currentATokenBalance The current AToken balance of the user
-   * @return currentStableDebt The current stable debt of the user
-   * @return currentVariableDebt The current variable debt of the user
-   * @return principalStableDebt The principal stable debt of the user
-   * @return scaledVariableDebt The scaled variable debt of the user
-   * @return stableBorrowRate The stable borrow rate of the user
-   * @return liquidityRate The liquidity rate of the reserve
-   * @return stableRateLastUpdated The timestamp of the last update of the user stable rate
-   * @return usageAsCollateralEnabled True if the user is using the asset as collateral, false
-   *         otherwise
+   * @dev Returns the downcasted int80 from int256, reverting on
+   * overflow (when the input is less than smallest int80 or
+   * greater than largest int80).
+   *
+   * Counterpart to Solidity's `int80` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 80 bits
+   *
+   * _Available since v4.7._
    */
-  function getUserReserveData(
-    address asset,
-    address user
-  )
-    external
-    view
-    returns (
-      uint256 currentATokenBalance,
-      uint256 currentStableDebt,
-      uint256 currentVariableDebt,
-      uint256 principalStableDebt,
-      uint256 scaledVariableDebt,
-      uint256 stableBorrowRate,
-      uint256 liquidityRate,
-      uint40 stableRateLastUpdated,
-      bool usageAsCollateralEnabled
-    );
+  function toInt80(int256 value) internal pure returns (int80 downcasted) {
+    downcasted = int80(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 80 bits");
+  }
 
   /**
-   * @notice Returns the token addresses of the reserve
-   * @param asset The address of the underlying asset of the reserve
-   * @return aTokenAddress The AToken address of the reserve
-   * @return stableDebtTokenAddress DEPRECATED in v3.2.0
-   * @return variableDebtTokenAddress The VariableDebtToken address of the reserve
+   * @dev Returns the downcasted int72 from int256, reverting on
+   * overflow (when the input is less than smallest int72 or
+   * greater than largest int72).
+   *
+   * Counterpart to Solidity's `int72` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 72 bits
+   *
+   * _Available since v4.7._
    */
-  function getReserveTokensAddresses(
-    address asset
-  )
-    external
-    view
-    returns (
-      address aTokenAddress,
-      address stableDebtTokenAddress,
-      address variableDebtTokenAddress
-    );
+  function toInt72(int256 value) internal pure returns (int72 downcasted) {
+    downcasted = int72(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 72 bits");
+  }
 
   /**
-   * @notice Returns the address of the Interest Rate strategy
-   * @param asset The address of the underlying asset of the reserve
-   * @return irStrategyAddress The address of the Interest Rate strategy
+   * @dev Returns the downcasted int64 from int256, reverting on
+   * overflow (when the input is less than smallest int64 or
+   * greater than largest int64).
+   *
+   * Counterpart to Solidity's `int64` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 64 bits
+   *
+   * _Available since v3.1._
    */
-  function getInterestRateStrategyAddress(
-    address asset
-  ) external view returns (address irStrategyAddress);
+  function toInt64(int256 value) internal pure returns (int64 downcasted) {
+    downcasted = int64(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 64 bits");
+  }
 
   /**
-   * @notice Returns whether the reserve has FlashLoans enabled or disabled
-   * @param asset The address of the underlying asset of the reserve
-   * @return True if FlashLoans are enabled, false otherwise
+   * @dev Returns the downcasted int56 from int256, reverting on
+   * overflow (when the input is less than smallest int56 or
+   * greater than largest int56).
+   *
+   * Counterpart to Solidity's `int56` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 56 bits
+   *
+   * _Available since v4.7._
    */
-  function getFlashLoanEnabled(address asset) external view returns (bool);
+  function toInt56(int256 value) internal pure returns (int56 downcasted) {
+    downcasted = int56(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 56 bits");
+  }
 
   /**
-   * @notice Returns whether virtual accounting is enabled/not for a reserve
-   * @param asset The address of the underlying asset of the reserve
-   * @return True if active, false otherwise
+   * @dev Returns the downcasted int48 from int256, reverting on
+   * overflow (when the input is less than smallest int48 or
+   * greater than largest int48).
+   *
+   * Counterpart to Solidity's `int48` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 48 bits
+   *
+   * _Available since v4.7._
    */
-  function getIsVirtualAccActive(address asset) external view returns (bool);
+  function toInt48(int256 value) internal pure returns (int48 downcasted) {
+    downcasted = int48(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 48 bits");
+  }
 
   /**
-   * @notice Returns the virtual underlying balance of the reserve
-   * @param asset The address of the underlying asset of the reserve
-   * @return The reserve virtual underlying balance
+   * @dev Returns the downcasted int40 from int256, reverting on
+   * overflow (when the input is less than smallest int40 or
+   * greater than largest int40).
+   *
+   * Counterpart to Solidity's `int40` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 40 bits
+   *
+   * _Available since v4.7._
    */
-  function getVirtualUnderlyingBalance(address asset) external view returns (uint256);
+  function toInt40(int256 value) internal pure returns (int40 downcasted) {
+    downcasted = int40(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 40 bits");
+  }
 
   /**
-   * @notice Returns the deficit of the reserve
-   * @param asset The address of the underlying asset of the reserve
-   * @return The reserve deficit
+   * @dev Returns the downcasted int32 from int256, reverting on
+   * overflow (when the input is less than smallest int32 or
+   * greater than largest int32).
+   *
+   * Counterpart to Solidity's `int32` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 32 bits
+   *
+   * _Available since v3.1._
    */
-  function getReserveDeficit(address asset) external view returns (uint256);
-}
+  function toInt32(int256 value) internal pure returns (int32 downcasted) {
+    downcasted = int32(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 32 bits");
+  }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IReserveInterestRateStrategy.sol
+  /**
+   * @dev Returns the downcasted int24 from int256, reverting on
+   * overflow (when the input is less than smallest int24 or
+   * greater than largest int24).
+   *
+   * Counterpart to Solidity's `int24` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 24 bits
+   *
+   * _Available since v4.7._
+   */
+  function toInt24(int256 value) internal pure returns (int24 downcasted) {
+    downcasted = int24(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 24 bits");
+  }
 
-/**
- * @title IReserveInterestRateStrategy
- * @author BGD Labs
- * @notice Basic interface for any rate strategy used by the Aave protocol
- */
-interface IReserveInterestRateStrategy {
   /**
-   * @notice Sets interest rate data for an Aave rate strategy
-   * @param reserve The reserve to update
-   * @param rateData The abi encoded reserve interest rate data to apply to the given reserve
-   *   Abstracted this way as rate strategies can be custom
+   * @dev Returns the downcasted int16 from int256, reverting on
+   * overflow (when the input is less than smallest int16 or
+   * greater than largest int16).
+   *
+   * Counterpart to Solidity's `int16` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 16 bits
+   *
+   * _Available since v3.1._
    */
-  function setInterestRateParams(address reserve, bytes calldata rateData) external;
+  function toInt16(int256 value) internal pure returns (int16 downcasted) {
+    downcasted = int16(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 16 bits");
+  }
 
   /**
-   * @notice Calculates the interest rates depending on the reserve's state and configurations
-   * @param params The parameters needed to calculate interest rates
-   * @return liquidityRate The liquidity rate expressed in ray
-   * @return variableBorrowRate The variable borrow rate expressed in ray
+   * @dev Returns the downcasted int8 from int256, reverting on
+   * overflow (when the input is less than smallest int8 or
+   * greater than largest int8).
+   *
+   * Counterpart to Solidity's `int8` operator.
+   *
+   * Requirements:
+   *
+   * - input must fit into 8 bits
+   *
+   * _Available since v3.1._
    */
-  function calculateInterestRates(
-    DataTypes.CalculateInterestRatesParams memory params
-  ) external view returns (uint256, uint256);
-}
+  function toInt8(int256 value) internal pure returns (int8 downcasted) {
+    downcasted = int8(value);
+    require(downcasted == value, "SafeCast: value doesn't fit in 8 bits");
+  }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/access/Ownable.sol
+  /**
+   * @dev Converts an unsigned uint256 into a signed int256.
+   *
+   * Requirements:
+   *
+   * - input must be less than or equal to maxInt256.
+   *
+   * _Available since v3.0._
+   */
+  function toInt256(uint256 value) internal pure returns (int256) {
+    // Note: Unsafe cast below is okay because `type(int256).max` is guaranteed to be positive
+    require(value <= uint256(type(int256).max), "SafeCast: value doesn't fit in an int256");
+    return int256(value);
+  }
+}
 
-// OpenZeppelin Contracts (last updated v5.0.0) (access/Ownable.sol)
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IACLManager.sol
 
 /**
- * @dev Contract module which provides a basic access control mechanism, where
- * there is an account (an owner) that can be granted exclusive access to
- * specific functions.
- *
- * The initial owner is set to the address provided by the deployer. This can
- * later be changed with {transferOwnership}.
- *
- * This module is used through inheritance. It will make available the modifier
- * `onlyOwner`, which can be applied to your functions to restrict their use to
- * the owner.
+ * @title IACLManager
+ * @author Aave
+ * @notice Defines the basic interface for the ACL Manager
  */
-abstract contract Ownable is Context {
-    address private _owner;
-
-    /**
-     * @dev The caller account is not authorized to perform an operation.
-     */
-    error OwnableUnauthorizedAccount(address account);
-
-    /**
-     * @dev The owner is not a valid owner account. (eg. `address(0)`)
-     */
-    error OwnableInvalidOwner(address owner);
-
-    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
-
-    /**
-     * @dev Initializes the contract setting the address provided by the deployer as the initial owner.
-     */
-    constructor(address initialOwner) {
-        if (initialOwner == address(0)) {
-            revert OwnableInvalidOwner(address(0));
-        }
-        _transferOwnership(initialOwner);
-    }
-
-    /**
-     * @dev Throws if called by any account other than the owner.
-     */
-    modifier onlyOwner() {
-        _checkOwner();
-        _;
-    }
-
-    /**
-     * @dev Returns the address of the current owner.
-     */
-    function owner() public view virtual returns (address) {
-        return _owner;
-    }
-
-    /**
-     * @dev Throws if the sender is not the owner.
-     */
-    function _checkOwner() internal view virtual {
-        if (owner() != _msgSender()) {
-            revert OwnableUnauthorizedAccount(_msgSender());
-        }
-    }
-
-    /**
-     * @dev Leaves the contract without owner. It will not be possible to call
-     * `onlyOwner` functions. Can only be called by the current owner.
-     *
-     * NOTE: Renouncing ownership will leave the contract without an owner,
-     * thereby disabling any functionality that is only available to the owner.
-     */
-    function renounceOwnership() public virtual onlyOwner {
-        _transferOwnership(address(0));
-    }
-
-    /**
-     * @dev Transfers ownership of the contract to a new account (`newOwner`).
-     * Can only be called by the current owner.
-     */
-    function transferOwnership(address newOwner) public virtual onlyOwner {
-        if (newOwner == address(0)) {
-            revert OwnableInvalidOwner(address(0));
-        }
-        _transferOwnership(newOwner);
-    }
+interface IACLManager_0 {
+  /**
+   * @notice Returns the contract address of the PoolAddressesProvider
+   * @return The address of the PoolAddressesProvider
+   */
+  function ADDRESSES_PROVIDER() external view returns (IPoolAddressesProvider);
 
-    /**
-     * @dev Transfers ownership of the contract to a new account (`newOwner`).
-     * Internal function without access restriction.
-     */
-    function _transferOwnership(address newOwner) internal virtual {
-        address oldOwner = _owner;
-        _owner = newOwner;
-        emit OwnershipTransferred(oldOwner, newOwner);
-    }
-}
+  /**
+   * @notice Returns the identifier of the PoolAdmin role
+   * @return The id of the PoolAdmin role
+   */
+  function POOL_ADMIN_ROLE() external view returns (bytes32);
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol
+  /**
+   * @notice Returns the identifier of the EmergencyAdmin role
+   * @return The id of the EmergencyAdmin role
+   */
+  function EMERGENCY_ADMIN_ROLE() external view returns (bytes32);
 
-// OpenZeppelin Contracts (last updated v5.1.0) (utils/math/SignedMath.sol)
+  /**
+   * @notice Returns the identifier of the RiskAdmin role
+   * @return The id of the RiskAdmin role
+   */
+  function RISK_ADMIN_ROLE() external view returns (bytes32);
 
-/**
- * @dev Standard signed math utilities missing in the Solidity language.
- */
-library SignedMath {
-    /**
-     * @dev Branchless ternary evaluation for `a ? b : c`. Gas costs are constant.
-     *
-     * IMPORTANT: This function may reduce bytecode size and consume less gas when used standalone.
-     * However, the compiler may optimize Solidity ternary operations (i.e. `a ? b : c`) to only compute
-     * one branch when needed, making this function more expensive.
-     */
-    function ternary(bool condition, int256 a, int256 b) internal pure returns (int256) {
-        unchecked {
-            // branchless ternary works because:
-            // b ^ (a ^ b) == a
-            // b ^ 0 == b
-            return b ^ ((a ^ b) * int256(SafeCast.toUint(condition)));
-        }
-    }
+  /**
+   * @notice Returns the identifier of the FlashBorrower role
+   * @return The id of the FlashBorrower role
+   */
+  function FLASH_BORROWER_ROLE() external view returns (bytes32);
 
-    /**
-     * @dev Returns the largest of two signed numbers.
-     */
-    function max(int256 a, int256 b) internal pure returns (int256) {
-        return ternary(a > b, a, b);
-    }
+  /**
+   * @notice Returns the identifier of the Bridge role
+   * @return The id of the Bridge role
+   */
+  function BRIDGE_ROLE() external view returns (bytes32);
 
-    /**
-     * @dev Returns the smallest of two signed numbers.
-     */
-    function min(int256 a, int256 b) internal pure returns (int256) {
-        return ternary(a < b, a, b);
-    }
+  /**
+   * @notice Returns the identifier of the AssetListingAdmin role
+   * @return The id of the AssetListingAdmin role
+   */
+  function ASSET_LISTING_ADMIN_ROLE() external view returns (bytes32);
 
-    /**
-     * @dev Returns the average of two signed numbers without overflow.
-     * The result is rounded towards zero.
-     */
-    function average(int256 a, int256 b) internal pure returns (int256) {
-        // Formula from the book "Hacker's Delight"
-        int256 x = (a & b) + ((a ^ b) >> 1);
-        return x + (int256(uint256(x) >> 255) & (a ^ b));
-    }
+  /**
+   * @notice Set the role as admin of a specific role.
+   * @dev By default the admin role for all roles is `DEFAULT_ADMIN_ROLE`.
+   * @param role The role to be managed by the admin role
+   * @param adminRole The admin role
+   */
+  function setRoleAdmin(bytes32 role, bytes32 adminRole) external;
 
-    /**
-     * @dev Returns the absolute unsigned value of a signed value.
-     */
-    function abs(int256 n) internal pure returns (uint256) {
-        unchecked {
-            // Formula from the "Bit Twiddling Hacks" by Sean Eron Anderson.
-            // Since `n` is a signed integer, the generated bytecode will use the SAR opcode to perform the right shift,
-            // taking advantage of the most significant (or "sign" bit) in two's complement representation.
-            // This opcode adds new most significant bits set to the value of the previous most significant bit. As a result,
-            // the mask will either be `bytes32(0)` (if n is positive) or `~bytes32(0)` (if n is negative).
-            int256 mask = n >> 255;
-
-            // A `bytes32(0)` mask leaves the input unchanged, while a `~bytes32(0)` mask complements it.
-            return uint256((n + mask) ^ mask);
-        }
-    }
-}
+  /**
+   * @notice Adds a new admin as PoolAdmin
+   * @param admin The address of the new admin
+   */
+  function addPoolAdmin(address admin) external;
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IAaveOracle.sol
+  /**
+   * @notice Removes an admin as PoolAdmin
+   * @param admin The address of the admin to remove
+   */
+  function removePoolAdmin(address admin) external;
 
-/**
- * @title IAaveOracle
- * @author Aave
- * @notice Defines the basic interface for the Aave Oracle
- */
-interface IAaveOracle is IPriceOracleGetter {
   /**
-   * @dev Emitted after the base currency is set
-   * @param baseCurrency The base currency of used for price quotes
-   * @param baseCurrencyUnit The unit of the base currency
+   * @notice Returns true if the address is PoolAdmin, false otherwise
+   * @param admin The address to check
+   * @return True if the given address is PoolAdmin, false otherwise
    */
-  event BaseCurrencySet(address indexed baseCurrency, uint256 baseCurrencyUnit);
+  function isPoolAdmin(address admin) external view returns (bool);
 
   /**
-   * @dev Emitted after the price source of an asset is updated
-   * @param asset The address of the asset
-   * @param source The price source of the asset
+   * @notice Adds a new admin as EmergencyAdmin
+   * @param admin The address of the new admin
    */
-  event AssetSourceUpdated(address indexed asset, address indexed source);
+  function addEmergencyAdmin(address admin) external;
 
   /**
-   * @dev Emitted after the address of fallback oracle is updated
-   * @param fallbackOracle The address of the fallback oracle
+   * @notice Removes an admin as EmergencyAdmin
+   * @param admin The address of the admin to remove
    */
-  event FallbackOracleUpdated(address indexed fallbackOracle);
+  function removeEmergencyAdmin(address admin) external;
 
   /**
-   * @notice Returns the PoolAddressesProvider
-   * @return The address of the PoolAddressesProvider contract
+   * @notice Returns true if the address is EmergencyAdmin, false otherwise
+   * @param admin The address to check
+   * @return True if the given address is EmergencyAdmin, false otherwise
    */
-  function ADDRESSES_PROVIDER() external view returns (IPoolAddressesProvider);
+  function isEmergencyAdmin(address admin) external view returns (bool);
 
   /**
-   * @notice Sets or replaces price sources of assets
-   * @param assets The addresses of the assets
-   * @param sources The addresses of the price sources
+   * @notice Adds a new admin as RiskAdmin
+   * @param admin The address of the new admin
    */
-  function setAssetSources(address[] calldata assets, address[] calldata sources) external;
+  function addRiskAdmin(address admin) external;
 
   /**
-   * @notice Sets the fallback oracle
-   * @param fallbackOracle The address of the fallback oracle
+   * @notice Removes an admin as RiskAdmin
+   * @param admin The address of the admin to remove
    */
-  function setFallbackOracle(address fallbackOracle) external;
+  function removeRiskAdmin(address admin) external;
 
   /**
-   * @notice Returns a list of prices from a list of assets addresses
-   * @param assets The list of assets addresses
-   * @return The prices of the given assets
+   * @notice Returns true if the address is RiskAdmin, false otherwise
+   * @param admin The address to check
+   * @return True if the given address is RiskAdmin, false otherwise
    */
-  function getAssetsPrices(address[] calldata assets) external view returns (uint256[] memory);
+  function isRiskAdmin(address admin) external view returns (bool);
 
   /**
-   * @notice Returns the address of the source for an asset address
-   * @param asset The address of the asset
-   * @return The address of the source
+   * @notice Adds a new address as FlashBorrower
+   * @param borrower The address of the new FlashBorrower
    */
-  function getSourceOfAsset(address asset) external view returns (address);
+  function addFlashBorrower(address borrower) external;
 
   /**
-   * @notice Returns the address of the fallback oracle
-   * @return The address of the fallback oracle
+   * @notice Removes an address as FlashBorrower
+   * @param borrower The address of the FlashBorrower to remove
    */
-  function getFallbackOracle() external view returns (address);
-}
+  function removeFlashBorrower(address borrower) external;
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPool.sol
+  /**
+   * @notice Returns true if the address is FlashBorrower, false otherwise
+   * @param borrower The address to check
+   * @return True if the given address is FlashBorrower, false otherwise
+   */
+  function isFlashBorrower(address borrower) external view returns (bool);
 
-/**
- * @title IPool
- * @author Aave
- * @notice Defines the basic interface for an Aave Pool.
- */
-interface IPool {
   /**
-   * @dev Emitted on mintUnbacked()
-   * @param reserve The address of the underlying asset of the reserve
-   * @param user The address initiating the supply
-   * @param onBehalfOf The beneficiary of the supplied assets, receiving the aTokens
-   * @param amount The amount of supplied assets
-   * @param referralCode The referral code used
+   * @notice Adds a new address as Bridge
+   * @param bridge The address of the new Bridge
    */
-  event MintUnbacked(
-    address indexed reserve,
-    address user,
-    address indexed onBehalfOf,
-    uint256 amount,
-    uint16 indexed referralCode
-  );
+  function addBridge(address bridge) external;
 
   /**
-   * @dev Emitted on backUnbacked()
-   * @param reserve The address of the underlying asset of the reserve
-   * @param backer The address paying for the backing
-   * @param amount The amount added as backing
-   * @param fee The amount paid in fees
+   * @notice Removes an address as Bridge
+   * @param bridge The address of the bridge to remove
    */
-  event BackUnbacked(address indexed reserve, address indexed backer, uint256 amount, uint256 fee);
+  function removeBridge(address bridge) external;
 
   /**
-   * @dev Emitted on supply()
-   * @param reserve The address of the underlying asset of the reserve
-   * @param user The address initiating the supply
-   * @param onBehalfOf The beneficiary of the supply, receiving the aTokens
-   * @param amount The amount supplied
-   * @param referralCode The referral code used
+   * @notice Returns true if the address is Bridge, false otherwise
+   * @param bridge The address to check
+   * @return True if the given address is Bridge, false otherwise
    */
-  event Supply(
-    address indexed reserve,
-    address user,
-    address indexed onBehalfOf,
-    uint256 amount,
-    uint16 indexed referralCode
-  );
+  function isBridge(address bridge) external view returns (bool);
 
   /**
-   * @dev Emitted on withdraw()
-   * @param reserve The address of the underlying asset being withdrawn
-   * @param user The address initiating the withdrawal, owner of aTokens
-   * @param to The address that will receive the underlying
-   * @param amount The amount to be withdrawn
+   * @notice Adds a new admin as AssetListingAdmin
+   * @param admin The address of the new admin
    */
-  event Withdraw(address indexed reserve, address indexed user, address indexed to, uint256 amount);
+  function addAssetListingAdmin(address admin) external;
 
   /**
-   * @dev Emitted on borrow() and flashLoan() when debt needs to be opened
-   * @param reserve The address of the underlying asset being borrowed
-   * @param user The address of the user initiating the borrow(), receiving the funds on borrow() or just
-   * initiator of the transaction on flashLoan()
-   * @param onBehalfOf The address that will be getting the debt
-   * @param amount The amount borrowed out
-   * @param interestRateMode The rate mode: 2 for Variable, 1 is deprecated (changed on v3.2.0)
-   * @param borrowRate The numeric rate at which the user has borrowed, expressed in ray
-   * @param referralCode The referral code used
+   * @notice Removes an admin as AssetListingAdmin
+   * @param admin The address of the admin to remove
    */
-  event Borrow(
-    address indexed reserve,
-    address user,
-    address indexed onBehalfOf,
-    uint256 amount,
-    DataTypes.InterestRateMode interestRateMode,
-    uint256 borrowRate,
-    uint16 indexed referralCode
-  );
+  function removeAssetListingAdmin(address admin) external;
 
   /**
-   * @dev Emitted on repay()
-   * @param reserve The address of the underlying asset of the reserve
-   * @param user The beneficiary of the repayment, getting his debt reduced
-   * @param repayer The address of the user initiating the repay(), providing the funds
-   * @param amount The amount repaid
-   * @param useATokens True if the repayment is done using aTokens, `false` if done with underlying asset directly
+   * @notice Returns true if the address is AssetListingAdmin, false otherwise
+   * @param admin The address to check
+   * @return True if the given address is AssetListingAdmin, false otherwise
    */
-  event Repay(
-    address indexed reserve,
-    address indexed user,
-    address indexed repayer,
-    uint256 amount,
-    bool useATokens
-  );
+  function isAssetListingAdmin(address admin) external view returns (bool);
+}
+
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPoolDataProvider.sol
+
+/**
+ * @title IPoolDataProvider
+ * @author Aave
+ * @notice Defines the basic interface of a PoolDataProvider
+ */
+interface IPoolDataProvider {
+  struct TokenData {
+    string symbol;
+    address tokenAddress;
+  }
 
   /**
-   * @dev Emitted on borrow(), repay() and liquidationCall() when using isolated assets
-   * @param asset The address of the underlying asset of the reserve
-   * @param totalDebt The total isolation mode debt for the reserve
+   * @notice Returns the address for the PoolAddressesProvider contract.
+   * @return The address for the PoolAddressesProvider contract
    */
-  event IsolationModeTotalDebtUpdated(address indexed asset, uint256 totalDebt);
+  function ADDRESSES_PROVIDER() external view returns (IPoolAddressesProvider);
 
   /**
-   * @dev Emitted when the user selects a certain asset category for eMode
-   * @param user The address of the user
-   * @param categoryId The category id
+   * @notice Returns the list of the existing reserves in the pool.
+   * @dev Handling MKR and ETH in a different way since they do not have standard `symbol` functions.
+   * @return The list of reserves, pairs of symbols and addresses
    */
-  event UserEModeSet(address indexed user, uint8 categoryId);
+  function getAllReservesTokens() external view returns (TokenData[] memory);
 
   /**
-   * @dev Emitted on setUserUseReserveAsCollateral()
-   * @param reserve The address of the underlying asset of the reserve
-   * @param user The address of the user enabling the usage as collateral
+   * @notice Returns the list of the existing ATokens in the pool.
+   * @return The list of ATokens, pairs of symbols and addresses
    */
-  event ReserveUsedAsCollateralEnabled(address indexed reserve, address indexed user);
+  function getAllATokens() external view returns (TokenData[] memory);
+
+  /**
+   * @notice Returns the configuration data of the reserve
+   * @dev Not returning borrow and supply caps for compatibility, nor pause flag
+   * @param asset The address of the underlying asset of the reserve
+   * @return decimals The number of decimals of the reserve
+   * @return ltv The ltv of the reserve
+   * @return liquidationThreshold The liquidationThreshold of the reserve
+   * @return liquidationBonus The liquidationBonus of the reserve
+   * @return reserveFactor The reserveFactor of the reserve
+   * @return usageAsCollateralEnabled True if the usage as collateral is enabled, false otherwise
+   * @return borrowingEnabled True if borrowing is enabled, false otherwise
+   * @return stableBorrowRateEnabled True if stable rate borrowing is enabled, false otherwise
+   * @return isActive True if it is active, false otherwise
+   * @return isFrozen True if it is frozen, false otherwise
+   */
+  function getReserveConfigurationData(
+    address asset
+  )
+    external
+    view
+    returns (
+      uint256 decimals,
+      uint256 ltv,
+      uint256 liquidationThreshold,
+      uint256 liquidationBonus,
+      uint256 reserveFactor,
+      bool usageAsCollateralEnabled,
+      bool borrowingEnabled,
+      bool stableBorrowRateEnabled,
+      bool isActive,
+      bool isFrozen
+    );
 
   /**
-   * @dev Emitted on setUserUseReserveAsCollateral()
-   * @param reserve The address of the underlying asset of the reserve
-   * @param user The address of the user enabling the usage as collateral
+   * @notice Returns the caps parameters of the reserve
+   * @param asset The address of the underlying asset of the reserve
+   * @return borrowCap The borrow cap of the reserve
+   * @return supplyCap The supply cap of the reserve
    */
-  event ReserveUsedAsCollateralDisabled(address indexed reserve, address indexed user);
+  function getReserveCaps(
+    address asset
+  ) external view returns (uint256 borrowCap, uint256 supplyCap);
 
   /**
-   * @dev Emitted on flashLoan()
-   * @param target The address of the flash loan receiver contract
-   * @param initiator The address initiating the flash loan
-   * @param asset The address of the asset being flash borrowed
-   * @param amount The amount flash borrowed
-   * @param interestRateMode The flashloan mode: 0 for regular flashloan,
-   *        1 for Stable (Deprecated on v3.2.0), 2 for Variable
-   * @param premium The fee flash borrowed
-   * @param referralCode The referral code used
+   * @notice Returns if the pool is paused
+   * @param asset The address of the underlying asset of the reserve
+   * @return isPaused True if the pool is paused, false otherwise
    */
-  event FlashLoan(
-    address indexed target,
-    address initiator,
-    address indexed asset,
-    uint256 amount,
-    DataTypes.InterestRateMode interestRateMode,
-    uint256 premium,
-    uint16 indexed referralCode
-  );
+  function getPaused(address asset) external view returns (bool isPaused);
 
   /**
-   * @dev Emitted when a borrower is liquidated.
-   * @param collateralAsset The address of the underlying asset used as collateral, to receive as result of the liquidation
-   * @param debtAsset The address of the underlying borrowed asset to be repaid with the liquidation
-   * @param user The address of the borrower getting liquidated
-   * @param debtToCover The debt amount of borrowed `asset` the liquidator wants to cover
-   * @param liquidatedCollateralAmount The amount of collateral received by the liquidator
-   * @param liquidator The address of the liquidator
-   * @param receiveAToken True if the liquidators wants to receive the collateral aTokens, `false` if he wants
-   * to receive the underlying collateral asset directly
+   * @notice Returns the siloed borrowing flag
+   * @param asset The address of the underlying asset of the reserve
+   * @return True if the asset is siloed for borrowing
    */
-  event LiquidationCall(
-    address indexed collateralAsset,
-    address indexed debtAsset,
-    address indexed user,
-    uint256 debtToCover,
-    uint256 liquidatedCollateralAmount,
-    address liquidator,
-    bool receiveAToken
-  );
+  function getSiloedBorrowing(address asset) external view returns (bool);
 
   /**
-   * @dev Emitted when the state of a reserve is updated.
-   * @param reserve The address of the underlying asset of the reserve
-   * @param liquidityRate The next liquidity rate
-   * @param stableBorrowRate The next stable borrow rate @note deprecated on v3.2.0
-   * @param variableBorrowRate The next variable borrow rate
-   * @param liquidityIndex The next liquidity index
-   * @param variableBorrowIndex The next variable borrow index
+   * @notice Returns the protocol fee on the liquidation bonus
+   * @param asset The address of the underlying asset of the reserve
+   * @return The protocol fee on liquidation
    */
-  event ReserveDataUpdated(
-    address indexed reserve,
-    uint256 liquidityRate,
-    uint256 stableBorrowRate,
-    uint256 variableBorrowRate,
-    uint256 liquidityIndex,
-    uint256 variableBorrowIndex
-  );
+  function getLiquidationProtocolFee(address asset) external view returns (uint256);
 
   /**
-   * @dev Emitted when the deficit of a reserve is covered.
-   * @param reserve The address of the underlying asset of the reserve
-   * @param caller The caller that triggered the DeficitCovered event
-   * @param amountCovered The amount of deficit covered
+   * @notice Returns the unbacked mint cap of the reserve
+   * @param asset The address of the underlying asset of the reserve
+   * @return The unbacked mint cap of the reserve
    */
-  event DeficitCovered(address indexed reserve, address caller, uint256 amountCovered);
+  function getUnbackedMintCap(address asset) external view returns (uint256);
 
   /**
-   * @dev Emitted when the protocol treasury receives minted aTokens from the accrued interest.
-   * @param reserve The address of the reserve
-   * @param amountMinted The amount minted to the treasury
+   * @notice Returns the debt ceiling of the reserve
+   * @param asset The address of the underlying asset of the reserve
+   * @return The debt ceiling of the reserve
    */
-  event MintedToTreasury(address indexed reserve, uint256 amountMinted);
+  function getDebtCeiling(address asset) external view returns (uint256);
 
   /**
-   * @dev Emitted when deficit is realized on a liquidation.
-   * @param user The user address where the bad debt will be burned
-   * @param debtAsset The address of the underlying borrowed asset to be burned
-   * @param amountCreated The amount of deficit created
+   * @notice Returns the debt ceiling decimals
+   * @return The debt ceiling decimals
    */
-  event DeficitCreated(address indexed user, address indexed debtAsset, uint256 amountCreated);
+  function getDebtCeilingDecimals() external pure returns (uint256);
 
   /**
-   * @notice Mints an `amount` of aTokens to the `onBehalfOf`
-   * @param asset The address of the underlying asset to mint
-   * @param amount The amount to mint
-   * @param onBehalfOf The address that will receive the aTokens
-   * @param referralCode Code used to register the integrator originating the operation, for potential rewards.
-   *   0 if the action is executed directly by the user, without any middle-man
+   * @notice Returns the reserve data
+   * @param asset The address of the underlying asset of the reserve
+   * @return unbacked The amount of unbacked tokens
+   * @return accruedToTreasuryScaled The scaled amount of tokens accrued to treasury that is to be minted
+   * @return totalAToken The total supply of the aToken
+   * @return totalStableDebt The total stable debt of the reserve
+   * @return totalVariableDebt The total variable debt of the reserve
+   * @return liquidityRate The liquidity rate of the reserve
+   * @return variableBorrowRate The variable borrow rate of the reserve
+   * @return stableBorrowRate The stable borrow rate of the reserve
+   * @return averageStableBorrowRate The average stable borrow rate of the reserve
+   * @return liquidityIndex The liquidity index of the reserve
+   * @return variableBorrowIndex The variable borrow index of the reserve
+   * @return lastUpdateTimestamp The timestamp of the last update of the reserve
    */
-  function mintUnbacked(
-    address asset,
-    uint256 amount,
-    address onBehalfOf,
-    uint16 referralCode
-  ) external;
+  function getReserveData(
+    address asset
+  )
+    external
+    view
+    returns (
+      uint256 unbacked,
+      uint256 accruedToTreasuryScaled,
+      uint256 totalAToken,
+      uint256 totalStableDebt,
+      uint256 totalVariableDebt,
+      uint256 liquidityRate,
+      uint256 variableBorrowRate,
+      uint256 stableBorrowRate,
+      uint256 averageStableBorrowRate,
+      uint256 liquidityIndex,
+      uint256 variableBorrowIndex,
+      uint40 lastUpdateTimestamp
+    );
 
   /**
-   * @notice Back the current unbacked underlying with `amount` and pay `fee`.
-   * @param asset The address of the underlying asset to back
-   * @param amount The amount to back
-   * @param fee The amount paid in fees
-   * @return The backed amount
+   * @notice Returns the total supply of aTokens for a given asset
+   * @param asset The address of the underlying asset of the reserve
+   * @return The total supply of the aToken
    */
-  function backUnbacked(address asset, uint256 amount, uint256 fee) external returns (uint256);
+  function getATokenTotalSupply(address asset) external view returns (uint256);
 
   /**
-   * @notice Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
-   * - E.g. User supplies 100 USDC and gets in return 100 aUSDC
-   * @param asset The address of the underlying asset to supply
-   * @param amount The amount to be supplied
-   * @param onBehalfOf The address that will receive the aTokens, same as msg.sender if the user
-   *   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens
-   *   is a different wallet
-   * @param referralCode Code used to register the integrator originating the operation, for potential rewards.
-   *   0 if the action is executed directly by the user, without any middle-man
+   * @notice Returns the total debt for a given asset
+   * @param asset The address of the underlying asset of the reserve
+   * @return The total debt for asset
    */
-  function supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
+  function getTotalDebt(address asset) external view returns (uint256);
 
   /**
-   * @notice Supply with transfer approval of asset to be supplied done via permit function
-   * see: https://eips.ethereum.org/EIPS/eip-2612 and https://eips.ethereum.org/EIPS/eip-713
-   * @param asset The address of the underlying asset to supply
-   * @param amount The amount to be supplied
-   * @param onBehalfOf The address that will receive the aTokens, same as msg.sender if the user
-   *   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens
-   *   is a different wallet
-   * @param deadline The deadline timestamp that the permit is valid
-   * @param referralCode Code used to register the integrator originating the operation, for potential rewards.
-   *   0 if the action is executed directly by the user, without any middle-man
-   * @param permitV The V parameter of ERC712 permit sig
-   * @param permitR The R parameter of ERC712 permit sig
-   * @param permitS The S parameter of ERC712 permit sig
+   * @notice Returns the user data in a reserve
+   * @param asset The address of the underlying asset of the reserve
+   * @param user The address of the user
+   * @return currentATokenBalance The current AToken balance of the user
+   * @return currentStableDebt The current stable debt of the user
+   * @return currentVariableDebt The current variable debt of the user
+   * @return principalStableDebt The principal stable debt of the user
+   * @return scaledVariableDebt The scaled variable debt of the user
+   * @return stableBorrowRate The stable borrow rate of the user
+   * @return liquidityRate The liquidity rate of the reserve
+   * @return stableRateLastUpdated The timestamp of the last update of the user stable rate
+   * @return usageAsCollateralEnabled True if the user is using the asset as collateral, false
+   *         otherwise
    */
-  function supplyWithPermit(
+  function getUserReserveData(
     address asset,
-    uint256 amount,
-    address onBehalfOf,
-    uint16 referralCode,
-    uint256 deadline,
-    uint8 permitV,
-    bytes32 permitR,
-    bytes32 permitS
-  ) external;
+    address user
+  )
+    external
+    view
+    returns (
+      uint256 currentATokenBalance,
+      uint256 currentStableDebt,
+      uint256 currentVariableDebt,
+      uint256 principalStableDebt,
+      uint256 scaledVariableDebt,
+      uint256 stableBorrowRate,
+      uint256 liquidityRate,
+      uint40 stableRateLastUpdated,
+      bool usageAsCollateralEnabled
+    );
 
   /**
-   * @notice Withdraws an `amount` of underlying asset from the reserve, burning the equivalent aTokens owned
-   * E.g. User has 100 aUSDC, calls withdraw() and receives 100 USDC, burning the 100 aUSDC
-   * @param asset The address of the underlying asset to withdraw
-   * @param amount The underlying amount to be withdrawn
-   *   - Send the value type(uint256).max in order to withdraw the whole aToken balance
-   * @param to The address that will receive the underlying, same as msg.sender if the user
-   *   wants to receive it on his own wallet, or a different address if the beneficiary is a
-   *   different wallet
-   * @return The final amount withdrawn
+   * @notice Returns the token addresses of the reserve
+   * @param asset The address of the underlying asset of the reserve
+   * @return aTokenAddress The AToken address of the reserve
+   * @return stableDebtTokenAddress DEPRECATED in v3.2.0
+   * @return variableDebtTokenAddress The VariableDebtToken address of the reserve
    */
-  function withdraw(address asset, uint256 amount, address to) external returns (uint256);
+  function getReserveTokensAddresses(
+    address asset
+  )
+    external
+    view
+    returns (
+      address aTokenAddress,
+      address stableDebtTokenAddress,
+      address variableDebtTokenAddress
+    );
 
   /**
-   * @notice Allows users to borrow a specific `amount` of the reserve underlying asset, provided that the borrower
-   * already supplied enough collateral, or he was given enough allowance by a credit delegator on the VariableDebtToken
-   * - E.g. User borrows 100 USDC passing as `onBehalfOf` his own address, receiving the 100 USDC in his wallet
-   *   and 100 variable debt tokens
-   * @param asset The address of the underlying asset to borrow
-   * @param amount The amount to be borrowed
-   * @param interestRateMode 2 for Variable, 1 is deprecated on v3.2.0
-   * @param referralCode The code used to register the integrator originating the operation, for potential rewards.
-   *   0 if the action is executed directly by the user, without any middle-man
-   * @param onBehalfOf The address of the user who will receive the debt. Should be the address of the borrower itself
-   * calling the function if he wants to borrow against his own collateral, or the address of the credit delegator
-   * if he has been given credit delegation allowance
+   * @notice Returns the address of the Interest Rate strategy
+   * @param asset The address of the underlying asset of the reserve
+   * @return irStrategyAddress The address of the Interest Rate strategy
    */
-  function borrow(
-    address asset,
-    uint256 amount,
-    uint256 interestRateMode,
-    uint16 referralCode,
-    address onBehalfOf
-  ) external;
+  function getInterestRateStrategyAddress(
+    address asset
+  ) external view returns (address irStrategyAddress);
 
   /**
-   * @notice Repays a borrowed `amount` on a specific reserve, burning the equivalent debt tokens owned
-   * - E.g. User repays 100 USDC, burning 100 variable debt tokens of the `onBehalfOf` address
-   * @param asset The address of the borrowed underlying asset previously borrowed
-   * @param amount The amount to repay
-   * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
-   * @param interestRateMode 2 for Variable, 1 is deprecated on v3.2.0
-   * @param onBehalfOf The address of the user who will get his debt reduced/removed. Should be the address of the
-   * user calling the function if he wants to reduce/remove his own debt, or the address of any other
-   * other borrower whose debt should be removed
-   * @return The final amount repaid
+   * @notice Returns whether the reserve has FlashLoans enabled or disabled
+   * @param asset The address of the underlying asset of the reserve
+   * @return True if FlashLoans are enabled, false otherwise
    */
-  function repay(
-    address asset,
-    uint256 amount,
-    uint256 interestRateMode,
-    address onBehalfOf
-  ) external returns (uint256);
+  function getFlashLoanEnabled(address asset) external view returns (bool);
 
   /**
-   * @notice Repay with transfer approval of asset to be repaid done via permit function
-   * see: https://eips.ethereum.org/EIPS/eip-2612 and https://eips.ethereum.org/EIPS/eip-713
-   * @param asset The address of the borrowed underlying asset previously borrowed
-   * @param amount The amount to repay
-   * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
-   * @param interestRateMode 2 for Variable, 1 is deprecated on v3.2.0
-   * @param onBehalfOf Address of the user who will get his debt reduced/removed. Should be the address of the
-   * user calling the function if he wants to reduce/remove his own debt, or the address of any other
-   * other borrower whose debt should be removed
-   * @param deadline The deadline timestamp that the permit is valid
-   * @param permitV The V parameter of ERC712 permit sig
-   * @param permitR The R parameter of ERC712 permit sig
-   * @param permitS The S parameter of ERC712 permit sig
-   * @return The final amount repaid
+   * @notice Returns whether virtual accounting is enabled/not for a reserve
+   * @param asset The address of the underlying asset of the reserve
+   * @return True if active, false otherwise
    */
-  function repayWithPermit(
-    address asset,
-    uint256 amount,
-    uint256 interestRateMode,
-    address onBehalfOf,
-    uint256 deadline,
-    uint8 permitV,
-    bytes32 permitR,
-    bytes32 permitS
-  ) external returns (uint256);
+  function getIsVirtualAccActive(address asset) external view returns (bool);
 
   /**
-   * @notice Repays a borrowed `amount` on a specific reserve using the reserve aTokens, burning the
-   * equivalent debt tokens
-   * - E.g. User repays 100 USDC using 100 aUSDC, burning 100 variable debt tokens
-   * @dev  Passing uint256.max as amount will clean up any residual aToken dust balance, if the user aToken
-   * balance is not enough to cover the whole debt
-   * @param asset The address of the borrowed underlying asset previously borrowed
-   * @param amount The amount to repay
-   * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
-   * @param interestRateMode DEPRECATED in v3.2.0
-   * @return The final amount repaid
+   * @notice Returns the virtual underlying balance of the reserve
+   * @param asset The address of the underlying asset of the reserve
+   * @return The reserve virtual underlying balance
    */
-  function repayWithATokens(
-    address asset,
-    uint256 amount,
-    uint256 interestRateMode
-  ) external returns (uint256);
+  function getVirtualUnderlyingBalance(address asset) external view returns (uint256);
+}
 
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IReserveInterestRateStrategy.sol
+
+/**
+ * @title IReserveInterestRateStrategy
+ * @author BGD Labs
+ * @notice Basic interface for any rate strategy used by the Aave protocol
+ */
+interface IReserveInterestRateStrategy {
   /**
-   * @notice Allows suppliers to enable/disable a specific supplied asset as collateral
-   * @param asset The address of the underlying asset supplied
-   * @param useAsCollateral True if the user wants to use the supply as collateral, false otherwise
+   * @notice Sets interest rate data for an Aave rate strategy
+   * @param reserve The reserve to update
+   * @param rateData The abi encoded reserve interest rate data to apply to the given reserve
+   *   Abstracted this way as rate strategies can be custom
    */
-  function setUserUseReserveAsCollateral(address asset, bool useAsCollateral) external;
+  function setInterestRateParams(address reserve, bytes calldata rateData) external;
 
   /**
-   * @notice Function to liquidate a non-healthy position collateral-wise, with Health Factor below 1
-   * - The caller (liquidator) covers `debtToCover` amount of debt of the user getting liquidated, and receives
-   *   a proportionally amount of the `collateralAsset` plus a bonus to cover market risk
-   * @param collateralAsset The address of the underlying asset used as collateral, to receive as result of the liquidation
-   * @param debtAsset The address of the underlying borrowed asset to be repaid with the liquidation
-   * @param user The address of the borrower getting liquidated
-   * @param debtToCover The debt amount of borrowed `asset` the liquidator wants to cover
-   * @param receiveAToken True if the liquidators wants to receive the collateral aTokens, `false` if he wants
-   * to receive the underlying collateral asset directly
+   * @notice Calculates the interest rates depending on the reserve's state and configurations
+   * @param params The parameters needed to calculate interest rates
+   * @return liquidityRate The liquidity rate expressed in ray
+   * @return variableBorrowRate The variable borrow rate expressed in ray
    */
-  function liquidationCall(
-    address collateralAsset,
-    address debtAsset,
-    address user,
-    uint256 debtToCover,
-    bool receiveAToken
-  ) external;
+  function calculateInterestRates(
+    DataTypes.CalculateInterestRatesParams memory params
+  ) external view returns (uint256, uint256);
+}
+
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/src/contracts/oz-common/Ownable.sol
+
+// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)
+// From commit https://github.com/OpenZeppelin/openzeppelin-contracts/commit/8b778fa20d6d76340c5fac1ed66c80273f05b95a
+
+/**
+ * @dev Contract module which provides a basic access control mechanism, where
+ * there is an account (an owner) that can be granted exclusive access to
+ * specific functions.
+ *
+ * By default, the owner account will be the one that deploys the contract. This
+ * can later be changed with {transferOwnership}.
+ *
+ * This module is used through inheritance. It will make available the modifier
+ * `onlyOwner`, which can be applied to your functions to restrict their use to
+ * the owner.
+ */
+abstract contract Ownable is Context {
+  address private _owner;
+
+  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
 
   /**
-   * @notice Allows smartcontracts to access the liquidity of the pool within one transaction,
-   * as long as the amount taken plus a fee is returned.
-   * @dev IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
-   * into consideration. For further details please visit https://docs.aave.com/developers/
-   * @param receiverAddress The address of the contract receiving the funds, implementing IFlashLoanReceiver interface
-   * @param assets The addresses of the assets being flash-borrowed
-   * @param amounts The amounts of the assets being flash-borrowed
-   * @param interestRateModes Types of the debt to open if the flash loan is not returned:
-   *   0 -> Don't open any debt, just revert if funds can't be transferred from the receiver
-   *   1 -> Deprecated on v3.2.0
-   *   2 -> Open debt at variable rate for the value of the amount flash-borrowed to the `onBehalfOf` address
-   * @param onBehalfOf The address  that will receive the debt in the case of using 2 on `modes`
-   * @param params Variadic packed params to pass to the receiver as extra information
-   * @param referralCode The code used to register the integrator originating the operation, for potential rewards.
-   *   0 if the action is executed directly by the user, without any middle-man
+   * @dev Initializes the contract setting the deployer as the initial owner.
    */
-  function flashLoan(
-    address receiverAddress,
-    address[] calldata assets,
-    uint256[] calldata amounts,
-    uint256[] calldata interestRateModes,
-    address onBehalfOf,
-    bytes calldata params,
-    uint16 referralCode
-  ) external;
+  constructor() {
+    _transferOwnership(_msgSender());
+  }
 
   /**
-   * @notice Allows smartcontracts to access the liquidity of the pool within one transaction,
-   * as long as the amount taken plus a fee is returned.
-   * @dev IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
-   * into consideration. For further details please visit https://docs.aave.com/developers/
-   * @param receiverAddress The address of the contract receiving the funds, implementing IFlashLoanSimpleReceiver interface
-   * @param asset The address of the asset being flash-borrowed
-   * @param amount The amount of the asset being flash-borrowed
-   * @param params Variadic packed params to pass to the receiver as extra information
-   * @param referralCode The code used to register the integrator originating the operation, for potential rewards.
-   *   0 if the action is executed directly by the user, without any middle-man
+   * @dev Throws if called by any account other than the owner.
    */
-  function flashLoanSimple(
-    address receiverAddress,
-    address asset,
-    uint256 amount,
-    bytes calldata params,
-    uint16 referralCode
-  ) external;
+  modifier onlyOwner() {
+    _checkOwner();
+    _;
+  }
 
   /**
-   * @notice Returns the user account data across all the reserves
-   * @param user The address of the user
-   * @return totalCollateralBase The total collateral of the user in the base currency used by the price feed
-   * @return totalDebtBase The total debt of the user in the base currency used by the price feed
-   * @return availableBorrowsBase The borrowing power left of the user in the base currency used by the price feed
-   * @return currentLiquidationThreshold The liquidation threshold of the user
-   * @return ltv The loan to value of The user
-   * @return healthFactor The current health factor of the user
+   * @dev Returns the address of the current owner.
    */
-  function getUserAccountData(
-    address user
-  )
-    external
-    view
-    returns (
-      uint256 totalCollateralBase,
-      uint256 totalDebtBase,
-      uint256 availableBorrowsBase,
-      uint256 currentLiquidationThreshold,
-      uint256 ltv,
-      uint256 healthFactor
-    );
+  function owner() public view virtual returns (address) {
+    return _owner;
+  }
 
   /**
-   * @notice Initializes a reserve, activating it, assigning an aToken and debt tokens and an
-   * interest rate strategy
-   * @dev Only callable by the PoolConfigurator contract
-   * @param asset The address of the underlying asset of the reserve
-   * @param aTokenAddress The address of the aToken that will be assigned to the reserve
-   * @param variableDebtAddress The address of the VariableDebtToken that will be assigned to the reserve
-   * @param interestRateStrategyAddress The address of the interest rate strategy contract
+   * @dev Throws if the sender is not the owner.
    */
-  function initReserve(
-    address asset,
-    address aTokenAddress,
-    address variableDebtAddress,
-    address interestRateStrategyAddress
-  ) external;
+  function _checkOwner() internal view virtual {
+    require(owner() == _msgSender(), 'Ownable: caller is not the owner');
+  }
 
   /**
-   * @notice Drop a reserve
-   * @dev Only callable by the PoolConfigurator contract
-   * @dev Does not reset eMode flags, which must be considered when reusing the same reserve id for a different reserve.
-   * @param asset The address of the underlying asset of the reserve
+   * @dev Leaves the contract without owner. It will not be possible to call
+   * `onlyOwner` functions anymore. Can only be called by the current owner.
+   *
+   * NOTE: Renouncing ownership will leave the contract without an owner,
+   * thereby removing any functionality that is only available to the owner.
    */
-  function dropReserve(address asset) external;
+  function renounceOwnership() public virtual onlyOwner {
+    _transferOwnership(address(0));
+  }
 
   /**
-   * @notice Updates the address of the interest rate strategy contract
-   * @dev Only callable by the PoolConfigurator contract
-   * @param asset The address of the underlying asset of the reserve
-   * @param rateStrategyAddress The address of the interest rate strategy contract
+   * @dev Transfers ownership of the contract to a new account (`newOwner`).
+   * Can only be called by the current owner.
    */
-  function setReserveInterestRateStrategyAddress(
-    address asset,
-    address rateStrategyAddress
-  ) external;
+  function transferOwnership(address newOwner) public virtual onlyOwner {
+    require(newOwner != address(0), 'Ownable: new owner is the zero address');
+    _transferOwnership(newOwner);
+  }
 
   /**
-   * @notice Accumulates interest to all indexes of the reserve
-   * @dev Only callable by the PoolConfigurator contract
-   * @dev To be used when required by the configurator, for example when updating interest rates strategy data
-   * @param asset The address of the underlying asset of the reserve
+   * @dev Transfers ownership of the contract to a new account (`newOwner`).
+   * Internal function without access restriction.
    */
-  function syncIndexesState(address asset) external;
+  function _transferOwnership(address newOwner) internal virtual {
+    address oldOwner = _owner;
+    _owner = newOwner;
+    emit OwnershipTransferred(oldOwner, newOwner);
+  }
+}
+
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IAaveOracle.sol
+
+/**
+ * @title IAaveOracle
+ * @author Aave
+ * @notice Defines the basic interface for the Aave Oracle
+ */
+interface IAaveOracle is IPriceOracleGetter {
+  /**
+   * @dev Emitted after the base currency is set
+   * @param baseCurrency The base currency of used for price quotes
+   * @param baseCurrencyUnit The unit of the base currency
+   */
+  event BaseCurrencySet(address indexed baseCurrency, uint256 baseCurrencyUnit);
 
   /**
-   * @notice Updates interest rates on the reserve data
-   * @dev Only callable by the PoolConfigurator contract
-   * @dev To be used when required by the configurator, for example when updating interest rates strategy data
-   * @param asset The address of the underlying asset of the reserve
+   * @dev Emitted after the price source of an asset is updated
+   * @param asset The address of the asset
+   * @param source The price source of the asset
    */
-  function syncRatesState(address asset) external;
+  event AssetSourceUpdated(address indexed asset, address indexed source);
 
   /**
-   * @notice Sets the configuration bitmap of the reserve as a whole
-   * @dev Only callable by the PoolConfigurator contract
-   * @param asset The address of the underlying asset of the reserve
-   * @param configuration The new configuration bitmap
+   * @dev Emitted after the address of fallback oracle is updated
+   * @param fallbackOracle The address of the fallback oracle
    */
-  function setConfiguration(
-    address asset,
-    DataTypes.ReserveConfigurationMap calldata configuration
-  ) external;
+  event FallbackOracleUpdated(address indexed fallbackOracle);
 
   /**
-   * @notice Returns the configuration of the reserve
-   * @param asset The address of the underlying asset of the reserve
-   * @return The configuration of the reserve
+   * @notice Returns the PoolAddressesProvider
+   * @return The address of the PoolAddressesProvider contract
    */
-  function getConfiguration(
-    address asset
-  ) external view returns (DataTypes.ReserveConfigurationMap memory);
+  function ADDRESSES_PROVIDER() external view returns (IPoolAddressesProvider);
 
   /**
-   * @notice Returns the configuration of the user across all the reserves
-   * @param user The user address
-   * @return The configuration of the user
+   * @notice Sets or replaces price sources of assets
+   * @param assets The addresses of the assets
+   * @param sources The addresses of the price sources
    */
-  function getUserConfiguration(
-    address user
-  ) external view returns (DataTypes.UserConfigurationMap memory);
+  function setAssetSources(address[] calldata assets, address[] calldata sources) external;
 
   /**
-   * @notice Returns the normalized income of the reserve
-   * @param asset The address of the underlying asset of the reserve
-   * @return The reserve's normalized income
+   * @notice Sets the fallback oracle
+   * @param fallbackOracle The address of the fallback oracle
    */
-  function getReserveNormalizedIncome(address asset) external view returns (uint256);
+  function setFallbackOracle(address fallbackOracle) external;
 
   /**
-   * @notice Returns the normalized variable debt per unit of asset
-   * @dev WARNING: This function is intended to be used primarily by the protocol itself to get a
-   * "dynamic" variable index based on time, current stored index and virtual rate at the current
-   * moment (approx. a borrower would get if opening a position). This means that is always used in
-   * combination with variable debt supply/balances.
-   * If using this function externally, consider that is possible to have an increasing normalized
-   * variable debt that is not equivalent to how the variable debt index would be updated in storage
-   * (e.g. only updates with non-zero variable debt supply)
-   * @param asset The address of the underlying asset of the reserve
-   * @return The reserve normalized variable debt
+   * @notice Returns a list of prices from a list of assets addresses
+   * @param assets The list of assets addresses
+   * @return The prices of the given assets
    */
-  function getReserveNormalizedVariableDebt(address asset) external view returns (uint256);
+  function getAssetsPrices(address[] calldata assets) external view returns (uint256[] memory);
 
   /**
-   * @notice Returns the state and configuration of the reserve
-   * @param asset The address of the underlying asset of the reserve
-   * @return The state and configuration data of the reserve
+   * @notice Returns the address of the source for an asset address
+   * @param asset The address of the asset
+   * @return The address of the source
    */
-  function getReserveData(address asset) external view returns (DataTypes.ReserveDataLegacy memory);
+  function getSourceOfAsset(address asset) external view returns (address);
 
   /**
-   * @notice Returns the virtual underlying balance of the reserve
-   * @param asset The address of the underlying asset of the reserve
-   * @return The reserve virtual underlying balance
+   * @notice Returns the address of the fallback oracle
+   * @return The address of the fallback oracle
    */
-  function getVirtualUnderlyingBalance(address asset) external view returns (uint128);
+  function getFallbackOracle() external view returns (address);
+}
+
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPool.sol
 
+/**
+ * @title IPool
+ * @author Aave
+ * @notice Defines the basic interface for an Aave Pool.
+ */
+interface IPool {
   /**
-   * @notice Validates and finalizes an aToken transfer
-   * @dev Only callable by the overlying aToken of the `asset`
-   * @param asset The address of the underlying asset of the aToken
-   * @param from The user from which the aTokens are transferred
-   * @param to The user receiving the aTokens
-   * @param amount The amount being transferred/withdrawn
-   * @param balanceFromBefore The aToken balance of the `from` user before the transfer
-   * @param balanceToBefore The aToken balance of the `to` user before the transfer
+   * @dev Emitted on mintUnbacked()
+   * @param reserve The address of the underlying asset of the reserve
+   * @param user The address initiating the supply
+   * @param onBehalfOf The beneficiary of the supplied assets, receiving the aTokens
+   * @param amount The amount of supplied assets
+   * @param referralCode The referral code used
    */
-  function finalizeTransfer(
-    address asset,
-    address from,
-    address to,
+  event MintUnbacked(
+    address indexed reserve,
+    address user,
+    address indexed onBehalfOf,
     uint256 amount,
-    uint256 balanceFromBefore,
-    uint256 balanceToBefore
-  ) external;
+    uint16 indexed referralCode
+  );
 
   /**
-   * @notice Returns the list of the underlying assets of all the initialized reserves
-   * @dev It does not include dropped reserves
-   * @return The addresses of the underlying assets of the initialized reserves
+   * @dev Emitted on backUnbacked()
+   * @param reserve The address of the underlying asset of the reserve
+   * @param backer The address paying for the backing
+   * @param amount The amount added as backing
+   * @param fee The amount paid in fees
    */
-  function getReservesList() external view returns (address[] memory);
+  event BackUnbacked(address indexed reserve, address indexed backer, uint256 amount, uint256 fee);
 
   /**
-   * @notice Returns the number of initialized reserves
-   * @dev It includes dropped reserves
-   * @return The count
+   * @dev Emitted on supply()
+   * @param reserve The address of the underlying asset of the reserve
+   * @param user The address initiating the supply
+   * @param onBehalfOf The beneficiary of the supply, receiving the aTokens
+   * @param amount The amount supplied
+   * @param referralCode The referral code used
    */
-  function getReservesCount() external view returns (uint256);
+  event Supply(
+    address indexed reserve,
+    address user,
+    address indexed onBehalfOf,
+    uint256 amount,
+    uint16 indexed referralCode
+  );
 
   /**
-   * @notice Returns the address of the underlying asset of a reserve by the reserve id as stored in the DataTypes.ReserveData struct
-   * @param id The id of the reserve as stored in the DataTypes.ReserveData struct
-   * @return The address of the reserve associated with id
+   * @dev Emitted on withdraw()
+   * @param reserve The address of the underlying asset being withdrawn
+   * @param user The address initiating the withdrawal, owner of aTokens
+   * @param to The address that will receive the underlying
+   * @param amount The amount to be withdrawn
    */
-  function getReserveAddressById(uint16 id) external view returns (address);
+  event Withdraw(address indexed reserve, address indexed user, address indexed to, uint256 amount);
 
   /**
-   * @notice Returns the PoolAddressesProvider connected to this contract
-   * @return The address of the PoolAddressesProvider
+   * @dev Emitted on borrow() and flashLoan() when debt needs to be opened
+   * @param reserve The address of the underlying asset being borrowed
+   * @param user The address of the user initiating the borrow(), receiving the funds on borrow() or just
+   * initiator of the transaction on flashLoan()
+   * @param onBehalfOf The address that will be getting the debt
+   * @param amount The amount borrowed out
+   * @param interestRateMode The rate mode: 2 for Variable, 1 is deprecated (changed on v3.2.0)
+   * @param borrowRate The numeric rate at which the user has borrowed, expressed in ray
+   * @param referralCode The referral code used
    */
-  function ADDRESSES_PROVIDER() external view returns (IPoolAddressesProvider);
+  event Borrow(
+    address indexed reserve,
+    address user,
+    address indexed onBehalfOf,
+    uint256 amount,
+    DataTypes.InterestRateMode interestRateMode,
+    uint256 borrowRate,
+    uint16 indexed referralCode
+  );
 
   /**
-   * @notice Updates the protocol fee on the bridging
-   * @param bridgeProtocolFee The part of the premium sent to the protocol treasury
+   * @dev Emitted on repay()
+   * @param reserve The address of the underlying asset of the reserve
+   * @param user The beneficiary of the repayment, getting his debt reduced
+   * @param repayer The address of the user initiating the repay(), providing the funds
+   * @param amount The amount repaid
+   * @param useATokens True if the repayment is done using aTokens, `false` if done with underlying asset directly
    */
-  function updateBridgeProtocolFee(uint256 bridgeProtocolFee) external;
+  event Repay(
+    address indexed reserve,
+    address indexed user,
+    address indexed repayer,
+    uint256 amount,
+    bool useATokens
+  );
 
   /**
-   * @notice Updates flash loan premiums. Flash loan premium consists of two parts:
-   * - A part is sent to aToken holders as extra, one time accumulated interest
-   * - A part is collected by the protocol treasury
-   * @dev The total premium is calculated on the total borrowed amount
-   * @dev The premium to protocol is calculated on the total premium, being a percentage of `flashLoanPremiumTotal`
-   * @dev Only callable by the PoolConfigurator contract
-   * @param flashLoanPremiumTotal The total premium, expressed in bps
-   * @param flashLoanPremiumToProtocol The part of the premium sent to the protocol treasury, expressed in bps
+   * @dev Emitted on borrow(), repay() and liquidationCall() when using isolated assets
+   * @param asset The address of the underlying asset of the reserve
+   * @param totalDebt The total isolation mode debt for the reserve
    */
-  function updateFlashloanPremiums(
-    uint128 flashLoanPremiumTotal,
-    uint128 flashLoanPremiumToProtocol
-  ) external;
+  event IsolationModeTotalDebtUpdated(address indexed asset, uint256 totalDebt);
 
   /**
-   * @notice Configures a new or alters an existing collateral configuration of an eMode.
-   * @dev In eMode, the protocol allows very high borrowing power to borrow assets of the same category.
-   * The category 0 is reserved as it's the default for volatile assets
-   * @param id The id of the category
-   * @param config The configuration of the category
+   * @dev Emitted when the user selects a certain asset category for eMode
+   * @param user The address of the user
+   * @param categoryId The category id
    */
-  function configureEModeCategory(
-    uint8 id,
-    DataTypes.EModeCategoryBaseConfiguration memory config
-  ) external;
+  event UserEModeSet(address indexed user, uint8 categoryId);
 
   /**
-   * @notice Replaces the current eMode collateralBitmap.
-   * @param id The id of the category
-   * @param collateralBitmap The collateralBitmap of the category
+   * @dev Emitted on setUserUseReserveAsCollateral()
+   * @param reserve The address of the underlying asset of the reserve
+   * @param user The address of the user enabling the usage as collateral
    */
-  function configureEModeCategoryCollateralBitmap(uint8 id, uint128 collateralBitmap) external;
+  event ReserveUsedAsCollateralEnabled(address indexed reserve, address indexed user);
 
   /**
-   * @notice Replaces the current eMode borrowableBitmap.
-   * @param id The id of the category
-   * @param borrowableBitmap The borrowableBitmap of the category
+   * @dev Emitted on setUserUseReserveAsCollateral()
+   * @param reserve The address of the underlying asset of the reserve
+   * @param user The address of the user enabling the usage as collateral
    */
-  function configureEModeCategoryBorrowableBitmap(uint8 id, uint128 borrowableBitmap) external;
+  event ReserveUsedAsCollateralDisabled(address indexed reserve, address indexed user);
 
   /**
-   * @notice Returns the data of an eMode category
-   * @dev DEPRECATED use independent getters instead
-   * @param id The id of the category
-   * @return The configuration data of the category
+   * @dev Emitted on flashLoan()
+   * @param target The address of the flash loan receiver contract
+   * @param initiator The address initiating the flash loan
+   * @param asset The address of the asset being flash borrowed
+   * @param amount The amount flash borrowed
+   * @param interestRateMode The flashloan mode: 0 for regular flashloan,
+   *        1 for Stable (Deprecated on v3.2.0), 2 for Variable
+   * @param premium The fee flash borrowed
+   * @param referralCode The referral code used
+   */
+  event FlashLoan(
+    address indexed target,
+    address initiator,
+    address indexed asset,
+    uint256 amount,
+    DataTypes.InterestRateMode interestRateMode,
+    uint256 premium,
+    uint16 indexed referralCode
+  );
+
+  /**
+   * @dev Emitted when a borrower is liquidated.
+   * @param collateralAsset The address of the underlying asset used as collateral, to receive as result of the liquidation
+   * @param debtAsset The address of the underlying borrowed asset to be repaid with the liquidation
+   * @param user The address of the borrower getting liquidated
+   * @param debtToCover The debt amount of borrowed `asset` the liquidator wants to cover
+   * @param liquidatedCollateralAmount The amount of collateral received by the liquidator
+   * @param liquidator The address of the liquidator
+   * @param receiveAToken True if the liquidators wants to receive the collateral aTokens, `false` if he wants
+   * to receive the underlying collateral asset directly
    */
-  function getEModeCategoryData(
-    uint8 id
-  ) external view returns (DataTypes.EModeCategoryLegacy memory);
+  event LiquidationCall(
+    address indexed collateralAsset,
+    address indexed debtAsset,
+    address indexed user,
+    uint256 debtToCover,
+    uint256 liquidatedCollateralAmount,
+    address liquidator,
+    bool receiveAToken
+  );
 
   /**
-   * @notice Returns the label of an eMode category
-   * @param id The id of the category
-   * @return The label of the category
+   * @dev Emitted when the state of a reserve is updated.
+   * @param reserve The address of the underlying asset of the reserve
+   * @param liquidityRate The next liquidity rate
+   * @param stableBorrowRate The next stable borrow rate @note deprecated on v3.2.0
+   * @param variableBorrowRate The next variable borrow rate
+   * @param liquidityIndex The next liquidity index
+   * @param variableBorrowIndex The next variable borrow index
    */
-  function getEModeCategoryLabel(uint8 id) external view returns (string memory);
+  event ReserveDataUpdated(
+    address indexed reserve,
+    uint256 liquidityRate,
+    uint256 stableBorrowRate,
+    uint256 variableBorrowRate,
+    uint256 liquidityIndex,
+    uint256 variableBorrowIndex
+  );
 
   /**
-   * @notice Returns the collateral config of an eMode category
-   * @param id The id of the category
-   * @return The ltv,lt,lb of the category
+   * @dev Emitted when the protocol treasury receives minted aTokens from the accrued interest.
+   * @param reserve The address of the reserve
+   * @param amountMinted The amount minted to the treasury
    */
-  function getEModeCategoryCollateralConfig(
-    uint8 id
-  ) external view returns (DataTypes.CollateralConfig memory);
+  event MintedToTreasury(address indexed reserve, uint256 amountMinted);
 
   /**
-   * @notice Returns the collateralBitmap of an eMode category
-   * @param id The id of the category
-   * @return The collateralBitmap of the category
+   * @notice Mints an `amount` of aTokens to the `onBehalfOf`
+   * @param asset The address of the underlying asset to mint
+   * @param amount The amount to mint
+   * @param onBehalfOf The address that will receive the aTokens
+   * @param referralCode Code used to register the integrator originating the operation, for potential rewards.
+   *   0 if the action is executed directly by the user, without any middle-man
    */
-  function getEModeCategoryCollateralBitmap(uint8 id) external view returns (uint128);
+  function mintUnbacked(
+    address asset,
+    uint256 amount,
+    address onBehalfOf,
+    uint16 referralCode
+  ) external;
 
   /**
-   * @notice Returns the borrowableBitmap of an eMode category
-   * @param id The id of the category
-   * @return The borrowableBitmap of the category
+   * @notice Back the current unbacked underlying with `amount` and pay `fee`.
+   * @param asset The address of the underlying asset to back
+   * @param amount The amount to back
+   * @param fee The amount paid in fees
+   * @return The backed amount
    */
-  function getEModeCategoryBorrowableBitmap(uint8 id) external view returns (uint128);
+  function backUnbacked(address asset, uint256 amount, uint256 fee) external returns (uint256);
 
   /**
-   * @notice Allows a user to use the protocol in eMode
-   * @param categoryId The id of the category
+   * @notice Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
+   * - E.g. User supplies 100 USDC and gets in return 100 aUSDC
+   * @param asset The address of the underlying asset to supply
+   * @param amount The amount to be supplied
+   * @param onBehalfOf The address that will receive the aTokens, same as msg.sender if the user
+   *   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens
+   *   is a different wallet
+   * @param referralCode Code used to register the integrator originating the operation, for potential rewards.
+   *   0 if the action is executed directly by the user, without any middle-man
    */
-  function setUserEMode(uint8 categoryId) external;
+  function supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
 
   /**
-   * @notice Returns the eMode the user is using
-   * @param user The address of the user
-   * @return The eMode id
+   * @notice Supply with transfer approval of asset to be supplied done via permit function
+   * see: https://eips.ethereum.org/EIPS/eip-2612 and https://eips.ethereum.org/EIPS/eip-713
+   * @param asset The address of the underlying asset to supply
+   * @param amount The amount to be supplied
+   * @param onBehalfOf The address that will receive the aTokens, same as msg.sender if the user
+   *   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens
+   *   is a different wallet
+   * @param deadline The deadline timestamp that the permit is valid
+   * @param referralCode Code used to register the integrator originating the operation, for potential rewards.
+   *   0 if the action is executed directly by the user, without any middle-man
+   * @param permitV The V parameter of ERC712 permit sig
+   * @param permitR The R parameter of ERC712 permit sig
+   * @param permitS The S parameter of ERC712 permit sig
    */
-  function getUserEMode(address user) external view returns (uint256);
+  function supplyWithPermit(
+    address asset,
+    uint256 amount,
+    address onBehalfOf,
+    uint16 referralCode,
+    uint256 deadline,
+    uint8 permitV,
+    bytes32 permitR,
+    bytes32 permitS
+  ) external;
 
   /**
-   * @notice Resets the isolation mode total debt of the given asset to zero
-   * @dev It requires the given asset has zero debt ceiling
-   * @param asset The address of the underlying asset to reset the isolationModeTotalDebt
+   * @notice Withdraws an `amount` of underlying asset from the reserve, burning the equivalent aTokens owned
+   * E.g. User has 100 aUSDC, calls withdraw() and receives 100 USDC, burning the 100 aUSDC
+   * @param asset The address of the underlying asset to withdraw
+   * @param amount The underlying amount to be withdrawn
+   *   - Send the value type(uint256).max in order to withdraw the whole aToken balance
+   * @param to The address that will receive the underlying, same as msg.sender if the user
+   *   wants to receive it on his own wallet, or a different address if the beneficiary is a
+   *   different wallet
+   * @return The final amount withdrawn
    */
-  function resetIsolationModeTotalDebt(address asset) external;
-
-  /**
-   * @notice Sets the liquidation grace period of the given asset
-   * @dev To enable a liquidation grace period, a timestamp in the future should be set,
-   *      To disable a liquidation grace period, any timestamp in the past works, like 0
-   * @param asset The address of the underlying asset to set the liquidationGracePeriod
-   * @param until Timestamp when the liquidation grace period will end
-   **/
-  function setLiquidationGracePeriod(address asset, uint40 until) external;
+  function withdraw(address asset, uint256 amount, address to) external returns (uint256);
 
   /**
-   * @notice Returns the liquidation grace period of the given asset
-   * @param asset The address of the underlying asset
-   * @return Timestamp when the liquidation grace period will end
-   **/
-  function getLiquidationGracePeriod(address asset) external view returns (uint40);
+   * @notice Allows users to borrow a specific `amount` of the reserve underlying asset, provided that the borrower
+   * already supplied enough collateral, or he was given enough allowance by a credit delegator on the VariableDebtToken
+   * - E.g. User borrows 100 USDC passing as `onBehalfOf` his own address, receiving the 100 USDC in his wallet
+   *   and 100 variable debt tokens
+   * @param asset The address of the underlying asset to borrow
+   * @param amount The amount to be borrowed
+   * @param interestRateMode 2 for Variable, 1 is deprecated on v3.2.0
+   * @param referralCode The code used to register the integrator originating the operation, for potential rewards.
+   *   0 if the action is executed directly by the user, without any middle-man
+   * @param onBehalfOf The address of the user who will receive the debt. Should be the address of the borrower itself
+   * calling the function if he wants to borrow against his own collateral, or the address of the credit delegator
+   * if he has been given credit delegation allowance
+   */
+  function borrow(
+    address asset,
+    uint256 amount,
+    uint256 interestRateMode,
+    uint16 referralCode,
+    address onBehalfOf
+  ) external;
 
   /**
-   * @notice Returns the total fee on flash loans
-   * @return The total fee on flashloans
+   * @notice Repays a borrowed `amount` on a specific reserve, burning the equivalent debt tokens owned
+   * - E.g. User repays 100 USDC, burning 100 variable debt tokens of the `onBehalfOf` address
+   * @param asset The address of the borrowed underlying asset previously borrowed
+   * @param amount The amount to repay
+   * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
+   * @param interestRateMode 2 for Variable, 1 is deprecated on v3.2.0
+   * @param onBehalfOf The address of the user who will get his debt reduced/removed. Should be the address of the
+   * user calling the function if he wants to reduce/remove his own debt, or the address of any other
+   * other borrower whose debt should be removed
+   * @return The final amount repaid
    */
-  function FLASHLOAN_PREMIUM_TOTAL() external view returns (uint128);
+  function repay(
+    address asset,
+    uint256 amount,
+    uint256 interestRateMode,
+    address onBehalfOf
+  ) external returns (uint256);
 
   /**
-   * @notice Returns the part of the bridge fees sent to protocol
-   * @return The bridge fee sent to the protocol treasury
+   * @notice Repay with transfer approval of asset to be repaid done via permit function
+   * see: https://eips.ethereum.org/EIPS/eip-2612 and https://eips.ethereum.org/EIPS/eip-713
+   * @param asset The address of the borrowed underlying asset previously borrowed
+   * @param amount The amount to repay
+   * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
+   * @param interestRateMode 2 for Variable, 1 is deprecated on v3.2.0
+   * @param onBehalfOf Address of the user who will get his debt reduced/removed. Should be the address of the
+   * user calling the function if he wants to reduce/remove his own debt, or the address of any other
+   * other borrower whose debt should be removed
+   * @param deadline The deadline timestamp that the permit is valid
+   * @param permitV The V parameter of ERC712 permit sig
+   * @param permitR The R parameter of ERC712 permit sig
+   * @param permitS The S parameter of ERC712 permit sig
+   * @return The final amount repaid
    */
-  function BRIDGE_PROTOCOL_FEE() external view returns (uint256);
+  function repayWithPermit(
+    address asset,
+    uint256 amount,
+    uint256 interestRateMode,
+    address onBehalfOf,
+    uint256 deadline,
+    uint8 permitV,
+    bytes32 permitR,
+    bytes32 permitS
+  ) external returns (uint256);
 
   /**
-   * @notice Returns the part of the flashloan fees sent to protocol
-   * @return The flashloan fee sent to the protocol treasury
+   * @notice Repays a borrowed `amount` on a specific reserve using the reserve aTokens, burning the
+   * equivalent debt tokens
+   * - E.g. User repays 100 USDC using 100 aUSDC, burning 100 variable debt tokens
+   * @dev  Passing uint256.max as amount will clean up any residual aToken dust balance, if the user aToken
+   * balance is not enough to cover the whole debt
+   * @param asset The address of the borrowed underlying asset previously borrowed
+   * @param amount The amount to repay
+   * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
+   * @param interestRateMode DEPRECATED in v3.2.0
+   * @return The final amount repaid
    */
-  function FLASHLOAN_PREMIUM_TO_PROTOCOL() external view returns (uint128);
+  function repayWithATokens(
+    address asset,
+    uint256 amount,
+    uint256 interestRateMode
+  ) external returns (uint256);
 
   /**
-   * @notice Returns the maximum number of reserves supported to be listed in this Pool
-   * @return The maximum number of reserves supported
+   * @notice Allows suppliers to enable/disable a specific supplied asset as collateral
+   * @param asset The address of the underlying asset supplied
+   * @param useAsCollateral True if the user wants to use the supply as collateral, false otherwise
    */
-  function MAX_NUMBER_RESERVES() external view returns (uint16);
+  function setUserUseReserveAsCollateral(address asset, bool useAsCollateral) external;
 
   /**
-   * @notice Mints the assets accrued through the reserve factor to the treasury in the form of aTokens
-   * @param assets The list of reserves for which the minting needs to be executed
+   * @notice Function to liquidate a non-healthy position collateral-wise, with Health Factor below 1
+   * - The caller (liquidator) covers `debtToCover` amount of debt of the user getting liquidated, and receives
+   *   a proportionally amount of the `collateralAsset` plus a bonus to cover market risk
+   * @param collateralAsset The address of the underlying asset used as collateral, to receive as result of the liquidation
+   * @param debtAsset The address of the underlying borrowed asset to be repaid with the liquidation
+   * @param user The address of the borrower getting liquidated
+   * @param debtToCover The debt amount of borrowed `asset` the liquidator wants to cover
+   * @param receiveAToken True if the liquidators wants to receive the collateral aTokens, `false` if he wants
+   * to receive the underlying collateral asset directly
    */
-  function mintToTreasury(address[] calldata assets) external;
+  function liquidationCall(
+    address collateralAsset,
+    address debtAsset,
+    address user,
+    uint256 debtToCover,
+    bool receiveAToken
+  ) external;
 
   /**
-   * @notice Rescue and transfer tokens locked in this contract
-   * @param token The address of the token
-   * @param to The address of the recipient
-   * @param amount The amount of token to transfer
+   * @notice Allows smartcontracts to access the liquidity of the pool within one transaction,
+   * as long as the amount taken plus a fee is returned.
+   * @dev IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
+   * into consideration. For further details please visit https://docs.aave.com/developers/
+   * @param receiverAddress The address of the contract receiving the funds, implementing IFlashLoanReceiver interface
+   * @param assets The addresses of the assets being flash-borrowed
+   * @param amounts The amounts of the assets being flash-borrowed
+   * @param interestRateModes Types of the debt to open if the flash loan is not returned:
+   *   0 -> Don't open any debt, just revert if funds can't be transferred from the receiver
+   *   1 -> Deprecated on v3.2.0
+   *   2 -> Open debt at variable rate for the value of the amount flash-borrowed to the `onBehalfOf` address
+   * @param onBehalfOf The address  that will receive the debt in the case of using 2 on `modes`
+   * @param params Variadic packed params to pass to the receiver as extra information
+   * @param referralCode The code used to register the integrator originating the operation, for potential rewards.
+   *   0 if the action is executed directly by the user, without any middle-man
    */
-  function rescueTokens(address token, address to, uint256 amount) external;
+  function flashLoan(
+    address receiverAddress,
+    address[] calldata assets,
+    uint256[] calldata amounts,
+    uint256[] calldata interestRateModes,
+    address onBehalfOf,
+    bytes calldata params,
+    uint16 referralCode
+  ) external;
 
   /**
-   * @notice Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
-   * - E.g. User supplies 100 USDC and gets in return 100 aUSDC
-   * @dev Deprecated: Use the `supply` function instead
-   * @param asset The address of the underlying asset to supply
-   * @param amount The amount to be supplied
-   * @param onBehalfOf The address that will receive the aTokens, same as msg.sender if the user
-   *   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens
-   *   is a different wallet
-   * @param referralCode Code used to register the integrator originating the operation, for potential rewards.
+   * @notice Allows smartcontracts to access the liquidity of the pool within one transaction,
+   * as long as the amount taken plus a fee is returned.
+   * @dev IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
+   * into consideration. For further details please visit https://docs.aave.com/developers/
+   * @param receiverAddress The address of the contract receiving the funds, implementing IFlashLoanSimpleReceiver interface
+   * @param asset The address of the asset being flash-borrowed
+   * @param amount The amount of the asset being flash-borrowed
+   * @param params Variadic packed params to pass to the receiver as extra information
+   * @param referralCode The code used to register the integrator originating the operation, for potential rewards.
    *   0 if the action is executed directly by the user, without any middle-man
    */
-  function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
+  function flashLoanSimple(
+    address receiverAddress,
+    address asset,
+    uint256 amount,
+    bytes calldata params,
+    uint16 referralCode
+  ) external;
 
   /**
-   * @notice It covers the deficit of a specified reserve by burning:
-   * - the equivalent aToken `amount` for assets with virtual accounting enabled
-   * - the equivalent `amount` of underlying for assets with virtual accounting disabled (e.g. GHO)
-   * @dev The deficit of a reserve can occur due to situations where borrowed assets are not repaid, leading to bad debt.
-   * @param asset The address of the underlying asset to cover the deficit.
-   * @param amount The amount to be covered, in aToken or underlying on non-virtual accounted assets
+   * @notice Returns the user account data across all the reserves
+   * @param user The address of the user
+   * @return totalCollateralBase The total collateral of the user in the base currency used by the price feed
+   * @return totalDebtBase The total debt of the user in the base currency used by the price feed
+   * @return availableBorrowsBase The borrowing power left of the user in the base currency used by the price feed
+   * @return currentLiquidationThreshold The liquidation threshold of the user
+   * @return ltv The loan to value of The user
+   * @return healthFactor The current health factor of the user
    */
-  function eliminateReserveDeficit(address asset, uint256 amount) external;
+  function getUserAccountData(
+    address user
+  )
+    external
+    view
+    returns (
+      uint256 totalCollateralBase,
+      uint256 totalDebtBase,
+      uint256 availableBorrowsBase,
+      uint256 currentLiquidationThreshold,
+      uint256 ltv,
+      uint256 healthFactor
+    );
 
   /**
-   * @notice Returns the current deficit of a reserve.
+   * @notice Initializes a reserve, activating it, assigning an aToken and debt tokens and an
+   * interest rate strategy
+   * @dev Only callable by the PoolConfigurator contract
    * @param asset The address of the underlying asset of the reserve
-   * @return The current deficit of the reserve
+   * @param aTokenAddress The address of the aToken that will be assigned to the reserve
+   * @param variableDebtAddress The address of the VariableDebtToken that will be assigned to the reserve
+   * @param interestRateStrategyAddress The address of the interest rate strategy contract
    */
-  function getReserveDeficit(address asset) external view returns (uint256);
+  function initReserve(
+    address asset,
+    address aTokenAddress,
+    address variableDebtAddress,
+    address interestRateStrategyAddress
+  ) external;
 
   /**
-   * @notice Returns the aToken address of a reserve.
+   * @notice Drop a reserve
+   * @dev Only callable by the PoolConfigurator contract
+   * @dev Does not reset eMode flags, which must be considered when reusing the same reserve id for a different reserve.
    * @param asset The address of the underlying asset of the reserve
-   * @return The address of the aToken
    */
-  function getReserveAToken(address asset) external view returns (address);
+  function dropReserve(address asset) external;
 
   /**
-   * @notice Returns the variableDebtToken address of a reserve.
+   * @notice Updates the address of the interest rate strategy contract
+   * @dev Only callable by the PoolConfigurator contract
    * @param asset The address of the underlying asset of the reserve
-   * @return The address of the variableDebtToken
-   */
-  function getReserveVariableDebtToken(address asset) external view returns (address);
-
-  /**
-   * @notice Gets the address of the external FlashLoanLogic
-   */
-  function getFlashLoanLogic() external view returns (address);
-
-  /**
-   * @notice Gets the address of the external BorrowLogic
-   */
-  function getBorrowLogic() external view returns (address);
-
-  /**
-   * @notice Gets the address of the external BridgeLogic
-   */
-  function getBridgeLogic() external view returns (address);
-
-  /**
-   * @notice Gets the address of the external EModeLogic
+   * @param rateStrategyAddress The address of the interest rate strategy contract
    */
-  function getEModeLogic() external view returns (address);
+  function setReserveInterestRateStrategyAddress(
+    address asset,
+    address rateStrategyAddress
+  ) external;
 
   /**
-   * @notice Gets the address of the external LiquidationLogic
+   * @notice Accumulates interest to all indexes of the reserve
+   * @dev Only callable by the PoolConfigurator contract
+   * @dev To be used when required by the configurator, for example when updating interest rates strategy data
+   * @param asset The address of the underlying asset of the reserve
    */
-  function getLiquidationLogic() external view returns (address);
+  function syncIndexesState(address asset) external;
 
   /**
-   * @notice Gets the address of the external PoolLogic
+   * @notice Updates interest rates on the reserve data
+   * @dev Only callable by the PoolConfigurator contract
+   * @dev To be used when required by the configurator, for example when updating interest rates strategy data
+   * @param asset The address of the underlying asset of the reserve
    */
-  function getPoolLogic() external view returns (address);
+  function syncRatesState(address asset) external;
 
   /**
-   * @notice Gets the address of the external SupplyLogic
+   * @notice Sets the configuration bitmap of the reserve as a whole
+   * @dev Only callable by the PoolConfigurator contract
+   * @param asset The address of the underlying asset of the reserve
+   * @param configuration The new configuration bitmap
    */
-  function getSupplyLogic() external view returns (address);
-}
-
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol
-
-// OpenZeppelin Contracts (last updated v5.1.0) (utils/math/Math.sol)
-
-/**
- * @dev Standard math utilities missing in the Solidity language.
- */
-library Math {
-    enum Rounding {
-        Floor, // Toward negative infinity
-        Ceil, // Toward positive infinity
-        Trunc, // Toward zero
-        Expand // Away from zero
-    }
-
-    /**
-     * @dev Returns the addition of two unsigned integers, with an success flag (no overflow).
-     */
-    function tryAdd(uint256 a, uint256 b) internal pure returns (bool success, uint256 result) {
-        unchecked {
-            uint256 c = a + b;
-            if (c < a) return (false, 0);
-            return (true, c);
-        }
-    }
-
-    /**
-     * @dev Returns the subtraction of two unsigned integers, with an success flag (no overflow).
-     */
-    function trySub(uint256 a, uint256 b) internal pure returns (bool success, uint256 result) {
-        unchecked {
-            if (b > a) return (false, 0);
-            return (true, a - b);
-        }
-    }
-
-    /**
-     * @dev Returns the multiplication of two unsigned integers, with an success flag (no overflow).
-     */
-    function tryMul(uint256 a, uint256 b) internal pure returns (bool success, uint256 result) {
-        unchecked {
-            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
-            // benefit is lost if 'b' is also tested.
-            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
-            if (a == 0) return (true, 0);
-            uint256 c = a * b;
-            if (c / a != b) return (false, 0);
-            return (true, c);
-        }
-    }
-
-    /**
-     * @dev Returns the division of two unsigned integers, with a success flag (no division by zero).
-     */
-    function tryDiv(uint256 a, uint256 b) internal pure returns (bool success, uint256 result) {
-        unchecked {
-            if (b == 0) return (false, 0);
-            return (true, a / b);
-        }
-    }
-
-    /**
-     * @dev Returns the remainder of dividing two unsigned integers, with a success flag (no division by zero).
-     */
-    function tryMod(uint256 a, uint256 b) internal pure returns (bool success, uint256 result) {
-        unchecked {
-            if (b == 0) return (false, 0);
-            return (true, a % b);
-        }
-    }
-
-    /**
-     * @dev Branchless ternary evaluation for `a ? b : c`. Gas costs are constant.
-     *
-     * IMPORTANT: This function may reduce bytecode size and consume less gas when used standalone.
-     * However, the compiler may optimize Solidity ternary operations (i.e. `a ? b : c`) to only compute
-     * one branch when needed, making this function more expensive.
-     */
-    function ternary(bool condition, uint256 a, uint256 b) internal pure returns (uint256) {
-        unchecked {
-            // branchless ternary works because:
-            // b ^ (a ^ b) == a
-            // b ^ 0 == b
-            return b ^ ((a ^ b) * SafeCast.toUint(condition));
-        }
-    }
-
-    /**
-     * @dev Returns the largest of two numbers.
-     */
-    function max(uint256 a, uint256 b) internal pure returns (uint256) {
-        return ternary(a > b, a, b);
-    }
-
-    /**
-     * @dev Returns the smallest of two numbers.
-     */
-    function min(uint256 a, uint256 b) internal pure returns (uint256) {
-        return ternary(a < b, a, b);
-    }
-
-    /**
-     * @dev Returns the average of two numbers. The result is rounded towards
-     * zero.
-     */
-    function average(uint256 a, uint256 b) internal pure returns (uint256) {
-        // (a + b) / 2 can overflow.
-        return (a & b) + (a ^ b) / 2;
-    }
-
-    /**
-     * @dev Returns the ceiling of the division of two numbers.
-     *
-     * This differs from standard division with `/` in that it rounds towards infinity instead
-     * of rounding towards zero.
-     */
-    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
-        if (b == 0) {
-            // Guarantee the same behavior as in a regular Solidity division.
-            Panic.panic(Panic.DIVISION_BY_ZERO);
-        }
-
-        // The following calculation ensures accurate ceiling division without overflow.
-        // Since a is non-zero, (a - 1) / b will not overflow.
-        // The largest possible result occurs when (a - 1) / b is type(uint256).max,
-        // but the largest value we can obtain is type(uint256).max - 1, which happens
-        // when a = type(uint256).max and b = 1.
-        unchecked {
-            return SafeCast.toUint(a > 0) * ((a - 1) / b + 1);
-        }
-    }
-
-    /**
-     * @dev Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or
-     * denominator == 0.
-     *
-     * Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv) with further edits by
-     * Uniswap Labs also under MIT license.
-     */
-    function mulDiv(uint256 x, uint256 y, uint256 denominator) internal pure returns (uint256 result) {
-        unchecked {
-            // 512-bit multiply [prod1 prod0] = x * y. Compute the product mod 2²⁵⁶ and mod 2²⁵⁶ - 1, then use
-            // the Chinese Remainder Theorem to reconstruct the 512 bit result. The result is stored in two 256
-            // variables such that product = prod1 * 2²⁵⁶ + prod0.
-            uint256 prod0 = x * y; // Least significant 256 bits of the product
-            uint256 prod1; // Most significant 256 bits of the product
-            assembly {
-                let mm := mulmod(x, y, not(0))
-                prod1 := sub(sub(mm, prod0), lt(mm, prod0))
-            }
-
-            // Handle non-overflow cases, 256 by 256 division.
-            if (prod1 == 0) {
-                // Solidity will revert if denominator == 0, unlike the div opcode on its own.
-                // The surrounding unchecked block does not change this fact.
-                // See https://docs.soliditylang.org/en/latest/control-structures.html#checked-or-unchecked-arithmetic.
-                return prod0 / denominator;
-            }
-
-            // Make sure the result is less than 2²⁵⁶. Also prevents denominator == 0.
-            if (denominator <= prod1) {
-                Panic.panic(ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW));
-            }
-
-            ///////////////////////////////////////////////
-            // 512 by 256 division.
-            ///////////////////////////////////////////////
-
-            // Make division exact by subtracting the remainder from [prod1 prod0].
-            uint256 remainder;
-            assembly {
-                // Compute remainder using mulmod.
-                remainder := mulmod(x, y, denominator)
-
-                // Subtract 256 bit number from 512 bit number.
-                prod1 := sub(prod1, gt(remainder, prod0))
-                prod0 := sub(prod0, remainder)
-            }
-
-            // Factor powers of two out of denominator and compute largest power of two divisor of denominator.
-            // Always >= 1. See https://cs.stackexchange.com/q/138556/92363.
-
-            uint256 twos = denominator & (0 - denominator);
-            assembly {
-                // Divide denominator by twos.
-                denominator := div(denominator, twos)
-
-                // Divide [prod1 prod0] by twos.
-                prod0 := div(prod0, twos)
-
-                // Flip twos such that it is 2²⁵⁶ / twos. If twos is zero, then it becomes one.
-                twos := add(div(sub(0, twos), twos), 1)
-            }
-
-            // Shift in bits from prod1 into prod0.
-            prod0 |= prod1 * twos;
-
-            // Invert denominator mod 2²⁵⁶. Now that denominator is an odd number, it has an inverse modulo 2²⁵⁶ such
-            // that denominator * inv ≡ 1 mod 2²⁵⁶. Compute the inverse by starting with a seed that is correct for
-            // four bits. That is, denominator * inv ≡ 1 mod 2⁴.
-            uint256 inverse = (3 * denominator) ^ 2;
-
-            // Use the Newton-Raphson iteration to improve the precision. Thanks to Hensel's lifting lemma, this also
-            // works in modular arithmetic, doubling the correct bits in each step.
-            inverse *= 2 - denominator * inverse; // inverse mod 2⁸
-            inverse *= 2 - denominator * inverse; // inverse mod 2¹⁶
-            inverse *= 2 - denominator * inverse; // inverse mod 2³²
-            inverse *= 2 - denominator * inverse; // inverse mod 2⁶⁴
-            inverse *= 2 - denominator * inverse; // inverse mod 2¹²⁸
-            inverse *= 2 - denominator * inverse; // inverse mod 2²⁵⁶
-
-            // Because the division is now exact we can divide by multiplying with the modular inverse of denominator.
-            // This will give us the correct result modulo 2²⁵⁶. Since the preconditions guarantee that the outcome is
-            // less than 2²⁵⁶, this is the final result. We don't need to compute the high bits of the result and prod1
-            // is no longer required.
-            result = prod0 * inverse;
-            return result;
-        }
-    }
-
-    /**
-     * @dev Calculates x * y / denominator with full precision, following the selected rounding direction.
-     */
-    function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
-        return mulDiv(x, y, denominator) + SafeCast.toUint(unsignedRoundsUp(rounding) && mulmod(x, y, denominator) > 0);
-    }
-
-    /**
-     * @dev Calculate the modular multiplicative inverse of a number in Z/nZ.
-     *
-     * If n is a prime, then Z/nZ is a field. In that case all elements are inversible, except 0.
-     * If n is not a prime, then Z/nZ is not a field, and some elements might not be inversible.
-     *
-     * If the input value is not inversible, 0 is returned.
-     *
-     * NOTE: If you know for sure that n is (big) a prime, it may be cheaper to use Fermat's little theorem and get the
-     * inverse using `Math.modExp(a, n - 2, n)`. See {invModPrime}.
-     */
-    function invMod(uint256 a, uint256 n) internal pure returns (uint256) {
-        unchecked {
-            if (n == 0) return 0;
-
-            // The inverse modulo is calculated using the Extended Euclidean Algorithm (iterative version)
-            // Used to compute integers x and y such that: ax + ny = gcd(a, n).
-            // When the gcd is 1, then the inverse of a modulo n exists and it's x.
-            // ax + ny = 1
-            // ax = 1 + (-y)n
-            // ax ≡ 1 (mod n) # x is the inverse of a modulo n
-
-            // If the remainder is 0 the gcd is n right away.
-            uint256 remainder = a % n;
-            uint256 gcd = n;
-
-            // Therefore the initial coefficients are:
-            // ax + ny = gcd(a, n) = n
-            // 0a + 1n = n
-            int256 x = 0;
-            int256 y = 1;
-
-            while (remainder != 0) {
-                uint256 quotient = gcd / remainder;
-
-                (gcd, remainder) = (
-                    // The old remainder is the next gcd to try.
-                    remainder,
-                    // Compute the next remainder.
-                    // Can't overflow given that (a % gcd) * (gcd // (a % gcd)) <= gcd
-                    // where gcd is at most n (capped to type(uint256).max)
-                    gcd - remainder * quotient
-                );
-
-                (x, y) = (
-                    // Increment the coefficient of a.
-                    y,
-                    // Decrement the coefficient of n.
-                    // Can overflow, but the result is casted to uint256 so that the
-                    // next value of y is "wrapped around" to a value between 0 and n - 1.
-                    x - y * int256(quotient)
-                );
-            }
-
-            if (gcd != 1) return 0; // No inverse exists.
-            return ternary(x < 0, n - uint256(-x), uint256(x)); // Wrap the result if it's negative.
-        }
-    }
-
-    /**
-     * @dev Variant of {invMod}. More efficient, but only works if `p` is known to be a prime greater than `2`.
-     *
-     * From https://en.wikipedia.org/wiki/Fermat%27s_little_theorem[Fermat's little theorem], we know that if p is
-     * prime, then `a**(p-1) ≡ 1 mod p`. As a consequence, we have `a * a**(p-2) ≡ 1 mod p`, which means that
-     * `a**(p-2)` is the modular multiplicative inverse of a in Fp.
-     *
-     * NOTE: this function does NOT check that `p` is a prime greater than `2`.
-     */
-    function invModPrime(uint256 a, uint256 p) internal view returns (uint256) {
-        unchecked {
-            return Math.modExp(a, p - 2, p);
-        }
-    }
-
-    /**
-     * @dev Returns the modular exponentiation of the specified base, exponent and modulus (b ** e % m)
-     *
-     * Requirements:
-     * - modulus can't be zero
-     * - underlying staticcall to precompile must succeed
-     *
-     * IMPORTANT: The result is only valid if the underlying call succeeds. When using this function, make
-     * sure the chain you're using it on supports the precompiled contract for modular exponentiation
-     * at address 0x05 as specified in https://eips.ethereum.org/EIPS/eip-198[EIP-198]. Otherwise,
-     * the underlying function will succeed given the lack of a revert, but the result may be incorrectly
-     * interpreted as 0.
-     */
-    function modExp(uint256 b, uint256 e, uint256 m) internal view returns (uint256) {
-        (bool success, uint256 result) = tryModExp(b, e, m);
-        if (!success) {
-            Panic.panic(Panic.DIVISION_BY_ZERO);
-        }
-        return result;
-    }
-
-    /**
-     * @dev Returns the modular exponentiation of the specified base, exponent and modulus (b ** e % m).
-     * It includes a success flag indicating if the operation succeeded. Operation will be marked as failed if trying
-     * to operate modulo 0 or if the underlying precompile reverted.
-     *
-     * IMPORTANT: The result is only valid if the success flag is true. When using this function, make sure the chain
-     * you're using it on supports the precompiled contract for modular exponentiation at address 0x05 as specified in
-     * https://eips.ethereum.org/EIPS/eip-198[EIP-198]. Otherwise, the underlying function will succeed given the lack
-     * of a revert, but the result may be incorrectly interpreted as 0.
-     */
-    function tryModExp(uint256 b, uint256 e, uint256 m) internal view returns (bool success, uint256 result) {
-        if (m == 0) return (false, 0);
-        assembly ("memory-safe") {
-            let ptr := mload(0x40)
-            // | Offset    | Content    | Content (Hex)                                                      |
-            // |-----------|------------|--------------------------------------------------------------------|
-            // | 0x00:0x1f | size of b  | 0x0000000000000000000000000000000000000000000000000000000000000020 |
-            // | 0x20:0x3f | size of e  | 0x0000000000000000000000000000000000000000000000000000000000000020 |
-            // | 0x40:0x5f | size of m  | 0x0000000000000000000000000000000000000000000000000000000000000020 |
-            // | 0x60:0x7f | value of b | 0x<.............................................................b> |
-            // | 0x80:0x9f | value of e | 0x<.............................................................e> |
-            // | 0xa0:0xbf | value of m | 0x<.............................................................m> |
-            mstore(ptr, 0x20)
-            mstore(add(ptr, 0x20), 0x20)
-            mstore(add(ptr, 0x40), 0x20)
-            mstore(add(ptr, 0x60), b)
-            mstore(add(ptr, 0x80), e)
-            mstore(add(ptr, 0xa0), m)
-
-            // Given the result < m, it's guaranteed to fit in 32 bytes,
-            // so we can use the memory scratch space located at offset 0.
-            success := staticcall(gas(), 0x05, ptr, 0xc0, 0x00, 0x20)
-            result := mload(0x00)
-        }
-    }
-
-    /**
-     * @dev Variant of {modExp} that supports inputs of arbitrary length.
-     */
-    function modExp(bytes memory b, bytes memory e, bytes memory m) internal view returns (bytes memory) {
-        (bool success, bytes memory result) = tryModExp(b, e, m);
-        if (!success) {
-            Panic.panic(Panic.DIVISION_BY_ZERO);
-        }
-        return result;
-    }
-
-    /**
-     * @dev Variant of {tryModExp} that supports inputs of arbitrary length.
-     */
-    function tryModExp(
-        bytes memory b,
-        bytes memory e,
-        bytes memory m
-    ) internal view returns (bool success, bytes memory result) {
-        if (_zeroBytes(m)) return (false, new bytes(0));
-
-        uint256 mLen = m.length;
-
-        // Encode call args in result and move the free memory pointer
-        result = abi.encodePacked(b.length, e.length, mLen, b, e, m);
-
-        assembly ("memory-safe") {
-            let dataPtr := add(result, 0x20)
-            // Write result on top of args to avoid allocating extra memory.
-            success := staticcall(gas(), 0x05, dataPtr, mload(result), dataPtr, mLen)
-            // Overwrite the length.
-            // result.length > returndatasize() is guaranteed because returndatasize() == m.length
-            mstore(result, mLen)
-            // Set the memory pointer after the returned data.
-            mstore(0x40, add(dataPtr, mLen))
-        }
-    }
-
-    /**
-     * @dev Returns whether the provided byte array is zero.
-     */
-    function _zeroBytes(bytes memory byteArray) private pure returns (bool) {
-        for (uint256 i = 0; i < byteArray.length; ++i) {
-            if (byteArray[i] != 0) {
-                return false;
-            }
-        }
-        return true;
-    }
-
-    /**
-     * @dev Returns the square root of a number. If the number is not a perfect square, the value is rounded
-     * towards zero.
-     *
-     * This method is based on Newton's method for computing square roots; the algorithm is restricted to only
-     * using integer operations.
-     */
-    function sqrt(uint256 a) internal pure returns (uint256) {
-        unchecked {
-            // Take care of easy edge cases when a == 0 or a == 1
-            if (a <= 1) {
-                return a;
-            }
-
-            // In this function, we use Newton's method to get a root of `f(x) := x² - a`. It involves building a
-            // sequence x_n that converges toward sqrt(a). For each iteration x_n, we also define the error between
-            // the current value as `ε_n = | x_n - sqrt(a) |`.
-            //
-            // For our first estimation, we consider `e` the smallest power of 2 which is bigger than the square root
-            // of the target. (i.e. `2**(e-1) ≤ sqrt(a) < 2**e`). We know that `e ≤ 128` because `(2¹²⁸)² = 2²⁵⁶` is
-            // bigger than any uint256.
-            //
-            // By noticing that
-            // `2**(e-1) ≤ sqrt(a) < 2**e → (2**(e-1))² ≤ a < (2**e)² → 2**(2*e-2) ≤ a < 2**(2*e)`
-            // we can deduce that `e - 1` is `log2(a) / 2`. We can thus compute `x_n = 2**(e-1)` using a method similar
-            // to the msb function.
-            uint256 aa = a;
-            uint256 xn = 1;
-
-            if (aa >= (1 << 128)) {
-                aa >>= 128;
-                xn <<= 64;
-            }
-            if (aa >= (1 << 64)) {
-                aa >>= 64;
-                xn <<= 32;
-            }
-            if (aa >= (1 << 32)) {
-                aa >>= 32;
-                xn <<= 16;
-            }
-            if (aa >= (1 << 16)) {
-                aa >>= 16;
-                xn <<= 8;
-            }
-            if (aa >= (1 << 8)) {
-                aa >>= 8;
-                xn <<= 4;
-            }
-            if (aa >= (1 << 4)) {
-                aa >>= 4;
-                xn <<= 2;
-            }
-            if (aa >= (1 << 2)) {
-                xn <<= 1;
-            }
-
-            // We now have x_n such that `x_n = 2**(e-1) ≤ sqrt(a) < 2**e = 2 * x_n`. This implies ε_n ≤ 2**(e-1).
-            //
-            // We can refine our estimation by noticing that the middle of that interval minimizes the error.
-            // If we move x_n to equal 2**(e-1) + 2**(e-2), then we reduce the error to ε_n ≤ 2**(e-2).
-            // This is going to be our x_0 (and ε_0)
-            xn = (3 * xn) >> 1; // ε_0 := | x_0 - sqrt(a) | ≤ 2**(e-2)
-
-            // From here, Newton's method give us:
-            // x_{n+1} = (x_n + a / x_n) / 2
-            //
-            // One should note that:
-            // x_{n+1}² - a = ((x_n + a / x_n) / 2)² - a
-            //              = ((x_n² + a) / (2 * x_n))² - a
-            //              = (x_n⁴ + 2 * a * x_n² + a²) / (4 * x_n²) - a
-            //              = (x_n⁴ + 2 * a * x_n² + a² - 4 * a * x_n²) / (4 * x_n²)
-            //              = (x_n⁴ - 2 * a * x_n² + a²) / (4 * x_n²)
-            //              = (x_n² - a)² / (2 * x_n)²
-            //              = ((x_n² - a) / (2 * x_n))²
-            //              ≥ 0
-            // Which proves that for all n ≥ 1, sqrt(a) ≤ x_n
-            //
-            // This gives us the proof of quadratic convergence of the sequence:
-            // ε_{n+1} = | x_{n+1} - sqrt(a) |
-            //         = | (x_n + a / x_n) / 2 - sqrt(a) |
-            //         = | (x_n² + a - 2*x_n*sqrt(a)) / (2 * x_n) |
-            //         = | (x_n - sqrt(a))² / (2 * x_n) |
-            //         = | ε_n² / (2 * x_n) |
-            //         = ε_n² / | (2 * x_n) |
-            //
-            // For the first iteration, we have a special case where x_0 is known:
-            // ε_1 = ε_0² / | (2 * x_0) |
-            //     ≤ (2**(e-2))² / (2 * (2**(e-1) + 2**(e-2)))
-            //     ≤ 2**(2*e-4) / (3 * 2**(e-1))
-            //     ≤ 2**(e-3) / 3
-            //     ≤ 2**(e-3-log2(3))
-            //     ≤ 2**(e-4.5)
-            //
-            // For the following iterations, we use the fact that, 2**(e-1) ≤ sqrt(a) ≤ x_n:
-            // ε_{n+1} = ε_n² / | (2 * x_n) |
-            //         ≤ (2**(e-k))² / (2 * 2**(e-1))
-            //         ≤ 2**(2*e-2*k) / 2**e
-            //         ≤ 2**(e-2*k)
-            xn = (xn + a / xn) >> 1; // ε_1 := | x_1 - sqrt(a) | ≤ 2**(e-4.5)  -- special case, see above
-            xn = (xn + a / xn) >> 1; // ε_2 := | x_2 - sqrt(a) | ≤ 2**(e-9)    -- general case with k = 4.5
-            xn = (xn + a / xn) >> 1; // ε_3 := | x_3 - sqrt(a) | ≤ 2**(e-18)   -- general case with k = 9
-            xn = (xn + a / xn) >> 1; // ε_4 := | x_4 - sqrt(a) | ≤ 2**(e-36)   -- general case with k = 18
-            xn = (xn + a / xn) >> 1; // ε_5 := | x_5 - sqrt(a) | ≤ 2**(e-72)   -- general case with k = 36
-            xn = (xn + a / xn) >> 1; // ε_6 := | x_6 - sqrt(a) | ≤ 2**(e-144)  -- general case with k = 72
-
-            // Because e ≤ 128 (as discussed during the first estimation phase), we know have reached a precision
-            // ε_6 ≤ 2**(e-144) < 1. Given we're operating on integers, then we can ensure that xn is now either
-            // sqrt(a) or sqrt(a) + 1.
-            return xn - SafeCast.toUint(xn > a / xn);
-        }
-    }
-
-    /**
-     * @dev Calculates sqrt(a), following the selected rounding direction.
-     */
-    function sqrt(uint256 a, Rounding rounding) internal pure returns (uint256) {
-        unchecked {
-            uint256 result = sqrt(a);
-            return result + SafeCast.toUint(unsignedRoundsUp(rounding) && result * result < a);
-        }
-    }
-
-    /**
-     * @dev Return the log in base 2 of a positive value rounded towards zero.
-     * Returns 0 if given 0.
-     */
-    function log2(uint256 value) internal pure returns (uint256) {
-        uint256 result = 0;
-        uint256 exp;
-        unchecked {
-            exp = 128 * SafeCast.toUint(value > (1 << 128) - 1);
-            value >>= exp;
-            result += exp;
-
-            exp = 64 * SafeCast.toUint(value > (1 << 64) - 1);
-            value >>= exp;
-            result += exp;
-
-            exp = 32 * SafeCast.toUint(value > (1 << 32) - 1);
-            value >>= exp;
-            result += exp;
-
-            exp = 16 * SafeCast.toUint(value > (1 << 16) - 1);
-            value >>= exp;
-            result += exp;
-
-            exp = 8 * SafeCast.toUint(value > (1 << 8) - 1);
-            value >>= exp;
-            result += exp;
-
-            exp = 4 * SafeCast.toUint(value > (1 << 4) - 1);
-            value >>= exp;
-            result += exp;
-
-            exp = 2 * SafeCast.toUint(value > (1 << 2) - 1);
-            value >>= exp;
-            result += exp;
-
-            result += SafeCast.toUint(value > 1);
-        }
-        return result;
-    }
-
-    /**
-     * @dev Return the log in base 2, following the selected rounding direction, of a positive value.
-     * Returns 0 if given 0.
-     */
-    function log2(uint256 value, Rounding rounding) internal pure returns (uint256) {
-        unchecked {
-            uint256 result = log2(value);
-            return result + SafeCast.toUint(unsignedRoundsUp(rounding) && 1 << result < value);
-        }
-    }
-
-    /**
-     * @dev Return the log in base 10 of a positive value rounded towards zero.
-     * Returns 0 if given 0.
-     */
-    function log10(uint256 value) internal pure returns (uint256) {
-        uint256 result = 0;
-        unchecked {
-            if (value >= 10 ** 64) {
-                value /= 10 ** 64;
-                result += 64;
-            }
-            if (value >= 10 ** 32) {
-                value /= 10 ** 32;
-                result += 32;
-            }
-            if (value >= 10 ** 16) {
-                value /= 10 ** 16;
-                result += 16;
-            }
-            if (value >= 10 ** 8) {
-                value /= 10 ** 8;
-                result += 8;
-            }
-            if (value >= 10 ** 4) {
-                value /= 10 ** 4;
-                result += 4;
-            }
-            if (value >= 10 ** 2) {
-                value /= 10 ** 2;
-                result += 2;
-            }
-            if (value >= 10 ** 1) {
-                result += 1;
-            }
-        }
-        return result;
-    }
-
-    /**
-     * @dev Return the log in base 10, following the selected rounding direction, of a positive value.
-     * Returns 0 if given 0.
-     */
-    function log10(uint256 value, Rounding rounding) internal pure returns (uint256) {
-        unchecked {
-            uint256 result = log10(value);
-            return result + SafeCast.toUint(unsignedRoundsUp(rounding) && 10 ** result < value);
-        }
-    }
-
-    /**
-     * @dev Return the log in base 256 of a positive value rounded towards zero.
-     * Returns 0 if given 0.
-     *
-     * Adding one to the result gives the number of pairs of hex symbols needed to represent `value` as a hex string.
-     */
-    function log256(uint256 value) internal pure returns (uint256) {
-        uint256 result = 0;
-        uint256 isGt;
-        unchecked {
-            isGt = SafeCast.toUint(value > (1 << 128) - 1);
-            value >>= isGt * 128;
-            result += isGt * 16;
-
-            isGt = SafeCast.toUint(value > (1 << 64) - 1);
-            value >>= isGt * 64;
-            result += isGt * 8;
-
-            isGt = SafeCast.toUint(value > (1 << 32) - 1);
-            value >>= isGt * 32;
-            result += isGt * 4;
-
-            isGt = SafeCast.toUint(value > (1 << 16) - 1);
-            value >>= isGt * 16;
-            result += isGt * 2;
-
-            result += SafeCast.toUint(value > (1 << 8) - 1);
-        }
-        return result;
-    }
-
-    /**
-     * @dev Return the log in base 256, following the selected rounding direction, of a positive value.
-     * Returns 0 if given 0.
-     */
-    function log256(uint256 value, Rounding rounding) internal pure returns (uint256) {
-        unchecked {
-            uint256 result = log256(value);
-            return result + SafeCast.toUint(unsignedRoundsUp(rounding) && 1 << (result << 3) < value);
-        }
-    }
-
-    /**
-     * @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
-     */
-    function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
-        return uint8(rounding) % 2 == 1;
-    }
-}
-
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
-
-/**
- * @title ReserveConfiguration library
- * @author Aave
- * @notice Implements the bitmap logic to handle the reserve configuration
- */
-library ReserveConfiguration {
-  uint256 internal constant LTV_MASK =                       0x000000000000000000000000000000000000000000000000000000000000FFFF; // prettier-ignore
-  uint256 internal constant LIQUIDATION_THRESHOLD_MASK =     0x00000000000000000000000000000000000000000000000000000000FFFF0000; // prettier-ignore
-  uint256 internal constant LIQUIDATION_BONUS_MASK =         0x0000000000000000000000000000000000000000000000000000FFFF00000000; // prettier-ignore
-  uint256 internal constant DECIMALS_MASK =                  0x00000000000000000000000000000000000000000000000000FF000000000000; // prettier-ignore
-  uint256 internal constant ACTIVE_MASK =                    0x0000000000000000000000000000000000000000000000000100000000000000; // prettier-ignore
-  uint256 internal constant FROZEN_MASK =                    0x0000000000000000000000000000000000000000000000000200000000000000; // prettier-ignore
-  uint256 internal constant BORROWING_MASK =                 0x0000000000000000000000000000000000000000000000000400000000000000; // prettier-ignore
-  // @notice there is an unoccupied hole of 1 bit at position 59 from pre 3.2 stableBorrowRateEnabled
-  uint256 internal constant PAUSED_MASK =                    0x0000000000000000000000000000000000000000000000001000000000000000; // prettier-ignore
-  uint256 internal constant BORROWABLE_IN_ISOLATION_MASK =   0x0000000000000000000000000000000000000000000000002000000000000000; // prettier-ignore
-  uint256 internal constant SILOED_BORROWING_MASK =          0x0000000000000000000000000000000000000000000000004000000000000000; // prettier-ignore
-  uint256 internal constant FLASHLOAN_ENABLED_MASK =         0x0000000000000000000000000000000000000000000000008000000000000000; // prettier-ignore
-  uint256 internal constant RESERVE_FACTOR_MASK =            0x00000000000000000000000000000000000000000000FFFF0000000000000000; // prettier-ignore
-  uint256 internal constant BORROW_CAP_MASK =                0x00000000000000000000000000000000000FFFFFFFFF00000000000000000000; // prettier-ignore
-  uint256 internal constant SUPPLY_CAP_MASK =                0x00000000000000000000000000FFFFFFFFF00000000000000000000000000000; // prettier-ignore
-  uint256 internal constant LIQUIDATION_PROTOCOL_FEE_MASK =  0x0000000000000000000000FFFF00000000000000000000000000000000000000; // prettier-ignore
-  //@notice there is an unoccupied hole of 8 bits from 168 to 176 left from pre 3.2 eModeCategory
-  uint256 internal constant UNBACKED_MINT_CAP_MASK =         0x00000000000FFFFFFFFF00000000000000000000000000000000000000000000; // prettier-ignore
-  uint256 internal constant DEBT_CEILING_MASK =              0x0FFFFFFFFFF00000000000000000000000000000000000000000000000000000; // prettier-ignore
-  uint256 internal constant VIRTUAL_ACC_ACTIVE_MASK =        0x1000000000000000000000000000000000000000000000000000000000000000; // prettier-ignore
-
-  /// @dev For the LTV, the start bit is 0 (up to 15), hence no bitshifting is needed
-  uint256 internal constant LIQUIDATION_THRESHOLD_START_BIT_POSITION = 16;
-  uint256 internal constant LIQUIDATION_BONUS_START_BIT_POSITION = 32;
-  uint256 internal constant RESERVE_DECIMALS_START_BIT_POSITION = 48;
-  uint256 internal constant IS_ACTIVE_START_BIT_POSITION = 56;
-  uint256 internal constant IS_FROZEN_START_BIT_POSITION = 57;
-  uint256 internal constant BORROWING_ENABLED_START_BIT_POSITION = 58;
-  uint256 internal constant IS_PAUSED_START_BIT_POSITION = 60;
-  uint256 internal constant BORROWABLE_IN_ISOLATION_START_BIT_POSITION = 61;
-  uint256 internal constant SILOED_BORROWING_START_BIT_POSITION = 62;
-  uint256 internal constant FLASHLOAN_ENABLED_START_BIT_POSITION = 63;
-  uint256 internal constant RESERVE_FACTOR_START_BIT_POSITION = 64;
-  uint256 internal constant BORROW_CAP_START_BIT_POSITION = 80;
-  uint256 internal constant SUPPLY_CAP_START_BIT_POSITION = 116;
-  uint256 internal constant LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION = 152;
-  //@notice there is an unoccupied hole of 8 bits from 168 to 176 left from pre 3.2 eModeCategory
-  uint256 internal constant UNBACKED_MINT_CAP_START_BIT_POSITION = 176;
-  uint256 internal constant DEBT_CEILING_START_BIT_POSITION = 212;
-  uint256 internal constant VIRTUAL_ACC_START_BIT_POSITION = 252;
-
-  uint256 internal constant MAX_VALID_LTV = 65535;
-  uint256 internal constant MAX_VALID_LIQUIDATION_THRESHOLD = 65535;
-  uint256 internal constant MAX_VALID_LIQUIDATION_BONUS = 65535;
-  uint256 internal constant MAX_VALID_DECIMALS = 255;
-  uint256 internal constant MAX_VALID_RESERVE_FACTOR = 65535;
-  uint256 internal constant MAX_VALID_BORROW_CAP = 68719476735;
-  uint256 internal constant MAX_VALID_SUPPLY_CAP = 68719476735;
-  uint256 internal constant MAX_VALID_LIQUIDATION_PROTOCOL_FEE = 65535;
-  uint256 internal constant MAX_VALID_UNBACKED_MINT_CAP = 68719476735;
-  uint256 internal constant MAX_VALID_DEBT_CEILING = 1099511627775;
-
-  uint256 public constant DEBT_CEILING_DECIMALS = 2;
-  uint16 public constant MAX_RESERVES_COUNT = 128;
+  function setConfiguration(
+    address asset,
+    DataTypes.ReserveConfigurationMap calldata configuration
+  ) external;
 
   /**
-   * @notice Sets the Loan to Value of the reserve
-   * @param self The reserve configuration
-   * @param ltv The new ltv
+   * @notice Returns the configuration of the reserve
+   * @param asset The address of the underlying asset of the reserve
+   * @return The configuration of the reserve
    */
-  function setLtv(DataTypes.ReserveConfigurationMap memory self, uint256 ltv) internal pure {
-    require(ltv <= MAX_VALID_LTV, Errors_1.INVALID_LTV);
-
-    self.data = (self.data & ~LTV_MASK) | ltv;
-  }
+  function getConfiguration(
+    address asset
+  ) external view returns (DataTypes.ReserveConfigurationMap memory);
 
   /**
-   * @notice Gets the Loan to Value of the reserve
-   * @param self The reserve configuration
-   * @return The loan to value
+   * @notice Returns the configuration of the user across all the reserves
+   * @param user The user address
+   * @return The configuration of the user
    */
-  function getLtv(DataTypes.ReserveConfigurationMap memory self) internal pure returns (uint256) {
-    return self.data & LTV_MASK;
-  }
+  function getUserConfiguration(
+    address user
+  ) external view returns (DataTypes.UserConfigurationMap memory);
 
   /**
-   * @notice Sets the liquidation threshold of the reserve
-   * @param self The reserve configuration
-   * @param threshold The new liquidation threshold
+   * @notice Returns the normalized income of the reserve
+   * @param asset The address of the underlying asset of the reserve
+   * @return The reserve's normalized income
    */
-  function setLiquidationThreshold(
-    DataTypes.ReserveConfigurationMap memory self,
-    uint256 threshold
-  ) internal pure {
-    require(threshold <= MAX_VALID_LIQUIDATION_THRESHOLD, Errors_1.INVALID_LIQ_THRESHOLD);
-
-    self.data =
-      (self.data & ~LIQUIDATION_THRESHOLD_MASK) |
-      (threshold << LIQUIDATION_THRESHOLD_START_BIT_POSITION);
-  }
+  function getReserveNormalizedIncome(address asset) external view returns (uint256);
 
   /**
-   * @notice Gets the liquidation threshold of the reserve
-   * @param self The reserve configuration
-   * @return The liquidation threshold
+   * @notice Returns the normalized variable debt per unit of asset
+   * @dev WARNING: This function is intended to be used primarily by the protocol itself to get a
+   * "dynamic" variable index based on time, current stored index and virtual rate at the current
+   * moment (approx. a borrower would get if opening a position). This means that is always used in
+   * combination with variable debt supply/balances.
+   * If using this function externally, consider that is possible to have an increasing normalized
+   * variable debt that is not equivalent to how the variable debt index would be updated in storage
+   * (e.g. only updates with non-zero variable debt supply)
+   * @param asset The address of the underlying asset of the reserve
+   * @return The reserve normalized variable debt
    */
-  function getLiquidationThreshold(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (uint256) {
-    return (self.data & LIQUIDATION_THRESHOLD_MASK) >> LIQUIDATION_THRESHOLD_START_BIT_POSITION;
-  }
+  function getReserveNormalizedVariableDebt(address asset) external view returns (uint256);
 
   /**
-   * @notice Sets the liquidation bonus of the reserve
-   * @param self The reserve configuration
-   * @param bonus The new liquidation bonus
+   * @notice Returns the state and configuration of the reserve
+   * @param asset The address of the underlying asset of the reserve
+   * @return The state and configuration data of the reserve
    */
-  function setLiquidationBonus(
-    DataTypes.ReserveConfigurationMap memory self,
-    uint256 bonus
-  ) internal pure {
-    require(bonus <= MAX_VALID_LIQUIDATION_BONUS, Errors_1.INVALID_LIQ_BONUS);
-
-    self.data =
-      (self.data & ~LIQUIDATION_BONUS_MASK) |
-      (bonus << LIQUIDATION_BONUS_START_BIT_POSITION);
-  }
+  function getReserveData(address asset) external view returns (DataTypes.ReserveDataLegacy memory);
 
   /**
-   * @notice Gets the liquidation bonus of the reserve
-   * @param self The reserve configuration
-   * @return The liquidation bonus
+   * @notice Returns the state and configuration of the reserve, including extra data included with Aave v3.1
+   * @dev DEPRECATED use independent getters instead (getReserveData, getLiquidationGracePeriod)
+   * @param asset The address of the underlying asset of the reserve
+   * @return The state and configuration data of the reserve with virtual accounting
    */
-  function getLiquidationBonus(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (uint256) {
-    return (self.data & LIQUIDATION_BONUS_MASK) >> LIQUIDATION_BONUS_START_BIT_POSITION;
-  }
+  function getReserveDataExtended(
+    address asset
+  ) external view returns (DataTypes.ReserveData memory);
 
   /**
-   * @notice Sets the decimals of the underlying asset of the reserve
-   * @param self The reserve configuration
-   * @param decimals The decimals
+   * @notice Returns the virtual underlying balance of the reserve
+   * @param asset The address of the underlying asset of the reserve
+   * @return The reserve virtual underlying balance
    */
-  function setDecimals(
-    DataTypes.ReserveConfigurationMap memory self,
-    uint256 decimals
-  ) internal pure {
-    require(decimals <= MAX_VALID_DECIMALS, Errors_1.INVALID_DECIMALS);
-
-    self.data = (self.data & ~DECIMALS_MASK) | (decimals << RESERVE_DECIMALS_START_BIT_POSITION);
-  }
+  function getVirtualUnderlyingBalance(address asset) external view returns (uint128);
 
   /**
-   * @notice Gets the decimals of the underlying asset of the reserve
-   * @param self The reserve configuration
-   * @return The decimals of the asset
+   * @notice Validates and finalizes an aToken transfer
+   * @dev Only callable by the overlying aToken of the `asset`
+   * @param asset The address of the underlying asset of the aToken
+   * @param from The user from which the aTokens are transferred
+   * @param to The user receiving the aTokens
+   * @param amount The amount being transferred/withdrawn
+   * @param balanceFromBefore The aToken balance of the `from` user before the transfer
+   * @param balanceToBefore The aToken balance of the `to` user before the transfer
    */
-  function getDecimals(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (uint256) {
-    return (self.data & DECIMALS_MASK) >> RESERVE_DECIMALS_START_BIT_POSITION;
-  }
+  function finalizeTransfer(
+    address asset,
+    address from,
+    address to,
+    uint256 amount,
+    uint256 balanceFromBefore,
+    uint256 balanceToBefore
+  ) external;
 
   /**
-   * @notice Sets the active state of the reserve
-   * @param self The reserve configuration
-   * @param active The active state
+   * @notice Returns the list of the underlying assets of all the initialized reserves
+   * @dev It does not include dropped reserves
+   * @return The addresses of the underlying assets of the initialized reserves
    */
-  function setActive(DataTypes.ReserveConfigurationMap memory self, bool active) internal pure {
-    self.data =
-      (self.data & ~ACTIVE_MASK) |
-      (uint256(active ? 1 : 0) << IS_ACTIVE_START_BIT_POSITION);
-  }
+  function getReservesList() external view returns (address[] memory);
 
   /**
-   * @notice Gets the active state of the reserve
-   * @param self The reserve configuration
-   * @return The active state
+   * @notice Returns the number of initialized reserves
+   * @dev It includes dropped reserves
+   * @return The count
    */
-  function getActive(DataTypes.ReserveConfigurationMap memory self) internal pure returns (bool) {
-    return (self.data & ACTIVE_MASK) != 0;
-  }
+  function getReservesCount() external view returns (uint256);
 
   /**
-   * @notice Sets the frozen state of the reserve
-   * @param self The reserve configuration
-   * @param frozen The frozen state
+   * @notice Returns the address of the underlying asset of a reserve by the reserve id as stored in the DataTypes.ReserveData struct
+   * @param id The id of the reserve as stored in the DataTypes.ReserveData struct
+   * @return The address of the reserve associated with id
    */
-  function setFrozen(DataTypes.ReserveConfigurationMap memory self, bool frozen) internal pure {
-    self.data =
-      (self.data & ~FROZEN_MASK) |
-      (uint256(frozen ? 1 : 0) << IS_FROZEN_START_BIT_POSITION);
-  }
+  function getReserveAddressById(uint16 id) external view returns (address);
 
   /**
-   * @notice Gets the frozen state of the reserve
-   * @param self The reserve configuration
-   * @return The frozen state
+   * @notice Returns the PoolAddressesProvider connected to this contract
+   * @return The address of the PoolAddressesProvider
    */
-  function getFrozen(DataTypes.ReserveConfigurationMap memory self) internal pure returns (bool) {
-    return (self.data & FROZEN_MASK) != 0;
-  }
+  function ADDRESSES_PROVIDER() external view returns (IPoolAddressesProvider);
 
   /**
-   * @notice Sets the paused state of the reserve
-   * @param self The reserve configuration
-   * @param paused The paused state
+   * @notice Updates the protocol fee on the bridging
+   * @param bridgeProtocolFee The part of the premium sent to the protocol treasury
    */
-  function setPaused(DataTypes.ReserveConfigurationMap memory self, bool paused) internal pure {
-    self.data =
-      (self.data & ~PAUSED_MASK) |
-      (uint256(paused ? 1 : 0) << IS_PAUSED_START_BIT_POSITION);
-  }
+  function updateBridgeProtocolFee(uint256 bridgeProtocolFee) external;
 
   /**
-   * @notice Gets the paused state of the reserve
-   * @param self The reserve configuration
-   * @return The paused state
+   * @notice Updates flash loan premiums. Flash loan premium consists of two parts:
+   * - A part is sent to aToken holders as extra, one time accumulated interest
+   * - A part is collected by the protocol treasury
+   * @dev The total premium is calculated on the total borrowed amount
+   * @dev The premium to protocol is calculated on the total premium, being a percentage of `flashLoanPremiumTotal`
+   * @dev Only callable by the PoolConfigurator contract
+   * @param flashLoanPremiumTotal The total premium, expressed in bps
+   * @param flashLoanPremiumToProtocol The part of the premium sent to the protocol treasury, expressed in bps
    */
-  function getPaused(DataTypes.ReserveConfigurationMap memory self) internal pure returns (bool) {
-    return (self.data & PAUSED_MASK) != 0;
-  }
+  function updateFlashloanPremiums(
+    uint128 flashLoanPremiumTotal,
+    uint128 flashLoanPremiumToProtocol
+  ) external;
 
   /**
-   * @notice Sets the borrowable in isolation flag for the reserve.
-   * @dev When this flag is set to true, the asset will be borrowable against isolated collaterals and the borrowed
-   * amount will be accumulated in the isolated collateral's total debt exposure.
-   * @dev Only assets of the same family (eg USD stablecoins) should be borrowable in isolation mode to keep
-   * consistency in the debt ceiling calculations.
-   * @param self The reserve configuration
-   * @param borrowable True if the asset is borrowable
-   */
-  function setBorrowableInIsolation(
-    DataTypes.ReserveConfigurationMap memory self,
-    bool borrowable
-  ) internal pure {
-    self.data =
-      (self.data & ~BORROWABLE_IN_ISOLATION_MASK) |
-      (uint256(borrowable ? 1 : 0) << BORROWABLE_IN_ISOLATION_START_BIT_POSITION);
-  }
-
-  /**
-   * @notice Gets the borrowable in isolation flag for the reserve.
-   * @dev If the returned flag is true, the asset is borrowable against isolated collateral. Assets borrowed with
-   * isolated collateral is accounted for in the isolated collateral's total debt exposure.
-   * @dev Only assets of the same family (eg USD stablecoins) should be borrowable in isolation mode to keep
-   * consistency in the debt ceiling calculations.
-   * @param self The reserve configuration
-   * @return The borrowable in isolation flag
-   */
-  function getBorrowableInIsolation(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (bool) {
-    return (self.data & BORROWABLE_IN_ISOLATION_MASK) != 0;
-  }
+   * @notice Configures a new or alters an existing collateral configuration of an eMode.
+   * @dev In eMode, the protocol allows very high borrowing power to borrow assets of the same category.
+   * The category 0 is reserved as it's the default for volatile assets
+   * @param id The id of the category
+   * @param config The configuration of the category
+   */
+  function configureEModeCategory(
+    uint8 id,
+    DataTypes.EModeCategoryBaseConfiguration memory config
+  ) external;
 
   /**
-   * @notice Sets the siloed borrowing flag for the reserve.
-   * @dev When this flag is set to true, users borrowing this asset will not be allowed to borrow any other asset.
-   * @param self The reserve configuration
-   * @param siloed True if the asset is siloed
+   * @notice Replaces the current eMode collateralBitmap.
+   * @param id The id of the category
+   * @param collateralBitmap The collateralBitmap of the category
    */
-  function setSiloedBorrowing(
-    DataTypes.ReserveConfigurationMap memory self,
-    bool siloed
-  ) internal pure {
-    self.data =
-      (self.data & ~SILOED_BORROWING_MASK) |
-      (uint256(siloed ? 1 : 0) << SILOED_BORROWING_START_BIT_POSITION);
-  }
+  function configureEModeCategoryCollateralBitmap(uint8 id, uint128 collateralBitmap) external;
 
   /**
-   * @notice Gets the siloed borrowing flag for the reserve.
-   * @dev When this flag is set to true, users borrowing this asset will not be allowed to borrow any other asset.
-   * @param self The reserve configuration
-   * @return The siloed borrowing flag
+   * @notice Replaces the current eMode borrowableBitmap.
+   * @param id The id of the category
+   * @param borrowableBitmap The borrowableBitmap of the category
    */
-  function getSiloedBorrowing(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (bool) {
-    return (self.data & SILOED_BORROWING_MASK) != 0;
-  }
+  function configureEModeCategoryBorrowableBitmap(uint8 id, uint128 borrowableBitmap) external;
 
   /**
-   * @notice Enables or disables borrowing on the reserve
-   * @param self The reserve configuration
-   * @param enabled True if the borrowing needs to be enabled, false otherwise
+   * @notice Returns the data of an eMode category
+   * @dev DEPRECATED use independent getters instead
+   * @param id The id of the category
+   * @return The configuration data of the category
    */
-  function setBorrowingEnabled(
-    DataTypes.ReserveConfigurationMap memory self,
-    bool enabled
-  ) internal pure {
-    self.data =
-      (self.data & ~BORROWING_MASK) |
-      (uint256(enabled ? 1 : 0) << BORROWING_ENABLED_START_BIT_POSITION);
-  }
+  function getEModeCategoryData(
+    uint8 id
+  ) external view returns (DataTypes.EModeCategoryLegacy memory);
 
   /**
-   * @notice Gets the borrowing state of the reserve
-   * @param self The reserve configuration
-   * @return The borrowing state
+   * @notice Returns the label of an eMode category
+   * @param id The id of the category
+   * @return The label of the category
    */
-  function getBorrowingEnabled(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (bool) {
-    return (self.data & BORROWING_MASK) != 0;
-  }
+  function getEModeCategoryLabel(uint8 id) external view returns (string memory);
 
   /**
-   * @notice Sets the reserve factor of the reserve
-   * @param self The reserve configuration
-   * @param reserveFactor The reserve factor
+   * @notice Returns the collateral config of an eMode category
+   * @param id The id of the category
+   * @return The ltv,lt,lb of the category
    */
-  function setReserveFactor(
-    DataTypes.ReserveConfigurationMap memory self,
-    uint256 reserveFactor
-  ) internal pure {
-    require(reserveFactor <= MAX_VALID_RESERVE_FACTOR, Errors_1.INVALID_RESERVE_FACTOR);
-
-    self.data =
-      (self.data & ~RESERVE_FACTOR_MASK) |
-      (reserveFactor << RESERVE_FACTOR_START_BIT_POSITION);
-  }
+  function getEModeCategoryCollateralConfig(
+    uint8 id
+  ) external view returns (DataTypes.CollateralConfig memory);
 
   /**
-   * @notice Gets the reserve factor of the reserve
-   * @param self The reserve configuration
-   * @return The reserve factor
+   * @notice Returns the collateralBitmap of an eMode category
+   * @param id The id of the category
+   * @return The collateralBitmap of the category
    */
-  function getReserveFactor(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (uint256) {
-    return (self.data & RESERVE_FACTOR_MASK) >> RESERVE_FACTOR_START_BIT_POSITION;
-  }
+  function getEModeCategoryCollateralBitmap(uint8 id) external view returns (uint128);
 
   /**
-   * @notice Sets the borrow cap of the reserve
-   * @param self The reserve configuration
-   * @param borrowCap The borrow cap
+   * @notice Returns the borrowableBitmap of an eMode category
+   * @param id The id of the category
+   * @return The borrowableBitmap of the category
    */
-  function setBorrowCap(
-    DataTypes.ReserveConfigurationMap memory self,
-    uint256 borrowCap
-  ) internal pure {
-    require(borrowCap <= MAX_VALID_BORROW_CAP, Errors_1.INVALID_BORROW_CAP);
-
-    self.data = (self.data & ~BORROW_CAP_MASK) | (borrowCap << BORROW_CAP_START_BIT_POSITION);
-  }
+  function getEModeCategoryBorrowableBitmap(uint8 id) external view returns (uint128);
 
   /**
-   * @notice Gets the borrow cap of the reserve
-   * @param self The reserve configuration
-   * @return The borrow cap
+   * @notice Allows a user to use the protocol in eMode
+   * @param categoryId The id of the category
    */
-  function getBorrowCap(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (uint256) {
-    return (self.data & BORROW_CAP_MASK) >> BORROW_CAP_START_BIT_POSITION;
-  }
+  function setUserEMode(uint8 categoryId) external;
 
   /**
-   * @notice Sets the supply cap of the reserve
-   * @param self The reserve configuration
-   * @param supplyCap The supply cap
+   * @notice Returns the eMode the user is using
+   * @param user The address of the user
+   * @return The eMode id
    */
-  function setSupplyCap(
-    DataTypes.ReserveConfigurationMap memory self,
-    uint256 supplyCap
-  ) internal pure {
-    require(supplyCap <= MAX_VALID_SUPPLY_CAP, Errors_1.INVALID_SUPPLY_CAP);
-
-    self.data = (self.data & ~SUPPLY_CAP_MASK) | (supplyCap << SUPPLY_CAP_START_BIT_POSITION);
-  }
+  function getUserEMode(address user) external view returns (uint256);
 
   /**
-   * @notice Gets the supply cap of the reserve
-   * @param self The reserve configuration
-   * @return The supply cap
+   * @notice Resets the isolation mode total debt of the given asset to zero
+   * @dev It requires the given asset has zero debt ceiling
+   * @param asset The address of the underlying asset to reset the isolationModeTotalDebt
    */
-  function getSupplyCap(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (uint256) {
-    return (self.data & SUPPLY_CAP_MASK) >> SUPPLY_CAP_START_BIT_POSITION;
-  }
+  function resetIsolationModeTotalDebt(address asset) external;
 
   /**
-   * @notice Sets the debt ceiling in isolation mode for the asset
-   * @param self The reserve configuration
-   * @param ceiling The maximum debt ceiling for the asset
-   */
-  function setDebtCeiling(
-    DataTypes.ReserveConfigurationMap memory self,
-    uint256 ceiling
-  ) internal pure {
-    require(ceiling <= MAX_VALID_DEBT_CEILING, Errors_1.INVALID_DEBT_CEILING);
+   * @notice Sets the liquidation grace period of the given asset
+   * @dev To enable a liquidation grace period, a timestamp in the future should be set,
+   *      To disable a liquidation grace period, any timestamp in the past works, like 0
+   * @param asset The address of the underlying asset to set the liquidationGracePeriod
+   * @param until Timestamp when the liquidation grace period will end
+   **/
+  function setLiquidationGracePeriod(address asset, uint40 until) external;
 
-    self.data = (self.data & ~DEBT_CEILING_MASK) | (ceiling << DEBT_CEILING_START_BIT_POSITION);
-  }
+  /**
+   * @notice Returns the liquidation grace period of the given asset
+   * @param asset The address of the underlying asset
+   * @return Timestamp when the liquidation grace period will end
+   **/
+  function getLiquidationGracePeriod(address asset) external returns (uint40);
 
   /**
-   * @notice Gets the debt ceiling for the asset if the asset is in isolation mode
-   * @param self The reserve configuration
-   * @return The debt ceiling (0 = isolation mode disabled)
+   * @notice Returns the total fee on flash loans
+   * @return The total fee on flashloans
    */
-  function getDebtCeiling(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (uint256) {
-    return (self.data & DEBT_CEILING_MASK) >> DEBT_CEILING_START_BIT_POSITION;
-  }
+  function FLASHLOAN_PREMIUM_TOTAL() external view returns (uint128);
 
   /**
-   * @notice Sets the liquidation protocol fee of the reserve
-   * @param self The reserve configuration
-   * @param liquidationProtocolFee The liquidation protocol fee
+   * @notice Returns the part of the bridge fees sent to protocol
+   * @return The bridge fee sent to the protocol treasury
    */
-  function setLiquidationProtocolFee(
-    DataTypes.ReserveConfigurationMap memory self,
-    uint256 liquidationProtocolFee
-  ) internal pure {
-    require(
-      liquidationProtocolFee <= MAX_VALID_LIQUIDATION_PROTOCOL_FEE,
-      Errors_1.INVALID_LIQUIDATION_PROTOCOL_FEE
-    );
-
-    self.data =
-      (self.data & ~LIQUIDATION_PROTOCOL_FEE_MASK) |
-      (liquidationProtocolFee << LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION);
-  }
+  function BRIDGE_PROTOCOL_FEE() external view returns (uint256);
 
   /**
-   * @dev Gets the liquidation protocol fee
-   * @param self The reserve configuration
-   * @return The liquidation protocol fee
+   * @notice Returns the part of the flashloan fees sent to protocol
+   * @return The flashloan fee sent to the protocol treasury
    */
-  function getLiquidationProtocolFee(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (uint256) {
-    return
-      (self.data & LIQUIDATION_PROTOCOL_FEE_MASK) >> LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION;
-  }
+  function FLASHLOAN_PREMIUM_TO_PROTOCOL() external view returns (uint128);
 
   /**
-   * @notice Sets the unbacked mint cap of the reserve
-   * @param self The reserve configuration
-   * @param unbackedMintCap The unbacked mint cap
+   * @notice Returns the maximum number of reserves supported to be listed in this Pool
+   * @return The maximum number of reserves supported
    */
-  function setUnbackedMintCap(
-    DataTypes.ReserveConfigurationMap memory self,
-    uint256 unbackedMintCap
-  ) internal pure {
-    require(unbackedMintCap <= MAX_VALID_UNBACKED_MINT_CAP, Errors_1.INVALID_UNBACKED_MINT_CAP);
-
-    self.data =
-      (self.data & ~UNBACKED_MINT_CAP_MASK) |
-      (unbackedMintCap << UNBACKED_MINT_CAP_START_BIT_POSITION);
-  }
+  function MAX_NUMBER_RESERVES() external view returns (uint16);
 
   /**
-   * @dev Gets the unbacked mint cap of the reserve
-   * @param self The reserve configuration
-   * @return The unbacked mint cap
+   * @notice Mints the assets accrued through the reserve factor to the treasury in the form of aTokens
+   * @param assets The list of reserves for which the minting needs to be executed
    */
-  function getUnbackedMintCap(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (uint256) {
-    return (self.data & UNBACKED_MINT_CAP_MASK) >> UNBACKED_MINT_CAP_START_BIT_POSITION;
-  }
+  function mintToTreasury(address[] calldata assets) external;
 
   /**
-   * @notice Sets the flashloanable flag for the reserve
-   * @param self The reserve configuration
-   * @param flashLoanEnabled True if the asset is flashloanable, false otherwise
+   * @notice Rescue and transfer tokens locked in this contract
+   * @param token The address of the token
+   * @param to The address of the recipient
+   * @param amount The amount of token to transfer
    */
-  function setFlashLoanEnabled(
-    DataTypes.ReserveConfigurationMap memory self,
-    bool flashLoanEnabled
-  ) internal pure {
-    self.data =
-      (self.data & ~FLASHLOAN_ENABLED_MASK) |
-      (uint256(flashLoanEnabled ? 1 : 0) << FLASHLOAN_ENABLED_START_BIT_POSITION);
-  }
+  function rescueTokens(address token, address to, uint256 amount) external;
 
   /**
-   * @notice Gets the flashloanable flag for the reserve
-   * @param self The reserve configuration
-   * @return The flashloanable flag
+   * @notice Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
+   * - E.g. User supplies 100 USDC and gets in return 100 aUSDC
+   * @dev Deprecated: Use the `supply` function instead
+   * @param asset The address of the underlying asset to supply
+   * @param amount The amount to be supplied
+   * @param onBehalfOf The address that will receive the aTokens, same as msg.sender if the user
+   *   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens
+   *   is a different wallet
+   * @param referralCode Code used to register the integrator originating the operation, for potential rewards.
+   *   0 if the action is executed directly by the user, without any middle-man
    */
-  function getFlashLoanEnabled(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (bool) {
-    return (self.data & FLASHLOAN_ENABLED_MASK) != 0;
-  }
+  function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
 
   /**
-   * @notice Sets the virtual account active/not state of the reserve
-   * @param self The reserve configuration
-   * @param active The active state
+   * @notice Gets the address of the external FlashLoanLogic
    */
-  function setVirtualAccActive(
-    DataTypes.ReserveConfigurationMap memory self,
-    bool active
-  ) internal pure {
-    self.data =
-      (self.data & ~VIRTUAL_ACC_ACTIVE_MASK) |
-      (uint256(active ? 1 : 0) << VIRTUAL_ACC_START_BIT_POSITION);
-  }
+  function getFlashLoanLogic() external view returns (address);
 
   /**
-   * @notice Gets the virtual account active/not state of the reserve
-   * @dev The state should be true for all normal assets and should be false
-   * Virtual accounting being disabled means that the asset:
-   * - is GHO
-   * - can never be supplied
-   * - the interest rate strategy is not influenced by the virtual balance
-   * @param self The reserve configuration
-   * @return The active state
+   * @notice Gets the address of the external BorrowLogic
    */
-  function getIsVirtualAccActive(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (bool) {
-    return (self.data & VIRTUAL_ACC_ACTIVE_MASK) != 0;
-  }
+  function getBorrowLogic() external view returns (address);
 
   /**
-   * @notice Gets the configuration flags of the reserve
-   * @param self The reserve configuration
-   * @return The state flag representing active
-   * @return The state flag representing frozen
-   * @return The state flag representing borrowing enabled
-   * @return The state flag representing paused
+   * @notice Gets the address of the external BridgeLogic
    */
-  function getFlags(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (bool, bool, bool, bool) {
-    uint256 dataLocal = self.data;
+  function getBridgeLogic() external view returns (address);
 
-    return (
-      (dataLocal & ACTIVE_MASK) != 0,
-      (dataLocal & FROZEN_MASK) != 0,
-      (dataLocal & BORROWING_MASK) != 0,
-      (dataLocal & PAUSED_MASK) != 0
-    );
-  }
+  /**
+   * @notice Gets the address of the external EModeLogic
+   */
+  function getEModeLogic() external view returns (address);
 
   /**
-   * @notice Gets the configuration parameters of the reserve from storage
-   * @param self The reserve configuration
-   * @return The state param representing ltv
-   * @return The state param representing liquidation threshold
-   * @return The state param representing liquidation bonus
-   * @return The state param representing reserve decimals
-   * @return The state param representing reserve factor
+   * @notice Gets the address of the external LiquidationLogic
    */
-  function getParams(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (uint256, uint256, uint256, uint256, uint256) {
-    uint256 dataLocal = self.data;
+  function getLiquidationLogic() external view returns (address);
 
-    return (
-      dataLocal & LTV_MASK,
-      (dataLocal & LIQUIDATION_THRESHOLD_MASK) >> LIQUIDATION_THRESHOLD_START_BIT_POSITION,
-      (dataLocal & LIQUIDATION_BONUS_MASK) >> LIQUIDATION_BONUS_START_BIT_POSITION,
-      (dataLocal & DECIMALS_MASK) >> RESERVE_DECIMALS_START_BIT_POSITION,
-      (dataLocal & RESERVE_FACTOR_MASK) >> RESERVE_FACTOR_START_BIT_POSITION
-    );
-  }
+  /**
+   * @notice Gets the address of the external PoolLogic
+   */
+  function getPoolLogic() external view returns (address);
 
   /**
-   * @notice Gets the caps parameters of the reserve from storage
-   * @param self The reserve configuration
-   * @return The state param representing borrow cap
-   * @return The state param representing supply cap.
+   * @notice Gets the address of the external SupplyLogic
    */
-  function getCaps(
-    DataTypes.ReserveConfigurationMap memory self
-  ) internal pure returns (uint256, uint256) {
-    uint256 dataLocal = self.data;
-
-    return (
-      (dataLocal & BORROW_CAP_MASK) >> BORROW_CAP_START_BIT_POSITION,
-      (dataLocal & SUPPLY_CAP_MASK) >> SUPPLY_CAP_START_BIT_POSITION
-    );
-  }
+  function getSupplyLogic() external view returns (address);
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IDefaultInterestRateStrategyV2.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IDefaultInterestRateStrategyV2.sol
 
 /**
  * @title IDefaultInterestRateStrategyV2
@@ -5735,7 +3986,7 @@ interface IDefaultInterestRateStrategyV2 is IReserveInterestRateStrategy {
   function setInterestRateParams(address reserve, InterestRateData calldata rateData) external;
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IInitializableAToken.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IInitializableAToken.sol
 
 /**
  * @title IInitializableAToken
@@ -5788,120 +4039,7 @@ interface IInitializableAToken {
   ) external;
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol
-
-// OpenZeppelin Contracts (last updated v5.1.0) (utils/Strings.sol)
-
-/**
- * @dev String operations.
- */
-library Strings {
-    bytes16 private constant HEX_DIGITS = "0123456789abcdef";
-    uint8 private constant ADDRESS_LENGTH = 20;
-
-    /**
-     * @dev The `value` string doesn't fit in the specified `length`.
-     */
-    error StringsInsufficientHexLength(uint256 value, uint256 length);
-
-    /**
-     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
-     */
-    function toString(uint256 value) internal pure returns (string memory) {
-        unchecked {
-            uint256 length = Math.log10(value) + 1;
-            string memory buffer = new string(length);
-            uint256 ptr;
-            assembly ("memory-safe") {
-                ptr := add(buffer, add(32, length))
-            }
-            while (true) {
-                ptr--;
-                assembly ("memory-safe") {
-                    mstore8(ptr, byte(mod(value, 10), HEX_DIGITS))
-                }
-                value /= 10;
-                if (value == 0) break;
-            }
-            return buffer;
-        }
-    }
-
-    /**
-     * @dev Converts a `int256` to its ASCII `string` decimal representation.
-     */
-    function toStringSigned(int256 value) internal pure returns (string memory) {
-        return string.concat(value < 0 ? "-" : "", toString(SignedMath.abs(value)));
-    }
-
-    /**
-     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
-     */
-    function toHexString(uint256 value) internal pure returns (string memory) {
-        unchecked {
-            return toHexString(value, Math.log256(value) + 1);
-        }
-    }
-
-    /**
-     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
-     */
-    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
-        uint256 localValue = value;
-        bytes memory buffer = new bytes(2 * length + 2);
-        buffer[0] = "0";
-        buffer[1] = "x";
-        for (uint256 i = 2 * length + 1; i > 1; --i) {
-            buffer[i] = HEX_DIGITS[localValue & 0xf];
-            localValue >>= 4;
-        }
-        if (localValue != 0) {
-            revert StringsInsufficientHexLength(value, length);
-        }
-        return string(buffer);
-    }
-
-    /**
-     * @dev Converts an `address` with fixed length of 20 bytes to its not checksummed ASCII `string` hexadecimal
-     * representation.
-     */
-    function toHexString(address addr) internal pure returns (string memory) {
-        return toHexString(uint256(uint160(addr)), ADDRESS_LENGTH);
-    }
-
-    /**
-     * @dev Converts an `address` with fixed length of 20 bytes to its checksummed ASCII `string` hexadecimal
-     * representation, according to EIP-55.
-     */
-    function toChecksumHexString(address addr) internal pure returns (string memory) {
-        bytes memory buffer = bytes(toHexString(addr));
-
-        // hash the hex part of buffer (skip length + 2 bytes, length 40)
-        uint256 hashValue;
-        assembly ("memory-safe") {
-            hashValue := shr(96, keccak256(add(buffer, 0x22), 40))
-        }
-
-        for (uint256 i = 41; i > 1; --i) {
-            // possible values for buffer[i] are 48 (0) to 57 (9) and 97 (a) to 102 (f)
-            if (hashValue & 0xf > 7 && uint8(buffer[i]) > 96) {
-                // case shift by xoring with 0x20
-                buffer[i] ^= 0x20;
-            }
-            hashValue >>= 4;
-        }
-        return string(buffer);
-    }
-
-    /**
-     * @dev Returns true if the two strings are equal.
-     */
-    function equal(string memory a, string memory b) internal pure returns (bool) {
-        return bytes(a).length == bytes(b).length && keccak256(bytes(a)) == keccak256(bytes(b));
-    }
-}
-
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPoolConfigurator.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IPoolConfigurator.sol
 
 /**
  * @title IPoolConfigurator
@@ -6449,14 +4587,14 @@ interface IPoolConfigurator {
   function MAX_GRACE_PERIOD() external view returns (uint40);
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IAToken.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/interfaces/IAToken.sol
 
 /**
  * @title IAToken
  * @author Aave
  * @notice Defines the basic interface for an AToken.
  */
-interface IAToken is IERC20_0, IScaledBalanceToken, IInitializableAToken {
+interface IAToken is IERC20, IScaledBalanceToken, IInitializableAToken {
   /**
    * @dev Emitted during the transfer action
    * @param from The user whose tokens are being transferred
@@ -6583,7 +4721,7 @@ interface IAToken is IERC20_0, IScaledBalanceToken, IInitializableAToken {
   function rescueTokens(address token, address to, uint256 amount) external;
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol
 
 /// @dev Examples here assume the usage of the `AaveV3Payload` base contracts
 /// contained in this same repository
@@ -6920,7 +5058,7 @@ interface IAaveV3ConfigEngine {
   function RATE_ENGINE() external view returns (address);
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-helpers/lib/aave-address-book/src/AaveV3.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-helpers/lib/aave-address-book/src/AaveV3.sol
 
 interface IACLManager_1 is IACLManager_0 {
   function hasRole(bytes32 role, address account) external view returns (bool);
@@ -6936,7 +5074,7 @@ interface IACLManager_1 is IACLManager_0 {
   function revokeRole(bytes32 role, address account) external;
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/src/interfaces/IPriceCapAdapter.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-capo/src/interfaces/IPriceCapAdapter.sol
 
 interface IPriceCapAdapter is ICLSynchronicityPriceAdapter {
   /**
@@ -7078,7 +5216,7 @@ interface IPriceCapAdapter is ICLSynchronicityPriceAdapter {
   error CallerIsNotRiskOrPoolAdmin();
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/src/interfaces/IPriceCapAdapterStable.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/lib/aave-capo/src/interfaces/IPriceCapAdapterStable.sol
 
 interface IPriceCapAdapterStable is ICLSynchronicityPriceAdapter {
   /**
@@ -7129,116 +5267,7 @@ interface IPriceCapAdapterStable is ICLSynchronicityPriceAdapter {
   error CapLowerThanActualPrice();
 }
 
-// downloads/SONEIUM/RISK_STEWARD/lib/aave-capo/src/interfaces/IPendlePriceCapAdapter.sol
-
-interface IPendlePriceCapAdapter is ICLSynchronicityPriceAdapter {
-  /**
-   * @notice Parameters to create adapter
-   * @param assetToUsdAggregator Price feed contract address for (ASSET / USD) pair, can also be CAPO adapter
-   * @param pendlePrincipalToken Pendle principal token contract address
-   * @param maxDiscountRatePerYear Maximum discount rate per year (in percents)
-   * @param discountRatePerYear Discount rate per year to set during construction (should be greater than zero and up to `maxDiscountRatePerYear`)
-   * @param aclManager ACL manager contract
-   * @param description Description of the adapter
-   */
-  struct PendlePriceCapAdapterParams {
-    address assetToUsdAggregator;
-    address pendlePrincipalToken;
-    uint64 maxDiscountRatePerYear;
-    uint64 discountRatePerYear;
-    address aclManager;
-    string description;
-  }
-
-  /**
-   * @notice Event is emitted when `discountRatePerYear` is changed from old value to the new one
-   * @param oldDiscountRatePerYear Old `discountRatePerYear` value
-   * @param newDiscountRatePerYear New `discountRatePerYear` value
-   */
-  event DiscountRatePerYearUpdated(uint64 oldDiscountRatePerYear, uint64 newDiscountRatePerYear);
-
-  /// @dev Attempted to set zero address
-  error ZeroAddress();
-
-  /// @dev Attempted to set zero `MAX_DISCOUNT_RATE_PER_YEAR`
-  error ZeroMaxDiscount();
-
-  /// @dev Attempted to create price adapter for pendle token with already passed maturity
-  error MaturityHasAlreadyPassed();
-
-  /// @dev Attempted to change `discountRatePerYear` from unauthorized address
-  error CallerIsNotRiskOrPoolAdmin();
-
-  /// @dev Attempted to set new `discountRatePerYear` greater than `MAX_DISCOUNT_RATE_PER_YEAR` or set zero
-  error InvalidNewDiscountRatePerYear();
-
-  /// @dev Attempted to set parameters that are valued at a discount of more than 100% for this linear model
-  error DiscountExceeds100Percent();
-
-  /**
-   * @notice Sets a new value `discountRatePerYear` used for PT tokens pricing
-   * @dev Can be called from risk admin or pool admin only
-   * @param discountRatePerYear_ New discount rate per year
-   */
-  function setDiscountRatePerYear(uint64 discountRatePerYear_) external;
-
-  /**
-   * @notice Returns the current discount rate set for a given asset (should be greater than zero and less than `MAX_DISCOUNT_RATE_PER_YEAR`)
-   * @dev The value may exceed 100%, but only if the period to maturity is less than an year
-   * @dev The parameter should be set based on the maximum possible APY value of the underlying asset
-   * @return discountRatePerYear The discount rate for the asset pricing
-   */
-  function discountRatePerYear() external view returns (uint64 discountRatePerYear);
-
-  /**
-   * @notice Returns the current discount on PT tokens
-   * @dev The discount amount is always inside [0; `PERCENTAGE_FACTOR`) range
-   * @return currentDiscount Current discount amount for the asset pricing
-   */
-  function getCurrentDiscount() external view returns (uint256 currentDiscount);
-
-  /**
-   * @notice Price feed for (ASSET / USD) pair
-   */
-  function ASSET_TO_USD_AGGREGATOR() external view returns (IChainlinkAggregator);
-
-  /**
-   * @notice Pendle principal token contract
-   */
-  function PENDLE_PRINCIPAL_TOKEN() external view returns (IPendlePrincipalToken);
-
-  /**
-   * @notice ACL manager contract
-   */
-  function ACL_MANAGER() external view returns (IACLManager_1);
-
-  /**
-   * @notice Number of decimals in the output of this price adapter
-   */
-  function DECIMALS() external view returns (uint8);
-
-  /**
-   * @notice Maximum percentage factor (100.00%)
-   */
-  function PERCENTAGE_FACTOR() external pure returns (uint256);
-
-  /**
-   * @notice Number of seconds per year (365 days)
-   */
-  function SECONDS_PER_YEAR() external pure returns (uint256);
-
-  /**
-   * @notice Asset maturity timestamp
-   */
-  function MATURITY() external view returns (uint256);
-
-  /**
-   * @notice The maximum implied APY rate that is set for a given asset before maturity occurs
-   */
-  function MAX_DISCOUNT_RATE_PER_YEAR() external view returns (uint64);
-}
-
-// downloads/SONEIUM/RISK_STEWARD/src/interfaces/IRiskSteward.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/src/interfaces/IRiskSteward.sol
 
 /**
  * @title IRiskSteward
@@ -7281,11 +5310,6 @@ interface IRiskSteward {
    */
   error AssetIsRestricted();
 
-  /**
-   * @notice The steward does not allow updates of risk param of a restricted eMode
-   */
-  error EModeIsRestricted();
-
   /**
    * @notice The steward does not allow updates of cap param of a restricted oracle
    */
@@ -7308,13 +5332,6 @@ interface IRiskSteward {
    */
   event AddressRestricted(address indexed contractAddress, bool indexed isRestricted);
 
-  /**
-   * @notice Emitted when the owner configures an eMode categoryId as restricted to be used by steward
-   * @param eModeCategoryId the id of the eMode category
-   * @param isRestricted true if eModeCategoryId is set as restricted, false otherwise
-   */
-  event EModeRestricted(uint8 indexed eModeCategoryId, bool indexed isRestricted);
-
   /**
    * @notice Emitted when the risk configuration for the risk params has been set
    * @param riskConfig struct containing the risk configurations
@@ -7322,7 +5339,7 @@ interface IRiskSteward {
   event RiskConfigSet(Config indexed riskConfig);
 
   /**
-   * @notice Struct storing the last update by the steward of risk param
+   * @notice Struct storing the last update by the steward of each risk param
    */
   struct Debounce {
     uint40 supplyCapLastUpdated;
@@ -7338,15 +5355,6 @@ interface IRiskSteward {
     uint40 priceCapLastUpdated;
   }
 
-  /**
-   * @notice Struct storing the last update by the steward of eMode risk param
-   */
-  struct EModeDebounce {
-    uint40 eModeLtvLastUpdated;
-    uint40 eModeLiquidationBonusLastUpdated;
-    uint40 eModeLiquidationThresholdLastUpdated;
-  }
-
   /**
    * @notice Struct storing the params used for validation of the risk param update
    * @param currentValue the current value of the risk param
@@ -7375,57 +5383,18 @@ interface IRiskSteward {
    * @notice Struct storing the risk configuration for all the risk param
    */
   struct Config {
-    CollateralConfig collateralConfig;
-    EmodeConfig eModeConfig;
-    RateConfig rateConfig;
-    CapConfig capConfig;
-    PriceCapConfig priceCapConfig;
-  }
-
-  /**
-   * @notice Struct storing the risk configuration for collateral side param
-   */
-  struct CollateralConfig {
     RiskParamConfig ltv;
     RiskParamConfig liquidationThreshold;
     RiskParamConfig liquidationBonus;
+    RiskParamConfig supplyCap;
+    RiskParamConfig borrowCap;
     RiskParamConfig debtCeiling;
-  }
-
-  /**
-   * @notice Struct storing the risk configuration for emode category param
-   */
-  struct EmodeConfig {
-    RiskParamConfig ltv;
-    RiskParamConfig liquidationThreshold;
-    RiskParamConfig liquidationBonus;
-  }
-
-  /**
-   * @notice Struct storing the risk configuration for rate param
-   */
-  struct RateConfig {
     RiskParamConfig baseVariableBorrowRate;
     RiskParamConfig variableRateSlope1;
     RiskParamConfig variableRateSlope2;
     RiskParamConfig optimalUsageRatio;
-  }
-
-  /**
-   * @notice Struct storing the risk configuration for cap param
-   */
-  struct CapConfig {
-    RiskParamConfig supplyCap;
-    RiskParamConfig borrowCap;
-  }
-
-  /**
-   * @notice Struct storing the risk configuration for price cap param
-   */
-  struct PriceCapConfig {
     RiskParamConfig priceCapLst;
     RiskParamConfig priceCapStable;
-    RiskParamConfig discountRatePendle;
   }
 
   /**
@@ -7444,23 +5413,15 @@ interface IRiskSteward {
     uint256 priceCap;
   }
 
-  /**
-   * @notice Struct used to update the pendle cap params
-   */
-  struct DiscountRatePendleUpdate {
-    address oracle;
-    uint256 discountRate;
-  }
-
   /**
    * @notice The config engine used to perform the cap update via delegatecall
    */
   function CONFIG_ENGINE() external view returns (IAaveV3ConfigEngine);
 
   /**
-   * @notice The aave pool of the instance steward controls
+   * @notice The pool data provider of the POOL the steward controls
    */
-  function POOL() external view returns (IPool);
+  function POOL_DATA_PROVIDER() external view returns (IPoolDataProvider);
 
   /**
    * @notice The safe controlling the steward
@@ -7491,14 +5452,6 @@ interface IRiskSteward {
    */
   function updateCollateralSide(IAaveV3ConfigEngine.CollateralUpdate[] calldata collateralUpdates) external;
 
-  /**
-   * @notice Allows updating eMode category params across multiple eMode ids
-   * @dev A eMode category update is only possible after minDelay has passed after last update
-   * @dev A eMode category increase / decrease is only allowed by a magnitude of maxPercentChange
-   * @param eModeCategoryUpdates struct containing new eMode category params to be updated
-   */
-  function updateEModeCategories(IAaveV3ConfigEngine.EModeCategoryUpdate[] calldata eModeCategoryUpdates) external;
-
   /**
    * @notice Allows updating lst price cap params across multiple oracles
    * @dev A price cap update is only possible after minDelay has passed after last update
@@ -7515,14 +5468,6 @@ interface IRiskSteward {
    */
   function updateStablePriceCaps(PriceCapStableUpdate[] calldata priceCapUpdates) external;
 
-  /**
-   * @notice Allows updating pendle price cap params (i.e discount rate) across multiple oracles
-   * @dev A price cap (i.e discount rate) update is only possible after minDelay has passed after last update
-   * @dev A price cap (i.e discount rate) increase / decrease is only allowed by a magnitude of maxPercentChange
-   * @param discountRateUpdates struct containing new price cap params (i.e discount rate) to be updated
-   */
-  function updatePendleDiscountRates(DiscountRatePendleUpdate[] calldata discountRateUpdates) external;
-
   /**
    * @notice method to check if an asset/oracle is restricted to be used by the risk stewards
    * @param contractAddress address of the underlying asset or oracle
@@ -7530,13 +5475,6 @@ interface IRiskSteward {
    */
   function isAddressRestricted(address contractAddress) external view returns (bool);
 
-  /**
-   * @notice method to check if an eMode category id is restricted to be used by the risk stewards
-   * @param eModeCategoryId the id of the eMode category
-   * @return bool if eModeCategoryId is restricted or not
-   */
-  function isEModeCategoryRestricted(uint8 eModeCategoryId) external view returns (bool);
-
   /**
    * @notice method called by the owner to set an asset/oracle as restricted
    * @param contractAddress address of the underlying asset or oracle
@@ -7544,27 +5482,13 @@ interface IRiskSteward {
    */
   function setAddressRestricted(address contractAddress, bool isRestricted) external;
 
-  /**
-   * @notice method called by the owner to set an eMode category as restricted
-   * @param eModeCategoryId the id of the eMode category
-   * @param isRestricted true if eModeCategoryId needs to be restricted, false otherwise
-   */
-  function setEModeCategoryRestricted(uint8 eModeCategoryId, bool isRestricted) external;
-
   /**
    * @notice Returns the timelock for a specific asset i.e the last updated timestamp
    * @param asset for which to fetch the timelock
-   * @return struct containing the latest updated timestamps of all the risk params by the steward per asset
+   * @return struct containing the latest updated timestamps of all the risk params by the steward
    */
   function getTimelock(address asset) external view returns (Debounce memory);
 
-  /**
-   * @notice Returns the timelock for a specific eMode category id i.e the last updated timestamp
-   * @param eModeCategoryId the eMode category for which to fetch the timelock
-   * @return struct containing the latest updated timestamps of eMode risk params by the steward
-   */
-  function getEModeTimelock(uint8 eModeCategoryId) external view returns (EModeDebounce memory);
-
   /**
    * @notice method to get the risk configuration set for all the risk params
    * @return struct containing the risk configurations
@@ -7578,7 +5502,7 @@ interface IRiskSteward {
   function setRiskConfig(Config memory riskConfig) external;
 }
 
-// downloads/SONEIUM/RISK_STEWARD/src/contracts/RiskSteward.sol
+// downloads/LINEA/RISK_STEWARD/RiskSteward/src/contracts/RiskSteward.sol
 
 /**
  * @title RiskSteward
@@ -7587,8 +5511,6 @@ interface IRiskSteward {
  *         This contract can update the following risk params: caps, ltv, liqThreshold, liqBonus, debtCeiling, interest rates params.
  */
 contract RiskSteward is Ownable, IRiskSteward {
-  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
-  using Strings for string;
   using Address for address;
   using SafeCast for uint256;
   using SafeCast for int256;
@@ -7597,7 +5519,7 @@ contract RiskSteward is Ownable, IRiskSteward {
   IAaveV3ConfigEngine public immutable CONFIG_ENGINE;
 
   /// @inheritdoc IRiskSteward
-  IPool public immutable POOL;
+  IPoolDataProvider public immutable POOL_DATA_PROVIDER;
 
   /// @inheritdoc IRiskSteward
   address public immutable RISK_COUNCIL;
@@ -7608,12 +5530,8 @@ contract RiskSteward is Ownable, IRiskSteward {
 
   mapping(address => Debounce) internal _timelocks;
 
-  mapping(uint8 => EModeDebounce) internal _eModeTimelocks;
-
   mapping(address => bool) internal _restrictedAddresses;
 
-  mapping(uint8 => bool) internal _restrictedEModes;
-
   /**
    * @dev Modifier preventing anyone, but the council to update risk params.
    */
@@ -7623,21 +5541,19 @@ contract RiskSteward is Ownable, IRiskSteward {
   }
 
   /**
-   * @param pool The aave pool to be controlled by the steward
+   * @param poolDataProvider The pool data provider of the pool to be controlled by the steward
    * @param engine the config engine to be used by the steward
    * @param riskCouncil the safe address of the council being able to interact with the steward
-   * @param owner the owner of the risk steward being able to set configs and mark items as restricted
    * @param riskConfig the risk configuration to setup for each individual risk param
    */
   constructor(
-    address pool,
-    address engine,
+    IPoolDataProvider poolDataProvider,
+    IAaveV3ConfigEngine engine,
     address riskCouncil,
-    address owner,
     Config memory riskConfig
-  ) Ownable(owner) {
-    POOL = IPool(pool);
-    CONFIG_ENGINE = IAaveV3ConfigEngine(engine);
+  ) {
+    POOL_DATA_PROVIDER = poolDataProvider;
+    CONFIG_ENGINE = engine;
     RISK_COUNCIL = riskCouncil;
     _riskConfig = riskConfig;
   }
@@ -7664,14 +5580,6 @@ contract RiskSteward is Ownable, IRiskSteward {
     _updateCollateralSide(collateralUpdates);
   }
 
-  /// @inheritdoc IRiskSteward
-  function updateEModeCategories(
-    IAaveV3ConfigEngine.EModeCategoryUpdate[] calldata eModeCategoryUpdates
-  ) external virtual onlyRiskCouncil {
-    _validateEModeCategoryUpdate(eModeCategoryUpdates);
-    _updateEModeCategories(eModeCategoryUpdates);
-  }
-
   /// @inheritdoc IRiskSteward
   function updateLstPriceCaps(
     PriceCapLstUpdate[] calldata priceCapUpdates
@@ -7688,24 +5596,11 @@ contract RiskSteward is Ownable, IRiskSteward {
     _updateStablePriceCaps(priceCapUpdates);
   }
 
-  /// @inheritdoc IRiskSteward
-  function updatePendleDiscountRates(
-    DiscountRatePendleUpdate[] calldata discountRateUpdates
-  ) external virtual onlyRiskCouncil {
-    _validatePendleDiscountRateUpdate(discountRateUpdates);
-    _updatePendleDiscountRates(discountRateUpdates);
-  }
-
   /// @inheritdoc IRiskSteward
   function getTimelock(address asset) external view returns (Debounce memory) {
     return _timelocks[asset];
   }
 
-  /// @inheritdoc IRiskSteward
-  function getEModeTimelock(uint8 eModeCategoryId) external view returns (EModeDebounce memory) {
-    return _eModeTimelocks[eModeCategoryId];
-  }
-
   /// @inheritdoc IRiskSteward
   function setRiskConfig(Config calldata riskConfig) external onlyOwner {
     _riskConfig = riskConfig;
@@ -7728,17 +5623,6 @@ contract RiskSteward is Ownable, IRiskSteward {
     emit AddressRestricted(contractAddress, isRestricted);
   }
 
-  /// @inheritdoc IRiskSteward
-  function isEModeCategoryRestricted(uint8 eModeCategoryId) external view returns (bool) {
-    return _restrictedEModes[eModeCategoryId];
-  }
-
-  /// @inheritdoc IRiskSteward
-  function setEModeCategoryRestricted(uint8 eModeCategoryId, bool isRestricted) external onlyOwner {
-    _restrictedEModes[eModeCategoryId] = isRestricted;
-    emit EModeRestricted(eModeCategoryId, isRestricted);
-  }
-
   /**
    * @notice method to validate the caps update
    * @param capsUpdate list containing the new supply, borrow caps of the assets
@@ -7753,14 +5637,16 @@ contract RiskSteward is Ownable, IRiskSteward {
       if (capsUpdate[i].supplyCap == 0 || capsUpdate[i].borrowCap == 0)
         revert InvalidUpdateToZero();
 
-      (uint256 currentBorrowCap, uint256 currentSupplyCap) = POOL.getConfiguration(asset).getCaps();
+      (uint256 currentBorrowCap, uint256 currentSupplyCap) = POOL_DATA_PROVIDER.getReserveCaps(
+        capsUpdate[i].asset
+      );
 
       _validateParamUpdate(
         ParamUpdateValidationInput({
           currentValue: currentSupplyCap,
           newValue: capsUpdate[i].supplyCap,
           lastUpdated: _timelocks[asset].supplyCapLastUpdated,
-          riskConfig: _riskConfig.capConfig.supplyCap,
+          riskConfig: _riskConfig.supplyCap,
           isChangeRelative: true
         })
       );
@@ -7769,7 +5655,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentBorrowCap,
           newValue: capsUpdate[i].borrowCap,
           lastUpdated: _timelocks[asset].borrowCapLastUpdated,
-          riskConfig: _riskConfig.capConfig.borrowCap,
+          riskConfig: _riskConfig.borrowCap,
           isChangeRelative: true
         })
       );
@@ -7799,7 +5685,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentOptimalUsageRatio,
           newValue: ratesUpdate[i].params.optimalUsageRatio,
           lastUpdated: _timelocks[asset].optimalUsageRatioLastUpdated,
-          riskConfig: _riskConfig.rateConfig.optimalUsageRatio,
+          riskConfig: _riskConfig.optimalUsageRatio,
           isChangeRelative: false
         })
       );
@@ -7808,7 +5694,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentBaseVariableBorrowRate,
           newValue: ratesUpdate[i].params.baseVariableBorrowRate,
           lastUpdated: _timelocks[asset].baseVariableRateLastUpdated,
-          riskConfig: _riskConfig.rateConfig.baseVariableBorrowRate,
+          riskConfig: _riskConfig.baseVariableBorrowRate,
           isChangeRelative: false
         })
       );
@@ -7817,7 +5703,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentVariableRateSlope1,
           newValue: ratesUpdate[i].params.variableRateSlope1,
           lastUpdated: _timelocks[asset].variableRateSlope1LastUpdated,
-          riskConfig: _riskConfig.rateConfig.variableRateSlope1,
+          riskConfig: _riskConfig.variableRateSlope1,
           isChangeRelative: false
         })
       );
@@ -7826,7 +5712,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentVariableRateSlope2,
           newValue: ratesUpdate[i].params.variableRateSlope2,
           lastUpdated: _timelocks[asset].variableRateSlope2LastUpdated,
-          riskConfig: _riskConfig.rateConfig.variableRateSlope2,
+          riskConfig: _riskConfig.variableRateSlope2,
           isChangeRelative: false
         })
       );
@@ -7839,7 +5725,7 @@ contract RiskSteward is Ownable, IRiskSteward {
    */
   function _validateCollateralsUpdate(
     IAaveV3ConfigEngine.CollateralUpdate[] calldata collateralUpdates
-  ) internal view virtual {
+  ) internal view {
     if (collateralUpdates.length == 0) revert NoZeroUpdates();
 
     for (uint256 i = 0; i < collateralUpdates.length; i++) {
@@ -7855,22 +5741,26 @@ contract RiskSteward is Ownable, IRiskSteward {
         collateralUpdates[i].debtCeiling == 0
       ) revert InvalidUpdateToZero();
 
-      DataTypes.ReserveConfigurationMap memory configuration = POOL.getConfiguration(asset);
       (
+        ,
         uint256 currentLtv,
         uint256 currentLiquidationThreshold,
         uint256 currentLiquidationBonus,
         ,
+        ,
+        ,
+        ,
+        ,
 
-      ) = configuration.getParams();
-      uint256 currentDebtCeiling = configuration.getDebtCeiling();
+      ) = POOL_DATA_PROVIDER.getReserveConfigurationData(asset);
+      uint256 currentDebtCeiling = POOL_DATA_PROVIDER.getDebtCeiling(asset);
 
       _validateParamUpdate(
         ParamUpdateValidationInput({
           currentValue: currentLtv,
           newValue: collateralUpdates[i].ltv,
           lastUpdated: _timelocks[asset].ltvLastUpdated,
-          riskConfig: _riskConfig.collateralConfig.ltv,
+          riskConfig: _riskConfig.ltv,
           isChangeRelative: false
         })
       );
@@ -7879,7 +5769,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentLiquidationThreshold,
           newValue: collateralUpdates[i].liqThreshold,
           lastUpdated: _timelocks[asset].liquidationThresholdLastUpdated,
-          riskConfig: _riskConfig.collateralConfig.liquidationThreshold,
+          riskConfig: _riskConfig.liquidationThreshold,
           isChangeRelative: false
         })
       );
@@ -7888,7 +5778,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentLiquidationBonus - 100_00, // as the definition is 100% + x%, and config engine takes into account x% for simplicity.
           newValue: collateralUpdates[i].liqBonus,
           lastUpdated: _timelocks[asset].liquidationBonusLastUpdated,
-          riskConfig: _riskConfig.collateralConfig.liquidationBonus,
+          riskConfig: _riskConfig.liquidationBonus,
           isChangeRelative: false
         })
       );
@@ -7897,66 +5787,13 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentDebtCeiling / 100, // as the definition is with 2 decimals, and config engine does not take the decimals into account.
           newValue: collateralUpdates[i].debtCeiling,
           lastUpdated: _timelocks[asset].debtCeilingLastUpdated,
-          riskConfig: _riskConfig.collateralConfig.debtCeiling,
+          riskConfig: _riskConfig.debtCeiling,
           isChangeRelative: true
         })
       );
     }
   }
 
-  /**
-   * @notice method to validate the eMode category update
-   * @param eModeCategoryUpdates list containing the new eMode category updates
-   */
-  function _validateEModeCategoryUpdate(
-    IAaveV3ConfigEngine.EModeCategoryUpdate[] calldata eModeCategoryUpdates
-  ) internal view {
-    if (eModeCategoryUpdates.length == 0) revert NoZeroUpdates();
-
-    for (uint256 i = 0; i < eModeCategoryUpdates.length; i++) {
-      uint8 eModeId = eModeCategoryUpdates[i].eModeCategory;
-      if (_restrictedEModes[eModeId]) revert EModeIsRestricted();
-      if (!eModeCategoryUpdates[i].label.equal(EngineFlags.KEEP_CURRENT_STRING))
-        revert ParamChangeNotAllowed();
-
-      if (
-        eModeCategoryUpdates[i].ltv == 0 ||
-        eModeCategoryUpdates[i].liqThreshold == 0 ||
-        eModeCategoryUpdates[i].liqBonus == 0
-      ) revert InvalidUpdateToZero();
-
-      DataTypes.CollateralConfig memory currentEmodeConfig = POOL.getEModeCategoryCollateralConfig(eModeId);
-
-      _validateParamUpdate(
-        ParamUpdateValidationInput({
-          currentValue: currentEmodeConfig.ltv,
-          newValue: eModeCategoryUpdates[i].ltv,
-          lastUpdated: _eModeTimelocks[eModeId].eModeLtvLastUpdated,
-          riskConfig: _riskConfig.eModeConfig.ltv,
-          isChangeRelative: false
-        })
-      );
-      _validateParamUpdate(
-        ParamUpdateValidationInput({
-          currentValue: currentEmodeConfig.liquidationThreshold,
-          newValue: eModeCategoryUpdates[i].liqThreshold,
-          lastUpdated: _eModeTimelocks[eModeId].eModeLiquidationThresholdLastUpdated,
-          riskConfig: _riskConfig.eModeConfig.liquidationThreshold,
-          isChangeRelative: false
-        })
-      );
-      _validateParamUpdate(
-        ParamUpdateValidationInput({
-          currentValue: currentEmodeConfig.liquidationBonus - 100_00, // as the definition is 100% + x%, and config engine takes into account x% for simplicity.
-          newValue: eModeCategoryUpdates[i].liqBonus,
-          lastUpdated: _eModeTimelocks[eModeId].eModeLiquidationBonusLastUpdated,
-          riskConfig: _riskConfig.eModeConfig.liquidationBonus,
-          isChangeRelative: false
-        })
-      );
-    }
-  }
-
   /**
    * @notice method to validate the oracle price caps update
    * @param priceCapsUpdate list containing the new price cap params for the oracles
@@ -7988,7 +5825,7 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentMaxYearlyGrowthPercent,
           newValue: priceCapsUpdate[i].priceCapUpdateParams.maxYearlyRatioGrowthPercent,
           lastUpdated: _timelocks[oracle].priceCapLastUpdated,
-          riskConfig: _riskConfig.priceCapConfig.priceCapLst,
+          riskConfig: _riskConfig.priceCapLst,
           isChangeRelative: true
         })
       );
@@ -8018,43 +5855,13 @@ contract RiskSteward is Ownable, IRiskSteward {
           currentValue: currentPriceCap.toUint256(),
           newValue: priceCapsUpdate[i].priceCap,
           lastUpdated: _timelocks[oracle].priceCapLastUpdated,
-          riskConfig: _riskConfig.priceCapConfig.priceCapStable,
+          riskConfig: _riskConfig.priceCapStable,
           isChangeRelative: true
         })
       );
     }
   }
 
-  /**
-   * @notice method to validate the pendle oracle discount rate update
-   * @param discountRateUpdate list containing the new discount rate values for the pendle oracles
-   */
-  function _validatePendleDiscountRateUpdate(
-    DiscountRatePendleUpdate[] calldata discountRateUpdate
-  ) internal view {
-    if (discountRateUpdate.length == 0) revert NoZeroUpdates();
-
-    for (uint256 i = 0; i < discountRateUpdate.length; i++) {
-      address oracle = discountRateUpdate[i].oracle;
-
-      if (_restrictedAddresses[oracle]) revert OracleIsRestricted();
-      if (discountRateUpdate[i].discountRate == 0) revert InvalidUpdateToZero();
-
-      // get current rate
-      uint256 currentDiscount = IPendlePriceCapAdapter(oracle).discountRatePerYear();
-
-      _validateParamUpdate(
-        ParamUpdateValidationInput({
-          currentValue: currentDiscount,
-          newValue: discountRateUpdate[i].discountRate,
-          lastUpdated: _timelocks[oracle].priceCapLastUpdated,
-          riskConfig: _riskConfig.priceCapConfig.discountRatePendle,
-          isChangeRelative: false
-        })
-      );
-    }
-  }
-
   /**
    * @notice method to validate the risk param update is within the allowed bound and the debounce is respected
    * @param validationParam struct containing values used for validation of the risk param update
@@ -8156,32 +5963,6 @@ contract RiskSteward is Ownable, IRiskSteward {
     );
   }
 
-  /**
-   * @notice method to update the eMode category params using the config engine and updates the debounce
-   * @param eModeCategoryUpdates list containing the new eMode category params of the eMode category id
-   */
-  function _updateEModeCategories(IAaveV3ConfigEngine.EModeCategoryUpdate[] calldata eModeCategoryUpdates) internal {
-    for (uint256 i = 0; i < eModeCategoryUpdates.length; i++) {
-      uint8 eModeId = eModeCategoryUpdates[i].eModeCategory;
-
-      if (eModeCategoryUpdates[i].ltv != EngineFlags.KEEP_CURRENT) {
-        _eModeTimelocks[eModeId].eModeLtvLastUpdated = uint40(block.timestamp);
-      }
-
-      if (eModeCategoryUpdates[i].liqThreshold != EngineFlags.KEEP_CURRENT) {
-        _eModeTimelocks[eModeId].eModeLiquidationThresholdLastUpdated = uint40(block.timestamp);
-      }
-
-      if (eModeCategoryUpdates[i].liqBonus != EngineFlags.KEEP_CURRENT) {
-        _eModeTimelocks[eModeId].eModeLiquidationBonusLastUpdated = uint40(block.timestamp);
-      }
-    }
-
-    address(CONFIG_ENGINE).functionDelegateCall(
-      abi.encodeWithSelector(CONFIG_ENGINE.updateEModeCategories.selector, eModeCategoryUpdates)
-    );
-  }
-
   /**
    * @notice method to update the oracle price caps update
    * @param priceCapsUpdate list containing the new price cap params for the oracles
@@ -8212,20 +5993,6 @@ contract RiskSteward is Ownable, IRiskSteward {
     }
   }
 
-  /**
-   * @notice method to update the pendle oracle discount rate
-   * @param discountRateUpdate list containing the new discount rate values for the pendle oracles
-   */
-  function _updatePendleDiscountRates(DiscountRatePendleUpdate[] calldata discountRateUpdate) internal {
-    for (uint256 i = 0; i < discountRateUpdate.length; i++) {
-      address oracle = discountRateUpdate[i].oracle;
-
-      _timelocks[oracle].priceCapLastUpdated = uint40(block.timestamp);
-
-      IPendlePriceCapAdapter(oracle).setDiscountRatePerYear(discountRateUpdate[i].discountRate.toUint64());
-    }
-  }
-
   /**
    * @notice method to fetch the current interest rate params of the asset
    * @param asset the address of the underlying asset
@@ -8246,7 +6013,7 @@ contract RiskSteward is Ownable, IRiskSteward {
       uint256 variableRateSlope2
     )
   {
-    address rateStrategyAddress = POOL.getReserveData(asset).interestRateStrategyAddress;
+    address rateStrategyAddress = POOL_DATA_PROVIDER.getInterestRateStrategyAddress(asset);
     IDefaultInterestRateStrategyV2.InterestRateData
       memory interestRateData = IDefaultInterestRateStrategyV2(rateStrategyAddress)
         .getInterestRateDataBps(asset);
```
