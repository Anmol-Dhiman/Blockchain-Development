// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// how this works: -
// first we have to deploye our malicious contract and then we have to deploye our MainContract,
// with passing the address of malicious contract inside the MainContract

// PREVENTION : -
// read the code base and don't trust the contract which use the external address of contract

// on etherscan we can upload the code to verify the contract
contract Bar {
    event log(string text);

    function logs() public {
        emit log(("here in the bar's log function"));
    }
}

contract MainContract {
    // external address contract which is not trustable
    Bar bar;

    constructor(address _bar) public {
        bar = Bar(_bar);
    }

    function calling() public {
        bar.logs();
    }
}

contract maliciousCode {
    event log(string text);

    // write the same function decelration here for writing the malicious code
    function logs() public {
        emit log("here in the mal's log function");
    }
}
