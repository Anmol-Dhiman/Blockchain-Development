import "./App.css";
import counter from "./artificats/contracts/Counter.sol/Counter.json";
import { ethers } from "hardhat";
import { useState } from "react";

function App() {
  const counterContractAddress = "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0";
  const [count, setCountValue] = useState("");
  // request to accesss the user metamask account
  async function requestAccount() {
    // window is eject provider in the browser by the metamask
    await window.ethereum.request({ methods: "eth_requestAccounts" });
  }

  // TODO here we have to set the provider and then we get the insatnce of a contract
  // and observe them

  async function increment() {
    // metamask exists
    if (window.ethereum !== "undefined") {
      await requestAccount();
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const counterContract = new ethers.Contract(
        counterContractAddress,
        counter.abi,
        provider
      );

      /*function increment() public {
          require(count + 1 > count, "count overflow");
          count++;
          emit changed(count);
      }
   */
      try {
        await counterContract.increment();
        counterContract.changed;
      } catch (error) {
        console.log(error);
      }
    }
  }

  async function decrement() {
    // metamask exists
    if (window.ethereum !== "undefined") {
      await requestAccount();
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const counterContract = new ethers.Contract(
        counterContractAddress,
        counter.abi,
        provider
      );

      /*function increment() public {
        require(count + 1 > count, "count overflow");
        count++;
        emit changed(count);
    }
 */
      try {
        await counterContract.decrement();
        counterContract.on("changed", (count) => {
          setCountValue(count);
        });
      } catch (error) {
        console.log(error);
      }
    }
  }

  return (
    <div className="App">
      <div>
        <h1>{count}</h1>
        <button
          onClick={increment}
          type="button"
          class="btn btn-success button-margin"
        >
          Increment
        </button>
        <button
          onClick={decrement}
          type="button"
          class="btn btn-danger button-margin"
        >
          Decrement
        </button>
      </div>
    </div>
  );
}

export default App;
