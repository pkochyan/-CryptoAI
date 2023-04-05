// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IToken {
    function transfer(address recipient, uint256 amount) external view returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract CryptoAI {
    IToken public token;
    mapping(address => uint256) public balances;

    constructor(address tokenAddress) {
        token = IToken(tokenAddress);
    }

    function deposit(uint256 amount) public {
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(token.transfer(msg.sender, amount), "Transfer failed");
        balances[msg.sender] -= amount;
    }

    function getBalance() public view returns (uint256) {
        return token.balanceOf(address(this));
    }
}
