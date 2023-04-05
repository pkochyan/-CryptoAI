// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IVirtualAsset {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract CryptoAI {
    IVirtualAsset public virtualAsset;
    mapping(address => uint256) public balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    constructor(address _virtualAsset) {
        virtualAsset = IVirtualAsset(_virtualAsset);
    }

    function deposit(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(virtualAsset.transferFrom(msg.sender, address(this), amount), "Transfer failed");

        balances[msg.sender] += amount;
        emit Deposited(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        require(virtualAsset.transfer(msg.sender, amount), "Transfer failed");

        emit Withdrawn(msg.sender, amount);
    }
}
