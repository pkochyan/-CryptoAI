// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Token {
    function transfer(address to, uint256 amount) external;
    function balanceOf(address owner) external view returns (uint256);
}

contract CryptoAI {
    Token public token;
    mapping(address => uint256) public balances;
    
    constructor(address _tokenAddress) {
        token = Token(_tokenAddress);
    }
    
    function deposit(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(token.balanceOf(msg.sender) >= amount, "Insufficient balance");
        token.transfer(address(this), amount);
        balances[msg.sender] += amount;
    }
    
    function withdraw(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        token.transfer(msg.sender, amount);
    }
    
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
