//require("@nomiclabs/hardhat-web3");
const art = require('../artifacts/contracts/Lot.sol/Lot.json')

task("viewcampaign", "Add campaign")
.addParam("contract", "The contract address")
.addParam("campaign", "The campaign id")
.addParam("candidate", "The candidate address")
.setAction(async (taskArgs) => {
    const [signer] = await ethers.getSigners();
    const lotContr = new ethers.Contract(taskArgs.contract,art.abi, signer);
    const result = await lotContr.viewCampaign(taskArgs.campaign, taskArgs.candidate);
    console.log(result);
  });
  
module.exports = {};

