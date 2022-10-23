// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract election {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    mapping(uint256 => Candidate) private candidates;
    mapping(address => bool) private voters;

    // default will be zero
    uint256 private candidateCount;

    constructor() {
        addCandidate("Rahul");
        addCandidate("Rohit");
    }

    function addCandidate(string memory candidate_name) public {
        candidates[candidateCount] = Candidate(
            candidateCount,
            candidate_name,
            0
        );
        candidateCount++;
    }

    function vote(uint256 candidate_id) public {
        require(!voters[msg.sender]);
        require(candidate_id >= 0 && candidate_id <= candidateCount);
        voters[msg.sender] = true;
        candidates[candidate_id].voteCount++;
    }

    function getCandidateVotes(uint256 candidate_id)
        public
        view
        returns (uint256)
    {
        return candidates[candidate_id].voteCount;
    }

    function getWinner() public view returns (string memory) {
        if (candidates[0].voteCount > candidates[1].voteCount)
            return candidates[0].name;
        else if (candidates[0].voteCount == candidates[1].voteCount)
            return "draw";
        else return candidates[1].name;
    }
}
