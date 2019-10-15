pragma solidity >=0.4.0 <0.7.0;

contract MyContract {
    uint256 public peopleCount = 0;
    mapping(uint => Person) public people;
    
    uint256 openingTime = 1570634174;

    modifier onlyWhileOpen() {
        require(block.timestamp >= openingTime); //The time stampe of the current block compared to set epoch time
        _;
    }
    
    struct Person {
        uint _id;
        string _firstName;
        string _lastName;
    }
    
    function addPerson(string memory _firstName, string memory _lastName) public onlyWhileOpen {
        incrementCount();
        people[peopleCount] = Person(peopleCount, _firstName, _lastName);
    }
    
    function incrementCount() internal {
        peopleCount += 1;
    }
}
