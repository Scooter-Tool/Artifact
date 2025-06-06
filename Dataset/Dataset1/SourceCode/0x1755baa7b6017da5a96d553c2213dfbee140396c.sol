pragma solidity =0.5.16;

// Contract.sol
/**
 *Submitted for verification at Etherscan.io on 2020-11-22
*/

// File: @openzeppelin/contracts/math/Math.sol

/**
 * @dev Standard math utilities missing in the Solidity language.
 */
library Math {
    /**
     * @dev Returns the largest of two numbers.
     */
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a >= b ? a : b;
    }

    /**
     * @dev Returns the smallest of two numbers.
     */
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }

    /**
     * @dev Returns the average of two numbers. The result is rounded towards
     * zero.
     */
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b) / 2 can overflow, so we distribute
        return (a / 2) + (b / 2) + ((a % 2 + b % 2) / 2);
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
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
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
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
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
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

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
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: @openzeppelin/contracts/ownership/Ownable.sol

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner);
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
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see {ERC20Detailed}.
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
    function mint(address account, uint amount) external;

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

// File: @openzeppelin/contracts/utils/Address.sol

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * This test is non-exhaustive, and there may be false-negatives: during the
     * execution of a contract's constructor, its address will be reported as
     * not containing a contract.
     *
     * IMPORTANT: It is unsafe to assume that an address for which this
     * function returns false is an externally-owned account (EOA) and not a
     * contract.
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != 0x0 && codehash != accountHash);
    }

    /**
     * @dev Converts an `address` into `address payable`. Note that this is
     * simply a type cast: the actual underlying value is not changed.
     *
     * _Available since v2.4.0._
     */
    function toPayable(address account) internal pure returns (address payable) {
        return address(uint160(account));
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
     *
     * _Available since v2.4.0._
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-call-value
        (bool success, ) = recipient.call.value(amount)("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
}

// File: @openzeppelin/contracts/token/ERC20/SafeERC20.sol

/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for ERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(value);
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves.

        // A Solidity high level call has three parts:
        //  1. The target address is checked to verify it contains contract code
        //  2. The call itself is made, and success asserted
        //  3. The return value is decoded, which in turn checks the size of the returned data.
        // solhint-disable-next-line max-line-length
        require(address(token).isContract(), "SafeERC20: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = address(token).call(data);
        require(success, "SafeERC20: low-level call failed");

        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

/**
 * Reward Amount Interface
 */

contract IRewardDistributionRecipient is Ownable {
    address rewardDistribution;

    function notifyRewardAmount(uint256 reward) external;

    modifier onlyRewardDistribution() {
        require(_msgSender() == rewardDistribution, "Caller is not reward distribution");
        _;
    }

    function setRewardDistribution(address _rewardDistribution)
        external
        onlyOwner
    {
        rewardDistribution = _rewardDistribution;
    }
}

/**
 * Staking Token Wrapper
 */

contract StakeTokenWrapper {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    IERC20 public stakeToken = IERC20(0x2c91AA5F6586e9E13D4EC50dA16b336beC448BCf); 

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function stake(uint256 amount) public {
        _totalSupply = _totalSupply.add(amount);
        _balances[msg.sender] = _balances[msg.sender].add(amount);
        stakeToken.safeTransferFrom(msg.sender, address(this), amount);
    }

    function withdraw(uint256 amount) public {
        _totalSupply = _totalSupply.sub(amount);
        _balances[msg.sender] = _balances[msg.sender].sub(amount);
        stakeToken.safeTransfer(msg.sender, amount);
    }
}

/**
 * Pool
 */

contract DOMOETHPool is StakeTokenWrapper, IRewardDistributionRecipient {
    IERC20 public defi = IERC20(0x77c329b7C9E2632A77Aca45074d92AB027898c0e);
    
    address payable public projectAddress;
    uint256 public constant DURATION = 7 days;
    uint256 public constant RewardDuration = 1 days;
    uint256 public constant startTime = 1607000400;
    uint256 public periodFinish = 0;
    uint256 public rewardRate = 0;
    uint256 public lastUpdateTime; 
    uint256 public rewardPerTokenStored = 0;
    uint256 public totalBurnReward = 0;
    uint256[] public stakePool = new uint256[](1); 
    uint256[] public burnPool = new uint256[](1);
    bool private open = true;
    uint256 private constant _gunit = 1e18;
    
    struct Deposit {
      uint256 amount;
      uint256 stakeTime;
      uint256 stakeRewardPerTokenStored;
      uint256 round;
   }
   
   struct User {
      Deposit[] deposits;
   }
    
    mapping(address => uint256) public userRewardPerTokenPaid; 
    mapping(address => uint256) public rewards; // Unclaimed rewards
    mapping (address => User) internal users;

    event RewardAdded(uint256 reward);
    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event RewardPaid(address indexed user, uint256 reward);
    event SetOpen(bool _open);

    constructor(address payable projectAddr) public {
        projectAddress = projectAddr;
    }
    
    function _autoExendArray(uint256[] storage arr, uint256 index) internal{
        if(index >= arr.length){
            arr.length = index.add(1);
        }
    }
    
    function getRound(uint256 beginTime) public view returns (uint256) {
        if(block.timestamp <= beginTime) return 0;
        return block.timestamp.sub(beginTime).div(RewardDuration);
    }
    
    function getUser(address adrr,uint256 index) public view returns (uint256,uint256,uint256,uint256) {
        return (users[adrr].deposits[index].amount,users[adrr].deposits[index].stakeTime,users[adrr].deposits[index].stakeRewardPerTokenStored,users[adrr].deposits[index].round);
    }
    
    function getBurnPoolReward(uint256 index) public view returns (uint256) {
        if(index >= burnPool.length) return 0;
        return burnPool[index];
    }

    function getTotalBurnPoolReward() public view returns (uint256) {
        uint256 totalBurnPoolReward = 0;
        for(uint256 i = 0; i < burnPool.length; i++){
            totalBurnPoolReward = totalBurnPoolReward.add(burnPool[i]);
        }
        return totalBurnPoolReward;
    }

    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = lastTimeRewardApplicable();
        if (account != address(0)) {
            rewards[account] = earned(account);
            userRewardPerTokenPaid[account] = rewardPerTokenStored;
        }
        _;
    }

    function lastTimeRewardApplicable() public view returns (uint256) {
        return Math.min(block.timestamp, periodFinish);
    }

    /**
     * Calculate the rewards for each token
     */
    function rewardPerToken() public view returns (uint256) {
        if (totalSupply() == 0) {
            return rewardPerTokenStored;
        }
        return
            rewardPerTokenStored.add(
                lastTimeRewardApplicable()
                    .sub(lastUpdateTime)
                    .mul(rewardRate)
                    .mul(_gunit)
                    .div(totalSupply())
            );
    }

    function earned(address account) public view returns (uint256) {
        return
            balanceOf(account)
                .mul(rewardPerToken().sub(userRewardPerTokenPaid[account]))
                .div(_gunit)
                .add(rewards[account]);
    }

    function stake(uint256 amount) public checkOpen checkStart updateReward(msg.sender){ 
        require(amount > 0, "Cannot stake 0");
        super.stake(amount);
        uint256 round = getRound(startTime);
        _autoExendArray(stakePool,round);
        _autoExendArray(burnPool,round);
        stakePool[round] = stakePool[round].add(amount);
        uint256 updateTime = lastTimeRewardApplicable();
        users[msg.sender].deposits.push(Deposit(amount, updateTime, rewardPerTokenStored,round));
        emit Staked(msg.sender, amount);
    }

    function withdraw(uint256 amount) public checkStart updateReward(msg.sender){
        require(amount > 0, "Cannot withdraw 0");
        getReward();
        super.withdraw(amount);
        uint256 totalAmount = amount;
        for (uint256 i = 0; i < users[msg.sender].deposits.length; i++) {
            uint256 userAmount = users[msg.sender].deposits[i].amount;
            uint256 userRound = users[msg.sender].deposits[i].round;
            if(totalAmount == 0 ) break;
            if(userAmount >= totalAmount){
                users[msg.sender].deposits[i].amount = users[msg.sender].deposits[i].amount.sub(totalAmount);
                stakePool[userRound] = stakePool[userRound].sub(totalAmount);
                totalAmount = 0;
            }else{
                stakePool[userRound] = stakePool[userRound].sub(users[msg.sender].deposits[i].amount);
                users[msg.sender].deposits[i].amount = 0;
                totalAmount = totalAmount.sub(userAmount);
            }
        }
        emit Withdrawn(msg.sender, amount);
    }

    function getReward() public checkStart updateReward(msg.sender){
        uint256 reward = earned(msg.sender);
        if (reward > 0) {
            rewards[msg.sender] = 0;
            uint256 taxAmount = tax(msg.sender);
            uint256 burnReward = _updateBurnReward(msg.sender);
            uint256 round = getRound(startTime);
            _autoExendArray(burnPool,round);
            _autoExendArray(stakePool,round.add(1));
            totalBurnReward = totalBurnReward.add(taxAmount);
            burnPool[round] = burnPool[round].add(taxAmount);
            defi.safeTransfer(projectAddress, reward.div(10));
            defi.safeTransfer(msg.sender, reward.mul(9).div(10).sub(taxAmount).add(burnReward));
            uint256 updateTime = lastTimeRewardApplicable();
            for (uint256 i = 0; i < users[msg.sender].deposits.length; i++) {
                if(users[msg.sender].deposits[i].amount != 0){
                    uint256 userRound = users[msg.sender].deposits[i].round;
                    stakePool[userRound] = stakePool[userRound].sub(users[msg.sender].deposits[i].amount);
                    users[msg.sender].deposits[i].stakeTime = updateTime;
                    users[msg.sender].deposits[i].stakeRewardPerTokenStored = userRewardPerTokenPaid[msg.sender];
                    users[msg.sender].deposits[i].round = round.add(1);
                    stakePool[round.add(1)] = stakePool[round.add(1)].add(users[msg.sender].deposits[i].amount);
                }
            }
            emit RewardPaid(msg.sender, reward);
        }
    }
    
    function getTaxRate(uint256 stakeTime) public view returns(uint256) {
        uint256 taxRate = lastTimeRewardApplicable()
                                .sub(stakeTime)
                                .mul(100)
                                .div(RewardDuration)
                                .div(3);
        return taxRate;
    }

    function tax(address account) public view returns(uint256) {
        uint256 taxAmount = 0;
        uint256 taxRewardPerToken = rewardPerToken();
        for(uint256 i = 0; i < users[account].deposits.length; i++) {
            if(users[account].deposits[i].amount != 0){
                uint256 taxRate = getTaxRate(users[account].deposits[i].stakeTime);
                if(taxRate < 100) {
                    taxRate = uint256(100).sub(taxRate);
                    uint256 userRewardPerToken = taxRewardPerToken.sub(users[account].deposits[i].stakeRewardPerTokenStored);
                    uint256 amount =  users[account].deposits[i].amount;
                    taxAmount = taxAmount.add(
                        amount
                            .mul(userRewardPerToken)
                            .mul(9)
                            .div(10)
                            .mul(18)
                            .div(100)
                            .mul(taxRate)
                        );
                }
            }
        }
        return taxAmount.div(_gunit).div(100);
    }
    
     function getBurnReward(address account) public view returns(uint256) {
        uint256 endIndex =  getRound(startTime);
        if(endIndex < 3 || users[account].deposits.length == 0){
            return 0;
        }
        uint256 burnRewardAmount = 0;
        uint256[] memory tempBurnPool = burnPool;
        
        for (uint256 i = 0; i < users[account].deposits.length; i++) {
            if(users[account].deposits[i].amount != 0){
                if(users[account].deposits[i].round == 0){
                    uint256 reward = 0;
                    for(uint256 j = 0; j < 3; j++){
                        reward = reward.add(tempBurnPool[j]);
                    }
                    burnRewardAmount = burnRewardAmount.add(
                                            reward.mul(users[account].deposits[i].amount)
                                            .div(stakePool[0])
                                        );
                }
                uint256 userRound = users[account].deposits[i].round == 0 ? 1 : users[account].deposits[i].round;
                if(endIndex >= userRound.add(3)){
                    uint256 stakeRealAmount = 0;
                    for(uint256 j = 0; j < userRound; j++){
                        stakeRealAmount = stakeRealAmount.add(stakePool[j]);
                    }
                    for(uint256 j = userRound; j < tempBurnPool.length - 3; j++ ){
                        stakeRealAmount = stakeRealAmount.add(stakePool[j]);
                        uint reward = tempBurnPool[j.add(2)].mul(users[account].deposits[i].amount).div(stakeRealAmount);
                        burnRewardAmount = burnRewardAmount.add(reward); 
                    }
                }
            }
        }
        
        return burnRewardAmount;
    }
    
    function _updateBurnReward(address account) internal returns(uint256) {
        uint256 endIndex =  getRound(startTime);
        if(endIndex < 3 || users[account].deposits.length == 0){
            return 0;
        }
        uint256 burnRewardAmount = 0;
        uint256[] memory tempBurnPool = burnPool;
        
        for (uint256 i = 0; i < users[account].deposits.length; i++) {
            if(users[account].deposits[i].amount != 0){
                if(users[account].deposits[i].round == 0){
                    uint256 reward = 0;
                    for(uint256 j = 0; j < 3; j++){
                        reward = reward.add(tempBurnPool[j]);
                    }
                    burnRewardAmount = burnRewardAmount.add(reward.mul(users[account].deposits[i].amount).div(stakePool[0]));
                    uint256 totalBurnRewardAmount = burnRewardAmount;
                    for (uint256 j = 0; j < 3; j++) {
                        if(totalBurnRewardAmount == 0 ) break;
                        if(burnPool[j] >= totalBurnRewardAmount){
                            burnPool[j] = burnPool[j].sub(totalBurnRewardAmount);
                            totalBurnRewardAmount = 0;
                        }else{
                            totalBurnRewardAmount = totalBurnRewardAmount.sub(burnPool[j]);
                            burnPool[j] = 0;
                        }
                    }
                }
                uint256 userRound = users[account].deposits[i].round == 0 ? 1 : users[account].deposits[i].round;
                if(endIndex >= userRound.add(3)){
                    uint256 stakeRealAmount = 0;
                    for(uint256 j = 0; j < userRound; j++){
                        stakeRealAmount = stakeRealAmount.add(stakePool[j]);
                    }
                    for(uint256 j = userRound; j < tempBurnPool.length - 3; j++ ){
                        stakeRealAmount = stakeRealAmount.add(stakePool[j]);
                        uint reward = tempBurnPool[j.add(2)].mul(users[account].deposits[i].amount).div(stakeRealAmount);
                        burnRewardAmount = burnRewardAmount.add(reward);
                        burnPool[j.add(2)] = burnPool[j.add(2)].add(reward);
                    }
                }
            }
        }
        
        return burnRewardAmount;
    }

    modifier checkStart(){
        require(block.timestamp > startTime,"Not start");
        _;
    }

    modifier checkOpen() {
        require(open, "Pool is closed");
        _;
    }

    function getPeriodFinish() external view returns (uint256) {
        return periodFinish;
    }

    function isOpen() external view returns (bool) {
        return open;
    }

    function setOpen(bool _open) external onlyOwner {
        open = _open;
        emit SetOpen(_open);
    }

    function notifyRewardAmount(uint256 reward)
        external
        onlyRewardDistribution
        checkOpen
        updateReward(address(0)){
        if (block.timestamp > startTime){
            if (block.timestamp >= periodFinish) {
                uint256 period = block.timestamp.sub(startTime).div(DURATION).add(1);
                periodFinish = startTime.add(period.mul(DURATION));
                rewardRate = reward.div(periodFinish.sub(block.timestamp));
            } else {
                uint256 remaining = periodFinish.sub(block.timestamp);
                uint256 leftover = remaining.mul(rewardRate);
                rewardRate = reward.add(leftover).div(remaining);
            }
            lastUpdateTime = block.timestamp;
        }else {
          rewardRate = reward.div(DURATION);
          periodFinish = startTime.add(DURATION);
          lastUpdateTime = startTime;
        }

        defi.mint(address(this),reward);
        emit RewardAdded(reward);

        // avoid overflow to lock assets
        _checkRewardRate();
    }
    
    function _checkRewardRate() internal view returns (uint256) {
        return DURATION.mul(rewardRate).mul(_gunit);
    }
}
