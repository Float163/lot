
//require("@nomiclabs/hardhat-web3");
const art = require('../artifacts/contracts/Lot.sol/Lot.json')

task("newcampaign", "Add campaign")
.addParam("contract", "The contract address")
.setAction(async (taskArgs) => {
    const [signer] = await ethers.getSigners();
    const lotContr = new ethers.Contract(taskArgs.contract,art.abi, signer);
    const result = await lotContr.newCampaign();

    console.log(result);
  });
  
module.exports = {};
