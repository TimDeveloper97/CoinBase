pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";

contract TokenUSDC is ERC20 {
    constructor() ERC20("TokenUSDC", "USDC") {
        _mint(msg.sender, 100 * 10**18);
    }
}
