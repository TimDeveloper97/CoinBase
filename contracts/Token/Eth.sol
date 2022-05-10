// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../constant.sol";

contract Eth is ERC20 {
    using SafeMath for uint256;
    address public minter;

    constructor() ERC20("Eth", "ETH") {
        minter = msg.sender;
        _mint(msg.sender, _totalSupply);
    }
}
