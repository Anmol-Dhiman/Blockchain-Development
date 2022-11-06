// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// this ^ sign means that we want to use solidity version of 0.8.0 and above

// we can check the error by three ways: -
// require(), revert(), assert()
// if the result is false and we get the error then we get the
// refund of  left out gas fee
// and the value of changed state variable reverted

contract error {
    // 21964
    // when we are not reading or writing in state variable, at that point of time we use pure
    // and when we read the state variable then only we use view keyword
    function testRequire(uint i) public pure {
        // we can use our custom error messages to save the gas fee
        // as the string of error message increase the gas fee increase
        require(i > 10, "i < 10");
    }

    // 21901
    function testRevert(uint i) public pure {
        if (i < 10) {
            revert("i < 10");
        }
    }

    uint num = 100;

    // if we get the assert error then we have a bug in smart contract
    function testAssert() public view {
        assert(num == 100);
    }

    function temp() external {
        num += 1;
    }

    error myError(uint i);

    // 21868
    function testCustomError(uint i) public pure {
        if (i < 10) {
            revert myError(i);
        }
    }
}
