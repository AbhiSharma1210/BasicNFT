// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract MintBasicNft is Script {
    string public constant TEST_URI =
        "ipfs://QmeBhJa3Z12uQpHoeaZmVp7HAcDo3Se2e7AzNQPFpEzXJT";

    uint256 public DEFAULT_ANVIL_PRIVATE_KEY =
        0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a;
    uint256 public deployerKey;

    // address latestContractAddress = contract address from broadcast;

    function run() external {
        if (block.chainid == 31337) {
            deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
        } else {
            deployerKey = vm.envUint("PRIVATE_KEY");
        }
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        // address mostRecentlyDeployed = latestContractAddress;
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(TEST_URI);
        vm.stopBroadcast();
    }
}
