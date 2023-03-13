// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract VotingRollup {
    struct Candidate {
        string name;
        uint votes;
    }

    mapping(uint => Candidate) candidates;
    address[] voted;

    constructor() {
        candidates[0] = Candidate("abc", 0);
        candidates[1] = Candidate("xyz", 0);
    }

    function listCandidate() public view returns (string[] memory) {
        string[] memory candidateNames = new string[](2);
        candidateNames[0] = candidates[0].name;
        candidateNames[1] = candidates[1].name;
        return candidateNames;
    }

    function vote(uint256 candidateIndex) public {
        require(candidateIndex < 2, "Invalid candidate index");
        candidates[candidateIndex].votes++;
        voted.push(msg.sender);
    }

    function getCandidate(uint256 candidateIndex) public view returns (uint) {
        require(candidateIndex < 2, "Invalid candidate index");
        return candidates[candidateIndex].votes;
    }

    function result() public view returns (string memory m)
    {
        if (candidates[0].votes > candidates[1].votes) {
            return candidates[0].name;
        }
        else if(candidates[0].votes < candidates[1].votes)
        {
            return candidates[1].name;
        }
        else if (candidates[0].votes == candidates[1].votes) {           
        string memory message = "Voting ended in draw!";
            return message;
        }
    }
    function simulateVotes() public {
    address useradd = msg.sender;
    uint256 candidateIndex;
    for (uint i = 0; i < 200; i++) {
        candidateIndex = uint256(keccak256(abi.encodePacked(block.timestamp, i, useradd))) % 2;
        vote(candidateIndex);
    }
}
}