contract Will {
    address owner;
    uint    fortune;
    bool    deceased;

    constructor() payable   { 
        owner = msg.sender; // msg sender reprents address that is being called
        fortune = msg.value; // msg value tells us how much ether is being send
        deceased = false;
    }

    // create modifier so the only person who can call the contract is the owner 
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    // create modifier so that we only allocates funds if deceased = true 
    modifier mustBeDeceased {
        require(deceased == true);
        _;
    }

    // list of family wallets 
    address payable[] familyWallets;

    // iteration iterating : looping through - when we map through we iterate through key store

    // map through inheritance 
    mapping(address => uint) inheritance;

    // set inheritace for each address 
    function setInheritance(address payable wallet, uint amount) public {
         familyWallets.push(wallet);
         inheritance[wallet] = amount;
    }

    function payout() private mustBeDeceased {
        for(uint i=0; i<familyWallets.length; i++){
            // transfering the funds from contract address to reciever address 
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }
    // Oracle switch simulation
    function hasDeceased() public onlyOwner{
        deceased = true;
        payout();
    }
}
