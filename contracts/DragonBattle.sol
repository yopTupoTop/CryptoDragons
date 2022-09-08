pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./interfaces/IDragonCoin.sol";
import "./interfaces/IDragonFactory.sol";
import "./interfaces/IDragon.sol";
import "./Dragon.sol";
import "./DragonFactory.sol";

abstract contract DragonBattle is IDragon, IDragonFactory {

    IDragonCoin private dragonCoin;
    IDragon private dragon;
    IDragonFactory private dragonFactory;

    constructor(address _dragonCoin, address _dragon, address _dragonFactory) {
        dragonCoin = IDragonCoin(_dragonCoin);
        dragon = IDragon(_dragon);
        dragonFactory = IDragonFactory(_dragonFactory);
    }

     modifier onlyOwnerOfDragon(uint256 _dragonId) {
        uint256 dragonCount = dragonFactory.getOwnersDragonCount(msg.sender);
        uint256 dragonId = dragon.getDragonsOwnerNft(msg.sender);
        require(dragonCount != 0);
        require(dragonId == _dragonId);
        _;
    }

    function attack(uint256 _dragonId, uint256 _targetId) external onlyOwnerOfDragon(_dragonId) {
        
        Dragon memory myDragon = dragon.getOwnedDragon(msg.sender, _dragonId);
        address targetAddress = dragon.getOwnedDragonNft(_targetId);
        Dragon memory targetDragon = dragon.getOwnedDragon(targetAddress, _targetId);

        uint256 randResult = uint256(keccak256(abi.encode(myDragon.dna + targetDragon.dna))) % 100;

        if (randResult <= 60) {
            myDragon.level++;
            dragonCoin.mint(msg.sender, 10);
        } else {
            targetDragon.level++;
            dragonCoin.mint(targetAddress, 10);
        }
    }
}