//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract CollateralVault{
    mapping(address=>uint256) public lockedCollateral;
    mapping(address=>uint256) public unlockedCollateral;

    error CollateralVault__CollateralIsLocked();
    error CollateralVault__TransferFailed();

    function lockCollateral() external payable{
        lockedCollateral[msg.sender] += msg.value;
    }

    function unlockCollateral(address user, uint256 amount) external {
        lockedCollateral[user] -= amount;
        unlockedCollateral[user] += amount;
    }

    function withdrawCollateral(uint256 amount) external  {
        if(amount > unlockedCollateral[msg.sender]){
            revert CollateralVault__CollateralIsLocked();
        }
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        if(!success){
            revert CollateralVault__TransferFailed();
        }
    }
}