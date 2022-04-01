// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 < 0.9.0;

contract SimpleStorage {
//--------------------------------------------------------------------------------
//Store a number, retrieve number 

    uint256 favoriteNumber; //initializes to null value --> 0 for uint256

    //TRANSACT FN: STORE | public | editable | 1 input | 0 outputs
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    //CALL FN: RETRIEVE |public | view | 0 inputs | 1 output
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

//----------------------------------------------------------------------------------
//Store a number + name pair, return paired name given a number or return pair by index
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public peopleArray; //creates array, peopleArray, of type "People"
    
    //MAPPING CALL: [in ~string~] = out ~uint256~
    mapping(string => uint256) public nameToFavoriteNumber;

    //TRANSACT FN: ADDPERSON | public | editable | 2 inputs (1 to memory) | 0 outputs
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        peopleArray.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

//----------------------------------------------------------------------------------
}
