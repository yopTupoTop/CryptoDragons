pragma solidity >=0.8.0;

import "./DragonFarm.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./IDragonCoin.sol";

contract DragonButtle is DragonFarm {

    IDragonCoin dragonCoin;

    constructor(address _dragonCoin) {
        dragonCoin = IDragonCoin(_dragonCoin);
    }

    function attack(uint256 _dragonId, uint256 _targetId) external {
        Dragon storage myDragon = dragons[_dragonId];
        Dragon storage enemyDragon = dragons[_targetId];
        uint256 randResult = uint256(keccak256(abi.encode(myDragon.dna + enemyDragon.dna))) % 100;
        if (randResult <= 60) {
            myDragon.level++;
            dragonCoin.mint(dragonToOwner[_dragonId], 10);
        } else {
            enemyDragon.level++;
            dragonCoin.mint(dragonToOwner[_targetId], 10);
        }
    }
}