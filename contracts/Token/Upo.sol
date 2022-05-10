// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../Token/BaseToken.sol";

contract Upo is TBase {
    constructor() TBase("Upo", "UPO") {}

}
