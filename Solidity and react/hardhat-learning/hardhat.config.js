require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */

const rinkeby_url = process.env.RINKEBY_RPC_URL;
const private_key = process.env.PRIVATE_KEY;

module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    rinkeby: {
      url: rinkeby_url,
      accounts: [private_key],
      chainId: 4,
    },
  },
  solidity: "0.8.17",
};
