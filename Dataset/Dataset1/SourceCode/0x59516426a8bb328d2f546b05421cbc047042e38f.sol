pragma solidity <0.8.0 >=0.6.0 >=0.6.2 ^0.6.0;

// Contract.sol
// File: @openzeppelin/contracts/GSN/Context.sol

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: @openzeppelin/contracts/introspection/IERC165.sol

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: @openzeppelin/contracts/token/ERC721/IERC721.sol

/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IERC721 is IERC165 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool _approved) external;

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);

    /**
      * @dev Safely transfers `tokenId` token from `from` to `to`.
      *
      * Requirements:
      *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
      * - `tokenId` token must exist and be owned by `from`.
      * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
      * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
      *
      * Emits a {Transfer} event.
      */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;
}

// File: @openzeppelin/contracts/token/ERC721/IERC721Metadata.sol

/**
 * @title ERC-721 Non-Fungible Token Standard, optional metadata extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
interface IERC721Metadata is IERC721 {

    /**
     * @dev Returns the token collection name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the token collection symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
     */
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

// File: @openzeppelin/contracts/token/ERC721/IERC721Enumerable.sol

/**
 * @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
interface IERC721Enumerable is IERC721 {

    /**
     * @dev Returns the total amount of tokens stored by the contract.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns a token ID owned by `owner` at a given `index` of its token list.
     * Use along with {balanceOf} to enumerate all of ``owner``'s tokens.
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256 tokenId);

    /**
     * @dev Returns a token ID at a given `index` of all the tokens stored by the contract.
     * Use along with {totalSupply} to enumerate all tokens.
     */
    function tokenByIndex(uint256 index) external view returns (uint256);
}

