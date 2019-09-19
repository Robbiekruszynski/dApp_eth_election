pragma solidity ^0.5.0;

contract Election {
    // Model a Candidate
    struct Candidate {

    //canidaite value
      uint id;
      string name;
      uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;

    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;

    // Store Candidates Count
    //keeps track of the amount of candidates
    uint public candidatesCount;

    // voted event
    event votedEvent (
    uint indexed _candidateId
    );

    constructor () public {
      addCandidate("Candidate 1");
      addCandidate("Candidate 2");
      addCandidate("Candidate 3");
      addCandidate("Candidate 4");


    }

    function addCandidate (string memory _name) private {
      //represents the ID of the candidate so we ++ first
        candidatesCount ++;

        //pass it the key / ID we get from above
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {

        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}
