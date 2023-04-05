pragma solidity ^0.8.0;

contract CryptoAI {
    mapping(address => uint) balances;

    function deposit() public payable {
        require(msg.value > 0, "Invalid deposit amount");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require(amount > 0, "Invalid withdrawal amount");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed");
    }

    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }
}
