# Simple Solididty contract

Try running some of the following tasks:

Local deploy
```shell
npx hardhat run tasks\deploy.js --network localhost
```

Rinkeby deploy
```shell
npx hardhat run tasks\deploy.js --network rinkeby
```

Add campaign
```shell
npx hardhat newcampaignn --account <who run> --contract <contract address>
```
View campaign
```shell
npx hardhat viewcampaignn --contract <contract address> --campaign <id campaign> --candidate <candidate address>
```

Close campaign
```shell
npx hardhat closecampaignn --contract <contract address> --campaign <id campaign>
```

Add candidate
```shell
npx hardhat addcandidate --contract <contract address> --campaign <id campaign> --candidate <candidate address>
```
