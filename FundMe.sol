// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6 <0.9.0;

// Get the latest ETH/USD price from chainlink price feed
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe {
//Let anyone deposit ETH into contract, but only owner of contract can withdraw
//NOTE: Must deploy on real test net to interact with contract

    using SafeMathChainlink for uint256; //safe math library to handle integer overflows
    address[] public funders; //contains funder addresses
    address public owner; //address of contract deployer, ~owner~

    //MAPPING CALL
    mapping(address => uint256) public addressToAmountFunded;

    constructor() public { //execute on deploy
        owner = msg.sender; 
    }

    //PAYABLE FN: Inputted through Remix 
    function fund() public payable {
        uint256 minimumUSD = 50 * 10 ** 18; //$50
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value; //Stored in WEI units
        funders.push(msg.sender);
    }

    //CALL FN: Get the version of the chainlink pricefeed
    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e); //address which contract is located
        return priceFeed.version(); //.version() is FN in AggV3Interface.sol
    }
    
    //CALL FN: Get price 18 digits
    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,) = priceFeed.latestRoundData(); //only need 1 output
        return uint256(answer * 10000000000); // ETH/USD rate in 18 digit 
    }

    //CALL FN: Get actual price in USD
   function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }

    // ------------------------------------------------------------------------------------------------------------------
    //MODIFIER (onlyOwner): Is the message sender owner of the contract?
    modifier onlyOwner {
        require(msg.sender == owner); 
        _; 
    }

    //PAYABLE FN
    function withdraw() payable onlyOwner public {
        //onlyOwner modifier condition must be met to continue on in FN

        msg.sender.transfer(address(this).balance);
        //IF using v0.8 of aggInterface --> payable(msg.sender).transfer(address(this).balance);
            
        //iterate through all the mappings and make them 0 since all the deposited amount has been withdrawn
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){ //through size of funders[]
            address funderAddress = funders[funderIndex]; 
            addressToAmountFunded[funderAddress] = 0; //reset all funders to 0
        }
        //clearing funders array
        funders = new address[](0);
    }


}
