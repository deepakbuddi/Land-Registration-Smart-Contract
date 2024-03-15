// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract LandRegistration{

    struct Details{
        string name;
        string location;
        address landOwner;
        uint price;
    }

    address public Owner;

    mapping (address => uint) public bal;
    mapping (uint => Details) public lands;
    mapping(uint => bool) public check;

    constructor (){
        Owner = msg.sender;
    }

    modifier OnlyOwner(){
        require(Owner == msg.sender, "Your not the owner");
        _;
    }

    function addLand(uint _SurNum, uint _price, string memory _name, string memory _location, address _landOwner) public {
        lands[_SurNum] = Details({
            name: _name,
            location: _location,
            landOwner: _landOwner,
            price: _price
        });
        check[_SurNum] = true;
    }


    function addBalance(address _SurNum, uint _amt) public{
        bal[_SurNum] += _amt;
    }

    function transferLand(uint _SurNum, string memory _name, uint _price, address _from, address _to) public {
        require(check[_SurNum],"Survey Number doesn't exist");

        require(bal[_to]  >= _price, "Sorry no sufficient amt");

        bal[_to] -= _price;
        bal[_from] += _price;
        lands[_SurNum].name = _name;
        lands[_SurNum].landOwner = _to;
        Owner = _to;
    }

}