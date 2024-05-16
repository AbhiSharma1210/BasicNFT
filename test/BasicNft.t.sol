// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("USER");

    string public constant TEST_NFT =
        "https://ipfs.io/ipfs/QmeBhJa3Z12uQpHoeaZmVp7HAcDo3Se2e7AzNQPFpEzXJT";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    // Test to check the name of NFT
    function testName_Is_Correct() public view {
        string memory expectedName = "BasicNFT";
        string memory actualName = basicNft.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCan_mint_and_have_balance() public {
        vm.prank(USER);
        basicNft.mintNft(TEST_NFT);
        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(TEST_NFT)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
