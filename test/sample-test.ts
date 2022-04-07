import { expect } from "chai";
import { ethers } from "hardhat";
import web3 from "web3";

describe("BroFactory", function () {
    it("should mint a bro", async function () {
        const [alice, bob] = await ethers.getSigners();

        const contractFactory = await ethers.getContractFactory("BroFactory");
        const broFactory = await contractFactory.deploy();
        await broFactory.deployed();

        expect(await broFactory.connect(alice).mintBro({ value: web3.utils.toWei("0.001", "ether") }))
            .to.emit(broFactory, "MintBro")
            .withArgs("from", "id");
    });
});
