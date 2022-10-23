# here i have make the contract in sol

# this is the basic hello world contract
# pragma solidity ^0.4.21;

# contract greeter {
#     string public greeting;


#     constructor() public {
#         greeting =  'sherlockVARM';
#     }

#    function setgreeting(string _greeting) public{
#     greeting= _greeting;
#    }


#     function greet() view public returns (string){
#     return greeting;

#     }
# }
import json
from web3 import Web3


ganache_url = "HTTP://127.0.0.1:7545"
web3 = Web3(Web3.HTTPProvider(ganache_url))

abi = json.loads('[{"constant":false,"inputs":[{"name":"_greeting","type":"string"}],"name":"setgreeting","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"greet","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"greeting","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]')
address = "0xd9145CCE52D386f254917e481eB44e9943F39138"


print(web3.isConnected())

contract = web3.eth.contract(address= address, abi= abi)

print(contract.methods.greet().call())
  
contract.methods.setgreeting("hello world").transact()
