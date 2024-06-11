// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Module1 {
    address public owner;
    uint256 public balance;

    constructor() {
        owner = msg.sender; 
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    event Deposit(address indexed depositor, uint256 amount);

    function deposit(uint256 amount) public payable {
        require(msg.value == amount, "Incorrect value sent");
        balance = balance + amount;
        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint256 amount) public onlyOwner {
        require(amount <= balance, "Insufficient balance");
        balance = balance - amount;
        payable(msg.sender).transfer(amount);
    }

    function checkBalance(uint256 expectedBalance) public view {
        assert(balance == expectedBalance);
    }

    function emergencyWithdraw() public pure {
        revert("Emergency withdraw is not allowed");
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}
