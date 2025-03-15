```diff
diff --git a/./downloads/ARBITRUM/WALLET_BALANCE_PROVIDER.sol b/./downloads/LINEA/WALLET_BALANCE_PROVIDER.sol
index 0195ac0..a31677f 100644
--- a/./downloads/ARBITRUM/WALLET_BALANCE_PROVIDER.sol
+++ b/./downloads/LINEA/WALLET_BALANCE_PROVIDER.sol

-// downloads/ARBITRUM/WALLET_BALANCE_PROVIDER/WalletBalanceProvider/@aave/periphery-v3/contracts/misc/WalletBalanceProvider.sol
+// downloads/LINEA/WALLET_BALANCE_PROVIDER/WalletBalanceProvider/src/contracts/helpers/WalletBalanceProvider.sol

 /**
  * @title WalletBalanceProvider contract
@@ -2240,7 +2561,7 @@ contract WalletBalanceProvider {
         reservesWithEth[j]
       );

-      (bool isActive, , , , ) = configuration.getFlags();
+      (bool isActive, , , ) = configuration.getFlags();

       if (!isActive) {
         balances[j] = 0;
```
