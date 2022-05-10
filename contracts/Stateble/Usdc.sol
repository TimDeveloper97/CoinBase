// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../constant.sol";

contract Usdc is ERC20 {
    using SafeMath for uint256;
    address public minter;
    mapping(address => uint256) internal balances;

    constructor() ERC20("Usdc", "USDC") {
        minter = msg.sender;
        balances[msg.sender] = _totalSupply;
        _mint(msg.sender, _totalSupply);
    }
}
