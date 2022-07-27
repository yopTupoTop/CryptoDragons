pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IDragonCoin.sol";

contract DragonCoin is IDragonCoin, ERC20 {
    
    constructor () ERC20 ("Dragon Coin", "DNC") {
        
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}