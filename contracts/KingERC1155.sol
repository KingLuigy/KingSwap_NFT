// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract KingERC1155 is ERC1155, Ownable {

    mapping(string => TokenInfo) public tokenNameToTokenInfo;
    uint256 public currentId = 0;
    
    struct TokenInfo {
        string tokenName; // token Name
        string tokenType; //
        uint startId;
        uint endId;
    }
    

    constructor() public ERC1155("https://thekingswap.github.io/ERC1155/api/token/{id}.json") {
    }

    function createToken(string memory _tokenName, uint256 _totalSupply, address _to) public onlyOwner{

            tokenNameToTokenInfo[_tokenName]=
            TokenInfo({
                tokenName: _tokenName,
                tokenType: "FT",
                startId: currentId,
                endId: currentId
            });

            _mint(_to,currentId,_totalSupply,"");
            currentId = currentId + 1;
    }

    function createNFTToken(string memory _tokenName, uint _totalSupply, address _to) public onlyOwner{
            uint256[] memory ids = new uint[](_totalSupply);
            uint256[] memory amounts = new uint[](_totalSupply);
            uint256 startId = currentId;
            uint256 endId = currentId + _totalSupply - 1;
            uint256 j = 0;
            for(uint256 i = startId ; i <= endId ; i++){
                ids[j] = i;
                amounts[j] = 1;
                j++;
            }

            currentId = endId;


            tokenNameToTokenInfo[_tokenName] =
            TokenInfo({
                tokenName: _tokenName,
                tokenType: "NFT",
                startId: startId,
                endId: endId
            });

            _mintBatch(_to,ids,amounts,"");
    }

    function retrieveTokenInfo(string memory _tokenName) public view returns(TokenInfo memory){
        return tokenNameToTokenInfo[_tokenName];
    }

    function _checkUserBalance(address _user, string memory _tokenName, uint amount) public view returns (uint256[] memory, uint256[] memory){
       TokenInfo memory tokeninfo = tokenNameToTokenInfo[_tokenName];
       uint startId = tokeninfo.startId;
       uint endId = tokeninfo.endId;
       uint length = endId - startId + 1;
       uint256[] memory ownIds = new uint[](length);
       uint256[] memory amounts = new uint[](length);
        uint j = 0;
        for(uint i = startId ; i <= endId ; i ++){
            
            if(balanceOf(_user,i) > 0)
                { 
                    ownIds[j] = i;
                    amounts[j] = 1;
                    j++;
                    
                    if(j == amount) continue;
                }
        }

        return (ownIds,amounts);

    }

    function batchTransfer(address _to, string memory _tokenName, uint amount) public {
        (uint256[] memory ids, uint256[] memory amounts) = _checkUserBalance(_to, _tokenName, amount);
        
        safeBatchTransferFrom(msg.sender,_to,ids,amounts, "");

    }

}