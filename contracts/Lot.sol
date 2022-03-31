//SPDX-License-Identifier: MIT

/**
 * @author Max Fadeev
 */

pragma solidity >=0.7.0 <0.9.0;

contract Lot {

    address public owner;
    address public voteAddress;
    uint public balance = 0;
    uint public price = 0.1 ether;
    uint public percent = 0.01 ether;    
    uint public amount = 0.09 ether;    
    
    struct Candidate {
        bool exist;
        uint votes;
    }

    struct Campaign {
        address winner;
        uint maxVote;
        uint startDate;
        uint balance;
        bool isFinished;
        uint numVoter;
        uint numCandidates;        
        mapping (address => Candidate) candidates;        
        mapping (address => bool) voters;
    }

    uint public numCampaigns;
    mapping (uint => Campaign) campaigns;

    constructor() {
        owner = msg.sender; 
        voteAddress = address(this);
    }

    function newCampaign() public returns (uint campaignID) {
        require(owner == msg.sender, 'Owner only can create a vote');
        campaignID = numCampaigns++; 
        Campaign storage c = campaigns[campaignID];
        c.balance = 0;
        c.startDate = block.timestamp;
        c.isFinished = false;   
        return campaignID;
    }


    function addCandidate(uint campaign, address candidate) public returns (bool status) {
        require(owner == msg.sender, 'Owner only can add a candidate');        
        require(campaign < numCampaigns, 'Campaign not found');
        require(campaigns[campaign].isFinished == false, 'Campaign is already closed');
        require(campaigns[campaign].candidates[candidate].exist == false, 'Candidate is already added');        
        campaigns[campaign].candidates[candidate].votes = 0;
        campaigns[campaign].candidates[candidate].exist = true;        
        campaigns[campaign].numCandidates++;
        return true;
    }

    function vote(uint campaign, address candidate) public payable returns (bool status) {
        require(campaign < numCampaigns, 'Campaign not found');
        require(campaigns[campaign].isFinished == false, 'Campaign is already closed');
        require(campaigns[campaign].voters[msg.sender] == false, 'Already voted');
        require(campaigns[campaign].candidates[candidate].exist == true, 'Candidate not found');                
        require(msg.value == price, 'Amount incorrect');

        campaigns[campaign].candidates[candidate].votes++;
        if (campaigns[campaign].maxVote < campaigns[campaign].candidates[candidate].votes) {
            campaigns[campaign].maxVote = campaigns[campaign].candidates[candidate].votes;
            campaigns[campaign].winner = candidate;
        }
        campaigns[campaign].balance = campaigns[campaign].balance + amount;
        balance = balance + percent;
        campaigns[campaign].voters[msg.sender] = true;
        return true;
    }

    function viewCampaign(uint campaign, address candidate) public view returns (bool _exist, uint startDate, bool isFinished, uint candidateVote, uint maxVote, uint campaignBalance) {
        require(campaign < numCampaigns, 'Campaign not found');
        return (campaigns[campaign].candidates[candidate].exist, campaigns[campaign].startDate,campaigns[campaign].isFinished, campaigns[campaign].candidates[candidate].votes, campaigns[campaign].maxVote, campaigns[campaign].balance);
    }

    function closeCampaign(uint campaign) public returns (bool status) {
        require(campaign < numCampaigns, 'Campaign not found');
        require(campaigns[campaign].isFinished == false, 'Campaign is already closed');
 //       require((block.timestamp - campaigns[campaign].startDate) / 60 / 60 /24 > 3 , 'Minimum 3 days');        
        campaigns[campaign].isFinished = true;
        address payable recivier = payable(campaigns[campaign].winner);
        recivier.transfer(campaigns[campaign].balance);
        return true;
    }

    function withdrawBalance() public {
        require(owner == msg.sender, 'Owner only');        
        require(balance > 0, 'Balance zero');
        address payable receiver = payable(msg.sender);
        receiver.transfer(balance);
        balance = 0;
    }
}