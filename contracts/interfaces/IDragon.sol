pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IDragon is IERC721 {
    struct Dragon {
        string name;
        uint256 dna;
        uint256 level;
    }

    function getOwnedDragon(address owner, uint256 tokenId) external view returns (Dragon memory);
    function getOwnedDragonNft(uint256 tokenId) external view returns (address);
}
