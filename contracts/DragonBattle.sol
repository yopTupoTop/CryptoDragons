pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./interfaces/IDragonCoin.sol";
import "./interfaces/IDragonFactory.sol";
import "./interfaces/IDragon.sol";
import "./Dragon.sol";
import "./DragonFactory.sol";

contract DragonBattle is IDragon, IDragonFactory {

    IDragonCoin dragonCoin;

    constructor(address _dragonCoin) {
        dragonCoin = IDragonCoin(_dragonCoin);
    }

     modifier onlyOwnerOfDragon(uint256 _dragonId) {
        uint256 dragonCount = getOwnersDragonCount(msg.sender);
        uint256 dragonId = getOwnedDragonNft(msg.sender);
        require(dragonCount != 0);
        require(dragonId == _dragonId);
        _;
    }

    function attack(uint256 _dragonId, uint256 _targetId) external onlyOwnerOfDragon(_dragonId) {
        
        Dragon memory myDragon = getOwnedDragon(msg.sender, _dragonId);
        address targetAddress = getOwnedDragonNft(_targetId);
        Dragon storage targetDragon = getOwnedDragon(targetAddress, _targetId);

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