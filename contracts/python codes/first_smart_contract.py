from os import access
from eth_utils import to_wei
from web3 import Web3

ganache_url = "HTTP://127.0.0.1:7545"

# this http provider will help web3 to communicate with ganache
web3 = Web3(Web3.HTTPProvider(ganache_url))

# accounts address in the ganache network
acount_1 = "0x891Ff07496C481598A0Ab93025b456568acc35BE"
acount_2 = "0xD77a0630e510dd944c9D8a18B408e857Aab0e5e2"

# the private key of those networks
private_key_acount_1 = "1097d1ee015638ad7f07a9b371418b5a8edc78b20ea04c2e7fa92f8cca52820e"
private_key_acount_2 = "1f25dceff9a056e58715095c313004d225872e8dccd8b8c1c8c9e32316dc0903"


# the nonce prevent you to execute the transaction twice
nonce = web3.eth.getTransactionCount(acount_1)

# here we build the transaction
tx = {
    'nonce': nonce,
    'to': acount_2,
    'value': web3.toWei(7, 'ether'),
    'gas': 2000000,
    'gasPrice': web3.toWei('50', 'gwei'),
}
 
# signed transaction
signed_tx = web3.eth.account.signTransaction(tx, private_key_acount_1)
# sending the transaction
tx_hash = web3.eth.sendRawTransaction(signed_tx.rawTransaction)
# printing the hex of transaction
print(web3.toHex(tx_hash))
