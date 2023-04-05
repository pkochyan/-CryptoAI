// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IVirtualAsset {
    function transfer(address recipient, uint256 amount) external view returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external view returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract CryptoAI {
    IVirtualAsset public virtualAsset;

    constructor(address _virtualAsset) {
        virtualAsset = IVirtualAsset(_virtualAsset);
    }

    function deposit(uint256 amount) external {
        require(virtualAsset.balanceOf(msg.sender) >= amount, "Insufficient balance");

        bool success = virtualAsset.transferFrom(msg.sender, address(this), amount);
        require(success, "Transfer failed");
    }

    function withdraw(uint256 amount) external {
        require(virtualAsset.balanceOf(address(this)) >= amount, "Insufficient balance");

        bool success = virtualAsset.transfer(msg.sender, amount);
        require(success, "Transfer failed");
    }

    function getBalance() external view returns (uint256) {
        return virtualAsset.balanceOf(address(this));
    }
}
