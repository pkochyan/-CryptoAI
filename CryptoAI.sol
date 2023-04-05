// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IVirtualAsset {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
}

contract CryptoAI {
    IVirtualAsset public virtualAsset;

    constructor(address virtualAssetAddress) {
        virtualAsset = IVirtualAsset(virtualAssetAddress);
    }

    function deposit(uint256 amount) external {
        require(amount > 0, "Deposit amount must be greater than 0");
        virtualAsset.transferFrom(msg.sender, address(this), amount);
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdrawal amount must be greater than 0");
        require(virtualAsset.balanceOf(address(this)) >= amount, "Insufficient balance");

        // Ensure that the transfer is performed before the state is updated
        (bool success, ) = msg.sender.call{value: 0}("");
        require(success, "Transfer failed");

        virtualAsset.transfer(msg.sender, amount);
    }
}
