pragma solidity >=0.8.0;

interface IDragonFactory {
    function getOwnersDragonCount(address owner) external view returns (uint256);
}