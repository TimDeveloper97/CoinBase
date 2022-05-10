// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "hardhat/console.sol";

contract Upfi {
    using Math for uint256;
    using SafeMath for uint256;
    mapping(address => uint256) public minters;

    modifier onlyMinter() {
        require(minters[msg.sender] > 0, "Only minter can interact");
        _;
    }

    function mint() external payable {}

    function redeem() external payable {}
}
