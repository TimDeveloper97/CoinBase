// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  const [owner] = await hre.ethers.getSigners();

  console.log("owner address:>> ", owner.address);
  console.log("owner balance:>> ", (await owner.getBalance()).toString());

  //#region Deploy Upfi
  const Upfi = await hre.ethers.getContractFactory("Upfi", owner);

  const upfi = await Upfi.deploy();
  await upfi.deployed();

  console.log("Upfi address:>> ", upfi.address);
  //#endregion

  //#region Deploy Usdc
  const Usdc = await hre.ethers.getContractFactory("Usdc", owner);

  const usdc = await Usdc.deploy();
  await usdc.deployed();

  console.log("Usdc address:>> ", usdc.address);
  //#endregion

  //#region Deploy Btc
  const Btc = await hre.ethers.getContractFactory("Btc", owner);

  const btc = await Btc.deploy();
  await btc.deployed();

  console.log("Btc address:>> ", btc.address);
  //#endregion

  //#region Deploy Eth
  const Eth = await hre.ethers.getContractFactory("Eth", owner);

  const eth = await Eth.deploy();
  await eth.deployed();

  console.log("Eth address:>> ", eth.address);
  //#endregion

  //#region Deploy Upo
  const Upo = await hre.ethers.getContractFactory("Upo", owner);

  const upo = await Upo.deploy();
  await upo.deployed();

  console.log("Upo address:>> ", upo.address);
  //#endregion

  //#region Deploy Migrations
  const Migrations = await hre.ethers.getContractFactory("Migrations", owner);
  const migrations = await Migrations.deploy();
  await migrations.deployed();
  //#endregion
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
