// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract Upfi is ERC20Burnable {
    address owner;
    uint256 public TOTAL_SUPPLY = 0;

    constructor() ERC20("Upfi", "UPFI") {
        owner = msg.sender;
        _mint(msg.sender, TOTAL_SUPPLY);
    }
}
