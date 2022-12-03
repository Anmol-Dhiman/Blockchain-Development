// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


// if a contract does not have any payable function then we can send ether to that contract by using the 
// selfdestruct() of any other contract 

contract Attacker{
    function kill(address payable _contractAddress) external {
        // this function will remove this contracts data from blockchain and set the 
        // address of this contract as 0x0000...
        selfdestruct(_contractAddress);
    }
}
