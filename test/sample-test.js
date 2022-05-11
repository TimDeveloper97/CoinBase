const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Mint", async function () {
  it("USDC + Token(Upo, Btc, Eth, Rose) => Upfi (success)", async function () {

    //#region Deploy Upfi
    const Upfi = await ethers.getContractFactory("Upfi");

    const upfi = await Upfi.deploy();
    await upfi.deployed();

    console.log("Upfi address:>> ", upfi.address);
    //#endregion

    //#region Deploy Usdc
    const Usdc = await ethers.getContractFactory("Usdc");

    const usdc = await Usdc.deploy();
    await usdc.deployed();

    console.log("Usdc address:>> ", usdc.address);
    //#endregion

    //#region Deploy Upo
    const Upo = await ethers.getContractFactory("Upo");

    const upo = await Upo.deploy();
    await upo.deployed();

    console.log("Upo address:>> ", upo.address);
    //#endregion

    //#region Deploy Migrations
    const Migrations = await ethers.getContractFactory("Migrations");

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
