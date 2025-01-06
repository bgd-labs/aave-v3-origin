```diff
diff --git a/./downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL.sol b/./downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL.sol
index 8c00995..8226df6 100644
--- a/./downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL.sol
+++ b/./downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL.sol
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
-pragma solidity =0.8.10 ^0.8.0 ^0.8.10;
+pragma solidity ^0.8.0 ^0.8.10;
 
-// downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/lib/aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
 
 /**
  * @dev Interface of the ERC20 standard as defined in the EIP.
@@ -77,7 +77,7 @@ interface IERC20 {
   event Approval(address indexed owner, address indexed spender, uint256 value);
 }
 
-// downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/lib/aave-v3-core/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/dependencies/openzeppelin/contracts/SafeCast.sol
 
 // OpenZeppelin Contracts v4.4.1 (utils/math/SafeCast.sol)
 
@@ -333,22 +333,41 @@ library SafeCast {
   }
 }
 
-// downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/lib/aave-v3-core/contracts/interfaces/IScaledBalanceToken.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/helpers/interfaces/IEACAggregatorProxy.sol
+
+interface IEACAggregatorProxy {
+  function decimals() external view returns (uint8);
+
+  function latestAnswer() external view returns (int256);
+
+  function latestTimestamp() external view returns (uint256);
+
+  function latestRound() external view returns (uint256);
+
+  function getAnswer(uint256 roundId) external view returns (int256);
+
+  function getTimestamp(uint256 roundId) external view returns (uint256);
+
+  event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 timestamp);
+  event NewRound(uint256 indexed roundId, address indexed startedBy);
+}
+
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/interfaces/IScaledBalanceToken.sol
 
 /**
  * @title IScaledBalanceToken
  * @author Aave
- * @notice Defines the basic interface for a scaledbalance token.
- **/
+ * @notice Defines the basic interface for a scaled-balance token.
+ */
 interface IScaledBalanceToken {
   /**
    * @dev Emitted after the mint action
    * @param caller The address performing the mint
-   * @param onBehalfOf The address of the user that will receive the minted scaled balance tokens
-   * @param value The amount being minted (user entered amount + balance increase from interest)
-   * @param balanceIncrease The increase in balance since the last action of the user
+   * @param onBehalfOf The address of the user that will receive the minted tokens
+   * @param value The scaled-up amount being minted (based on user entered amount and balance increase from interest)
+   * @param balanceIncrease The increase in scaled-up balance since the last action of 'onBehalfOf'
    * @param index The next liquidity index of the reserve
-   **/
+   */
   event Mint(
     address indexed caller,
     address indexed onBehalfOf,
@@ -358,13 +377,14 @@ interface IScaledBalanceToken {
   );
 
   /**
-   * @dev Emitted after scaled balance tokens are burned
-   * @param from The address from which the scaled tokens will be burned
+   * @dev Emitted after the burn action
+   * @dev If the burn function does not involve a transfer of the underlying asset, the target defaults to zero address
+   * @param from The address from which the tokens will be burned
    * @param target The address that will receive the underlying, if any
-   * @param value The amount being burned (user entered amount - balance increase from interest)
-   * @param balanceIncrease The increase in balance since the last action of the user
+   * @param value The scaled-up amount being burned (user entered amount - balance increase from interest)
+   * @param balanceIncrease The increase in scaled-up balance since the last action of 'from'
    * @param index The next liquidity index of the reserve
-   **/
+   */
   event Burn(
     address indexed from,
     address indexed target,
@@ -379,7 +399,7 @@ interface IScaledBalanceToken {
    * at the moment of the update
    * @param user The user whose balance is calculated
    * @return The scaled balance of the user
-   **/
+   */
   function scaledBalanceOf(address user) external view returns (uint256);
 
   /**
@@ -387,24 +407,24 @@ interface IScaledBalanceToken {
    * @param user The address of the user
    * @return The scaled balance of the user
    * @return The scaled total supply
-   **/
+   */
   function getScaledUserBalanceAndSupply(address user) external view returns (uint256, uint256);
 
   /**
    * @notice Returns the scaled total supply of the scaled balance token. Represents sum(debt/index)
    * @return The scaled total supply
-   **/
+   */
   function scaledTotalSupply() external view returns (uint256);
 
   /**
    * @notice Returns last index interest was accrued to the user's balance
    * @param user The address of the user
    * @return The last index interest was accrued to the user's balance, expressed in ray
-   **/
+   */
   function getPreviousIndex(address user) external view returns (uint256);
 }
 
-// downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/lib/aave-v3-core/contracts/protocol/libraries/aave-upgradeability/VersionedInitializable.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/misc/aave-upgradeability/VersionedInitializable.sol
 
 /**
  * @title VersionedInitializable
@@ -456,13 +476,13 @@ abstract contract VersionedInitializable {
    * @notice Returns the revision number of the contract
    * @dev Needs to be defined in the inherited class as a constant.
    * @return The revision number
-   **/
+   */
   function getRevision() internal pure virtual returns (uint256);
 
   /**
    * @notice Returns true if and only if the function is running in the constructor
    * @return True if the function is running in the constructor
-   **/
+   */
   function isConstructor() private view returns (bool) {
     // extcodesize checks the size of the code stored in an address, and
     // address returns the current address. Since the code is still not
@@ -481,26 +501,7 @@ abstract contract VersionedInitializable {
   uint256[50] private ______gap;
 }
 
-// downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/lib/aave-v3-periphery/contracts/misc/interfaces/IEACAggregatorProxy.sol
-
-interface IEACAggregatorProxy {
-  function decimals() external view returns (uint8);
-
-  function latestAnswer() external view returns (int256);
-
-  function latestTimestamp() external view returns (uint256);
-
-  function latestRound() external view returns (uint256);
-
-  function getAnswer(uint256 roundId) external view returns (int256);
-
-  function getTimestamp(uint256 roundId) external view returns (uint256);
-
-  event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 timestamp);
-  event NewRound(uint256 indexed roundId, address indexed startedBy);
-}
-
-// downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/lib/aave-v3-periphery/contracts/rewards/interfaces/IRewardsDistributor.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/rewards/interfaces/IRewardsDistributor.sol
 
 /**
  * @title IRewardsDistributor
@@ -677,7 +678,7 @@ interface IRewardsDistributor {
   function getEmissionManager() external view returns (address);
 }
 
-// downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/lib/aave-v3-periphery/contracts/rewards/interfaces/ITransferStrategyBase.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/rewards/interfaces/ITransferStrategyBase.sol
 
 interface ITransferStrategyBase {
   event EmergencyWithdrawal(
@@ -715,7 +716,7 @@ interface ITransferStrategyBase {
   function emergencyWithdrawal(address token, address to, uint256 amount) external;
 }
 
-// downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/lib/aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol
 
 interface IERC20Detailed is IERC20 {
   function name() external view returns (string memory);
@@ -725,7 +726,7 @@ interface IERC20Detailed is IERC20 {
   function decimals() external view returns (uint8);
 }
 
-// downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/lib/aave-v3-periphery/contracts/rewards/libraries/RewardsDataTypes.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/rewards/libraries/RewardsDataTypes.sol
 
 library RewardsDataTypes {
   struct RewardsConfigInput {
@@ -776,7 +777,7 @@ library RewardsDataTypes {
   }
 }
 
-// downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/lib/aave-v3-periphery/contracts/rewards/interfaces/IRewardsController.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/rewards/interfaces/IRewardsController.sol
 
 /**
  * @title IRewardsController
@@ -974,7 +975,7 @@ interface IRewardsController is IRewardsDistributor {
   ) external returns (address[] memory rewardsList, uint256[] memory claimedAmounts);
 }
 
-// downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/lib/aave-v3-periphery/contracts/rewards/RewardsDistributor.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/rewards/RewardsDistributor.sol
 
 /**
  * @title RewardsDistributor
@@ -1014,7 +1015,7 @@ abstract contract RewardsDistributor is IRewardsDistributor {
   function getRewardsData(
     address asset,
     address reward
-  ) public view override returns (uint256, uint256, uint256, uint256) {
+  ) external view override returns (uint256, uint256, uint256, uint256) {
     return (
       _assets[asset].rewards[reward].index,
       _assets[asset].rewards[reward].emissionPerSecond,
@@ -1066,7 +1067,7 @@ abstract contract RewardsDistributor is IRewardsDistributor {
     address user,
     address asset,
     address reward
-  ) public view override returns (uint256) {
+  ) external view override returns (uint256) {
     return _assets[asset].rewards[reward].usersData[user].index;
   }
 
@@ -1505,7 +1506,7 @@ abstract contract RewardsDistributor is IRewardsDistributor {
   }
 }
 
-// downloads/ARBITRUM/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/lib/aave-v3-periphery/contracts/rewards/RewardsController.sol
+// downloads/LINEA/DEFAULT_INCENTIVES_CONTROLLER_IMPL/RewardsController/src/contracts/rewards/RewardsController.sol
 
 /**
  * @title RewardsController
@@ -1515,7 +1516,7 @@ abstract contract RewardsDistributor is IRewardsDistributor {
 contract RewardsController is RewardsDistributor, VersionedInitializable, IRewardsController {
   using SafeCast for uint256;
 
-  uint256 public constant REVISION = 2;
+  uint256 public constant REVISION = 1;
 
   // This mapping allows whitelisted addresses to claim on behalf of others
   // useful for contracts that hold tokens to be rewarded but don't have any native logic to claim Liquidity Mining rewards
```
