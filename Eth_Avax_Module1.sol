// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IronManSuitDevelopment {
    address public TonyStark;
    uint256 public suitFund;
    uint256 public proposalCount;

    struct Proposal {
        uint256 id;
        string description;
        uint256 cost;
        uint256 votes;
        bool funded;
        mapping(address => bool) voters;
    }

    mapping(uint256 => Proposal) public proposals;
    address[] public avengers;

    constructor(address[] memory _avengers) {
        TonyStark = msg.sender;
        avengers = _avengers;
        proposalCount = 0;
    }

    modifier onlyTonyStark() {
        require(msg.sender == TonyStark, "You are not Tony Stark");
        _;
    }

    modifier onlyAvengers() {
        bool isAvenger = false;
        for (uint256 i = 0; i < avengers.length; i++) {
            if (msg.sender == avengers[i]) {
                isAvenger = true;
                break;
            }
        }
        require(isAvenger, "You are not an Avenger");
        _;
    }

    function contributeToSuitFund() public payable {
        require(msg.value > 0, "You must contribute some ether");
        suitFund += msg.value;
    }

    function proposeSuitDevelopment(string memory description, uint256 cost) public onlyAvengers {
        require(cost > 0, "Development cost must be greater than zero");
        Proposal storage newProposal = proposals[proposalCount];
        newProposal.id = proposalCount;
        newProposal.description = description;
        newProposal.cost = cost;
        newProposal.votes = 0;
        newProposal.funded = false;
        proposalCount++;
    }

    function voteOnProposal(uint256 proposalId) public onlyAvengers {
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.voters[msg.sender], "You have already voted on this proposal");
        proposal.voters[msg.sender] = true;
        proposal.votes++;
    }

    function fundSuitDevelopment(uint256 proposalId) public onlyTonyStark {
        Proposal storage proposal = proposals[proposalId];
        require(proposal.cost <= suitFund, "Insufficient funds to develop the Iron Man suit");
        require(proposal.votes > avengers.length / 2, "Not enough votes to approve the proposal");
        require(!proposal.funded, "Proposal has already been funded");
        suitFund -= proposal.cost;
        proposal.funded = true;
    }

    function checkSuitFundBalance() public view returns (uint256) {
        return suitFund;
    }

    function emergencyShutdown() public onlyTonyStark {
        // In case of emergency, Tony Stark can shut down the contract and withdraw remaining funds
        assert(msg.sender == TonyStark); 
        payable(TonyStark).transfer(address(this).balance);
    }
}
