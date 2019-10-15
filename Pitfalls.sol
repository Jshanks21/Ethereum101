pragma solidity ^0.4.0;

//Short list of common pitfalls in Solididty Smart Contract code.
//See documentation for details at: https://solidity.readthedocs.io/en/v0.4.0/security-considerations.html#pitfalls

//Re-Entrancy Example

contract Fund{
    //mapping of Eth shares from the contract to an address.
    mapping(address => uint) shares;
    /*A withdraw shares function, but an external contract can keep calling it to withdraw
    funds before the function can set the withdrawal allowance to 0, wiping all funds
    in the contract. */
    function withdraw() public {
        if (msg.sender.send(shares[msg.sender])) //This is the interaction.
            shares[msg.sender] = 0; //This is the effect. They should be reversed.
    }
}

/*Solution - Follow proper Development Pattern:

CHECKS-EFFECTS-INTERACTIONS

1. Check states and confirm changes in states first. 
2. Create functions that enact the desired effects (e.g. function withdraw()).
3. Enable interactions between this and external contracts.
*/

//Previous example corrected

pragma solidity ^0.4.0;

contract CorrectedFund {
    /// Mapping of ether shares of the contract.
    mapping(address => uint) shares;
    /// Withdraw your share.
    function withdraw() {
        var share = shares[msg.sender]; 
        shares[msg.sender] = 0; //Enacts effects of function withdraw()
        if (!msg.sender.send(share)) //Interacts after effects of the function are initiated.
            throw;
    }
}

/*MAKE SURE LOOPS REQUIRE A FIXED NUMBER OF ITERATIONS.
This is in order to avoid overspending GAS. Otherwise, thecontract might run out of GAS 
midway through calling it, which would cause errors and leave the current state 
of the contract unknown.
*/

/*NEVER USE TX.ORIGIN FOR AUTH - USE MSG.sender
Otherwise, someone could create a proxy contract to act as a "middleman", which would
result in it being the tx.origin and thus recieve the funds instead of the original 
caller. */

/*ALWAYS INCLUDE A FAIL SAFE MODE
Include routine checks and balances in your contract to make sure everything adds up 
correctly. If the checks fail, you can enter a "lockdown mode" with your fail safe to
identify the error. */
