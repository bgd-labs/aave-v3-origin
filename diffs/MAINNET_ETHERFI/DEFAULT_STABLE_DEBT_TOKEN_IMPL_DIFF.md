```diff
diff --git a/./downloads/MAINNET/DEFAULT_STABLE_DEBT_TOKEN_IMPL.sol b/./downloads/ETHERFI/DEFAULT_STABLE_DEBT_TOKEN_IMPL.sol

-// downloads/MAINNET/DEFAULT_STABLE_DEBT_TOKEN_IMPL/StableDebtToken/@aave/core-v3/contracts/protocol/tokenization/base/IncentivizedERC20.sol
+// downloads/ETHERFI/DEFAULT_STABLE_DEBT_TOKEN_IMPL/StableDebtTokenInstance/src/core/contracts/protocol/tokenization/base/IncentivizedERC20.sol

 /**
  * @title IncentivizedERC20
@@ -2654,15 +2708,15 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
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

@@ -2823,7 +2877,7 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
   }
 }

-// downloads/MAINNET/DEFAULT_STABLE_DEBT_TOKEN_IMPL/StableDebtToken/@aave/core-v3/contracts/protocol/tokenization/StableDebtToken.sol
+// downloads/ETHERFI/DEFAULT_STABLE_DEBT_TOKEN_IMPL/StableDebtTokenInstance/src/core/contracts/protocol/tokenization/StableDebtToken.sol

 /**
  * @title StableDebtToken
@@ -2832,20 +2886,7 @@ abstract contract IncentivizedERC20 is Context, IERC20Detailed {
  * at stable rate mode
  * @dev Transfer and approve functionalities are disabled since its a non-transferable token
  */
-contract StableDebtToken is DebtTokenBase, IncentivizedERC20, IStableDebtToken {
-  using WadRayMath for uint256;
-  using SafeCast for uint256;
-
-  uint256 public constant DEBT_TOKEN_REVISION = 0x1;
-
-  // Map of users address and the timestamp of their last update (userAddress => lastUpdateTimestamp)
-  mapping(address => uint40) internal _timestamps;
-
-  uint128 internal _avgStableRate;
-
-  // Timestamp of the last update of the total supply
-  uint40 internal _totalSupplyTimestamp;
-
+abstract contract StableDebtToken is DebtTokenBase, IncentivizedERC20, IStableDebtToken {
   /**
    * @dev Constructor.
    * @param pool The address of the Pool contract
@@ -2856,6 +2897,128 @@ contract StableDebtToken is DebtTokenBase, IncentivizedERC20, IStableDebtToken {
     // Intentionally left blank
   }

+  /// @inheritdoc IInitializableDebtToken
+  function initialize(
+    IPool initializingPool,
+    address underlyingAsset,
+    IAaveIncentivesController incentivesController,
+    uint8 debtTokenDecimals,
+    string memory debtTokenName,
+    string memory debtTokenSymbol,
+    bytes calldata params
+  ) external virtual;
+
+  /// @inheritdoc IStableDebtToken
+  function getAverageStableRate() external pure virtual override returns (uint256) {
+    return 0;
+  }
+
+  /// @inheritdoc IStableDebtToken
+  function getUserLastUpdated(address) external pure virtual override returns (uint40) {
+    return 0;
+  }
+
+  /// @inheritdoc IStableDebtToken
+  function getUserStableRate(address) external pure virtual override returns (uint256) {
+    return 0;
+  }
+
+  /// @inheritdoc IERC20
+  function balanceOf(address) public pure virtual override returns (uint256) {
+    return 0;
+  }
+
+  /// @inheritdoc IStableDebtToken
+  function mint(
+    address,
+    address,
+    uint256,
+    uint256
+  ) external virtual override onlyPool returns (bool, uint256, uint256) {
+    revert(Errors.OPERATION_NOT_SUPPORTED);
+  }
+
+  /// @inheritdoc IStableDebtToken
+  function burn(address, uint256) external virtual override onlyPool returns (uint256, uint256) {
+    revert(Errors.OPERATION_NOT_SUPPORTED);
+  }
+
+  /// @inheritdoc IStableDebtToken
+  function getSupplyData() external pure override returns (uint256, uint256, uint256, uint40) {
+    return (0, 0, 0, 0);
+  }
+
+  /// @inheritdoc IStableDebtToken
+  function getTotalSupplyAndAvgRate() external pure override returns (uint256, uint256) {
+    return (0, 0);
+  }
+
+  /// @inheritdoc IERC20
+  function totalSupply() public pure virtual override returns (uint256) {
+    return 0;
+  }
+
+  /// @inheritdoc IStableDebtToken
+  function getTotalSupplyLastUpdated() external pure override returns (uint40) {
+    return 0;
+  }
+
+  /// @inheritdoc IStableDebtToken
+  function principalBalanceOf(address) external pure virtual override returns (uint256) {
+    return 0;
+  }
+
+  /// @inheritdoc IStableDebtToken
+  function UNDERLYING_ASSET_ADDRESS() external view override returns (address) {
+    return _underlyingAsset;
+  }
+
+  /// @inheritdoc EIP712Base
+  function _EIP712BaseId() internal view override returns (string memory) {
+    return name();
+  }
+
+  /**
+   * @dev Being non transferrable, the debt token does not implement any of the
+   * standard ERC20 functions for transfer and allowance.
+   */
+  function transfer(address, uint256) external virtual override returns (bool) {
+    revert(Errors.OPERATION_NOT_SUPPORTED);
+  }
+
+  function allowance(address, address) external view virtual override returns (uint256) {
+    revert(Errors.OPERATION_NOT_SUPPORTED);
+  }
+
+  function approve(address, uint256) external virtual override returns (bool) {
+    revert(Errors.OPERATION_NOT_SUPPORTED);
+  }
+
+  function transferFrom(address, address, uint256) external virtual override returns (bool) {
+    revert(Errors.OPERATION_NOT_SUPPORTED);
+  }
+
+  function increaseAllowance(address, uint256) external virtual override returns (bool) {
+    revert(Errors.OPERATION_NOT_SUPPORTED);
+  }
+
+  function decreaseAllowance(address, uint256) external virtual override returns (bool) {
+    revert(Errors.OPERATION_NOT_SUPPORTED);
+  }
+}
+
+// downloads/ETHERFI/DEFAULT_STABLE_DEBT_TOKEN_IMPL/StableDebtTokenInstance/src/core/instances/StableDebtTokenInstance.sol
+
+contract StableDebtTokenInstance is StableDebtToken {
+  uint256 public constant DEBT_TOKEN_REVISION = 1;
+
+  constructor(IPool pool) StableDebtToken(pool) {}
+
+  /// @inheritdoc VersionedInitializable
+  function getRevision() internal pure virtual override returns (uint256) {
+    return DEBT_TOKEN_REVISION;
+  }
+
   /// @inheritdoc IInitializableDebtToken
   function initialize(
     IPool initializingPool,
@@ -2886,313 +3049,4 @@ contract StableDebtToken is DebtTokenBase, IncentivizedERC20, IStableDebtToken {
       params
     );
   }
-
-  /// @inheritdoc VersionedInitializable
-  function getRevision() internal pure virtual override returns (uint256) {
-    return DEBT_TOKEN_REVISION;
-  }
-
-  /// @inheritdoc IStableDebtToken
-  function getAverageStableRate() external view virtual override returns (uint256) {
-    return _avgStableRate;
-  }
-
-  /// @inheritdoc IStableDebtToken
-  function getUserLastUpdated(address user) external view virtual override returns (uint40) {
-    return _timestamps[user];
-  }
-
-  /// @inheritdoc IStableDebtToken
-  function getUserStableRate(address user) external view virtual override returns (uint256) {
-    return _userState[user].additionalData;
-  }
-
-  /// @inheritdoc IERC20
-  function balanceOf(address account) public view virtual override returns (uint256) {
-    uint256 accountBalance = super.balanceOf(account);
-    uint256 stableRate = _userState[account].additionalData;
-    if (accountBalance == 0) {
-      return 0;
-    }
-    uint256 cumulatedInterest = MathUtils.calculateCompoundedInterest(
-      stableRate,
-      _timestamps[account]
-    );
-    return accountBalance.rayMul(cumulatedInterest);
-  }
-
-  struct MintLocalVars {
-    uint256 previousSupply;
-    uint256 nextSupply;
-    uint256 amountInRay;
-    uint256 currentStableRate;
-    uint256 nextStableRate;
-    uint256 currentAvgStableRate;
-  }
-
-  /// @inheritdoc IStableDebtToken
-  function mint(
-    address user,
-    address onBehalfOf,
-    uint256 amount,
-    uint256 rate
-  ) external virtual override onlyPool returns (bool, uint256, uint256) {
-    MintLocalVars memory vars;
-
-    if (user != onBehalfOf) {
-      _decreaseBorrowAllowance(onBehalfOf, user, amount);
-    }
-
-    (, uint256 currentBalance, uint256 balanceIncrease) = _calculateBalanceIncrease(onBehalfOf);
-
-    vars.previousSupply = totalSupply();
-    vars.currentAvgStableRate = _avgStableRate;
-    vars.nextSupply = _totalSupply = vars.previousSupply + amount;
-
-    vars.amountInRay = amount.wadToRay();
-
-    vars.currentStableRate = _userState[onBehalfOf].additionalData;
-    vars.nextStableRate = (vars.currentStableRate.rayMul(currentBalance.wadToRay()) +
-      vars.amountInRay.rayMul(rate)).rayDiv((currentBalance + amount).wadToRay());
-
-    _userState[onBehalfOf].additionalData = vars.nextStableRate.toUint128();
-
-    //solium-disable-next-line
-    _totalSupplyTimestamp = _timestamps[onBehalfOf] = uint40(block.timestamp);
-
-    // Calculates the updated average stable rate
-    vars.currentAvgStableRate = _avgStableRate = (
-      (vars.currentAvgStableRate.rayMul(vars.previousSupply.wadToRay()) +
-        rate.rayMul(vars.amountInRay)).rayDiv(vars.nextSupply.wadToRay())
-    ).toUint128();
-
-    uint256 amountToMint = amount + balanceIncrease;
-    _mint(onBehalfOf, amountToMint, vars.previousSupply);
-
-    emit Transfer(address(0), onBehalfOf, amountToMint);
-    emit Mint(
-      user,
-      onBehalfOf,
-      amountToMint,
-      currentBalance,
-      balanceIncrease,
-      vars.nextStableRate,
-      vars.currentAvgStableRate,
-      vars.nextSupply
-    );
-
-    return (currentBalance == 0, vars.nextSupply, vars.currentAvgStableRate);
-  }
-
-  /// @inheritdoc IStableDebtToken
-  function burn(
-    address from,
-    uint256 amount
-  ) external virtual override onlyPool returns (uint256, uint256) {
-    (, uint256 currentBalance, uint256 balanceIncrease) = _calculateBalanceIncrease(from);
-
-    uint256 previousSupply = totalSupply();
-    uint256 nextAvgStableRate = 0;
-    uint256 nextSupply = 0;
-    uint256 userStableRate = _userState[from].additionalData;
-
-    // Since the total supply and each single user debt accrue separately,
-    // there might be accumulation errors so that the last borrower repaying
-    // might actually try to repay more than the available debt supply.
-    // In this case we simply set the total supply and the avg stable rate to 0
-    if (previousSupply <= amount) {
-      _avgStableRate = 0;
-      _totalSupply = 0;
-    } else {
-      nextSupply = _totalSupply = previousSupply - amount;
-      uint256 firstTerm = uint256(_avgStableRate).rayMul(previousSupply.wadToRay());
-      uint256 secondTerm = userStableRate.rayMul(amount.wadToRay());
-
-      // For the same reason described above, when the last user is repaying it might
-      // happen that user rate * user balance > avg rate * total supply. In that case,
-      // we simply set the avg rate to 0
-      if (secondTerm >= firstTerm) {
-        nextAvgStableRate = _totalSupply = _avgStableRate = 0;
-      } else {
-        nextAvgStableRate = _avgStableRate = (
-          (firstTerm - secondTerm).rayDiv(nextSupply.wadToRay())
-        ).toUint128();
-      }
-    }
-
-    if (amount == currentBalance) {
-      _userState[from].additionalData = 0;
-      _timestamps[from] = 0;
-    } else {
-      //solium-disable-next-line
-      _timestamps[from] = uint40(block.timestamp);
-    }
-    //solium-disable-next-line
-    _totalSupplyTimestamp = uint40(block.timestamp);
-
-    if (balanceIncrease > amount) {
-      uint256 amountToMint = balanceIncrease - amount;
-      _mint(from, amountToMint, previousSupply);
-      emit Transfer(address(0), from, amountToMint);
-      emit Mint(
-        from,
-        from,
-        amountToMint,
-        currentBalance,
-        balanceIncrease,
-        userStableRate,
-        nextAvgStableRate,
-        nextSupply
-      );
-    } else {
-      uint256 amountToBurn = amount - balanceIncrease;
-      _burn(from, amountToBurn, previousSupply);
-      emit Transfer(from, address(0), amountToBurn);
-      emit Burn(from, amountToBurn, currentBalance, balanceIncrease, nextAvgStableRate, nextSupply);
-    }
-
-    return (nextSupply, nextAvgStableRate);
-  }
-
-  /**
-   * @notice Calculates the increase in balance since the last user interaction
-   * @param user The address of the user for which the interest is being accumulated
-   * @return The previous principal balance
-   * @return The new principal balance
-   * @return The balance increase
-   */
-  function _calculateBalanceIncrease(
-    address user
-  ) internal view returns (uint256, uint256, uint256) {
-    uint256 previousPrincipalBalance = super.balanceOf(user);
-
-    if (previousPrincipalBalance == 0) {
-      return (0, 0, 0);
-    }
-
-    uint256 newPrincipalBalance = balanceOf(user);
-
-    return (
-      previousPrincipalBalance,
-      newPrincipalBalance,
-      newPrincipalBalance - previousPrincipalBalance
-    );
-  }
-
-  /// @inheritdoc IStableDebtToken
-  function getSupplyData() external view override returns (uint256, uint256, uint256, uint40) {
-    uint256 avgRate = _avgStableRate;
-    return (super.totalSupply(), _calcTotalSupply(avgRate), avgRate, _totalSupplyTimestamp);
-  }
-
-  /// @inheritdoc IStableDebtToken
-  function getTotalSupplyAndAvgRate() external view override returns (uint256, uint256) {
-    uint256 avgRate = _avgStableRate;
-    return (_calcTotalSupply(avgRate), avgRate);
-  }
-
-  /// @inheritdoc IERC20
-  function totalSupply() public view virtual override returns (uint256) {
-    return _calcTotalSupply(_avgStableRate);
-  }
-
-  /// @inheritdoc IStableDebtToken
-  function getTotalSupplyLastUpdated() external view override returns (uint40) {
-    return _totalSupplyTimestamp;
-  }
-
-  /// @inheritdoc IStableDebtToken
-  function principalBalanceOf(address user) external view virtual override returns (uint256) {
-    return super.balanceOf(user);
-  }
-
-  /// @inheritdoc IStableDebtToken
-  function UNDERLYING_ASSET_ADDRESS() external view override returns (address) {
-    return _underlyingAsset;
-  }
-
-  /**
-   * @notice Calculates the total supply
-   * @param avgRate The average rate at which the total supply increases
-   * @return The debt balance of the user since the last burn/mint action
-   */
-  function _calcTotalSupply(uint256 avgRate) internal view returns (uint256) {
-    uint256 principalSupply = super.totalSupply();
-
-    if (principalSupply == 0) {
-      return 0;
-    }
-
-    uint256 cumulatedInterest = MathUtils.calculateCompoundedInterest(
-      avgRate,
-      _totalSupplyTimestamp
-    );
-
-    return principalSupply.rayMul(cumulatedInterest);
-  }
-
-  /**
-   * @notice Mints stable debt tokens to a user
-   * @param account The account receiving the debt tokens
-   * @param amount The amount being minted
-   * @param oldTotalSupply The total supply before the minting event
-   */
-  function _mint(address account, uint256 amount, uint256 oldTotalSupply) internal {
-    uint128 castAmount = amount.toUint128();
-    uint128 oldAccountBalance = _userState[account].balance;
-    _userState[account].balance = oldAccountBalance + castAmount;
-
-    if (address(_incentivesController) != address(0)) {
-      _incentivesController.handleAction(account, oldTotalSupply, oldAccountBalance);
-    }
-  }
-
-  /**
-   * @notice Burns stable debt tokens of a user
-   * @param account The user getting his debt burned
-   * @param amount The amount being burned
-   * @param oldTotalSupply The total supply before the burning event
-   */
-  function _burn(address account, uint256 amount, uint256 oldTotalSupply) internal {
-    uint128 castAmount = amount.toUint128();
-    uint128 oldAccountBalance = _userState[account].balance;
-    _userState[account].balance = oldAccountBalance - castAmount;
-
-    if (address(_incentivesController) != address(0)) {
-      _incentivesController.handleAction(account, oldTotalSupply, oldAccountBalance);
-    }
-  }
-
-  /// @inheritdoc EIP712Base
-  function _EIP712BaseId() internal view override returns (string memory) {
-    return name();
-  }
-
-  /**
-   * @dev Being non transferrable, the debt token does not implement any of the
-   * standard ERC20 functions for transfer and allowance.
-   */
-  function transfer(address, uint256) external virtual override returns (bool) {
-    revert(Errors.OPERATION_NOT_SUPPORTED);
-  }
-
-  function allowance(address, address) external view virtual override returns (uint256) {
-    revert(Errors.OPERATION_NOT_SUPPORTED);
-  }
-
-  function approve(address, uint256) external virtual override returns (bool) {
-    revert(Errors.OPERATION_NOT_SUPPORTED);
-  }
-
-  function transferFrom(address, address, uint256) external virtual override returns (bool) {
-    revert(Errors.OPERATION_NOT_SUPPORTED);
-  }
-
-  function increaseAllowance(address, uint256) external virtual override returns (bool) {
-    revert(Errors.OPERATION_NOT_SUPPORTED);
-  }
-
-  function decreaseAllowance(address, uint256) external virtual override returns (bool) {
-    revert(Errors.OPERATION_NOT_SUPPORTED);
-  }
 }
```