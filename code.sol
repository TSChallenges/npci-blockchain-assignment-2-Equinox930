// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdvancedBank {
    address public owner; // The owner of the contract
    mapping(address => uint256) private balances; // Stores user balances
    uint256 public interestRate; // Annual interest rate in percentage (e.g., 5 means 5%)

    // Constructor to initialize the owner
    constructor() {
        owner = msg.sender;
        interestRate = 5; 
    }

    // Modifier to restrict access to owner-only functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    // Function to deposit Ether into the bank
    function deposit() public payable {
        require(msg.value > 0, "Must deposit more than 0 ETH.");
        balances[msg.sender] += msg.value;

    }

    // Function to withdraw Ether from the bank
    function withdraw(uint256 amount) public {
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);

    }

    // Function to calculate interest for the caller
    function calculateInterest() public view returns (uint256) {
        uint256 balance = balances[user];
        uint256 interest = (balance * interestRate) / 100;
        return 0; // Replace this with the actual calculation
    }

    // Function for the owner to set the interest rate
    function setInterestRate(uint256 rate) public onlyOwner {
        require(rate > 0 && rate <= 100, "Interest rate must be between 1 and 100%");
        require(newRate <= 100, "Interest rate must be between 0 and 100.");
        interestRate = newRate;
    }

    // Function for the owner to withdraw all funds (administrative purpose)
    function withdrawAll() public onlyOwner {
        uint256 contractBalance = address(this).balance; // Get the contract's total balance
        payable(owner).transfer(address(this).balance);
    }

    // Function to check the balance of the caller
    function getBalance() public view returns (uint256) {
        return balances[msg.sender]; // Returns the balance of the caller
    }

    // Fallback function to handle direct Ether transfers
    receive() external payable {
        deposit(); // TODO: Call the deposit function when Ether is sent directly
    }
}
