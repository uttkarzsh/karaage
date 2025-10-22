//SPDX-License-Idntifier: MIT
pragma solidity ^0.8.24;

import { IPyth, PythStructs } from "@pythnetwork/pyth-sdk-solidity/IPyth.sol";

contract PythOracle{
    IPyth pyth;

    constructor() {
        address  hederaAddress = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        pyth = IPyth(hederaAddress); 
    }

    function getPrice() public view returns(PythStructs.Price memory){
        bytes32 priceFeedId = 0xff61491a931112ddf1bd8147cd1b641375f79f5825126d665480874634fd0ace;
        PythStructs.Price memory price = pyth.getPriceNoOlderThan(priceFeedId, 60);
        return price;
    }
}