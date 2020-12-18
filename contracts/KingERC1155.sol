// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract KingERC1155 is ERC1155, Ownable {
    TokenInfo[] public tokenInfo;
    uint256 public currentId = 1;
    
    struct TokenInfo {
        string tokenName; // token Name
    }
    

    constructor() public ERC1155("https://thekingswap.github.io/ERC1155/api/token/{id}.json") {
    }

    function createToken(string memory _tokenName, uint256 _totalSupply, address _to) public onlyOwner{
        
            tokenInfo.push(
            TokenInfo({
                tokenName: _tokenName
            }));

            _mint(_to,currentId,_totalSupply,"");
            currentId = currentId + 1;
    }

}