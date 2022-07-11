const Web3 = require("web3");
const HDWalletProvider = require("@truffle/hdwallet-provider");
const SolnSquareVerifierArtifact = require("./eth-contracts/build/contracts/SolnSquareVerifier.json"); //ABI
const secret = require("./.secret.json");

const provider = new HDWalletProvider({
  mnemonic: {
    phrase: secret.mnemonicPhrase,
  },
  providerOrUrl: `https://rinkeby.infura.io/v3/${secret.infuraKey}`,
});
// Mint will be reverted if proof already exist, every solution should be unique
const proof = require("./zokrates/code/square/proof.json");

(async () => {
  const numberOfTokensToMint = 10;
  const web3 = await new Web3(provider);
  const accounts = await web3.eth.getAccounts();
  const address0 = accounts[0];
  console.log(`got account=${address0}`);
  const soln = await new web3.eth.Contract(
    SolnSquareVerifierArtifact.abi,
    address0 // address
  );


  try {
    for(var index = 0; index<numberOfTokensToMint; index++){
      var token = await soln.methods.mint(
        address0, 
        proof.proof.a,
        proof.proof.b,
        proof.proof.c,
        proof.inputs)
        .send({ from: address0 });
      console.log(`minting token with proof completed. token-${index} = ${JSON.stringify(token)}`);
    }
  } catch (error) {
    console.error(`mint token with proof error=`, error);
  }
})();
