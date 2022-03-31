
//require("@nomiclabs/hardhat-web3");
//const art = require('../artifacts/contracts/Lot.sol/Lot.json')
const art = require('../contracts/artifacts/Lot.json')

task("closecampaign", "Add campaign")
.addParam("contract", "The contract address")
.addParam("campaign", "The campaign id")
.setAction(async (taskArgs) => {
    const [signer] = await ethers.getSigners();
    const lotContr = new ethers.Contract(taskArgs.contract,art.abi, signer);
    const result = await lotContr.closeCampaign(taskArgs.campaign);

    console.log(result);
  });
  
module.exports = {};

