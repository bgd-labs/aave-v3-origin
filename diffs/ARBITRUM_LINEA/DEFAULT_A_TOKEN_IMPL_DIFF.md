```diff
diff --git a/./downloads/ARBITRUM/DEFAULT_A_TOKEN_IMPL.sol b/./downloads/LINEA/DEFAULT_A_TOKEN_IMPL.sol
index efb0fd4..fd9dc66 100644
--- a/./downloads/ARBITRUM/DEFAULT_A_TOKEN_IMPL.sol
+++ b/./downloads/LINEA/DEFAULT_A_TOKEN_IMPL.sol

-// downloads/ARBITRUM/DEFAULT_A_TOKEN_IMPL/AToken/lib/aave-v3-core/contracts/protocol/tokenization/base/IncentivizedERC20.sol
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/protocol/tokenization/base/IncentivizedERC20.sol

 /**
  * @title IncentivizedERC20
@@ -2563,8 +2719,7 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
   /**
    * @dev UserState - additionalData is a flexible field.
    * ATokens and VariableDebtTokens use this field store the index of the
-   * user's last supply/withdrawal/borrow/repayment. StableDebtTokens use
-   * this field to store the user's stable rate.
+   * user's last supply/withdrawal/borrow/repayment.
    */
   struct UserState {
     uint128 balance;
@@ -2587,15 +2742,15 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
   /**
    * @dev Constructor.
    * @param pool The reference to the main Pool contract
-   * @param name The name of the token
-   * @param symbol The symbol of the token
-   * @param decimals The number of decimals of the token
+   * @param name_ The name of the token
+   * @param symbol_ The symbol of the token
+   * @param decimals_ The number of decimals of the token
    */
-  constructor(IPool pool, string memory name, string memory symbol, uint8 decimals) {
+  constructor(IPool pool, string memory name_, string memory symbol_, uint8 decimals_) {
     _addressesProvider = pool.ADDRESSES_PROVIDER();
-    _name = name;
-    _symbol = symbol;
-    _decimals = decimals;
+    _name = name_;
+    _symbol = symbol_;
+    _decimals = decimals_;
     POOL = pool;
   }

@@ -2756,7 +2911,7 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
   }
 }

 /**
  * @title Aave ERC20 AToken
  * @author Aave
  * @notice Implementation of the interest bearing token for the Aave protocol
  */
-contract AToken is VersionedInitializable, ScaledBalanceTokenBase, EIP712Base, IAToken {
+abstract contract AToken is VersionedInitializable, ScaledBalanceTokenBase, EIP712Base, IAToken {
   using WadRayMath for uint256;
   using SafeCast for uint256;
   using GPv2SafeERC20 for IERC20;
@@ -2982,16 +3137,9 @@ contract AToken is VersionedInitializable, ScaledBalanceTokenBase, EIP712Base, I
   bytes32 public constant PERMIT_TYPEHASH =
     keccak256('Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)');

-  uint256 public constant ATOKEN_REVISION = 0x2;
-
   address internal _treasury;
   address internal _underlyingAsset;

-  /// @inheritdoc VersionedInitializable
-  function getRevision() internal pure virtual override returns (uint256) {
-    return ATOKEN_REVISION;
-  }
-
   /**
    * @dev Constructor.
    * @param pool The address of the Pool contract
@@ -3012,29 +3160,7 @@ contract AToken is VersionedInitializable, ScaledBalanceTokenBase, EIP712Base, I
     string calldata aTokenName,
     string calldata aTokenSymbol,
     bytes calldata params
-  ) public virtual override initializer {
-    require(initializingPool == POOL, Errors.POOL_ADDRESSES_DO_NOT_MATCH);
-    _setName(aTokenName);
-    _setSymbol(aTokenSymbol);
-    _setDecimals(aTokenDecimals);
-
-    _treasury = treasury;
-    _underlyingAsset = underlyingAsset;
-    _incentivesController = incentivesController;
-
-    _domainSeparator = _calculateDomainSeparator();
-
-    emit Initialized(
-      underlyingAsset,
-      address(POOL),
-      treasury,
-      address(incentivesController),
-      aTokenDecimals,
-      aTokenName,
-      aTokenSymbol,
-      params
-    );
-  }
+  ) public virtual;

   /// @inheritdoc IAToken
   function mint(
@@ -3208,3 +3334,50 @@ contract AToken is VersionedInitializable, ScaledBalanceTokenBase, EIP712Base, I
     IERC20(token).safeTransfer(to, amount);
   }
 }
+
+// downloads/LINEA/DEFAULT_A_TOKEN_IMPL/ATokenInstance/src/contracts/instances/ATokenInstance.sol
+
+contract ATokenInstance is AToken {
+  uint256 public constant ATOKEN_REVISION = 1;
+
+  constructor(IPool pool) AToken(pool) {}
+
+  /// @inheritdoc VersionedInitializable
+  function getRevision() internal pure virtual override returns (uint256) {
+    return ATOKEN_REVISION;
+  }
+
+  /// @inheritdoc IInitializableAToken
+  function initialize(
+    IPool initializingPool,
+    address treasury,
+    address underlyingAsset,
+    IAaveIncentivesController incentivesController,
+    uint8 aTokenDecimals,
+    string calldata aTokenName,
+    string calldata aTokenSymbol,
+    bytes calldata params
+  ) public virtual override initializer {
+    require(initializingPool == POOL, Errors.POOL_ADDRESSES_DO_NOT_MATCH);
+    _setName(aTokenName);
+    _setSymbol(aTokenSymbol);
+    _setDecimals(aTokenDecimals);
+
+    _treasury = treasury;
+    _underlyingAsset = underlyingAsset;
+    _incentivesController = incentivesController;
+
+    _domainSeparator = _calculateDomainSeparator();
+
+    emit Initialized(
+      underlyingAsset,
+      address(POOL),
+      treasury,
+      address(incentivesController),
+      aTokenDecimals,
+      aTokenName,
+      aTokenSymbol,
+      params
+    );
+  }
+}
```