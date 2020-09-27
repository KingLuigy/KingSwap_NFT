const Migrations = artifacts.require("Migrations");
const NFTs_KingSwap = artifacts.require("KINGS_Nobility");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(NFTs_KingSwap);
};
