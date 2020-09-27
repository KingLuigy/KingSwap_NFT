pragma solidity ^ 0.6.0;
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.1.0/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
contract KINGS_Nobility is ERC1155 { 
    
    //The king has form a nobility hierachry.
    
    //Nobility Contract Name & Information of it
    string private name;
    string private description;
    
    //3 Tiers of NFTS Token
    uint256 private constant CHAMPION = 0; //Epic Tier
    uint256 private constant KNIGHT = 1;  //Blue Tier
    uint256 private constant WARRIOR = 2; //Greent Tier
    
    //Owner address
    address private owner;
    //For calling Different NFTs Types
    address [] private owners;
    
   
    uint256 [] private listIds = [CHAMPION, KNIGHT, WARRIOR];
    string listNFTs = "CHAMPION - ID: 0, KNIGHT - ID: 1, WARRIOR - ID: 2";
    
    modifier _onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    constructor () public ERC1155 ('') {
        
        name = "KingsToken NFT";
        description = "Pre-sale NFTS (28 Oct 2020) - For early adopter and private investor to purchase initial NFTs. More information visit www.kingswap.io";
        
        //Owner of the contractor will hold the totalsupply and be issued to individual.
        _mint(msg.sender, CHAMPION, 50000, "");
        _mint(msg.sender, KNIGHT, 150000, "");
        _mint(msg.sender, WARRIOR, 800000, "");
        
        //Store owner address
        owner = msg.sender;
        
        //store 3 address of the owner so that owner can review 3 tier of supply he hold and also anyone can view it. Look at checkTotalSupply() function
        owners = [owner,owner,owner];
    }
    
    //return totalsupply of NFTs left. (Owner holds the total supply of NFTS, will be dispered to individual by owner)
    function checkTotalSupply() public view returns (uint256 [] memory){
       return balanceOfBatch(owners, listIds);
    }
     
    //return a list of NFTs Type. More information on the perks of it visit wwww.kingswap.io
    function getNFTsType() public view returns (string memory)
    {
        return listNFTs;
    }
    
    //Get Name of the Contract
    function getName() public view returns (string memory) { 
        return name;
    }
    
    //Get Information of this contract
    function getDescription() public view returns (string memory) { 
        return description;
    }
    //Add supply
    function create(uint256 id,uint256 amount) _onlyOwner external{
        _mint(owner,id,amount,"");
    }
    
   
}