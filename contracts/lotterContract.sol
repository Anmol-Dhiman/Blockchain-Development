// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Lottery{
    
 address public manager;

 address payable[] public players;
 

   constructor() {
    manager = msg.sender;}
 
  function enter() public payable {
    // we can pass some code in it and if it return ture then function will continue and if it return false then the function will terminate over here
// this will check weather the amount of eather sent by the player is > .01 or not and if it become false then the function will termiante over here only 
    require(msg.value > .01 ether);
    players.push(msg.sender);
    }

    function randomNumberGenerator() private view returns (uint) {
  // block and now(current time) is also a global variable as like the msg 
// this is a sudo random variable as it can be pridictable 

   return uint( keccak256(abi.encode(block.difficulty ,block.timestamp,  players))); }
  

  
   function winner() public onlyManagerCanPickWinner {

        
       uint index = randomNumberGenerator() % players.length;
    // this refer to the current contract 
        players[index].transfer(address(this).balance);

        // now we reset the contract

        // this (0) means that the dynamic array will created with initial length of 0
        players = new address[](0);
   }


// this will work as a function for the require statement 
   modifier onlyManagerCanPickWinner(){

       require(msg.sender == manager);
    //    this _; means that wherever we use this modifier, that function's code will execute after require statement 
       _;


// this is how it look like internally
    // require(msg.sender == manager);
    //    uint index = randomNumberGenerator() % players.length;
    // // this refer to the current contract 
    //     players[index].transfer(address(this).balance);

    //     // now we reset the contract

    //     // this (0) means that the dynamic array will created with initial length of 0
    //     players = new address[](0);
   }


}