const { expect } = require("chai").expect;
const { ethers} = require("hardhat");

const dragonsNames = ["dragon1", "dragon2"];

describe("Dragon Factory test", function() {
    let Dragon;
    let DragonFactory;

    let dragon;
    let dragonFactory;

    let owner;
    let address1;

    beforeEach(async function() {
        Dragon = await ethers.getContractFactory("Dragon");
        DragonFactory = await ethers.getContractFactory("DragonFactory");

        dragon = await Dragon.deploy();
        dragonFactory = await DragonFactory.deploy(dragon.address);

        [owner, address1] = await ethers.getSigners();
    });

    it("should create dragon for users's adrdess", async function() {
        await dragonFactory.createDragon(dragonsNames[0], {from: address1});
        let count = await dragonFactory.getOwnersDragonCount(address1);
        expect(count).to.equal(1);
        const dragonId = await dragon.getDragonsOwnerNft(address1);
        const dragonName = await dragon.getOwnedDragon(address1, dragonId).name;
        expect(dragonName).to.equal(dragonsNames[0]);
    });

    it("should revert creating a dragon, because user already has dragon", async function() {
        await dragonFactory.createDragon(dragonsNames[0], {from: address1});
        expect(dragonFactory.createDragon(dragonsNames[1], {from: address1})).revertWith("You already have a dragon");
    });

    it("should create new dragon foe ether", async function() {
        await dragonFactory.payAndMultiply(dragonsNames[0], {
            value: ethers.utils.parseEther("1.0") 
        }, {from: address1});
        let count = await dragonFactory.getOwnersDragonCount(address1);
        expect(count).to.equal(1);
        const dragonId = await dragon.getDragonsOwnerNft(address1);
        const dragonName = await dragon.getOwnedDragon(address1, dragonId).name;
        expect(dragonName).to.equal(dragonsNames[0]);
    });

    it("should revert transaction, because user don't sent ether", async function() {
        expect(await dragonFactory.payAndMultiply(dragonsNames[0], {
            value: ethers.utils.parseEther("0.0") 
        }, {from: address1})).revertWith("Pay to multiply");
    });
});