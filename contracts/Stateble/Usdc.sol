// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../Constant.sol";

contract Usdc is ERC20 {
    using SafeMath for uint256;
    address public minter;
    uint256 public TOTAL_SUPPLY = _totalSupply;

    constructor() ERC20("Usdc", "USDC") {
        minter = msg.sender;
        _mint(msg.sender, TOTAL_SUPPLY);
    }
}
