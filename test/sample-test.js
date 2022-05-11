const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Mint", function () {
  it("USDC + Token(Upo, Btc, Eth, Rose) => Upfi (success)", async function () {

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

    console.log("Migrations address:>> ", migrations.address);
    //#endregion

    expect(await upo.MAX_TOTAL_SUPPLY).to.equal(1000);
    expect(await usdc.TOTAL_SUPPLY).to.equal(1000);
    expect(await upfi.TOTAL_SUPPLY).to.equal(0);

    console.log("upo.MAX_TOTAL_SUPPLY:>> ", upo.MAX_TOTAL_SUPPLY);
    console.log("usdc.TOTAL_SUPPLY:>> ", usdc.TOTAL_SUPPLY);
    console.log("upfi.TOTAL_SUPPLY:>> ", upfi.TOTAL_SUPPLY);

    const mint = await migrations.mint(usdc.address, upo.address, "Upo", upfi.address, 20);
    await mint.wait();

    console.log("upo.MAX_TOTAL_SUPPLY:>> ", upo.MAX_TOTAL_SUPPLY);
    console.log("usdc.TOTAL_SUPPLY:>> ", usdc.TOTAL_SUPPLY);
    console.log("upfi.TOTAL_SUPPLY:>> ", upfi.TOTAL_SUPPLY);
  });
});
