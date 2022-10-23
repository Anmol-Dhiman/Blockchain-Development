// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Counter{

uint private count;

event incrementing(uint num);
event decrementing(uint num);

function increment() public{
    count++;    
    emit incrementing(count);

}
 function decrement() public{
     count--;
     emit decrementing(count);
 }

// constructor
    constructor() {
        count =0;
    }


    function getCount() view public returns (uint){
        return count;
    }
}