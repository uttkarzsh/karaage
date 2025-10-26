// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Oracle} from "./Oracle.sol";
import {IVerifier} from "./Verifier.sol";
import { OApp, Origin, MessagingFee } from "@layerzerolabs/oapp-evm/contracts/oapp/OApp.sol";
import { OAppOptionsType3 } from "@layerzerolabs/oapp-evm/contracts/oapp/libs/OAppOptionsType3.sol";

contract KaraageLendingPool {
    IVerifier verifier;

    struct UserInfo {
        uint256 ethCollateral;
        uint256 debt;
        bool isCollateralFresh;
    }

    constructor(address _endpoint, address _owner, address _ethOApp, IVerifier _verifier) OApp(_endpoint, _owner) Ownable(_owner) {
        ethOApp = _ethOApp;
        verifier = IVerifier(_verifier);
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
    error KaraageLendingPool__ProofInvalid();

    modifier onlyEthOApp() {
        if (msg.sender != ethOApp) revert KaraageLendingPool__NotAuthorized();
        _;
    }
    
    function syncCollateral(address user, uint256 newCollateral, bytes calldata _proof, bytes32[] calldata _publicInputs) external onlyEthOApp {
        if(!verifier.verify(_proof, _publicInputs)) {
            revert KaraageLendingPool__ProofInvalid();
        }
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

    function _lzReceive(
        Origin calldata /*_origin*/,
        bytes32 /*_guid*/,
        bytes calldata _message,
        address /*_executor*/,
        bytes calldata /*_extraData*/
    ) internal override {

        string memory _string = abi.decode(_message, (string));

        lastMessage = _string;
    }
}
