//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { OApp, Origin, MessagingFee } from "@layerzerolabs/oapp-evm/contracts/oapp/OApp.sol";
import { OAppOptionsType3 } from "@layerzerolabs/oapp-evm/contracts/oapp/libs/OAppOptionsType3.sol";

contract CollateralVault{
    mapping(address=>uint256) public lockedCollateral;
    mapping(address=>uint256) public unlockedCollateral;

    constructor(address _endpoint, address _owner) OApp(_endpoint, _owner) Ownable(_owner) {}

    error CollateralVault__CollateralIsLocked();
    error CollateralVault__TransferFailed();

    function lockCollateral() external payable{
        lockedCollateral[msg.sender] += msg.value;
        bytes memory message = abi.encode(msg.value, msg.sender);

        _lzSend(
            _dstEid,
            _message,
            combineOptions(_dstEid, SEND, _options),
            MessagingFee(msg.value, 0),
            payable(msg.sender)
        );
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