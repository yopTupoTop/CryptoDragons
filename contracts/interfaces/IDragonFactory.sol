pragma solidity ^0.8.0;

interface IDragonFactory {
    function createDragon(string calldata _name) external;
    function payAndMultiply(string memory _name, uint256 pay) external payable;
    function getOwnersDragonCount(address owner) external view returns (uint256);
}