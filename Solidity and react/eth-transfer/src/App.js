
import { useEffect, useInsertionEffect, useSyncExternalStore } from 'react';
import './App.css';

function App() {

  // as we have metamask in browser then we have access to window.etherum 
  // and to window.web3
  // these two library are injected by the metamask into website
  //  this api aloows website to request useSyncExternalStore, accounts, read data to blockchain, 
  //  sign messages and transactions



  useEffect(() => {
    const loadProvider = async () => {
      console.log(window.web3)
      console.log(window.etherum)
    }
    loadProvider()
  }, [])
  // these empty square brackets means that this will run only one in App




  return (
    <>
      <div className='parent'>
        <div className='child-code'>
          <div className='balance-view is-size-2'>
            Current Balance : <strong>10 </strong>ETH
          </div>
          <button className='btn mr-2'
            onClick={async () => {
              const accounts = await window.ethereum.request({ method: "eth_requestAccounts" })
              console.log(accounts)
            }
            }>Enable Etherum</button>
          <button className='dontae-button mr-2'>Donate</button>
          <button className='withdraw-button mr-2'>Withdraw</button>
        </div>
      </div>
    </>
  );
}

export default App;
