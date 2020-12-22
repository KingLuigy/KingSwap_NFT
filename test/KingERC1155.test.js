const { expectRevert } = require("C:/KingToken/openzeppelin-test-helpers-master");
const KingERC1155 = artifacts.require('KingERC1155');

contract('KingERC1155', ([alice, bob, carol]) => {
    beforeEach(async () => {
        this.KingERC1155 = await KingERC1155.new( { from: alice });
    });

        it('FT Creation', async () => {
            
            await this.KingERC1155.createToken("Pala", '10', alice, { from: alice });
            const totalSupply = await this.KingERC1155.balanceOf(alice, '0');
            // const carolBal = await this.KingERC1155.balanceOf(carol);
            // assert.equal(await carolBal.valueOf(), '10');
            assert.equal(await totalSupply.valueOf(), '10');
            // await expectRevert(
            //     this.KingERC1155.mint(bob, '1', { from: alice }),
            //             'hardcap reached',
            //         );
         
           

        

    });

    it('NFT Creation', async () => {
            
        await this.KingERC1155.createNFTToken("Pala1", '10', alice, { from: alice });
        const supply = await this.KingERC1155.balanceOf(alice, '2');
        // const carolBal = await this.KingERC1155.balanceOf(carol);
        // assert.equal(await carolBal.valueOf(), '10');
        assert.equal(await supply.valueOf(), '1');
        // await expectRevert(
        //     this.KingERC1155.mint(bob, '1', { from: alice }),
        //             'hardcap reached',
        //         );
     
       

    

});

it('NFT batch Transfer', async () => {
            
    await this.KingERC1155.createNFTToken("Pala1", '10', alice, { from: alice });
    
    var alicesupply = await this.KingERC1155.balanceOf(alice, '2');
    // const carolBal = await this.KingERC1155.balanceOf(carol);
    // assert.equal(await carolBal.valueOf(), '10');
    assert.equal(await alicesupply.valueOf(), '1');
    await this.KingERC1155.batchTransfer(carol, "Pala1", '10',{ from: alice });
    alicesupply = await this.KingERC1155.balanceOf(alice, '2');
    var carolsupply = await this.KingERC1155.balanceOf(carol, '2');
    assert.equal(await carolsupply.valueOf(), '1');
    assert.equal(await alicesupply.valueOf(), '0');

    // await expectRevert(
    //     this.KingERC1155.mint(bob, '1', { from: alice }),
    //             'hardcap reached',
    //         );
 
   



});

});