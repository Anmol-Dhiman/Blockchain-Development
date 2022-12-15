// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint private count;

    event changed(uint num);

    function increment() public {
        require(count + 1 > count, "count overflow");
        count++;
        emit changed(count);
    }

    function decrement() public {
        require(count > 0, "count underflow");
        count--;
        emit changed(count);
    }

    function getCount() public view returns (uint) {
        return count;
    }
}
