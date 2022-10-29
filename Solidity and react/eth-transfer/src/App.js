
import { Profiler, useEffect, useState } from 'react';
import './App.css';
import Web3 from 'web3';



function App() {

  // as we have metamask in browser then we have access to window.etherum 
  // and to window.web3
  // these two library are injected by the metamask into website
  //  this api aloows website to request useSyncExternalStore, accounts, read data to blockchain, 
  //  sign messages and transactions


  // this is the state variable just like the compose state 
  const [web3Api, setWeb3Api] = useState({
    provider: null,
    web3: null
  })

  const [account, setAccount] = useState(
    null
  )


  useEffect(() => {
    const loadProvider = async () => {

      let provider = null;
      if (window.ethereum) {
        provider = window.ethereum
        try {
          await provider.request({method:"eth_requestAccounts"});
        } catch (error) {
          console.log(error)
        }
      } else if (window.web3) {
        provider = window.web3.currentProvider

      } else if (!process.env.production) {
        provider = new Web3.providers.HttpProvider("http://localhost:7545")
      }

      setWeb3Api({
        web3: new Web3(provider),
        provider
      })

    }
    loadProvider()
  }, [])
  // these empty square brackets means that this will run only one in App
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
          <span>
            <strong>Account : </strong><h1>
              {account ? account : "not connected"}
            </h1>
          </span>

          <div className='balance-view is-size-2'>
            Current Balance :
            <strong>10 </strong>
            ETH
          </div>
          <button className='dontae-button mr-2'>Donate</button>
          <button className='withdraw-button mr-2'>Withdraw</button>
        </div>
      </div>
    </>
  );
}

export default App;
