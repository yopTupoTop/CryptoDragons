const { expect } = require("chai");
const { ethers, artifacts } = require("hardhat");
const DragonBattle = artifacts.require("DragonBattle");


describe ("DragonBattle"), (accounts) => {
    let [alice, bob] = accounts;
    let contractInstance;
    
    beforeEach(async () => {
        contractInstance = await DragonBattle.new();
    })
}