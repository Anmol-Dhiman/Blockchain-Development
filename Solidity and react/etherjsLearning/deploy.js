// async keyword is used to specity that the method is going to be
// executed in async manner and the awiat keyword in async function
// specify that we have to wait for this function to before moving on second function

const ethers = require("ethers");
const fs = require("fs-extra");
require("dotenv").config();

async function main() {
  // http://127.0.0.1:7545

  //   this is how we connect to local blockchain
  const provider = new ethers.providers.JsonRpcBatchProvider(
    process.env.RPC_URL
  );

  console.log(process.env.PRIVATE_KEY);
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
  const abi = fs.readFileSync("./counter_sol_counter.abi", "utf-8");
  const binary = fs.readFileSync("./counter_sol_counter.bin", "utf-8");

  const contractFractory = new ethers.ContractFactory(abi, binary, wallet);

  console.log("Delploying contact wait....");
  const contract = await contractFractory.deploy();
  //   console.log(contract);

  await contract.increment();

  const count = await contract.getCount();
  console.log(count.toString());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
