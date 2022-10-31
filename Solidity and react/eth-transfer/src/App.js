
import { useEffect, useState } from 'react';
import './App.css';
import Web3 from 'web3';
import detectEthereumProvider from '@metamask/detect-provider'
import { loadContract } from "./utils/load-contract";

function App() {

  // as we have metamask in browser then we have access to window.etherum 
  // and to window.web3
  // these two library are injected by the metamask into website
  //  this api aloows website to request useSyncExternalStore, accounts, read data to blockchain, 
  //  sign messages and transactions


  // this is the state variable just like the compose state 
  const [web3Api, setWeb3Api] = useState({
    provider: null,
    web3: null,
    contract: null
  })

  const [account, setAccount] = useState(
    null
  )
  const [balance, setBalance] = useState(null)


  useEffect(() => {
    const loadProvider = async () => {

      const provider = await detectEthereumProvider();
      const contract = await loadContract("Faucet", provider)

      if (provider) {


        setWeb3Api({
          web3: new Web3(provider),
          provider,
          contract
        })
      } else {
        console.error('Please install MetaMask!');
      }

    }
    loadProvider()
  }, [])
  // these empty square brackets means that this will run only one in App

  useEffect(() => {
    const loadBalance = async () => {
      const { contract, web3 } = web3Api
      const balance = await web3.eth.getBalance(contract.address)
      setBalance(web3.utils.fromWei(balance, "ether"))
    }
    web3Api.contract && loadBalance()
  }, [web3Api])


  useEffect(() => {

    const getAccount = async () => {
      const accounts = await web3Api.web3.eth.getAccounts()
      setAccount(accounts[0])
    }
    web3Api.web3 && getAccount()
    // this function will get executed only when the web3Api initalized
    // this useEffect will executed after setWeb3Api function 
  }, [web3Api.web3])

  return (
    <>
      <div className='parent'>
        <div className='child-code'>
          <div className='is-flex is-align-items-center'>
            <span>
              <strong className='mr-2'>Account: </strong>
            </span>
            <div>
              {account ?
                <div>{account}</div> :
                <button className='button is-small'
                  onClick={() =>
                    web3Api.provider.request({
                      method: "eth_requestAccounts"
                    })}>
                  Connect Wallet
                </button>
              }
            </div>
          </div>
          <div className='balance-view is-size-2 my-4'>
            Current Balance :
            <strong> {balance} </strong>
            ETH
          </div>
          <button className='button is-primary   mr-2'>Donate</button>
          <button className='button is-link   mr-2'>Withdraw</button>
        </div>
      </div>
    </>
  );
}

export default App;
