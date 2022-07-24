pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DragonCoin is ERC20 {
    
    constructor () ERC20 ("Dragon Coin", "DNC") {
        
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}