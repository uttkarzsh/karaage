//SPDX-License-Idntifier: MIT
pragma solidity ^0.8.24;

import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract Oracle{
    AggregatorV3Interface public dataFeed;

    constructor(address priceFeed){
        dataFeed = AggregatorV3Interface(priceFeed);
    }

    function getPrice() public view returns(int256){
        (,int256 price,,,) = dataFeed.latestRoundData();
        return price;
    }
}