// File: @openzeppelin/contracts/token/ERC721/IERC721Receiver.sol

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC721.onERC721Received.selector`.
     */
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4);
}

// File: @openzeppelin/contracts/introspection/ERC165.sol

/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts may inherit from this and call {_registerInterface} to declare
 * their support of an interface.
 */
abstract contract ERC165 is IERC165 {
    /*
     * bytes4(keccak256('supportsInterface(bytes4)')) == 0x01ffc9a7
     */
    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;

    /**
     * @dev Mapping of interface ids to whether or not it's supported.
     */
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor () internal {
        // Derived contracts need only register support for their own interfaces,
        // we register support for ERC165 itself here
        _registerInterface(_INTERFACE_ID_ERC165);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     *
     * Time complexity O(1), guaranteed to always use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) public view override returns (bool) {
        return _supportedInterfaces[interfaceId];
    }

    /**
     * @dev Registers the contract as an implementer of the interface defined by
     * `interfaceId`. Support of the actual ERC165 interface is automatic and
     * registering its interface id is not required.
     *
     * See {IERC165-supportsInterface}.
     *
     * Requirements:
     *
     * - `interfaceId` cannot be the ERC165 invalid interface (`0xffffffff`).
     */
    function _registerInterface(bytes4 interfaceId) internal virtual {
        require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}

// File: @openzeppelin/contracts/math/SafeMath.sol

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: @openzeppelin/contracts/utils/Address.sol

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: value }(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

// File: @openzeppelin/contracts/utils/EnumerableSet.sol

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
        mapping (bytes32 => uint256) _indexes;
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

        if (valueIndex != 0) { // Equivalent to contains(set, value)
            // To delete an element from the _values array in O(1), we swap the element to delete with the last one in
            // the array, and then remove the last element (sometimes called as 'swap and pop').
            // This modifies the order of the array, as noted in {at}.

            uint256 toDeleteIndex = valueIndex - 1;
            uint256 lastIndex = set._values.length - 1;

            // When the value to delete is the last one, the swap operation is unnecessary. However, since this occurs
            // so rarely, we still do the swap anyway to avoid the gas cost of adding an 'if' statement.

            bytes32 lastvalue = set._values[lastIndex];

            // Move the last value to the index where the value to delete is
            set._values[toDeleteIndex] = lastvalue;
            // Update the index for the moved value
            set._indexes[lastvalue] = toDeleteIndex + 1; // All indexes are 1-based

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
        require(set._values.length > index, "EnumerableSet: index out of bounds");
        return set._values[index];
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
        return _add(set._inner, bytes32(uint256(value)));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(AddressSet storage set, address value) internal returns (bool) {
        return _remove(set._inner, bytes32(uint256(value)));
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(AddressSet storage set, address value) internal view returns (bool) {
        return _contains(set._inner, bytes32(uint256(value)));
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
        return address(uint256(_at(set._inner, index)));
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
     * @dev Returns the number of values on the set. O(1).
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
}

// File: @openzeppelin/contracts/utils/EnumerableMap.sol

/**
 * @dev Library for managing an enumerable variant of Solidity's
 * https://solidity.readthedocs.io/en/latest/types.html#mapping-types[`mapping`]
 * type.
 *
 * Maps have the following properties:
 *
 * - Entries are added, removed, and checked for existence in constant time
 * (O(1)).
 * - Entries are enumerated in O(n). No guarantees are made on the ordering.
 *
 * ```
 * contract Example {
 *     // Add the library methods
 *     using EnumerableMap for EnumerableMap.UintToAddressMap;
 *
 *     // Declare a set state variable
 *     EnumerableMap.UintToAddressMap private myMap;
 * }
 * ```
 *
 * As of v3.0.0, only maps of type `uint256 -> address` (`UintToAddressMap`) are
 * supported.
 */
library EnumerableMap {
    // To implement this library for multiple types with as little code
    // repetition as possible, we write it in terms of a generic Map type with
    // bytes32 keys and values.
    // The Map implementation uses private functions, and user-facing
    // implementations (such as Uint256ToAddressMap) are just wrappers around
    // the underlying Map.
    // This means that we can only create new EnumerableMaps for types that fit
    // in bytes32.

    struct MapEntry {
        bytes32 _key;
        bytes32 _value;
    }

    struct Map {
        // Storage of map keys and values
        MapEntry[] _entries;

        // Position of the entry defined by a key in the `entries` array, plus 1
        // because index 0 means a key is not in the map.
        mapping (bytes32 => uint256) _indexes;
    }

    /**
     * @dev Adds a key-value pair to a map, or updates the value for an existing
     * key. O(1).
     *
     * Returns true if the key was added to the map, that is if it was not
     * already present.
     */
    function _set(Map storage map, bytes32 key, bytes32 value) private returns (bool) {
        // We read and store the key's index to prevent multiple reads from the same storage slot
        uint256 keyIndex = map._indexes[key];

        if (keyIndex == 0) { // Equivalent to !contains(map, key)
            map._entries.push(MapEntry({ _key: key, _value: value }));
            // The entry is stored at length-1, but we add 1 to all indexes
            // and use 0 as a sentinel value
            map._indexes[key] = map._entries.length;
            return true;
        } else {
            map._entries[keyIndex - 1]._value = value;
            return false;
        }
    }

    /**
     * @dev Removes a key-value pair from a map. O(1).
     *
     * Returns true if the key was removed from the map, that is if it was present.
     */
    function _remove(Map storage map, bytes32 key) private returns (bool) {
        // We read and store the key's index to prevent multiple reads from the same storage slot
        uint256 keyIndex = map._indexes[key];

        if (keyIndex != 0) { // Equivalent to contains(map, key)
            // To delete a key-value pair from the _entries array in O(1), we swap the entry to delete with the last one
            // in the array, and then remove the last entry (sometimes called as 'swap and pop').
            // This modifies the order of the array, as noted in {at}.

            uint256 toDeleteIndex = keyIndex - 1;
            uint256 lastIndex = map._entries.length - 1;

            // When the entry to delete is the last one, the swap operation is unnecessary. However, since this occurs
            // so rarely, we still do the swap anyway to avoid the gas cost of adding an 'if' statement.

            MapEntry storage lastEntry = map._entries[lastIndex];

            // Move the last entry to the index where the entry to delete is
            map._entries[toDeleteIndex] = lastEntry;
            // Update the index for the moved entry
            map._indexes[lastEntry._key] = toDeleteIndex + 1; // All indexes are 1-based

            // Delete the slot where the moved entry was stored
            map._entries.pop();

            // Delete the index for the deleted slot
            delete map._indexes[key];

            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Returns true if the key is in the map. O(1).
     */
    function _contains(Map storage map, bytes32 key) private view returns (bool) {
        return map._indexes[key] != 0;
    }

    /**
     * @dev Returns the number of key-value pairs in the map. O(1).
     */
    function _length(Map storage map) private view returns (uint256) {
        return map._entries.length;
    }

   /**
    * @dev Returns the key-value pair stored at position `index` in the map. O(1).
    *
    * Note that there are no guarantees on the ordering of entries inside the
    * array, and it may change when more entries are added or removed.
    *
    * Requirements:
    *
    * - `index` must be strictly less than {length}.
    */
    function _at(Map storage map, uint256 index) private view returns (bytes32, bytes32) {
        require(map._entries.length > index, "EnumerableMap: index out of bounds");

        MapEntry storage entry = map._entries[index];
        return (entry._key, entry._value);
    }

    /**
     * @dev Returns the value associated with `key`.  O(1).
     *
     * Requirements:
     *
     * - `key` must be in the map.
     */
    function _get(Map storage map, bytes32 key) private view returns (bytes32) {
        return _get(map, key, "EnumerableMap: nonexistent key");
    }

    /**
     * @dev Same as {_get}, with a custom error message when `key` is not in the map.
     */
    function _get(Map storage map, bytes32 key, string memory errorMessage) private view returns (bytes32) {
        uint256 keyIndex = map._indexes[key];
        require(keyIndex != 0, errorMessage); // Equivalent to contains(map, key)
        return map._entries[keyIndex - 1]._value; // All indexes are 1-based
    }

    // UintToAddressMap

    struct UintToAddressMap {
        Map _inner;
    }

    /**
     * @dev Adds a key-value pair to a map, or updates the value for an existing
     * key. O(1).
     *
     * Returns true if the key was added to the map, that is if it was not
     * already present.
     */
    function set(UintToAddressMap storage map, uint256 key, address value) internal returns (bool) {
        return _set(map._inner, bytes32(key), bytes32(uint256(value)));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the key was removed from the map, that is if it was present.
     */
    function remove(UintToAddressMap storage map, uint256 key) internal returns (bool) {
        return _remove(map._inner, bytes32(key));
    }

    /**
     * @dev Returns true if the key is in the map. O(1).
     */
    function contains(UintToAddressMap storage map, uint256 key) internal view returns (bool) {
        return _contains(map._inner, bytes32(key));
    }

    /**
     * @dev Returns the number of elements in the map. O(1).
     */
    function length(UintToAddressMap storage map) internal view returns (uint256) {
        return _length(map._inner);
    }

   /**
    * @dev Returns the element stored at position `index` in the set. O(1).
    * Note that there are no guarantees on the ordering of values inside the
    * array, and it may change when more values are added or removed.
    *
    * Requirements:
    *
    * - `index` must be strictly less than {length}.
    */
    function at(UintToAddressMap storage map, uint256 index) internal view returns (uint256, address) {
        (bytes32 key, bytes32 value) = _at(map._inner, index);
        return (uint256(key), address(uint256(value)));
    }

    /**
     * @dev Returns the value associated with `key`.  O(1).
     *
     * Requirements:
     *
     * - `key` must be in the map.
     */
    function get(UintToAddressMap storage map, uint256 key) internal view returns (address) {
        return address(uint256(_get(map._inner, bytes32(key))));
    }

    /**
     * @dev Same as {get}, with a custom error message when `key` is not in the map.
     */
    function get(UintToAddressMap storage map, uint256 key, string memory errorMessage) internal view returns (address) {
        return address(uint256(_get(map._inner, bytes32(key), errorMessage)));
    }
}

// File: @openzeppelin/contracts/utils/Strings.sol

/**
 * @dev String operations.
 */
library Strings {
    /**
     * @dev Converts a `uint256` to its ASCII `string` representation.
     */
    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        uint256 index = digits - 1;
        temp = value;
        while (temp != 0) {
            buffer[index--] = byte(uint8(48 + temp % 10));
            temp /= 10;
        }
        return string(buffer);
    }
}

// File: contracts/ERC721.sol

/**
 * @title ERC721 Non-Fungible Token Standard basic implementation
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721 is Context, ERC165, IERC721, IERC721Metadata, IERC721Enumerable {
    using SafeMath for uint256;
    using Address for address;
    using EnumerableSet for EnumerableSet.UintSet;
    using EnumerableMap for EnumerableMap.UintToAddressMap;
    using Strings for uint256;

    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    // Mapping from holder address to their (enumerable) set of owned tokens
    mapping (address => EnumerableSet.UintSet) private _holderTokens;

    // Enumerable mapping from token ids to their owners
    EnumerableMap.UintToAddressMap private _tokenOwners;

    // Mapping from token ID to approved address
    mapping (uint256 => address) private _tokenApprovals;

    // Mapping from owner to operator approvals
    mapping (address => mapping (address => bool)) private _operatorApprovals;

    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Optional mapping for token URIs
    mapping (uint256 => string) private _tokenURIs;

    // Base URI
    string private _baseURI;

    /*
     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c5
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
     *
     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
     *        0xa22cb465 ^ 0xe985e9c5 ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
     */
    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;

    /*
     *     bytes4(keccak256('name()')) == 0x06fdde03
     *     bytes4(keccak256('symbol()')) == 0x95d89b41
     *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd
     *
     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f
     */
    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;

    /*
     *     bytes4(keccak256('totalSupply()')) == 0x18160ddd
     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59
     *     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7
     *
     *     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63
     */
    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;

    /**
     * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
     */
    constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;

        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721);
        _registerInterface(_INTERFACE_ID_ERC721_METADATA);
        _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);
    }

    /**
     * @dev See {IERC721-balanceOf}.
     */
    function balanceOf(address owner) public view override returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");

        return _holderTokens[owner].length();
    }

    /**
     * @dev See {IERC721-ownerOf}.
     */
    function ownerOf(uint256 tokenId) public view override returns (address) {
        return _tokenOwners.get(tokenId, "ERC721: owner query for nonexistent token");
    }

    /**
     * @dev See {IERC721Metadata-name}.
     */
    function name() public view override returns (string memory) {
        return _name;
    }

    /**
     * @dev See {IERC721Metadata-symbol}.
     */
    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];

        // If there is no base URI, return the token URI.
        if (bytes(_baseURI).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(_baseURI, _tokenURI));
        }
        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.
        return string(abi.encodePacked(_baseURI, tokenId.toString()));
    }

    /**
    * @dev Returns the base URI set via {_setBaseURI}. This will be
    * automatically added as a prefix in {tokenURI} to each token's URI, or
    * to the token ID if no specific URI is set for that token ID.
    */
    function baseURI() public view returns (string memory) {
        return _baseURI;
    }

    /**
     * @dev See {IERC721Enumerable-tokenOfOwnerByIndex}.
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) public view override returns (uint256) {
        return _holderTokens[owner].at(index);
    }

    /**
     * @dev See {IERC721Enumerable-totalSupply}.
     */
    function totalSupply() public view override returns (uint256) {
        // _tokenOwners are indexed by tokenIds, so .length() returns the number of tokenIds
        return _tokenOwners.length();
    }

    /**
     * @dev See {IERC721Enumerable-tokenByIndex}.
     */
    function tokenByIndex(uint256 index) public view override returns (uint256) {
        (uint256 tokenId, ) = _tokenOwners.at(index);
        return tokenId;
    }

    /**
     * @dev See {IERC721-approve}.
     */
    function approve(address to, uint256 tokenId) public virtual override {
        address owner = ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        require(_msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _approve(to, tokenId);
    }

    /**
     * @dev See {IERC721-getApproved}.
     */
    function getApproved(uint256 tokenId) public view override returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

    /**
     * @dev See {IERC721-setApprovalForAll}.
     */
    function setApprovalForAll(address operator, bool approved) public virtual override {
        require(operator != _msgSender(), "ERC721: approve to caller");

        _operatorApprovals[_msgSender()][operator] = approved;
        emit ApprovalForAll(_msgSender(), operator, approved);
    }

    /**
     * @dev See {IERC721-isApprovedForAll}.
     */
    function isApprovedForAll(address owner, address operator) public view virtual override returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev See {IERC721-transferFrom}.
     */
    function transferFrom(address from, address to, uint256 tokenId) public virtual override {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");

        _transfer(from, to, tokenId);
    }

    /**
     * @dev See {IERC721-safeTransferFrom}.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override {
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev See {IERC721-safeTransferFrom}.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public virtual override {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        _safeTransfer(from, to, tokenId, _data);
    }

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * `_data` is additional data, it has no specified format and it is sent in call to `to`.
     *
     * This internal function is equivalent to {safeTransferFrom}, and can be used to e.g.
     * implement alternative mechanisms to perform token transfer, such as signature-based.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function _safeTransfer(address from, address to, uint256 tokenId, bytes memory _data) internal virtual {
        _transfer(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev Returns whether `tokenId` exists.
     *
     * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
     *
     * Tokens start existing when they are minted (`_mint`),
     * and stop existing when they are burned (`_burn`).
     */
    function _exists(uint256 tokenId) internal view returns (bool) {
        return _tokenOwners.contains(tokenId);
    }

    /**
     * @dev Returns whether `spender` is allowed to manage `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    /**
     * @dev Safely mints `tokenId` and transfers it to `to`.
     *
     * Requirements:
     d*
     * - `tokenId` must not exist.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function _safeMint(address to, uint256 tokenId) internal virtual {
        _safeMint(to, tokenId, "");
    }

    /**
     * @dev Same as {xref-ERC721-_safeMint-address-uint256-}[`_safeMint`], with an additional `data` parameter which is
     * forwarded in {IERC721Receiver-onERC721Received} to contract recipients.
     */
    function _safeMint(address to, uint256 tokenId, bytes memory _data) internal virtual {
        _mint(to, tokenId);
        require(_checkOnERC721Received(address(0), to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev Mints `tokenId` and transfers it to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {_safeMint} whenever possible
     *
     * Requirements:
     *
     * - `tokenId` must not exist.
     * - `to` cannot be the zero address.
     *
     * Emits a {Transfer} event.
     */
    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _beforeTokenTransfer(address(0), to, tokenId);

        _holderTokens[to].add(tokenId);

        _tokenOwners.set(tokenId, to);

        emit Transfer(address(0), to, tokenId);
    }

    /**
     * @dev Destroys `tokenId`.
     * The approval is cleared when the token is burned.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     *
     * Emits a {Transfer} event.
     */
    function _burn(uint256 tokenId) internal virtual {
        address owner = ownerOf(tokenId);

        _beforeTokenTransfer(owner, address(0), tokenId);

        // Clear approvals
        _approve(address(0), tokenId);

        // Clear metadata (if any)
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }

        _holderTokens[owner].remove(tokenId);

        _tokenOwners.remove(tokenId);

        emit Transfer(owner, address(0), tokenId);
    }

    /**
     * @dev Transfers `tokenId` from `from` to `to`.
     *  As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     *
     * Emits a {Transfer} event.
     */
    function _transfer(address from, address to, uint256 tokenId) internal virtual {
        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _beforeTokenTransfer(from, to, tokenId);

        // Clear approvals from the previous owner
        _approve(address(0), tokenId);

        _holderTokens[from].remove(tokenId);
        _holderTokens[to].add(tokenId);

        _tokenOwners.set(tokenId, to);

        emit Transfer(from, to, tokenId);
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    /**
     * @dev Internal function to set the base URI for all token IDs. It is
     * automatically added as a prefix to the value returned in {tokenURI},
     * or to the token ID if {tokenURI} is empty.
     */
    function _setBaseURI(string memory baseURI_) internal virtual {
        _baseURI = baseURI_;
    }

    /**
     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data)
    private returns (bool)
    {
        if (!to.isContract()) {
            return true;
        }
        bytes memory returndata = to.functionCall(abi.encodeWithSelector(
                IERC721Receiver(to).onERC721Received.selector,
                _msgSender(),
                from,
                tokenId,
                _data
            ), "ERC721: transfer to non ERC721Receiver implementer");
        bytes4 retval = abi.decode(returndata, (bytes4));
        return (retval == _ERC721_RECEIVED);
    }

    function _approve(address to, uint256 tokenId) private {
        _tokenApprovals[tokenId] = to;
        emit Approval(ownerOf(tokenId), to, tokenId);
    }

    /**
     * @dev Hook that is called before any token transfer. This includes minting
     * and burning.
     *
     * Calling conditions:
     *
     * - When `from` and `to` are both non-zero, ``from``'s `tokenId` will be
     * transferred to `to`.
     * - When `from` is zero, `tokenId` will be minted for `to`.
     * - When `to` is zero, ``from``'s `tokenId` will be burned.
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual { }
}

// File: @openzeppelin/contracts/access/Ownable.sol

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
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: contracts/ERC721Tradable.sol

contract OwnableDelegateProxy { }

contract ProxyRegistry {
    mapping(address => OwnableDelegateProxy) public proxies;
}

/**
 * @title ERC721Tradable
 * ERC721Tradable - ERC721 contract that whitelists a trading address, and has minting functionality.
 */
contract ERC721Tradable is ERC721, Ownable {
  using Strings for string;

  address proxyRegistryAddress;
  uint256 private _currentTokenId = 0;

  constructor(string memory _name, string memory _symbol, address _proxyRegistryAddress) ERC721(_name, _symbol) public {
    proxyRegistryAddress = _proxyRegistryAddress;
  }

  /**
    * @dev calculates the next token ID based on value of _currentTokenId
    * @return uint256 for the next token ID
    */
  function _getNextTokenId() internal view returns (uint256) {
    return _currentTokenId.add(1);
  }

  /**
    * @dev increments the value of _currentTokenId
    */
  function _incrementTokenId() internal  {
    _currentTokenId++;
  }

  /**
   * Override isApprovedForAll to whitelist user's OpenSea proxy accounts to enable gas-less listings.
   */
  function isApprovedForAll(
    address owner,
    address operator
  )
    public
    view
    override
    returns (bool)
  {
    // Whitelist OpenSea proxy contract for easy trading.
    ProxyRegistry proxyRegistry = ProxyRegistry(proxyRegistryAddress);
    if (address(proxyRegistry.proxies(owner)) == operator) {
        return true;
    }

    return super.isApprovedForAll(owner, operator);
  }
}

// File: contracts/DNA.sol

contract DNA {

    struct DNAData {
        uint potGene;
        uint headGene;
        uint bodyGene;
        uint faceGene;
        uint jointGene;
        uint sunglassesGene;
        uint earringGene;
        uint redGene;
        uint greenGene;
        uint blueGene;
    }

    function getGene(uint dna, uint n) public pure returns (uint) {
        return (dna / (10 ** (15 - n))) % 10;
    }

    function getBlueGene(uint dna) public pure returns (uint){
        return dna % 1000;
    }

    function getGreenGene(uint dna) public pure returns (uint) {
        return (dna % 1000000 - (dna % 1000)) / 1000;
    }

    function getRedGene(uint dna) public pure returns (uint) {
        return (dna % 1000000000 - (dna % 1000000)) / 1000000;
    }

    function mixDNA(uint dna1, uint dna2) public pure returns (uint) {
        DNAData memory data = DNAData(
            (getGene(dna1, 0) * getGene(dna2, 0) % 7) + 1, // pot
            (getGene(dna1, 1) * getGene(dna2, 1) % 7) + 1, // head
            (getGene(dna1, 2) * getGene(dna2, 2) % 6) + 1, // body
            (getGene(dna1, 3) * getGene(dna2, 3) % 5) + 1, // face
            getGene(dna1, 4) * getGene(dna2, 4) % 2, // sunglasses
            getGene(dna1, 5) * getGene(dna2, 5) % 2, // joint
            getGene(dna1, 6) * getGene(dna2, 6) % 2, // earring
            (getRedGene(dna1) * getRedGene(dna2)) % 256, // red
            (getGreenGene(dna1) * getGreenGene(dna2)) % 256, // green
            (getBlueGene(dna1) * getBlueGene(dna2)) % 256 // blue
        );

        uint newDNA = ((10 ** 15) * data.potGene) + ((10 ** 14) * data.headGene) + ((10 ** 13) * data.bodyGene)
        + ((10 ** 12) * data.faceGene) + ((10 ** 11) * data.jointGene) + ((10 ** 10) * data.sunglassesGene) + ((10 ** 9) * data.earringGene)
        + ((10 ** 6) * data.redGene) + ((10 ** 3) * data.greenGene) + (data.blueGene % 256);

        return newDNA;
    }

    function clamp(uint value, uint min, uint max) public pure returns (uint) {
        return (value < min) ? min : (value > max) ? max : value;
    }

}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

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
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

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
}

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol

/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin guidelines: functions revert instead
 * of returning `false` on failure. This behavior is nonetheless conventional
 * and does not conflict with the expectations of ERC20 applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    /**
     * @dev Sets the values for {name} and {symbol}, initializes {decimals} with
     * a default value of 18.
     *
     * To select a different value for {decimals}, use {_setupDecimals}.
     *
     * All three of these values are immutable: they can only be set once during
     * construction.
     */
    constructor (string memory name_, string memory symbol_) public {
        _name = name_;
        _symbol = symbol_;
        _decimals = 18;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless {_setupDecimals} is
     * called.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * Requirements:
     *
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Sets {decimals} to a value other than the default one of 18.
     *
     * WARNING: This function should only be called from the constructor. Most
     * applications that interact with token contracts will not expect
     * {decimals} to ever change, and may work incorrectly if it does.
     */
    function _setupDecimals(uint8 decimals_) internal {
        _decimals = decimals_;
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be to transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }
}

// File: hardhat/console.sol

library console {
        address constant CONSOLE_ADDRESS = address(0x000000000000000000636F6e736F6c652e6c6f67);

        function _sendLogPayload(bytes memory payload) private view {
                uint256 payloadLength = payload.length;
                address consoleAddress = CONSOLE_ADDRESS;
                assembly {
                        let payloadStart := add(payload, 32)
                        let r := staticcall(gas(), consoleAddress, payloadStart, payloadLength, 0, 0)
                }
        }

        function log() internal view {
                _sendLogPayload(abi.encodeWithSignature("log()"));
        }

        function logInt(int p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(int)", p0));
        }

        function logUint(uint p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint)", p0));
        }

        function logString(string memory p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
        }

        function logBool(bool p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool)", p0));
        }

        function logAddress(address p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address)", p0));
        }

        function logBytes(bytes memory p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes)", p0));
        }

        function logByte(byte p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(byte)", p0));
        }

        function logBytes1(bytes1 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes1)", p0));
        }

        function logBytes2(bytes2 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes2)", p0));
        }

        function logBytes3(bytes3 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes3)", p0));
        }

        function logBytes4(bytes4 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes4)", p0));
        }

        function logBytes5(bytes5 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes5)", p0));
        }

        function logBytes6(bytes6 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes6)", p0));
        }

        function logBytes7(bytes7 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes7)", p0));
        }

        function logBytes8(bytes8 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes8)", p0));
        }

        function logBytes9(bytes9 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes9)", p0));
        }

        function logBytes10(bytes10 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes10)", p0));
        }

        function logBytes11(bytes11 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes11)", p0));
        }

        function logBytes12(bytes12 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes12)", p0));
        }

        function logBytes13(bytes13 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes13)", p0));
        }

        function logBytes14(bytes14 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes14)", p0));
        }

        function logBytes15(bytes15 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes15)", p0));
        }

        function logBytes16(bytes16 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes16)", p0));
        }

        function logBytes17(bytes17 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes17)", p0));
        }

        function logBytes18(bytes18 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes18)", p0));
        }

        function logBytes19(bytes19 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes19)", p0));
        }

        function logBytes20(bytes20 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes20)", p0));
        }

        function logBytes21(bytes21 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes21)", p0));
        }

        function logBytes22(bytes22 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes22)", p0));
        }

        function logBytes23(bytes23 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes23)", p0));
        }

        function logBytes24(bytes24 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes24)", p0));
        }

        function logBytes25(bytes25 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes25)", p0));
        }

        function logBytes26(bytes26 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes26)", p0));
        }

        function logBytes27(bytes27 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes27)", p0));
        }

        function logBytes28(bytes28 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes28)", p0));
        }

        function logBytes29(bytes29 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes29)", p0));
        }

        function logBytes30(bytes30 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes30)", p0));
        }

        function logBytes31(bytes31 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes31)", p0));
        }

        function logBytes32(bytes32 p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bytes32)", p0));
        }

        function log(uint p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint)", p0));
        }

        function log(string memory p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
        }

        function log(bool p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool)", p0));
        }

        function log(address p0) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address)", p0));
        }

        function log(uint p0, uint p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint)", p0, p1));
        }

        function log(uint p0, string memory p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string)", p0, p1));
        }

        function log(uint p0, bool p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool)", p0, p1));
        }

        function log(uint p0, address p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address)", p0, p1));
        }

        function log(string memory p0, uint p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint)", p0, p1));
        }

        function log(string memory p0, string memory p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string)", p0, p1));
        }

        function log(string memory p0, bool p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool)", p0, p1));
        }

        function log(string memory p0, address p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
        }

        function log(bool p0, uint p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint)", p0, p1));
        }

        function log(bool p0, string memory p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string)", p0, p1));
        }

        function log(bool p0, bool p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool)", p0, p1));
        }

        function log(bool p0, address p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address)", p0, p1));
        }

        function log(address p0, uint p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint)", p0, p1));
        }

        function log(address p0, string memory p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string)", p0, p1));
        }

        function log(address p0, bool p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool)", p0, p1));
        }

        function log(address p0, address p1) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address)", p0, p1));
        }

        function log(uint p0, uint p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,uint)", p0, p1, p2));
        }

        function log(uint p0, uint p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,string)", p0, p1, p2));
        }

        function log(uint p0, uint p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,bool)", p0, p1, p2));
        }

        function log(uint p0, uint p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,address)", p0, p1, p2));
        }

        function log(uint p0, string memory p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,uint)", p0, p1, p2));
        }

        function log(uint p0, string memory p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,string)", p0, p1, p2));
        }

        function log(uint p0, string memory p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,bool)", p0, p1, p2));
        }

        function log(uint p0, string memory p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,address)", p0, p1, p2));
        }

        function log(uint p0, bool p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,uint)", p0, p1, p2));
        }

        function log(uint p0, bool p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,string)", p0, p1, p2));
        }

        function log(uint p0, bool p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,bool)", p0, p1, p2));
        }

        function log(uint p0, bool p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,address)", p0, p1, p2));
        }

        function log(uint p0, address p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,uint)", p0, p1, p2));
        }

        function log(uint p0, address p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,string)", p0, p1, p2));
        }

        function log(uint p0, address p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,bool)", p0, p1, p2));
        }

        function log(uint p0, address p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,address)", p0, p1, p2));
        }

        function log(string memory p0, uint p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,uint)", p0, p1, p2));
        }

        function log(string memory p0, uint p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,string)", p0, p1, p2));
        }

        function log(string memory p0, uint p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,bool)", p0, p1, p2));
        }

        function log(string memory p0, uint p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,address)", p0, p1, p2));
        }

        function log(string memory p0, string memory p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,uint)", p0, p1, p2));
        }

        function log(string memory p0, string memory p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,string)", p0, p1, p2));
        }

        function log(string memory p0, string memory p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,bool)", p0, p1, p2));
        }

        function log(string memory p0, string memory p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,address)", p0, p1, p2));
        }

        function log(string memory p0, bool p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,uint)", p0, p1, p2));
        }

        function log(string memory p0, bool p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,string)", p0, p1, p2));
        }

        function log(string memory p0, bool p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,bool)", p0, p1, p2));
        }

        function log(string memory p0, bool p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,address)", p0, p1, p2));
        }

        function log(string memory p0, address p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,uint)", p0, p1, p2));
        }

        function log(string memory p0, address p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,string)", p0, p1, p2));
        }

        function log(string memory p0, address p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,bool)", p0, p1, p2));
        }

        function log(string memory p0, address p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,address)", p0, p1, p2));
        }

        function log(bool p0, uint p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,uint)", p0, p1, p2));
        }

        function log(bool p0, uint p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,string)", p0, p1, p2));
        }

        function log(bool p0, uint p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,bool)", p0, p1, p2));
        }

        function log(bool p0, uint p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,address)", p0, p1, p2));
        }

        function log(bool p0, string memory p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,uint)", p0, p1, p2));
        }

        function log(bool p0, string memory p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,string)", p0, p1, p2));
        }

        function log(bool p0, string memory p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,bool)", p0, p1, p2));
        }

        function log(bool p0, string memory p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,address)", p0, p1, p2));
        }

        function log(bool p0, bool p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,uint)", p0, p1, p2));
        }

        function log(bool p0, bool p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,string)", p0, p1, p2));
        }

        function log(bool p0, bool p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,bool)", p0, p1, p2));
        }

        function log(bool p0, bool p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,address)", p0, p1, p2));
        }

        function log(bool p0, address p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,uint)", p0, p1, p2));
        }

        function log(bool p0, address p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,string)", p0, p1, p2));
        }

        function log(bool p0, address p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,bool)", p0, p1, p2));
        }

        function log(bool p0, address p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,address)", p0, p1, p2));
        }

        function log(address p0, uint p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,uint)", p0, p1, p2));
        }

        function log(address p0, uint p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,string)", p0, p1, p2));
        }

        function log(address p0, uint p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,bool)", p0, p1, p2));
        }

        function log(address p0, uint p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,address)", p0, p1, p2));
        }

        function log(address p0, string memory p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,uint)", p0, p1, p2));
        }

        function log(address p0, string memory p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,string)", p0, p1, p2));
        }

        function log(address p0, string memory p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,bool)", p0, p1, p2));
        }

        function log(address p0, string memory p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,address)", p0, p1, p2));
        }

        function log(address p0, bool p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,uint)", p0, p1, p2));
        }

        function log(address p0, bool p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,string)", p0, p1, p2));
        }

        function log(address p0, bool p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,bool)", p0, p1, p2));
        }

        function log(address p0, bool p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,address)", p0, p1, p2));
        }

        function log(address p0, address p1, uint p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,uint)", p0, p1, p2));
        }

        function log(address p0, address p1, string memory p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,string)", p0, p1, p2));
        }

        function log(address p0, address p1, bool p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,bool)", p0, p1, p2));
        }

        function log(address p0, address p1, address p2) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,address)", p0, p1, p2));
        }

        function log(uint p0, uint p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,uint,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,uint,string)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,uint,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,uint,address)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,string,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,string,string)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,string,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,string,address)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,bool,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,bool,string)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,bool,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,bool,address)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,address,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,address,string)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,address,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, uint p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,uint,address,address)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,uint,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,uint,string)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,uint,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,uint,address)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,string,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,string,string)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,string,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,string,address)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,bool,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,bool,string)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,bool,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,bool,address)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,address,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,address,string)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,address,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, string memory p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,string,address,address)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,uint,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,uint,string)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,uint,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,uint,address)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,string,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,string,string)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,string,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,string,address)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,bool,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,bool,string)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,bool,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,bool,address)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,address,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,address,string)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,address,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, bool p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,bool,address,address)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,uint,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,uint,string)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,uint,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,uint,address)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,string,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,string,string)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,string,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,string,address)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,bool,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,bool,string)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,bool,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,bool,address)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,address,uint)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,address,string)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,address,bool)", p0, p1, p2, p3));
        }

        function log(uint p0, address p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(uint,address,address,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,uint,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,uint,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,uint,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,uint,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,string,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,string,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,string,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,string,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,bool,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,bool,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,bool,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,bool,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,address,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,address,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,address,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, uint p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,uint,address,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,uint,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,uint,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,uint,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,uint,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,string,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,string,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,string,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,string,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,bool,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,bool,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,bool,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,bool,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,address,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,address,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,address,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, string memory p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,string,address,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,uint,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,uint,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,uint,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,uint,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,string,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,string,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,string,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,string,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,bool,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,bool,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,bool,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,bool,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,address,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,address,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,address,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, bool p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,bool,address,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,uint,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,uint,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,uint,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,uint,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,string,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,string,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,string,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,string,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,bool,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,bool,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,bool,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,bool,address)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,address,uint)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,address,string)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,address,bool)", p0, p1, p2, p3));
        }

        function log(string memory p0, address p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(string,address,address,address)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,uint,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,uint,string)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,uint,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,uint,address)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,string,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,string,string)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,string,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,string,address)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,bool,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,bool,string)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,bool,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,bool,address)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,address,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,address,string)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,address,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, uint p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,uint,address,address)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,uint,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,uint,string)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,uint,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,uint,address)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,string,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,string,string)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,string,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,string,address)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,bool,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,bool,string)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,bool,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,bool,address)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,address,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,address,string)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,address,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, string memory p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,string,address,address)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,uint,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,uint,string)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,uint,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,uint,address)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,string,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,string,string)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,string,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,string,address)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,bool,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,bool,string)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,bool,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,bool,address)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,address,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,address,string)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,address,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, bool p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,bool,address,address)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,uint,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,uint,string)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,uint,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,uint,address)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,string,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,string,string)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,string,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,string,address)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,bool,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,bool,string)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,bool,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,bool,address)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,address,uint)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,address,string)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,address,bool)", p0, p1, p2, p3));
        }

        function log(bool p0, address p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(bool,address,address,address)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,uint,uint)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,uint,string)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,uint,bool)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,uint,address)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,string,uint)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,string,string)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,string,bool)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,string,address)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,bool,uint)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,bool,string)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,bool,bool)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,bool,address)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,address,uint)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,address,string)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,address,bool)", p0, p1, p2, p3));
        }

        function log(address p0, uint p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,uint,address,address)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,uint,uint)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,uint,string)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,uint,bool)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,uint,address)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,string,uint)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,string,string)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,string,bool)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,string,address)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,bool,uint)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,bool,string)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,bool,bool)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,bool,address)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,address,uint)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,address,string)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,address,bool)", p0, p1, p2, p3));
        }

        function log(address p0, string memory p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,string,address,address)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,uint,uint)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,uint,string)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,uint,bool)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,uint,address)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,string,uint)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,string,string)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,string,bool)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,string,address)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,bool,uint)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,bool,string)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,bool,bool)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,bool,address)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,address,uint)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,address,string)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,address,bool)", p0, p1, p2, p3));
        }

        function log(address p0, bool p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,bool,address,address)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, uint p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,uint,uint)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, uint p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,uint,string)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, uint p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,uint,bool)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, uint p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,uint,address)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, string memory p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,string,uint)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, string memory p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,string,string)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, string memory p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,string,bool)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, string memory p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,string,address)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, bool p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,bool,uint)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, bool p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,bool,string)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, bool p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,bool,bool)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, bool p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,bool,address)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, address p2, uint p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,address,uint)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, address p2, string memory p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,address,string)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, address p2, bool p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,address,bool)", p0, p1, p2, p3));
        }

        function log(address p0, address p1, address p2, address p3) internal view {
                _sendLogPayload(abi.encodeWithSignature("log(address,address,address,address)", p0, p1, p2, p3));
        }

}

