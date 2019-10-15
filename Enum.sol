pragma solidity ^0.5.1;

contract MyContract{
    enum State {Waiting, Ready, Active}
    State public state = State.Waiting; //More concise alternative than using a constructor to set the default state
    
    function activate() public {
        state = State.Active;
    }
    
    function checkState() public view returns (bool) {
        return state == State.Active;
    }
}  
