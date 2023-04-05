// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptoAI {
    mapping(address => uint) balances;

    event Deposit(address indexed account, uint amount);
    event Withdrawal(address indexed account, uint amount);

    function deposit() external payable {
        require(msg.value > 0, "Amount should be greater than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint amount) external {
        require(amount > 0, "Amount should be greater than 0");
        require(amount <= balances[msg.sender], "Insufficient balance");
        payable(msg.sender).transfer(amount);
        balances[msg.sender] -= amount;
        emit Withdrawal(msg.sender, amount);
    }

    function getBalance(address account) external view returns (uint) {
        return balances[account];
    }
}
