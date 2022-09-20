const { expect } = require("chai").expect;
const { ethers} = require("hardhat");
const utils = require("./helpers/utils");
const time = require("./helpers/time");
const dragonNames = ["1", "2"];

describe ("Dragon Battle test", function() {
    
    let Battle;
    let Factory;
    let Dragon;
    let Coin;

    let battle;
    let factory;
    let dragon;
    let coin;

    let owner;
    let address1;
    let address2;
    
    beforeEach(async function () {
        Battle = await ethers.getContractFactory("DragonBattle");
        Factory = await ethers.getContractFactory("DragonFactory");
        Dragon = await ethers.getContractFactory("Dragon");
        Coin = await ethers.getContractFactory("DragonCoin");

        dragon = await Dragon.deploy();
        coin = await Coin.deploy();
        factory = await Factory.deploy(dragon.address);
        battle = await Battle.deploy(coin.address, dragon.address, factory.address);

        [owner, address1, address2] = await ethers.getSigners();
    });

    it("dragon should be able to attack", async function () {
        const blockNumBefore = await ethers.provider.getBlockNumber();
        const blockBefore = await ethers.provider.getBlock(blockNumBefore);
        const timestampBefore = blockBefore.timestamp;
        let result;
        result = await factory.createDragon(dragonNames[0], {from: address1});
        const dragonId = await dragon.getDragonsOwnerNft(address1);
        await time.increase(time.duration.days(1));
        let currentDragon = dragon.getOwnedDragon(address1, dragonId);
        let readiness = currentDragon.readyTime;
        expect(readiness <= timestampBefore).to.equal(true); 
    });
    
});