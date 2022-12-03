// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// basically this is  type of smart contract where we can store our ether and then
// withdraw after some time
// eg compound protocol

contract FundStorage {
    mapping(address => uint) public balances;
    bool internal locked;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0);

        // as this method send the ether to attackers contract and when the attacker receives the ether
        // then again he calls the withdraw() and still the attacker balance in not zero so this will form a recursive transaction

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        balances[msg.sender] = 0;
    }

    // PREVENTION : -
    // update the balance of user before sending him ether
    // or
    // user this modifier technique : - prevent next transaction to happen by locking the previous transaction
    modifier noReentrant() {
        require(!locked, "No re-entrancy");
        locked = true;
        _;
        locked = false;
    }

    function withdraw3() public {
        uint bal = balances[msg.sender];
        require(bal > 0);

        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");
    }

    // this will be costly as we are adding 1 more state variable and we are changing the state of that variable
    // on every transaction
    // on failure it will reutnr "Failed to send Ether"
    function withdraw2() public noReentrant {
        withdraw();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
