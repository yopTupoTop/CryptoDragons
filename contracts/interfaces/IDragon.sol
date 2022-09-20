pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IDragon is IERC721 {
    struct Dragon {
        string name;
        uint256 dna;
        uint32 level;
        uint32 readyTime;
    }

    function mint(address to, string memory name, uint256 dna) external;
    function getOwnedDragon(address owner, uint256 tokenId) external view returns (Dragon memory);
    function getOwnedDragonNft(uint256 tokenId) external view returns (address);
    function getDragonsOwnerNft(address owner) external view returns (uint256);
}
