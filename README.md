# Udacity Blockchain Capstone
The capstone will build upon the knowledge you have gained in the course in order to build a decentralized housing product. 

## Version
    "openzeppelin-solidity": "2.2.0",
    "@truffle/hdwallet-provider": "^2.0.10",
    "buffer": "^6.0.3",
    "ipfs": "^0.63.5",
    "solc": "0.5.2",
    "truffle": "^5.5.21",
    "web3": "^1.7.4"

# Contract Addresses, Contract Abi's, OpenSea MarketPlace Storefront link's.

## Contract Addresses
 1. [CustomERC721Token](https://rinkeby.etherscan.io/address/0x8977022C0cf66bf9cE7E7903e8C4323841d0FD50)
 2. [SquareVerifier](https://rinkeby.etherscan.io/address/0xe9F89bd6579Fe10c82897865A48Bf22aE9c55aBB)
 3. [SolnSquareVerifier](https://rinkeby.etherscan.io/address/0x24C22D392e50C5C0CEDbaBd6c28657a3726726b8)

## Tests

### TestERC721Mintable.js
##### Inside `eth-contracts`

Test minting functionality of tokens and transfer of tokens.

    truffle test ./test/TestERC721Mintable.js

### TestSquareVerifier.js

Verifies zkSnarks is successfully implemented.

    truffle test ./test/TestSquareVerifier.js

### TestSolnSquareVerifier.js

Test minting with zkSnarks.

    truffle test ./test/TestSolnSquareVerifier.js

##### All 11 tests should pass

## Contract ABI's
1. CustomERC721Token: [eth-contracts/build/contracts/CustomERC721Token.json](eth-contracts/build/contracts/CustomERC721Token.json])
2. SquareVerifier: [eth-contracts/build/contracts/SquareVerifier.json](eth-contracts/build/contracts/SquareVerifier.json)
3. SolnSquareVerifier: [eth-contracts/build/contracts/SolnSquareVerifier.json](eth-contracts/build/contracts/SolnSquareVerifier.json)

## Zokrates
* Completes the Zokrates proof in square.code by adding the variable names in square.code 
```bash
    zokrates compile -i square.code \ 
    && zokrates setup \
    && zokrates compute-witness -a 2 4 \
    && zokrates generate-proof \
    && zokrates export-verifier

 ```
* Completes test contract in SolnSquareVerifier.sol 
* Writes and passes the test cases in 'TestSolnSquareVerifier.js' 

# 10 Tokens Minted
```

```

# OpenSea Marketplace
* Storefront: https://testnets.opensea.io/collection/smoked-cut-potato
* Token1: https://testnets.opensea.io/assets/rinkeby/0x88b48f654c30e99bc2e4a1559b4dcf1ad93fa656/12018692258504210061577519183504414610600541988278227211486949901420009095169

# How to tutiorial
## How to deploy to Rinkeby network
```bash
truffle migrate --network rinkeby
```

## How to create a new Zokrates solution
```bash
~/zokrates compute-witness -a {num_1} {num_1 * num_1}
~/zokrates generate-proof
```
* get `proof.json` and `witness` file


# Deployment Log
```

```
