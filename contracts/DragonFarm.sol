pragma solidity >=0.8.0;

contract DragonFarm {
    event NewDragon(uint256 id, string name, uint256 dna);
    struct Dragon {
        uint256 id;
        string name;
        uint256 dna;
        uint256 level;
    }
    Dragon[] public dragons;

    mapping(uint256 => address) dragonToOwner; // storing and displaying address of owner
    mapping(address => uint256) ownerToDragons; // storing and displaying count of dragons for owner

    function generateRandomDna(string memory _name)
        private
        pure
        returns (uint256)
    {
        uint256 randDna = uint256(keccak256(abi.encode(_name)));
        return randDna % (10**16);
    }

    function createDragon(string memory _name) public {
        uint256 dna = generateRandomDna(_name);
        uint256 id = ownerToDragons[msg.sender]; // save address of owner
        addDragon(id, _name, dna);
    }

    function addDragon(
        uint256 _id,
        string memory _name,
        uint256 _dna
    ) private {
        dragons.push(Dragon(_id, _name, _dna, 0));
        dragonToOwner[_id] = msg.sender; // atach dragon to owner's address
        emit NewDragon(_id, _name, _dna);
        ownerToDragons[msg.sender]++;
    }
}
