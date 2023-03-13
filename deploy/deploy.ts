import { Wallet, utils, Provider } from "zksync-web3";
import * as ethers from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { Deployer } from "@matterlabs/hardhat-zksync-deploy";
// An example of a deploy script that will deploy and call a simple contract.
export default async function (hre: HardhatRuntimeEnvironment) {
  console.log(`Running deploy script for the Greeter contract`);
  const provider = new Provider("https://zksync2-testnet.zksync.dev");
  const wallet = new Wallet("private key", provider); 

  const deployer = new Deployer(hre, wallet);
  const artifact = await deployer.loadArtifact("VotingRollup");

  const deploymentFee = await deployer.estimateDeployFee(artifact, []);

  const parsedFee = ethers.utils.formatEther(deploymentFee.toString());
  console.log(`The deployment is estimated to cost ${parsedFee} ETH`);

  const greeterContract = await deployer.deploy(artifact, []);

  console.log("constructor args:" + greeterContract.interface.encodeDeploy([]));

  const contractAddress = greeterContract.address;
  console.log(`${artifact} was deployed to ${contractAddress}`);
}
