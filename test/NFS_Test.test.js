
require('chai')
.use(require('chai-as-promised'))
.should()

const { expectRevert } = require('@openzeppelin/test-helpers');
const KingNFTs = artifacts.require('KINGS_Nobility');
const alice = "";
const bob = '';
contract('KINGS_Nobility', (accounts) => {
    this.owner = accounts[0];
    this.alice= accounts[1];
    this.bob= accounts[2];
    beforeEach(async () => {
        this.king = await KingNFTs.new();
    });



    it('should have correct name', async () => {
        
        const name = await this.king.getName();
        assert.equal(name, 'KingsToken NFT');
    })
    
    it('should have correct list of nfts', async () => {
        
        const types = await this.king.getNFTsType();
        assert.equal(types, 'CHAMPION - ID: 0, KNIGHT - ID: 1, WARRIOR - ID: 2');
    });

    
    
  });