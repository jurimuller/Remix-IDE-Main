// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 < 0.9.0;
import "./SimpleStorage.sol";

contract StorageFactory is SimpleStorage { //brings in SimpleStorage functions/code

    //CALL-able: Holds contract addresses
    SimpleStorage[] public simpleStorageArray; 

    //TRANSACT FN: Populates array 
    function createSimpleStorageContract() public {
        SimpleStorage simpleStorageObject = new SimpleStorage(); //creates contract/object
        simpleStorageArray.push(simpleStorageObject); //push contract/object to array
    }

    //TRANSACT FN: Store a number to a contract (specified by index). Errors if no contract at index.
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        SimpleStorage simpleStorageObject = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])); //returns contract to interact w/
        simpleStorageObject.store(_simpleStorageNumber); //interact w/ contract

        //SIMPLIFIED:
        //SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber); 
    }

    //CALL FN: Return number stored in contract (specified by index)
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        SimpleStorage simpleStorageObject = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        return simpleStorageObject.retrieve();

        //SIMPLIFIED:
        //return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve(); 
    }
}
