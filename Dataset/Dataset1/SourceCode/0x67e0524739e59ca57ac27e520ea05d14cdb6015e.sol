// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 ^0.8.0 ^0.8.7;

// @openzeppelin/contracts/token/ERC20/IERC20.sol

// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

// @openzeppelin/contracts/utils/Context.sol

// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// @openzeppelin/contracts/utils/structs/EnumerableSet.sol

// OpenZeppelin Contracts (last updated v4.8.0) (utils/structs/EnumerableSet.sol)
// This file was procedurally generated from scripts/generate/templates/EnumerableSet.js.

/**
 * @dev Library for managing
 * https://en.wikipedia.org/wiki/Set_(abstract_data_type)[sets] of primitive
 * types.
 *
 * Sets have the following properties:
 *
 * - Elements are added, removed, and checked for existence in constant time
 * (O(1)).
 * - Elements are enumerated in O(n). No guarantees are made on the ordering.
 *
 * ```
 * contract Example {
 *     // Add the library methods
 *     using EnumerableSet for EnumerableSet.AddressSet;
 *
 *     // Declare a set state variable
 *     EnumerableSet.AddressSet private mySet;
 * }
 * ```
 *
 * As of v3.3.0, sets of type `bytes32` (`Bytes32Set`), `address` (`AddressSet`)
 * and `uint256` (`UintSet`) are supported.
 *
 * [WARNING]
 * ====
 * Trying to delete such a structure from storage will likely result in data corruption, rendering the structure
 * unusable.
 * See https://github.com/ethereum/solidity/pull/11843[ethereum/solidity#11843] for more info.
 *
 * In order to clean an EnumerableSet, you can either remove all elements one by one or create a fresh instance using an
 * array of EnumerableSet.
 * ====
 */