// File: contracts/Strainz.sol

contract Strainz is ERC721Tradable, DNA {
    event Minted(uint tokenId);

    uint public genesisLeft = 100;

    struct Strain {
        uint id;
        string prefix;
        string postfix;
        uint dna;
        uint generation;
        uint growRate; // 0-255
        uint lastHarvest;
        uint breedingCost;
    }

    mapping(uint => Strain) public strainData;
    Budz public budz;

    constructor(address _proxyRegistryAddress) ERC721Tradable("Strainz", "STRAINZ", _proxyRegistryAddress) public {
        _setBaseURI("https://api.strainz.tech/strain/");
        budz = new Budz();
        budz.mintTo(msg.sender, 25000); // Uniswap Pool Allocation
    }

    /**
    * @dev Mints a token to an address with a tokenURI.
    * @param _to address of the future owner of the token
    */
    function mintTo(address _to, string memory prefix, string memory postfix, uint dna, uint generation, uint growRate) private {
        uint newTokenId = _getNextTokenId();
        _mint(_to, newTokenId);
        _incrementTokenId();
        strainData[newTokenId] = Strain(newTokenId, prefix, postfix, dna, generation, growRate, now, 1000);
        emit Minted(newTokenId);
    }

    function breed(uint _first, uint _second) public {
        require(ownerOf(_first) == msg.sender && ownerOf(_second) == msg.sender);
        Strain storage strain1 = strainData[_first];
        Strain storage strain2 = strainData[_second];

        uint cost = max(strain1.breedingCost, strain2.breedingCost);
        require(budz.balanceOf(msg.sender) >= cost && budz.allowance(msg.sender, address(this)) >= cost);
        budz.burnFrom(msg.sender, cost);

        uint newDNA = mixDNA(strain1.dna, strain2.dna);
        uint generation = max(strain1.generation, strain2.generation) + 1;

        bool mix = block.number % 2 == 0;

        strain1.breedingCost = clamp(strain1.breedingCost * 2, 1000, 1024000);
        strain2.breedingCost = clamp(strain2.breedingCost * 2, 1000, 1024000);

        mintTo(
            msg.sender,
            mix ? strain1.prefix : strain2.prefix,
            mix ? strain2.postfix : strain1.postfix,
            newDNA, generation,
            mixStat(strain1.growRate, strain2.growRate)
        );

    }

    function mixStat(uint rate1, uint rate2) private view returns (uint) {
        return clamp(((rate1 + rate2) / 2) - ((block.number % 50) - 1), 0, 255);
    }

    function genesisMint(string memory prefix, string memory postfix, uint dna) public {
        require(genesisLeft > 0);
        uint stats = clamp(genesisLeft * 3, 128, 255); // First strainz have a grow rate between 128-255
        mintTo(msg.sender, prefix, postfix, dna, 0, stats);
        genesisLeft--;
    }

    function max(uint a, uint b) private pure returns (uint) {
        if (a > b) {
            return a;
        } else return b;
    }

    function harvest(uint tokenId) public {
        require(ownerOf(tokenId) == msg.sender);
        Strain storage strain = strainData[tokenId];

        uint numberOfBudz = harvestableAmount(tokenId);
        require(numberOfBudz > 0);
        budz.mintTo(msg.sender, numberOfBudz);
        strain.lastHarvest = now;
    }

    function harvestAll() public {
        uint numberOfTokens = balanceOf(msg.sender);
        require(numberOfTokens > 0);
        uint sum = 0;
        for (uint i = 0; i < numberOfTokens; i++) {
            Strain storage strain = strainData[tokenOfOwnerByIndex(msg.sender, i)];
            sum += harvestableAmount(strain.id);
            strain.lastHarvest = now;
        }
        budz.mintTo(msg.sender, sum);
    }
    // every 6 weeks (growRate * 255) mintable tokens
    function harvestableAmount(uint tokenId) public view returns (uint) {
        Strain storage strain = strainData[tokenId];
        uint timeSinceLastHarvest = now - strain.lastHarvest;
        return (strain.growRate * 255 * timeSinceLastHarvest) / 6 weeks;
    }

}

// File: contracts/Budz.sol

/**
 * @title Creature
 * Creature - a contract for my non-fungible creatures.
 */
contract Budz is Ownable, ERC20 {
    using SafeMath for uint256;

    Strainz strainz;
    modifier onlyStrainz() {
        require(address(strainz) == msg.sender);
        _;
    }

    constructor() ERC20("Budz", "BUDZ") public {
        _setupDecimals(0);
        strainz = Strainz(msg.sender);
    }

    function mintTo(address receiver, uint amount) public onlyStrainz {
        _mint(receiver, amount);
    }

    function burnFrom(address account, uint amount) public onlyStrainz {
        uint256 decreasedAllowance = allowance(account, msg.sender).sub(amount, "ERC20: burn amount exceeds allowance");

        _approve(account, msg.sender, decreasedAllowance);
        _burn(account, amount);
    }

}
