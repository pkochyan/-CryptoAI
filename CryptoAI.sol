// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IToken.sol";

contract CryptoAI {
    IToken public token;

    mapping(address => uint256) public balances;

    constructor(address tokenAddress) {
        token = IToken(tokenAddress);
    }

    function deposit(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        require(token.transfer(msg.sender, amount), "Transfer failed");
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
