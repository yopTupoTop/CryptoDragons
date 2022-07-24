pragma solidity >= 0.8.0;

import "./DragonFarm.sol";

contract DragonForge is DragonFarm {

    function reforge(string memory _name, uint256 _id, uint256 _foodAmount) public payable {
        require(_foodAmount > 0, "Pay for food");
        uint256 foodId = uint256(keccak256(abi.encode(_foodAmount)));
        foodId = foodId % (10 ** 16);
        uint256 newDna = (_id + foodId) / 2;
        dragons.push(Dragon(_id, _name, newDna, 0));
    }
}