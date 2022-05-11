require("@nomiclabs/hardhat-waffle");
// require("dotenv").config({ path: __dirname + "/./../../.env" });

const mnemonic =
  'wrist deer lumber program crop sugar section jaguar lab repair mutual demise dutch cradle brand margin minor happy cinnamon cube wish edit monitor amazing';

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks: {
    emerald_local: {
      url: "http://localhost:8545",
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    emerald_testnet: {
      chainId: 42261,
      url: "https://testnet.emerald.oasis.dev",
      gas: 1000000,
      gasPrice: 100000000000,
      accounts: { mnemonic: mnemonic }
    },
    emerald_mainnet: {
      url: "https://emerald.oasis.dev",
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
  },
  // paths: {
  //   sources: "./contracts",
  //   tests: "./test",
  //   cache: "./cache",
  //   artifacts: "./artifacts"
  // },
  mocha: {
    timeout: 60000
  }
};
