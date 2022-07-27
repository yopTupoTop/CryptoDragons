pragma solidity >=0.8.0;

import "./DragonFarm.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./IDragonCoin.sol";

contract DragonButtle is DragonFarm {

    IDragonCoin dragonCoin;

    constructor(address _dragonCoin) {
        dragonCoin = IDragonCoin(_dragonCoin);
    }

    function attack(uint256 _dragonId, uint256 _targetId) public {
        require(msg.sender == dragonToOwner[_dragonId]);
        uint256 randomResult = uint256(keccak256(abi.encode(_dragonId + _targetId))) % 2;

        if (randomResult == 0) {
            dragonCoin.mint(msg.sender, 10);
        } else {
           dragonCoin.mint(dragonToOwner[_targetId], 10);
        }
    }
}