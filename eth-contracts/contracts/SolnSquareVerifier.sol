//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.2;

import "./SquareVerifier.sol";
import "./ERC721Mintable.sol";

// define a contract call to the zokrates generated solidity contract <Verifier> or <renamedVerifier>
contract Verifier {
    function verifyTx(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[2] memory input
    ) public returns (bool r);
}

// define another contract named SolnSquareVerifier that inherits from your ERC721Mintable class
contract SolnSquareVerifier is CustomERC721Token {
    // define a solutions struct that can hold an index & an address
    struct Solution {
        uint256 index;
        address account;
        bool minted; //flag to indicate if this solution has been used in token minting
    }

    // define an array of the above struct
    Solution[] private solutions;

    // define a mapping to store unique solutions submitted (solutionHash => solution)
    mapping(bytes32 => bool) private submittedSolutions;
    mapping (bytes32 => Solution) solutionsMap;

    // Create an event to emit when a solution is added
    event SolutionAdded(uint256 index, address account);

    Verifier verifier;

    constructor(
        address verifierAddress,
        string memory name,
        string memory symbol
    ) public CustomERC721Token(name, symbol) {
        verifier = Verifier(verifierAddress);
    }

    // Create a function to add the solutions to the array and emit the event
    function addSolution(bytes32 solutionHash, address account)
        public
        whenNotPaused
    {
        uint256 solutionIndex = solutions.length + 1;
        Solution memory s = Solution(solutionIndex, account, false);
        solutions.push(s);
        submittedSolutions[solutionHash] = true;
        solutionsMap[solutionHash] = s;
        emit SolutionAdded(solutionIndex, account);
    }

    function canMintToken(
        address _to,
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[2] memory input
    ) public {
        // check if solution is valid
        require(verifier.verifyTx(a, b, c, input), "solution not valid");
        bytes32 solutionHash = keccak256(abi.encodePacked(a, b, c, input));

        addSolution(solutionHash, _to);
    }

    // Create a function to mint new NFT only after the solution has been verified
    function mint(
        address to,
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[2] memory input
    ) public returns (bool) {
        bytes32 solutionHash = keccak256(abi.encodePacked(a, b, c, input));

        //  - check uniquness
        require(
            !submittedSolutions[solutionHash],
            "Solution has been submitted"
        );
        require(verifier.verifyTx(a, b, c, input), "verifyTx failed");

        //  - handle metadata as well as tokenSuplly
        addSolution(solutionHash, to);
        super.mint(to, solutions.length);
        solutionsMap[solutionHash].minted = true;
    }
}
