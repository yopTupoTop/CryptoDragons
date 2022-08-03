pragma solidity >=0.8.0;

contract DragonFarm {

    event NewDragon(uint256 id, string name, uint256 dna);

    struct Dragon {
        string name;
        uint256 dna;
        uint256 level;
    }

    mapping (uint256 => address) public dragonToOwner; // stores address of user, who is owner of dragon with this id 
    mapping (address => uint256) ownersDragonCount; // stores count of dragon from user's address

    Dragon[] public dragons;

    function _createDragon(uint256 _dna, string memory _name) internal {
        dragons.push(Dragon(_name, _dna, 1));
        uint256 id = dragons.length - 1;
        dragonToOwner[id] = msg.sender;
        ownersDragonCount[msg.sender]++;
        emit NewDragon(id, _name, _dna);
    }

    function generateRandomDna(string memory _str) public pure returns (uint256) {
        uint256 rand = uint256(keccak256(abi.encode(_str)));
        return rand % (10 ** 16);
    }

    // this function can be called only when user doesn't have dragons
    function createDragon(string memory _name) public {
        require(ownersDragonCount[msg.sender] == 0);
        uint256 randDna = generateRandomDna(_name);
        _createDragon(randDna, _name);
    }

}