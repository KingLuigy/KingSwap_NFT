pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.1.0/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.1.0/contracts/utils/Counters.sol";

contract KingTokenNFTQueen is ERC721 {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    //Owner address
    address private owner;
    
    //List of user address;
    mapping(address => uint) private wallets;

     modifier _onlyOwner(){
        require(msg.sender == owner);
        _;
    }


    constructor(string memory myName, string memory mySymbol,address _owner) ERC721(myName, mySymbol) public {
        owner = _owner;
    }
    
    //for owner to see NFTs issued to who
    function checkWalletAddressExist(address player) _onlyOwner() public view returns (uint){
        return wallets[player];
    }

    function mint(address player, uint totalSupply) _onlyOwner() public returns (bool) {

        for(uint256 i = 1; i<= totalSupply; i++){
            _tokenIds.increment();
            uint256 newItemId = _tokenIds.current();
            _mint(player, newItemId);
            _setTokenURI(newItemId,"https://api.jsonbin.io/b/5f7367137243cd7e82466615/29");
        }
        //check if address exist in wallet
        if(wallets[player] == 0){
              wallets[player] = totalSupply;  
        }else{
                uint totalsum = wallets[player];
                totalsum = totalsum + totalSupply;
                wallets[player] = totalsum;
        }
    }
    
}