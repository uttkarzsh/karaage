//SPDX-License-Idntifier: MIT
pragma solidity ^0.8.24;

import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract Oracle{
    AggregatorV3Interface public dataFeed;

    constructor(){
        dataFeed = AggregatorV3Interface(0xb9d461e0b962aF219866aDfA7DD19C52bB9871b9);
    }

    function getPrice() public view returns(int256){
        (,int256 price,,,) = dataFeed.latestRoundData();
        return price;
    }
}