import "./App.css";
import { useState } from "react";
import MainMint from "./MainMint";
import NavBar from "./NavBar";

// constract address : - 0x5FbDB2315678afecb367f032d93F642f64180aa3

function App() {
  const [accounts, setAccounts] = useState([]);

  return (
    <div className="overlay">
      <div className="App">
        <NavBar accounts={accounts} setAccounts={setAccounts}></NavBar>
        <MainMint accounts={accounts} setAccounts={setAccounts}></MainMint>
      </div>
      <div className="moving-background"></div>
    </div>
  );
}

export default App;
