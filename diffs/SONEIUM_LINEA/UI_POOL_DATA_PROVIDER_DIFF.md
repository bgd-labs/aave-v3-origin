```diff
diff --git a/./downloads/SONEIUM/UI_POOL_DATA_PROVIDER.sol b/./downloads/LINEA/UI_POOL_DATA_PROVIDER.sol
index 46e3c51..2a04406 100644
--- a/./downloads/SONEIUM/UI_POOL_DATA_PROVIDER.sol
+++ b/./downloads/LINEA/UI_POOL_DATA_PROVIDER.sol
@@ -1,55 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.0 ^0.8.10;

-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/dependencies/chainlink/AggregatorInterface.sol
-
-// Chainlink Contracts v0.8
-
-interface AggregatorInterface {
-  function decimals() external view returns (uint8);
-
-  function description() external view returns (string memory);
-
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
-
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
-  event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 updatedAt);
-
-  event NewRound(uint256 indexed roundId, address indexed startedBy, uint256 startedAt);
-}

-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/helpers/interfaces/IEACAggregatorProxy.sol
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
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/dependencies/openzeppelin/contracts/IERC20.sol

-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/helpers/interfaces/IUiPoolDataProviderV3.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/helpers/interfaces/IUiPoolDataProviderV3.sol

 interface IUiPoolDataProviderV3 {
   struct AggregatedReserveData {
@@ -2324,8 +2241,6 @@ interface IUiPoolDataProviderV3 {
     // v3.1
     bool virtualAccActive;
     uint128 virtualUnderlyingBalance;
-    // v3.3
-    uint128 deficit;
   }

   struct UserReserveData {
@@ -2368,7 +2283,7 @@ interface IUiPoolDataProviderV3 {
   function getEModes(IPoolAddressesProvider provider) external view returns (Emode[] memory);
 }

-// downloads/SONEIUM/UI_POOL_DATA_PROVIDER/src/contracts/helpers/UiPoolDataProviderV3.sol
+// downloads/LINEA/UI_POOL_DATA_PROVIDER/UiPoolDataProviderV3/src/contracts/helpers/UiPoolDataProviderV3.sol

 contract UiPoolDataProviderV3 is IUiPoolDataProviderV3 {
   using WadRayMath for uint256;
   using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
   using UserConfiguration for DataTypes.UserConfigurationMap;

-  AggregatorInterface public immutable networkBaseTokenPriceInUsdProxyAggregator;
-  AggregatorInterface public immutable marketReferenceCurrencyPriceInUsdProxyAggregator;
+  IEACAggregatorProxy public immutable networkBaseTokenPriceInUsdProxyAggregator;
+  IEACAggregatorProxy public immutable marketReferenceCurrencyPriceInUsdProxyAggregator;
   uint256 public constant ETH_CURRENCY_UNIT = 1 ether;
   address public constant MKR_ADDRESS = 0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2;

   constructor(
-    AggregatorInterface _networkBaseTokenPriceInUsdProxyAggregator,
-    AggregatorInterface _marketReferenceCurrencyPriceInUsdProxyAggregator
+    IEACAggregatorProxy _networkBaseTokenPriceInUsdProxyAggregator,
+    IEACAggregatorProxy _marketReferenceCurrencyPriceInUsdProxyAggregator
   ) {
     networkBaseTokenPriceInUsdProxyAggregator = _networkBaseTokenPriceInUsdProxyAggregator;
     marketReferenceCurrencyPriceInUsdProxyAggregator = _marketReferenceCurrencyPriceInUsdProxyAggregator;
@@ -4018,7 +3930,6 @@ contract UiPoolDataProviderV3 is IUiPoolDataProviderV3 {
       } catch {}

       // v3 only
-      reserveData.deficit = uint128(pool.getReserveDeficit(reserveData.underlyingAsset));
       reserveData.debtCeiling = reserveConfigurationMap.getDebtCeiling();
       reserveData.debtCeilingDecimals = poolDataProvider.getDebtCeilingDecimals();
       (reserveData.borrowCap, reserveData.supplyCap) = reserveConfigurationMap.getCaps();
```
