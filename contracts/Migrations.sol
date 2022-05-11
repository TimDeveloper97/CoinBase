// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "hardhat/console.sol";
import "./Constant.sol";

contract Migrations {
    using SafeMath for uint256;
    address public owner;
    uint256 public last_completed_migration;
    mapping(string => uint256) priceMoney;

    /* ========== EVENTS ========== */
    error InsufficientBalance(uint256 requested, uint256 available);
    event Mint(uint256 usdc, uint256 token, uint256 upfi);

    /* ========== Modifiers =============== */
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can request.");
        _;
    }

    modifier restricted() {
        if (msg.sender == owner) _;
    }

    constructor() payable {
        owner = msg.sender;

        priceMoney["Usdc"] = _usdcToUSD;
        priceMoney["Upo"] = _upoToUSD;
        priceMoney["Btc"] = _btcToUSD;
        priceMoney["Eth"] = _ethToUSD;
        priceMoney["Rose"] = _roseToUSD;
    }

    /* ========== OWNER FUNCTIONS ========== */
    function mint(
        address _usdc,
        address _token,
        string calldata _typeToken,
        address _upfi,
        uint256 _amount
    ) external payable onlyOwner {
        if (_amount > getBalance(_usdc))
            revert InsufficientBalance({
                requested: _amount,
                available: getBalance(_usdc)
            });

        require(priceMoney[_typeToken] != 0.0, "Type token doesn't exist");

        // caculator
        uint256 tmpUnit = _amount.div(_statebleMintTcr);
        uint256 vUpfi_ = tmpUnit * 100;
        uint256 vToken_ = ((tmpUnit * 25) / 100) / priceMoney[_typeToken];

        //wallet
        require(vToken_ <= getBalance(_token), "Insufficient number of tokens");
        getBalance(_token).sub(vToken_);
        getBalance(_usdc).sub(_amount);
        getBalance(_upfi).add(vUpfi_);

        emit Mint(_amount, vToken_, vUpfi_);
    }

    function redeem() external payable onlyOwner {}

    function setCompleted(uint256 completed) public restricted {
        last_completed_migration = completed;
    }

    function upgrade(address newAddress) public restricted {
        Migrations upgraded = Migrations(newAddress);
        upgraded.setCompleted(last_completed_migration);
    }

    function getBalance(address _token) public view returns (uint256) {
        return ERC20(_token).balanceOf(owner);
    }
}
