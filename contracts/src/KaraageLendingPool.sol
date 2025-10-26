// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract KaraageLendingPool {
    struct UserInfo {
        uint256 ethCollateral;
        uint256 debt;
        bool isCollateralFresh;
    }
    mapping(address => UserInfo) public users;

    uint256 public constant LTV = 75; 
    address public immutable ethOApp; 

    event CollateralSync(address indexed user, uint256 newCollateral);
    event Borrow(address indexed user, uint256 amount);
    event Repay(address indexed user, uint256 amount);

    error KaraageLendingPool__NotAuthorized();
    error KaraageLendingPool__ExceedsBorrowLimit();
    error KaraageLendingPool__NoCollateral();
    error KaraageLendingPool__NotFresh();

    modifier onlyEthOApp() {
        if (msg.sender != ethOApp) revert KaraageLendingPool__NotAuthorized();
        _;
    }

    constructor(address _ethOApp) {
        ethOApp = _ethOApp;
    }

    
    function syncCollateral(address user, uint256 newCollateral) external onlyEthOApp {
        users[user].ethCollateral = newCollateral;
        users[user].isCollateralFresh = true;
        emit CollateralSync(user, newCollateral);
    }

    function availableToBorrow(address user) public view returns (uint256) {
        uint256 allowed = (users[user].ethCollateral * LTV) / 100;
        return allowed > users[user].debt ? allowed - users[user].debt : 0;
    }

    
    function borrow(uint256 amount) external {
        UserInfo storage u = users[msg.sender];
        if (u.ethCollateral == 0) revert KaraageLendingPool__NoCollateral();
        if (!u.isCollateralFresh) revert KaraageLendingPool__NotFresh();

        uint256 maxBorrow = availableToBorrow(msg.sender);
        if (amount > maxBorrow) revert KaraageLendingPool__ExceedsBorrowLimit();

        u.debt += amount;
        u.isCollateralFresh = false; 

        emit Borrow(msg.sender, amount);
    }

   
    function repay(uint256 amount) external payable {
        UserInfo storage u = users[msg.sender];
        require(amount > 0 && u.debt >= amount, "Invalid repay");
        u.debt -= amount;   
        emit Repay(msg.sender, amount);
    }
}
