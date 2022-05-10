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

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can request.");
        _;
    }

    error InsufficientBalance(uint256 requested, uint256 available);

    function getBalance() public view returns (uint256) {
        return ERC20(owner).balanceOf(msg.sender);
    }

    function mint(uint256 amount) external payable onlyOwner {
        if (amount > getBalance())
            revert InsufficientBalance({
                requested: amount,
                available: getBalance()
            });

        balances[msg.sender] = balances[msg.sender].sub(amount);
        // ERC20(owner).
    }
    // làm thế nào để chuyển 1 giá trị coin UPFI vào ví người dùng?
    // làm thế nào để trừ đi giá trị các token người đó đang sở hữu
    // làm thế nào để biết các giá trị các token đang ở trong wallet của họ
    function redeem() external payable onlyOwner {}
}
