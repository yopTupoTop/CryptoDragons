pragma solidity >=0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./interfaces/IDragon.sol";
import "./Dragon.sol";
import "./interfaces/IDragonFactory.sol";

contract DragonFactory is  IDragonFactory {

    event NewDragon(string name, uint256 dna);

  

    //mapping (uint256 => address) public dragonToOwner; // stores address of user, who is owner of dragon with this id 
    mapping (address => uint256) public OwnersDragonCount; // stores count of dragon from user's address

    IDragon private dragonNFT;

    constructor(address _dragonNFT) {
        dragonNFT = IDragon(_dragonNFT);
    }

    function _createDragon(uint256 _dna, string memory _name) internal {
        dragonNFT.mint(msg.sender, _name, _dna);
        OwnersDragonCount[msg.sender]++;
        emit NewDragon(_name, _dna);
    }

    function generateRandomDna(string memory _str) public pure returns (uint256) {
        uint256 rand = uint256(keccak256(abi.encode(_str)));
        return rand % (10 ** 16);
    }

    // this function can be called only when user doesn't have dragons
    function createDragon(string memory _name) public {
        require(OwnersDragonCount[msg.sender] == 0);
        uint256 randDna = generateRandomDna(_name);
        _createDragon(randDna, _name);
    }

    //this function allows create new dragons if you also have one 
    function payAndMultiply(string memory _name, uint256 pay) public payable {
        require(msg.value > 0, "pay to multiply");
        string memory newStr = Strings.toString(pay);
        uint256 randDna = generateRandomDna(newStr);
        _createDragon(randDna, _name);
    }

    function getOwnersDragonCount(address owner) external view returns (uint256) {
        return OwnersDragonCount[owner];
    }
}