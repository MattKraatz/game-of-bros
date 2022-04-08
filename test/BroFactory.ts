import { expect } from "chai";
import { ethers, waffle } from "hardhat";
import web3 from "web3";

import BroFactoryArtifact from "../artifacts/contracts/BroFactory.sol/BroFactory.json";
import { BroFactory } from "../typechain-types/contracts/BroFactory";

describe("BroFactory", function () {
    let broFactory: BroFactory;

    beforeEach(async () => {
        const [alice] = await ethers.getSigners();

        broFactory = (await waffle.deployContract(alice, BroFactoryArtifact)) as BroFactory;

        // TODO: test initial deployment state
    });

    it("should mint a bro", async function () {
        const [, bob] = await ethers.getSigners();

        expect(await broFactory.connect(bob).mintBro({ value: web3.utils.toWei("0.001", "ether") }))
            .to.emit(broFactory, "MintBro")
            .withArgs("from", "id");
    });
});
