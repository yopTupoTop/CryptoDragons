pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./interfaces/IDragonCoin.sol";
import "./Dragon.sol";

contract DragonButtle is Dragon {

    IDragonCoin dragonCoin;

    constructor(address _dragonCoin) {
        dragonCoin = IDragonCoin(_dragonCoin);
    }

    function attack(uint256 _dragonId, uint256 _targetId) external {
        Dragon storage myDragon = OwnedDragon[msg.sender][_dragonId];
        address targetAddress = OwnedDragonNft[_targetId];
        Dragon storage targetDragon = OwnedDragon[targetAddress][_targetId];

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