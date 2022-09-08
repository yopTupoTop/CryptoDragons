pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./interfaces/IDragon.sol";

abstract contract Dragon is IDragon, ERC721 {

    using Counters for Counters.Counter;
    Counters.Counter private _counter;

    constructor() ERC721("DragonItem", "DITM") {

    }

    //player address => token id => struct Dragon
    mapping(address => mapping(uint256 => Dragon)) public OwnedDragon;
    mapping(uint256 => address) public OwnedDragonNft;
    mapping(address => uint256) public DragonsOwnerNft;
    
    function mint(address to, string memory name, uint256 dna) external {
        _counter.increment();
        _mint(to, _counter.current());
        OwnedDragonNft[_counter.current()] = to;
        OwnedDragon[to][_counter.current()] = Dragon(name, dna, 1);
    }

    function getOwnedDragon(address owner, uint256 tokenId) external view returns (Dragon memory) {
        return OwnedDragon[owner][tokenId];
    }

    function getOwnedDragonNft(uint256 tokenId) external view returns (address) {
        return OwnedDragonNft[tokenId];
    }

    function getDragonsOwnerNft(address owner) external view returns (uint256) {
        return DragonsOwnerNft[owner];
    }
}