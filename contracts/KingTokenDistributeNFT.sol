// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./KingToken.sol";
import "./KingTokenNFTKingWerewolf.sol";
import "./KingTokenNFTQueenVampz.sol";
import "./KingTokenNFTKnightMummy.sol";
import "./KingTokenNFTsKnight.sol";
import "./KingTokenNFTsQueen.sol";
import "./KingTokenNFTsKing.sol";

contract KingTokenDistributeNFT is Ownable {
    using SafeMath for uint;


    // the king token
    KingToken public king;
    KingTokenNFTKingWerewolf public kw;
    KingTokenNFTQueenVampz public qz;
    KingTokenNFTKnightMummy public km;


    KingTokenNFTsKnight public knight;
    KingTokenNFTsQueen public queen;
    KingTokenNFTsKing public kingNFTs;


    //Default Constructor
    constructor(KingToken _king,  KingTokenNFTKingWerewolf _kw, KingTokenNFTQueenVampz _qz,KingTokenNFTKnightMummy _km,KingTokenNFTsKing _kingNFTs,KingTokenNFTsQueen _queen,KingTokenNFTsKnight _knight)
    public{
        king = _king;

        kw = _kw;
        qz = _qz;
        km = _km;

        kingNFTs = _kingNFTs;
        queen = _queen;
        knight = _knight;
    }


    function withdrawQueen(uint _amount) internal {
        require(_amount > 0, "no kings");
        uint256 length = queen.totalSupply();
        uint256 length2 = qz.totalSupply();
        uint balance = _amount;
        uint amountToTransfer = balance.div(length.add(length2));

        if(length != 0){
            for(uint i = 1; i <=length;i++){
                address walletAddr = queen.ownerOf(i);
                if(balance > amountToTransfer){
                    balance = balance.sub(amountToTransfer);
                    king.transfer(walletAddr, amountToTransfer);
                }else{
                    king.transfer(walletAddr, balance);
                }
            }
        }

        if(length2 != 0){
            for(uint i = 1; i <=length2;i++){
                address walletAddr = qz.ownerOf(i);
                if(balance > amountToTransfer){
                    balance = balance.sub(amountToTransfer);
                    king.transfer(walletAddr, amountToTransfer);
                }else{
                    king.transfer(walletAddr, balance);
                }
            }
        }
    }

    function withdrawKing(uint _amount) internal {
        require(_amount > 0, "no kings");
        uint256 length = kingNFTs.totalSupply();
        uint256 length2 = kw.totalSupply();
        uint balance = _amount;
        uint amountToTransfer = balance.div(length.add(length2));
        
        if(length != 0){
            for(uint i = 1; i <=length;i++){
                address walletAddr = kingNFTs.ownerOf(i);
                if(balance > amountToTransfer){
                    balance = balance.sub(amountToTransfer);
                    king.transfer(walletAddr, amountToTransfer);
                }else{
                    king.transfer(walletAddr, balance);
                }
            }
        }

        if(length2 != 0){
            for(uint i = 1; i <=length2;i++){
                address walletAddr = kw.ownerOf(i);
                if(balance > amountToTransfer){
                    balance = balance.sub(amountToTransfer);
                    king.transfer(walletAddr, amountToTransfer);
                }else{
                    king.transfer(walletAddr, balance);
                }
            }
        }
    }

    function withdrawKnight(uint _amount) internal {
        require(_amount > 0, "no kings");
        uint256 length = knight.totalSupply();
        uint256 length2 = km.totalSupply();
        uint balance = _amount;
        uint amountToTransfer = balance.div(length.add(length2));
        
        if(length != 0){
            for(uint i = 1; i <=length;i++){
                address walletAddr = knight.ownerOf(i);
                if(balance > amountToTransfer){
                    balance = balance.sub(amountToTransfer);
                    king.transfer(walletAddr, amountToTransfer);
                }else{
                    king.transfer(walletAddr, balance);
                }
            }
        }

        if(length2 != 0){
            for(uint i = 1; i <=length2;i++){
                address walletAddr = km.ownerOf(i);
                if(balance > amountToTransfer){
                    balance = balance.sub(amountToTransfer);
                    king.transfer(walletAddr, amountToTransfer);
                }else{
                    king.transfer(walletAddr, balance);
                }
            }
        }
    }

    //Anyone can call it but it will be split to only the people in this address.
    function withdraw() public onlyOwner{
        uint _amount = king.balanceOf(address(this));
        require(_amount > 0, "zero king amount");
        uint balance = _amount;
        uint kingAllocation = _amount.mul(3).div(5);
        balance = balance.sub(kingAllocation);
        uint queenAllocation = _amount.mul(3).div(10);
        balance = balance.sub(queenAllocation);



        withdrawKing(kingAllocation);
        withdrawQueen(queenAllocation);
        withdrawKnight(balance);


    }
       

        
        

}