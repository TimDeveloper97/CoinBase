// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";

contract Upfi {
    using Math for uint256;
    using SafeMath for uint256;

    mapping(address => uint256) internal balances;
    address owner;
    uint256 public TOTAL_SUPPLY = 0;
    // Usdc _usdc;

    /* ========== EVENTS ========== */
    error InsufficientBalance(uint256 requested, uint256 available);

    /* ========== Modifiers =============== */
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can request.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function getBalanceUsdc() public view returns (uint256) {
        // return Usdc;
        return 1;
    }

    /* ========== OWNER FUNCTIONS ========== */
    function mint(uint256 amount) external payable onlyOwner {
        if (amount > getBalanceUsdc())
            revert InsufficientBalance({
                requested: amount,
                available: getBalanceUsdc()
            });

        balances[msg.sender] = balances[msg.sender].sub(amount);
    }

    function redeem() external payable onlyOwner {}
}
