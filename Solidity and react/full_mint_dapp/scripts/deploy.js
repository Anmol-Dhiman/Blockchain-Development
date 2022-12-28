const hre = require("hardhat");

async function main() {
  const RobotPunksNFT = await hre.ethers.getContractFactory("RobotPunksNFT");
  const robotPunskNFT = await RobotPunksNFT.deploy();

  await robotPunskNFT.deployed();
  console.log("robot punks contract address is " + robotPunskNFT.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
