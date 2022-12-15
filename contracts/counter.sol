// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter{

uint private count =0 ;

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

  
    function getCount() view public returns (uint){
        return count;
    }
}