library EnumerableSet {
    // To implement this library for multiple types with as little code
    // repetition as possible, we write it in terms of a generic Set type with
    // bytes32 values.
    // The Set implementation uses private functions, and user-facing
    // implementations (such as AddressSet) are just wrappers around the
    // underlying Set.
    // This means that we can only create new EnumerableSets for types that fit
    // in bytes32.

    struct Set {
        // Storage of set values
        bytes32[] _values;
        // Position of the value in the `values` array, plus 1 because index 0
        // means a value is not in the set.
        mapping(bytes32 => uint256) _indexes;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function _add(Set storage set, bytes32 value) private returns (bool) {
        if (!_contains(set, value)) {
            set._values.push(value);
            // The value is stored at length-1, but we add 1 to all indexes
            // and use 0 as a sentinel value
            set._indexes[value] = set._values.length;
            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function _remove(Set storage set, bytes32 value) private returns (bool) {
        // We read and store the value's index to prevent multiple reads from the same storage slot
        uint256 valueIndex = set._indexes[value];

        if (valueIndex != 0) {
            // Equivalent to contains(set, value)
            // To delete an element from the _values array in O(1), we swap the element to delete with the last one in
            // the array, and then remove the last element (sometimes called as 'swap and pop').
            // This modifies the order of the array, as noted in {at}.

            uint256 toDeleteIndex = valueIndex - 1;
            uint256 lastIndex = set._values.length - 1;

            if (lastIndex != toDeleteIndex) {
                bytes32 lastValue = set._values[lastIndex];

                // Move the last value to the index where the value to delete is
                set._values[toDeleteIndex] = lastValue;
                // Update the index for the moved value
                set._indexes[lastValue] = valueIndex; // Replace lastValue's index to valueIndex
            }

            // Delete the slot where the moved value was stored
            set._values.pop();

            // Delete the index for the deleted slot
            delete set._indexes[value];

            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function _contains(Set storage set, bytes32 value) private view returns (bool) {
        return set._indexes[value] != 0;
    }

    /**
     * @dev Returns the number of values on the set. O(1).
     */
    function _length(Set storage set) private view returns (uint256) {
        return set._values.length;
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function _at(Set storage set, uint256 index) private view returns (bytes32) {
        return set._values[index];
    }

    /**
     * @dev Return the entire set in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function _values(Set storage set) private view returns (bytes32[] memory) {
        return set._values;
    }

    // Bytes32Set

    struct Bytes32Set {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(Bytes32Set storage set, bytes32 value) internal returns (bool) {
        return _add(set._inner, value);
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(Bytes32Set storage set, bytes32 value) internal returns (bool) {
        return _remove(set._inner, value);
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(Bytes32Set storage set, bytes32 value) internal view returns (bool) {
        return _contains(set._inner, value);
    }

    /**
     * @dev Returns the number of values in the set. O(1).
     */
    function length(Bytes32Set storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(Bytes32Set storage set, uint256 index) internal view returns (bytes32) {
        return _at(set._inner, index);
    }

    /**
     * @dev Return the entire set in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function values(Bytes32Set storage set) internal view returns (bytes32[] memory) {
        bytes32[] memory store = _values(set._inner);
        bytes32[] memory result;

        /// @solidity memory-safe-assembly
        assembly {
            result := store
        }

        return result;
    }

    // AddressSet

    struct AddressSet {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(AddressSet storage set, address value) internal returns (bool) {
        return _add(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(AddressSet storage set, address value) internal returns (bool) {
        return _remove(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(AddressSet storage set, address value) internal view returns (bool) {
        return _contains(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Returns the number of values in the set. O(1).
     */
    function length(AddressSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(AddressSet storage set, uint256 index) internal view returns (address) {
        return address(uint160(uint256(_at(set._inner, index))));
    }

    /**
     * @dev Return the entire set in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function values(AddressSet storage set) internal view returns (address[] memory) {
        bytes32[] memory store = _values(set._inner);
        address[] memory result;

        /// @solidity memory-safe-assembly
        assembly {
            result := store
        }

        return result;
    }

    // UintSet

    struct UintSet {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(UintSet storage set, uint256 value) internal returns (bool) {
        return _add(set._inner, bytes32(value));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(UintSet storage set, uint256 value) internal returns (bool) {
        return _remove(set._inner, bytes32(value));
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(UintSet storage set, uint256 value) internal view returns (bool) {
        return _contains(set._inner, bytes32(value));
    }

    /**
     * @dev Returns the number of values in the set. O(1).
     */
    function length(UintSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(UintSet storage set, uint256 index) internal view returns (uint256) {
        return uint256(_at(set._inner, index));
    }

    /**
     * @dev Return the entire set in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function values(UintSet storage set) internal view returns (uint256[] memory) {
        bytes32[] memory store = _values(set._inner);
        uint256[] memory result;

        /// @solidity memory-safe-assembly
        assembly {
            result := store
        }

        return result;
    }
}

// @uniswap/lib/contracts/libraries/TransferHelper.sol

// helper methods for interacting with ERC20 tokens and sending ETH that do not consistently return true/false
library TransferHelper {
    function safeApprove(
        address token,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            'TransferHelper::safeApprove: approve failed'
        );
    }

    function safeTransfer(
        address token,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            'TransferHelper::safeTransfer: transfer failed'
        );
    }

    function safeTransferFrom(
        address token,
        address from,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            'TransferHelper::transferFrom: transferFrom failed'
        );
    }

    function safeTransferETH(address to, uint256 value) internal {
        (bool success, ) = to.call{value: value}(new bytes(0));
        require(success, 'TransferHelper::safeTransferETH: ETH transfer failed');
    }
}

// @openzeppelin/contracts/access/Ownable.sol

// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// contracts/FjordLbpAbstractV1.sol

enum LBPType {
    NORMAL,
    NFT,
    REDEMPTION,
    SWEEPER
}

enum SwapKind {
    GIVEN_IN,
    GIVEN_OUT
}

interface IAsset {
    // solhint-disable-previous-line no-empty-blocks
}

struct SingleSwap {
    bytes32 poolId;
    SwapKind kind;
    IAsset assetIn;
    IAsset assetOut;
    uint256 amount;
    bytes userData;
}

struct FundManagement {
    address sender;
    bool fromInternalBalance;
    address payable recipient;
    bool toInternalBalance;
}

interface LBPFactory {
    function create(
        string memory name,
        string memory symbol,
        address[] memory tokens,
        uint256[] memory weights,
        uint256 swapFeePercentage,
        address owner,
        bool swapEnabledOnStart
    ) external returns (address);
}

interface Vault {
    struct JoinPoolRequest {
        address[] assets;
        uint256[] maxAmountsIn;
        bytes userData;
        bool fromInternalBalance;
    }

    struct ExitPoolRequest {
        address[] assets;
        uint256[] minAmountsOut;
        bytes userData;
        bool toInternalBalance;
    }

    function joinPool(bytes32 poolId, address sender, address recipient, JoinPoolRequest memory request) external;

    function exitPool(bytes32 poolId, address sender, address recipient, ExitPoolRequest memory request) external;

    function getPoolTokens(
        bytes32 poolId
    ) external view returns (address[] memory tokens, uint256[] memory balances, uint256 lastChangeBlock);

    function swap(
        SingleSwap memory singleSwap,
        FundManagement memory funds,
        uint256 limit,
        uint256 deadline
    ) external payable returns (uint256 amountCalculated);
}

interface LBP {
    function updateWeightsGradually(uint256 startTime, uint256 endTime, uint256[] memory endWeights) external;

    function setSwapEnabled(bool swapEnabled) external;

    function getPoolId() external returns (bytes32 poolID);
}

interface WeightedPool {
    function getPoolId() external returns (bytes32 poolID);
}

interface Blocklist {
    function isNotBlocked(address _address) external view returns (bool);
}

enum ExitKind {
    EXACT_BPT_IN_FOR_ONE_TOKEN_OUT,
    EXACT_BPT_IN_FOR_TOKENS_OUT,
    BPT_IN_FOR_EXACT_TOKENS_OUT
}

abstract contract FjordLbpAbstractV1 is Ownable {
    using EnumerableSet for EnumerableSet.AddressSet;
    address public blockListAddress;
    EnumerableSet.AddressSet internal _pools;
    EnumerableSet.AddressSet internal _recipientAddresses;
    mapping(address => uint256) internal _feeRecipientsBPS;
    uint256 internal constant _TEN_THOUSAND_BPS = 10_000;
    LBPType public lbpType;

    //===== Events =====//
    event Skimmed(address token, address to, uint256 balance);
    event RecipientsUpdated(address[] recipients, uint256[] recipientShareBPS);
    event TransferredFee(address indexed pool, address token, address feeRecipient, uint256 feeAmount);
    event TransferredToken(address indexed pool, address token, address to, uint256 amount);
    event JoinedPool(address indexed pool, address[] tokens, uint256[] amounts, bytes userData);
    event GradualWeightUpdateScheduled(address indexed pool, uint256 startTime, uint256 endTime, uint256[] endWeights);
    event SwapEnabledSet(address indexed pool, bool swapEnabled);
    event TransferredPoolOwnership(address indexed pool, address previousOwner, address newOwner);
    event PoolCreated(
        address indexed pool,
        bytes32 poolId,
        string name,
        string symbol,
        address[] tokens,
        uint256[] weights,
        uint256 swapFeePercentage,
        address owner,
        bool swapEnabledOnStart,
        LBPType lbpType
    );

    //===== Functions =====//
    /**
     * @dev Checks if the pool address was created in this smart contract
     */
    function isPool(address pool) external view returns (bool valid) {
        return _pools.contains(pool);
    }

    /**
     * @dev Returns the total amount of pools created in the contract
     */
    function poolCount() external view returns (uint256 count) {
        return _pools.length();
    }

    /**
     * @dev Returns a pool for a specific index
     */
    function getPoolAt(uint256 index) external view returns (address pool) {
        return _pools.at(index);
    }

    /**
     * @dev Returns all the pool values
     */
    function getPools() external view returns (address[] memory pools) {
        return _pools.values();
    }

    /**
     * @dev Returns the total amount of LBP Tokens for a pool. These tokens are burned when exit
     */
    function getBPTTokenBalance(address pool) external view returns (uint256 bptBalance) {
        return IERC20(pool).balanceOf(address(this));
    }

    /**
     * @dev Returns all the fee recipients
     */
    function getFeeRecipients() external view returns (address[] memory recipients) {
        return _recipientAddresses.values();
    }

    /**
     * @dev Returns the fee share percentage in BPS for a fee recipient
     */
    function getRecipientShareBPS(address recipientAddress) external view returns (uint256 shareSize) {
        if (_recipientAddresses.contains(recipientAddress)) {
            return _feeRecipientsBPS[recipientAddress];
        }
        return uint256(0);
    }

    /**
     * @dev calculate the amount of BPToken to burn.
     * - if maxBPTTokenOut is 0, everything will be burned
     * - else it will burn only the amount passed
     */
    function _calcBPTokenToBurn(address pool, uint256 maxBPTTokenOut) internal view returns (uint256) {
        uint256 bptBalance = IERC20(pool).balanceOf(address(this));
        require(maxBPTTokenOut <= bptBalance, "Specifed BPT out amount out exceeds owner balance");
        require(bptBalance > 0, "Pool owner BPT balance is less than zero");
        return maxBPTTokenOut == 0 ? bptBalance : maxBPTTokenOut;
    }

    /**
     * @dev Transfer token to pool owner
     */
    function _transferTokenToPoolOwner(address pool, address token, uint256 amount) internal {
        TransferHelper.safeTransfer(token, msg.sender, amount);
        emit TransferredToken(pool, token, msg.sender, amount);
    }

    /**
     * @dev Send fee to owner of contract.
     *      Only used for exits where there was a transfer error between fee recipients
     */
    function _distributeSafeFee(address pool, address fundToken, uint256 totalFeeAmount) internal {
        TransferHelper.safeTransfer(fundToken, owner(), totalFeeAmount);
        emit TransferredFee(pool, fundToken, owner(), totalFeeAmount);
    }

    /**
     * @dev Resets _recipientAddresses mapping and _feeRecipientsBPS.
     * Note this should only be used in updateRecipients.
     *      None of these mapping/array should be empty
     */
    function _resetRecipients() private {
        uint256 recipientsLength = _recipientAddresses.length();
        address[] memory recipientValues = _recipientAddresses.values();
        for (uint256 i = 0; i < recipientsLength; i++) {
            address recipientAddress = recipientValues[i];
            delete _feeRecipientsBPS[recipientAddress];
            _recipientAddresses.remove(recipientAddress);
        }
    }

    /**
     * @dev Updates recipients and share.
     * NOTE: the first recipient will be the one used for emergency safeDistributeFee
     */
    function updateRecipients(address[] calldata recipients, uint256[] calldata recipientShareBPS) external onlyOwner {
        require(recipients.length > 0, "recipients must have values");
        require(recipientShareBPS.length > 0, "recipientShareBPS must have values");
        require(
            recipients.length == recipientShareBPS.length,
            "'recipients' and 'recipientShareBPS' arrays must have the same length"
        );
        _resetRecipients();
        require(blockListAddress != address(0), "no blocklist address set");
        uint256 sumBPS = 0;
        uint256 arraysLength = recipientShareBPS.length;
        for (uint256 i = 0; i < arraysLength; i++) {
            require(recipientShareBPS[i] > uint256(0), "Share BPS size must be greater than 0");
            bool recipientIsNotBlocked = Blocklist(blockListAddress).isNotBlocked(recipients[i]);
            require(recipientIsNotBlocked, "recipient is blocked");
            sumBPS += recipientShareBPS[i];
            _recipientAddresses.add(recipients[i]);
            _feeRecipientsBPS[recipients[i]] = recipientShareBPS[i];
        }
        require(sumBPS == _TEN_THOUSAND_BPS, "Invalid recipients BPS sum");
        require(_recipientAddresses.length() == recipientShareBPS.length, "Fee recipient address must be unique");
        // emit event
        emit RecipientsUpdated(recipients, recipientShareBPS);
    }

    /**
     * @dev Distribute fee between recipients
     */
    function _distributePlatformAccessFee(address pool, address fundToken, uint256 totalFeeAmount) internal {
        uint256 recipientsLength = _recipientAddresses.length();
        for (uint256 i = 0; i < recipientsLength; i++) {
            address recipientAddress = _recipientAddresses.at(i);
            // calculate amount for each recipient based on the their _feeRecipientsBPS
            uint256 proportionalAmount = (totalFeeAmount * _feeRecipientsBPS[recipientAddress]) / _TEN_THOUSAND_BPS;
            TransferHelper.safeTransfer(fundToken, recipientAddress, proportionalAmount);
            emit TransferredFee(pool, fundToken, recipientAddress, proportionalAmount);
        }
    }

    /**
     * @dev Transfer any token that is not LBPT to the given address.
     * This is used in case tokens were sent to this contract accidentally
     */
    function skim(address token, address recipient) external onlyOwner {
        require(!_pools.contains(token), "can't skim BPT tokens");
        uint256 balance = IERC20(token).balanceOf(address(this));
        TransferHelper.safeTransfer(token, recipient, balance);
        emit Skimmed(token, recipient, balance);
    }

    /**
     * @dev Updates the contract address used as the Blocklist contract
     */
    function updateBlocklistAddress(address contractAddress) external onlyOwner {
        blockListAddress = contractAddress;
    }
}

// contracts/FjordLbpProxyV6.sol

struct PoolConfig {
    string name;
    string symbol;
    address[] tokens;
    uint256[] amounts;
    uint256[] weights;
    uint256[] endWeights;
    uint256 swapFeePercentage;
    uint256 startTime;
    uint256 endTime;
}

struct WeightedPoolConfig {
    string name;
    string symbol;
    address[] tokens;
    uint256[] amounts;
    uint256[] weights;
    uint256 swapFeePercentage;
}

struct PoolData {
    address owner;
    uint256 fundTokenInputAmount;
    LBPType lbpType;
    address weightedPoolAddress;
}

interface IRateProvider {
    /**
     * @dev Returns an 18 decimal fixed point number that is the exchange rate of the token to some other underlying
     * token. The meaning of this rate depends on the context.
     */
    function getRate() external view returns (uint256);
}

interface WeightedPoolFactory {
    function create(
        string memory name,
        string memory symbol,
        IERC20[] memory tokens,
        uint256[] memory normalizedWeights,
        IRateProvider[] memory rateProviders,
        uint256 swapFeePercentage,
        address owner
    ) external returns (address);
}

/// @title FjordLbpProxyV6
/// @notice This contract allows for simplified creation and management of Balancer LBPs
/// It currently supports:
/// - LBPs with 2 tokens
/// - Withdrawal of the full liquidity at once
/// - Having multiple fee recipients
/// - Weighted Pools with 2 tokens
contract FjordLbpProxyV6 is FjordLbpAbstractV1 {
    address ZERO_ADDRESS = 0x0000000000000000000000000000000000000000;
    using EnumerableSet for EnumerableSet.AddressSet;
    EnumerableSet.AddressSet internal _weightedPools;
    EnumerableSet.AddressSet internal _fundTokenAddresses;

    mapping(address => PoolData) private _poolData;
    address public immutable VaultAddress;
    address public immutable LBPFactoryAddress;
    address public immutable WeightedPoolFactoryAddress;
    uint256 public immutable platformAccessFeeBPS;

    event WeightedPoolCreated(
        address indexed pool,
        bytes32 poolId,
        string name,
        string symbol,
        address[] tokens,
        uint256[] weights,
        uint256 swapFeePercentage,
        address owner
    );

    event JoinedWeightedPool(address indexed pool, address[] tokens, uint256[] amounts, bytes userData);

    constructor(
        uint256 _platformAccessFeeBPS,
        address _LBPFactoryAddress,
        address _WeightedPoolFactoryAddress,
        address _vaultAddress,
        address[] memory fundTokenAddresses
    ) {
        require(_platformAccessFeeBPS <= 10_000, "LBP Fee cannot be greater than 10.000 (100%)");
        require(fundTokenAddresses.length > 0, "At least 1 fund needs to be used");
        lbpType = LBPType.NORMAL;
        platformAccessFeeBPS = _platformAccessFeeBPS;
        LBPFactoryAddress = _LBPFactoryAddress;
        WeightedPoolFactoryAddress = _WeightedPoolFactoryAddress;
        VaultAddress = _vaultAddress;
        // set initial fee recipient to owner of contract
        _recipientAddresses.add(owner());
        _feeRecipientsBPS[owner()] = _TEN_THOUSAND_BPS;
        addFundTokenOptions(fundTokenAddresses);
    }

    /**
     * Pool access control.
     * @dev Modifier to ensure only pool owners can perform actions
     */
    modifier onlyLBPPoolOwner(address pool) {
        require(msg.sender == _poolData[pool].owner, "!owner");
        _;
    }

    /**
     * Returns the list of allowed collateral tokens
     */
    function allowedFundTokens() external view returns (address[] memory fundTokens) {
        return _fundTokenAddresses.values();
    }

    /**
     * Returns whether a collateral token is allowed or not
     */
    function isAllowedFund(address tokenAddress) external view returns (bool) {
        return _fundTokenAddresses.contains(tokenAddress);
    }

    /**
     * @dev Checks if the weighted pool address was created in this smart contract
     */
    function isWeightedPool(address pool) external view returns (bool valid) {
        return _weightedPools.contains(pool);
    }

    /**
     * @dev Returns all the weighted pool values
     */
    function getWeightedPools() external view returns (address[] memory pools) {
        return _weightedPools.values();
    }

    /**
     * @dev Returns the total amount of weighted pools created in the contract
     */
    function weightedPoolCount() external view returns (uint256 count) {
        return _weightedPools.length();
    }

    /**
     * @dev Returns the pool's data saved during creation
     */
    function getPoolData(address pool) external view returns (PoolData memory poolData) {
        return _poolData[pool];
    }

    /**
     * @dev Creates a pool and return the contract address of the new pool
     * - poolConfig.tokens: tokens must be sorted ASC
     * - poolConfig.amounts: the index of each amount should be the same as the index of the token in Tokens
     * - poolConfig.weights: the index of each weight should be the same as the index of the token in Tokens
     */
    function createLBP(PoolConfig memory poolConfig) external returns (address) {
        // 1: deposit tokens and approve vault
        require(poolConfig.tokens.length == 2, "Copper LBPs must have exactly two tokens");
        require(poolConfig.tokens[0] != poolConfig.tokens[1], "LBP tokens must be unique");
        require(poolConfig.startTime > block.timestamp, "LBP start time must be in the future");
        require(poolConfig.endTime > poolConfig.startTime, "LBP end time must be greater than start time");
        require(blockListAddress != address(0), "no blocklist address set");
        bool msgSenderIsNotBlocked = Blocklist(blockListAddress).isNotBlocked(msg.sender);
        require(msgSenderIsNotBlocked, "msg.sender is blocked");
        int256 indexOfFundToken = _findIndexOfFund(poolConfig.tokens);
        TransferHelper.safeTransferFrom(poolConfig.tokens[0], msg.sender, address(this), poolConfig.amounts[0]);
        TransferHelper.safeTransferFrom(poolConfig.tokens[1], msg.sender, address(this), poolConfig.amounts[1]);
        TransferHelper.safeApprove(poolConfig.tokens[0], VaultAddress, poolConfig.amounts[0]);
        TransferHelper.safeApprove(poolConfig.tokens[1], VaultAddress, poolConfig.amounts[1]);

        // 2: pool creation
        address pool = LBPFactory(LBPFactoryAddress).create(
            poolConfig.name,
            poolConfig.symbol,
            poolConfig.tokens,
            poolConfig.weights,
            poolConfig.swapFeePercentage,
            address(this), // owner set to this proxy
            false // swaps disabled on start
        );

        bytes32 poolId = LBP(pool).getPoolId();
        emit PoolCreated(
            pool,
            poolId,
            poolConfig.name,
            poolConfig.symbol,
            poolConfig.tokens,
            poolConfig.weights,
            poolConfig.swapFeePercentage,
            address(this),
            false,
            lbpType
        );

        // 3: store pool data
        _poolData[pool] = PoolData(msg.sender, poolConfig.amounts[uint256(indexOfFundToken)], lbpType, address(0));
        require(_pools.add(pool), "exists already");

        bytes memory userData = abi.encode(0, poolConfig.amounts); // JOIN_KIND_INIT = 0
        // 4: deposit tokens into pool
        Vault(VaultAddress).joinPool(
            poolId,
            address(this), // sender
            address(this), // recipient
            Vault.JoinPoolRequest(poolConfig.tokens, poolConfig.amounts, userData, false)
        );
        emit JoinedPool(pool, poolConfig.tokens, poolConfig.amounts, userData);

        // 5: configure weights
        LBP(pool).updateWeightsGradually(poolConfig.startTime, poolConfig.endTime, poolConfig.endWeights);
        emit GradualWeightUpdateScheduled(pool, poolConfig.startTime, poolConfig.endTime, poolConfig.endWeights);

        return pool;
    }

    /**
     * @dev Enable or disables swaps.
     * Note: LBPs are created with trading disabled by default.
     */
    function setSwapEnabled(address pool, bool swapEnabled) external onlyLBPPoolOwner(pool) {
        LBP(pool).setSwapEnabled(swapEnabled);
        emit SwapEnabledSet(pool, swapEnabled);
    }

    /**
     * @dev Transfer ownership of the pool to a new owner
     */
    function transferPoolOwnership(address pool, address newOwner) external onlyLBPPoolOwner(pool) {
        require(blockListAddress != address(0), "no blocklist address set");
        bool newOwnerIsNotBlocked = Blocklist(blockListAddress).isNotBlocked(msg.sender);
        require(newOwnerIsNotBlocked, "newOwner is blocked");

        address previousOwner = _poolData[pool].owner;
        _poolData[pool].owner = newOwner;
        emit TransferredPoolOwnership(pool, previousOwner, newOwner);
    }

    /**
     * @dev Exit a pool, burn the BPT token and transfer back the tokens.
     * - If maxBPTTokenOut is passed as 0, the function will use the total balance available for the BPT token.
     * - If maxBPTTokenOut is between 0 and the total of BPT available, that will be the amount used to burn.
     * maxBPTTokenOut must be greater than or equal to 0
     * - isStandardFee value should be true unless there is an issue with safeTransfer, in which case it can be passed
     * as false, and the fee will stay in the contract and later on distributed manualy to mitigate errors
     */
    function exitPool(address pool, uint256 maxBPTTokenOut, bool isStandardFee) external onlyLBPPoolOwner(pool) {
        uint256[] memory minAmountsOut = new uint256[](2);
        minAmountsOut[0] = uint256(0);
        minAmountsOut[1] = uint256(0);

        // 1. Get pool data
        bytes32 poolId = LBP(pool).getPoolId();
        (address[] memory poolTokens, uint256[] memory balances, ) = Vault(VaultAddress).getPoolTokens(poolId);
        require(poolTokens.length == minAmountsOut.length, "invalid input length");
        PoolData memory poolData = _poolData[pool];

        // 2. Specify the exact BPT amount to burn
        uint256 bptToBurn = _calcBPTokenToBurn(pool, maxBPTTokenOut);

        // 3. Exit pool and keep tokens in contract
        Vault(VaultAddress).exitPool(
            poolId,
            address(this),
            payable(address(this)),
            Vault.ExitPoolRequest(
                poolTokens,
                minAmountsOut,
                abi.encode(ExitKind.EXACT_BPT_IN_FOR_TOKENS_OUT, bptToBurn),
                false
            )
        );

        // 4. Get the amount of Fund token from the pool that was left behind after exit (dust)
        (, uint256[] memory balancesAfterExit, ) = Vault(VaultAddress).getPoolTokens(poolId);
        int256 indexOfFundToken = _findIndexOfFund(poolTokens);

        // 5. Distribute tokens and fees
        _distributeTokens(
            pool,
            poolTokens,
            poolData,
            balances[uint256(indexOfFundToken)] - balancesAfterExit[uint256(indexOfFundToken)],
            isStandardFee,
            indexOfFundToken
        );
    }

    /**
     * @dev Distributes the tokens to the owner and the fee to the fee recipients
     */
    function _distributeTokens(
        address pool,
        address[] memory poolTokens,
        PoolData memory poolData,
        uint256 fundTokenFromPool,
        bool isStandardFee,
        int256 indexOfFundToken
    ) private {
        require(indexOfFundToken >= 0, "No valid collateral token found");

        address mainToken = poolTokens[indexOfFundToken == 0 ? 1 : 0];
        address fundToken = poolTokens[uint256(indexOfFundToken)];
        uint256 mainTokenBalance = IERC20(mainToken).balanceOf(address(this));
        uint256 remainingFundBalance = fundTokenFromPool;

        // if the amount of fund token increased during the LBP
        if (fundTokenFromPool > poolData.fundTokenInputAmount) {
            uint256 totalPlatformAccessFeeAmount = ((fundTokenFromPool - poolData.fundTokenInputAmount) *
                platformAccessFeeBPS) / _TEN_THOUSAND_BPS;
            // Fund amount after substracting the fee
            remainingFundBalance = fundTokenFromPool - totalPlatformAccessFeeAmount;

            if (isStandardFee == true) {
                _distributePlatformAccessFee(pool, fundToken, totalPlatformAccessFeeAmount);
            } else {
                _distributeSafeFee(pool, fundToken, totalPlatformAccessFeeAmount);
            }
        }

        // Transfer the balance of the main token
        _transferTokenToPoolOwner(pool, mainToken, mainTokenBalance);
        // Transfer the balanace of fund token excluding the platform access fee
        _transferTokenToPoolOwner(pool, fundToken, remainingFundBalance);
    }

    /**
     * @dev Creates a weighted pool for an existing LBP.
     * - The owner of the LBP must be the creator of the weighted pool
     * - Only one can be created for each LBP
     */
    function createWeightedPoolForLBP(
        address lbpPool,
        WeightedPoolConfig memory weightedPoolConfig
    ) external onlyLBPPoolOwner(lbpPool) returns (address) {
        // 1: deposit tokens and approve vault
        require(weightedPoolConfig.tokens.length == 2, "Weighted pool must have exactly two tokens");
        require(weightedPoolConfig.tokens[0] != weightedPoolConfig.tokens[1], "Tokens must be unique");
        require(blockListAddress != address(0), "no blocklist address set");
        require(Blocklist(blockListAddress).isNotBlocked(msg.sender), "msg.sender is blocked");
        require(_poolData[lbpPool].weightedPoolAddress == address(0), "Weighted pool already exists for this LBP");

        TransferHelper.safeTransferFrom(
            weightedPoolConfig.tokens[0],
            msg.sender,
            address(this),
            weightedPoolConfig.amounts[0]
        );
        TransferHelper.safeTransferFrom(
            weightedPoolConfig.tokens[1],
            msg.sender,
            address(this),
            weightedPoolConfig.amounts[1]
        );
        TransferHelper.safeApprove(weightedPoolConfig.tokens[0], VaultAddress, weightedPoolConfig.amounts[0]);
        TransferHelper.safeApprove(weightedPoolConfig.tokens[1], VaultAddress, weightedPoolConfig.amounts[1]);

        IERC20[] memory tokens = new IERC20[](2);
        tokens[0] = IERC20(weightedPoolConfig.tokens[0]);
        tokens[1] = IERC20(weightedPoolConfig.tokens[1]);
        IRateProvider[] memory rateProviders = new IRateProvider[](2);
        rateProviders[0] = IRateProvider(ZERO_ADDRESS);
        rateProviders[1] = IRateProvider(ZERO_ADDRESS);

        // 2: pool creation
        address weightedPool = WeightedPoolFactory(WeightedPoolFactoryAddress).create(
            weightedPoolConfig.name,
            weightedPoolConfig.symbol,
            tokens,
            weightedPoolConfig.weights,
            rateProviders,
            weightedPoolConfig.swapFeePercentage,
            msg.sender
        );

        bytes32 poolId = WeightedPool(weightedPool).getPoolId();
        emit WeightedPoolCreated(
            weightedPool,
            poolId,
            weightedPoolConfig.name,
            weightedPoolConfig.symbol,
            weightedPoolConfig.tokens,
            weightedPoolConfig.weights,
            weightedPoolConfig.swapFeePercentage,
            msg.sender
        );

        // 3: store pool data
        _poolData[lbpPool].weightedPoolAddress = weightedPool;
        require(_weightedPools.add(weightedPool), "exists already");

        bytes memory userData = abi.encode(0, weightedPoolConfig.amounts); // JOIN_KIND_INIT = 0
        // 4: deposit tokens into pool and send Weighted Pool Tokens to creator
        Vault(VaultAddress).joinPool(
            poolId,
            address(this), // sender
            msg.sender, // recipient
            Vault.JoinPoolRequest(weightedPoolConfig.tokens, weightedPoolConfig.amounts, userData, false)
        );
        emit JoinedWeightedPool(weightedPool, weightedPoolConfig.tokens, weightedPoolConfig.amounts, userData);
        return weightedPool;
    }

    /**
     * @dev Returns the total amount of weighted Tokens for a pool. These tokens are burned when exit
     */
    function getWeightedTokenBalance(address weightedPool) external view returns (uint256 weightedBalance) {
        return IERC20(weightedPool).balanceOf(msg.sender);
    }

    /**
     * Finds the id of the fund token and returns the index
     * If only one fund token is not found an error is thrown
     */
    function _findIndexOfFund(address[] memory tokens) internal view returns (int256) {
        bool isToken1Fund = _fundTokenAddresses.contains(tokens[0]);
        bool isToken2Fund = _fundTokenAddresses.contains(tokens[1]);

        // 1 of the tokens must be a fund token
        require(isToken1Fund == true || isToken2Fund == true, "At least one token must be a collateral token");
        // 1 of the tokens must not be a fund token
        require(
            isToken1Fund == false || isToken2Fund == false,
            "At least one of the token must not be a collateral token"
        );

        return isToken1Fund == true ? int256(0) : int256(1);
    }

    /**
     * Adds a list of token addresses as options for fund tokens
     */
    function addFundTokenOptions(address[] memory tokens) private {
        for (uint256 i = 0; i < tokens.length; i++) {
            _fundTokenAddresses.add(tokens[i]);
        }
    }
}
