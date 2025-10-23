//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract KaraageLendingPool{
    struct User {
        uint256 collateral;
        uint256 debt;
    }

    mapping(address=>User) public userInfo;

    function borrow() external {

    }
    
    function repay() external {
        
    }
}