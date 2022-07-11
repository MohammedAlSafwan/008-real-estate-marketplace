// migrating the appropriate contracts
var CustomERC721Token = artifacts.require("CustomERC721Token");
var SquareVerifier = artifacts.require("SquareVerifier");
var SolnSquareVerifier = artifacts.require("SolnSquareVerifier");

module.exports = function (deployer) {
  deployer.deploy(CustomERC721Token, "SmokedCutPotato", "SCP");
  deployer.deploy(SquareVerifier).then(() => {
    deployer.deploy(SolnSquareVerifier, SquareVerifier.address, "SmokedCutPotato", "SCP");
  });
};
