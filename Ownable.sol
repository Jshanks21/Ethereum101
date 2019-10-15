pragma solidity ^0.5.1;

contract Ownable{
    
    address public owner;

    event NewOwner(address indexed newOwner);
    
    modifier onlyOwner(){
    require(owner == msg.sender);
    _;
    }
    
    constructor() public {
        owner = msg.sender;
    }
    
    function transferOwnership(address _newOwner) public onlyOwner returns (string memory) {
        owner = _newOwner;
        emit NewOwner(msg.sender);
        return string("Transfer Complete");
    }
}
