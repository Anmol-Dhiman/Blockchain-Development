// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// FRONT RUNNING : -
// suppose user A make a transaction and the transaction in the transaction pool
// and other user B can see the transaction and with this that user create a new transaction
// with a higher gas price, now the priority will be given to user B's transaction
// and user B will get the benefit instead of A as user B can see the transaction of user A

// PREVENTION : - avoid transaction based incentives

// this contract is vulnerable to front running
// situation : -
// here if user A get the solution and his transaction is in transaction pool and now user B
// can see A's solution and make another transaction with high gas fee, then B will
// get the benefit instead of A
contract hackMe {
    bytes32 public hash =
        0xc3371313d9262277c85574cf51df0fc24f49e01798c85e409d0ab7bebfeeb44a;

    constructor() public payable {}

    function withdraw(string memory _solution) public {
        require(
            hash == keccak256(abi.encodePacked(_solution)),
            "incorrect solution!!"
        );

        (bool send, ) = msg.sender.call{value: address(this).balance}("");
        require(send, "failed to send the ether");
    }
}
