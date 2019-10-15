pragma solidity ^0.5.1;

//This construction is similar to classes in C++ where the DogContract above is the ddeclared
//class, with relevant functions inside, and the first call in the ExternalContract is the
//variable object defining/pointing to the contract with all the functions we need. Watch 
//Bucky's C++ tutorial 12 - https://youtu.be/ABRP_5RYhqU - for details.

contract DogContract{
    
    function addDog(string memory _name, uint _age) public payable returns (uint);

    function getBalance() public view returns (uint);
}

contract ExternalContract{
    
    DogContract dcInstance = DogContract(0xCac3f0403895fAdAE1c5Cb2F9cB5fB0FbDa62a37);
    
    function addExternalDog(string memory _name, uint _age) public payable returns (uint){
        return dcInstance.addDog.value(msg.value)(_name, _age);
    }
    
    function getExternalBalance() public view returns (uint){
        return dcInstance.getBalance();
    }
}
