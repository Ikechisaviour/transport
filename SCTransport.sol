// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract FleetManagement{
    address constant blankAddress = 0x0000000000000000000000000000000000000000;    
    string  constant blankDestination = "";    

   
    struct fleet{
        string name;
        string location;
        string setDestination;
        bool terminated;
        bool registered;
        uint lastUpdated;
        uint condition;
        address customer;
        bool approvedByCustomer;
        uint driver;
        uint good;
    }

    struct user{
        address who;
        bool registered;
        string permission;

    }

    mapping (string => fleet) fleets;
    mapping (address => user) users;

    uint storedData;

    function registerUser(
        address _user, 
        string memory _permission
        )external  {
        users[_user].who = _user;
        users[_user].registered = true;
        users[_user].permission = _permission;

    } 

/// @notice This function will register a recipient

    function registerFleet(
        string memory _name
        
    )external  {
        fleets[_name].name = _name;
        fleets[_name].registered = true;


    }

    function dispatchRegistration(
        string memory _name,
        string memory _location,
        uint _driver, 
        uint _goods, 
        string memory _setDestination,
        address _customer
        ) public {   
        fleets[_name].location = _location;
        fleets[_name].driver = _driver;
        fleets[_name].good = _goods;
        fleets[_name].setDestination = _setDestination;
        fleets[_name].customer = _customer;
        fleets[_name].lastUpdated = block.timestamp;
    }

    function updateLocation(
        string memory _name,
        string memory _location
    )external {
        fleets[_name].location = _location;
        fleets[_name].lastUpdated = block.timestamp;
    }

    function updateCondition(string memory _name, uint _condition)external {
        fleets[_name].condition = _condition;
    }
    
    function terminateFleet(string memory _name)external {
        fleets[_name].terminated = true;
    }

    function customerApproval(string memory _name, string memory _setDestination)external {
        if(keccak256(abi.encodePacked(fleets[_name].setDestination)) == keccak256(abi.encodePacked(_setDestination))){
            fleets[_name].approvedByCustomer = true;
        }        
    }

    function deliveryCompleted(string memory _name) external {
        fleets[_name].setDestination = blankDestination;
        fleets[_name].customer = blankAddress;
        fleets[_name].approvedByCustomer = false;
    }
    
    // function approvalCondition()public {}
    function viewDriver(string memory _name) external view returns(uint) {
        return fleets[_name].driver;
    }

    function viewFleet(string memory _name)external view returns(
        string memory, string memory, address, uint, uint 
    ){
        return (fleets[_name].location, 
        fleets[_name].setDestination,
        fleets[_name].customer,
        fleets[_name].driver,
        fleets[_name].good);
    }

    function viewUser(address _user)external view returns(address, string memory){
        return (users[_user].who, users[_user].permission);
    }

}
