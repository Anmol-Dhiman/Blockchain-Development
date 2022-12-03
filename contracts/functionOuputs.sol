// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Outputs {
    // 21543
    function simpleReturn() public pure returns (uint, bool) {
        return (1, true);
    }

    // 21521
    function nameReturn() public pure returns (uint x, bool b) {
        return (1, true);
    }
f
    // 21499
    function valueReturn() public pure returns (uint x, bool b) {
        x = 1;
        b = true;
    }

    // 21734
    // how to get the value of these methods which return multiple values
    function destructuringAssignment()
        external
        pure
        returns (
            uint a,
            bool b,
            bool c
        )
    {
        (a, b) = valueReturn();
        (, c) = nameReturn();
    }
}
