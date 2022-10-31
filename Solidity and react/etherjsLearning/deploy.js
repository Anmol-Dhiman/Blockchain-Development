// async keyword is used to specity that the method is going to be
// executed in async manner and the awiat keyword in async function
// specify that we have to wait for this function to before moving on second function

const ethers = require("ethers");
const fs = require("fs-extra");
async function main() {
  // http://127.0.0.1:7545

  //   this is how we connect to local blockchain
  const provider = new ethers.providers.JsonRpcBatchProvider(
    "http://127.0.0.1:7545"
  );

  const wallet = new ethers.Wallet(
    "6fe8e3a03dea20a22f327c7cf63c0832eeca634f95d67c83958e515514c191af",
    provider
  );

  const abi = fs.readFileSync("./counter_sol_counter.abi", "utf-8");
  const binary = fs.readFileSync("./counter_sol_counter.bin", "utf-8");

  const contractFractory = new ethers.ContractFactory(abi, binary, wallet);

  console.log("Delploying contact wait....");
  const contract = await contractFractory.deploy();
  console.log(contract);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
