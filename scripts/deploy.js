// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");
require('dotenv').config();

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  const lockedAmount = hre.ethers.utils.parseEther("1");

  const Lock = await hre.ethers.getContractFactory("Lock");
  const lock = await Lock.deploy(unlockTime, { value: lockedAmount });

  const IDragon = await hre.ethers.getContractFactory("IDragon");
  const iDragon = await IDragon.deploy();

  const IDragonFactory = await hre.ethers.getContractFactory("IDragonFactory");
  const iDragonFactory = await IDragonFactory.deploy();

  const IDragonCoin = await hre.ethers.getContractFactory("IDragonCoin");
  const iDragonCoin = await IDragonCoin.deploy();

  const Dragon = await hre.ethers.getContractFactory("Dragon");
  const dragon = await Dragon.deploy();

  const DragonFactory = await hre.ethers.getContractFactory("DragonFactory");
  const dragonFactory = await DragonFactory.deploy(iDragon.address);

  const DragonCoin = await hre.ethers.getContractFactory("DragonCoin");
  const dragonCoin = await DragonCoin.deploy();

  const DragonBattle = await hre.ethers.getContractFactory("DragonBattle");
  const dragonBattle = await DragonBattle.deploy(iDragonCoin.address, iDragon.address, iDragonFactory.address);

  await lock.deployed();

  console.log("Lock with 1 ETH deployed to:", lock.address);

  console.log("dragon factory deployed to:", dragonFactory.address);
  console.log("dragon deployed to:", dragon.address);
  console.log("dragon coin deployed to:", dragonCoin.address);
  console.log("dragon battle deployed to:", dragonBattle.address);
}
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

