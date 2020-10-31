const { expectRevert } = require("C:/KingToken/openzeppelin-test-helpers-master");
const KingTokenDistributeNFT = artifacts.require('KingTokenDistributeNFT');
const KingToken = artifacts.require('KingToken');
const KingTokenNFTKingWerewolf = artifacts.require('KingTokenNFTKingWerewolf');
const KingTokenNFTKnightMummy = artifacts.require('KingTokenNFTKnightMummy');
const KingTokenNFTQueenVampz = artifacts.require('KingTokenNFTQueenVampz');
const KingTokenNFTsKing = artifacts.require('KingTokenNFTsKing');
const KingTokenNFTsQueen = artifacts.require('KingTokenNFTsQueen');
const KingTokenNFTsKnight = artifacts.require('KingTokenNFTsKnight');


contract('KingTokenDistributeNFT', ([alice, bob, carol, daniel, eli, farah, goblin, harry, indi, john]) => {
    beforeEach(async () => {
        
        this.king = await KingToken.new({ from: alice });
        this.kwNFT = await KingTokenNFTKingWerewolf.new('KingTokenNFTKingWerewolf', 'KingWereWolf', alice, { from: alice });
        this.qvNFT = await KingTokenNFTQueenVampz.new('KingTokenNFTQueenVampz', 'QueenVampz', alice, { from: alice });
        this.kmngNFT = await KingTokenNFTKnightMummy.new('KingTokenNFTKnightMummy', 'KnightMummy', alice, { from: alice });
        this.kingNFT = await KingTokenNFTsKing.new('KingTokenNFTsKing', 'NFTsKing', alice, { from: alice });
        this.queenNFT = await KingTokenNFTsQueen.new('KingTokenNFTsQueen', 'NFTsQueen', alice, { from: alice });
        this.knightNFT = await KingTokenNFTsKnight.new('KingTokenNFTsKnight', 'NFTsKnight', alice, { from: alice });
        this.distributeNFT = await KingTokenDistributeNFT.new(this.king.address,this.kwNFT.address, this.qvNFT.address,this.kmngNFT.address,this.kingNFT.address,this.queenNFT.address,this.knightNFT.address, {from: alice});
    });

        it('should distribute correctly', async () => {

            await this.kwNFT.mint(bob, '1', { from: alice });
            await this.qvNFT.mint(carol, '1', { from: alice });
            await this.kmngNFT.mint(daniel, '1', { from: alice });
            await this.kingNFT.mint(eli, '1', { from: alice });
            await this.queenNFT.mint(farah, '1', { from: alice });
            //await this.knightNFT.mint(goblin, '1', { from: alice });

            await this.kwNFT.mint(harry, '2', { from: alice });
            await this.qvNFT.mint(indi, '2', { from: alice });
            await this.kmngNFT.mint(john, '2', { from: alice });


            //15000 to King Holder
            //7500 to Queen Holder
            //2500 to Knight Holder

            //alice 0;
            //bob 1/4 * 15000 = 3750
            //carol 1/4 * 7500 = 1250
            //daniel 1/3 * 2500 = 833

            await this.king.mint(this.distributeNFT.address, '25000')
            await this.distributeNFT.withdraw();
            

            const aliceBal = await this.king.balanceOf(alice);
            const bobBal = await this.king.balanceOf(bob);
            const carolBal = await this.king.balanceOf(carol);
            const danielBal = await this.king.balanceOf(daniel);
            const eliBal = await this.king.balanceOf(eli);
            const farahBal = await this.king.balanceOf(farah);
            const goblinBal = await this.king.balanceOf(goblin);
            const harryBal = await this.king.balanceOf(harry);
            const indiBal = await this.king.balanceOf(indi);
            const johnBal = await this.king.balanceOf(john);



            assert.equal(await aliceBal.valueOf(), '0'); // no NFT
            assert.equal(await bobBal.valueOf(), '3750'); // 1 KingNFT
            assert.equal(await carolBal.valueOf(), '1875'); // 1 QueenNFT
            assert.equal(await danielBal.valueOf(), '833'); //1 KnightNFT
            assert.equal(await eliBal.valueOf(), '3750'); // 1 King NFT
            assert.equal(await farahBal.valueOf(), '1875'); // 1 Queen NFT
            assert.equal(await goblinBal.valueOf(), '0'); // 0 Knight NFT
            assert.equal(await harryBal.valueOf(), '7500'); // 2 King NFT
            assert.equal(await indiBal.valueOf(), '3750'); // 2 Queen NFT
            assert.equal(await johnBal.valueOf(), '1666'); // 2 Knight NFT



            // await expectRevert(
            //     this.kingNFT.mint(bob, '1', { from: alice }),
            //             'hardcap reached',
            //         );

    });

});