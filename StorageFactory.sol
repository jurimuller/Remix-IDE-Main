// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 < 0.9.0;
import "./SimpleStorage.sol";

contract StorageFactory is SimpleStorage { //brings in SimpleStorage functions/code

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorageObject = new SimpleStorage(); //create object
        simpleStorageArray.push(simpleStorageObject); //push object to array
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        SimpleStorage simpleStorageObject = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])); //returns contract to interact w/
        simpleStorageObject.store(_simpleStorageNumber); //interact w/ contract

        //SIMPLIFIED:
        //SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber); 
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        SimpleStorage simpleStorageObject = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        return simpleStorageObject.retrieve();

        //SIMPLIFIED:
        //return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve(); 
    }
}
