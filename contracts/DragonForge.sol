pragma solidity >=0.8.0;

import "./DragonFarm.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DragonForge is DragonFarm {
    function payAndMultiply(string memory _name, uint256 pay) public payable {
        require(msg.value > 0, "pay to multiply");
        string memory newStr = Strings.toString(pay);
        uint256 randDna = generateRandomDna(newStr);
        _createDragon(randDna, _name);
    }
}