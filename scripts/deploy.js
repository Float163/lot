// deploy contract
const hre = require("hardhat");
const ethers = hre.ethers;

async function main() {
  //await hre.run('compile');
  const [signer] = await ethers.getSigners();

  // We get the contract to deploy
  const Lot = await ethers.getContractFactory("Lot", signer);
  const lot = await Lot.deploy();

  await lot.deployed();

  console.log(`Lot deployed to:${lot.address} from ${signer.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
