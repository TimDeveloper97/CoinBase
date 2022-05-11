// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../constant.sol";

contract TBase is ERC20Burnable, Ownable, Initializable {
    using SafeMath for uint256;
    address payable owner;
    mapping(address => uint256) internal minters;
    uint256 public MAX_TOTAL_SUPPLY = _totalSupply;

    /* ========== EVENTS ========== */
    event MinterUpdate(address indexed account, uint256 cap);
    event MaxTotalSupplyUpdated(uint256 _newCap);

    /* ========== Modifiers =============== */
    modifier onlyMinter() {
        require(minters[msg.sender] > 0, "Only minter can interact");
        _;
    }

    constructor(string memory _name, string memory _symbol)
        ERC20(_name, _symbol)
    {
        owner = payable(msg.sender);
        minters[msg.sender] = MAX_TOTAL_SUPPLY;
        _mint(msg.sender, MAX_TOTAL_SUPPLY);
    }

    function initialize(uint256 _initial) public initializer {
        super._mint(_msgSender(), _initial); // mint initial supply to add liquidity
    }

    /* ========== MUTATIVE FUNCTIONS ========== */
    function _beforeTokenTransfer(
        address _from,
        address _to,
        uint256 _amount
    ) internal override {
        super._beforeTokenTransfer(_from, _to, _amount);
        if (_from == address(0)) {
            // When minting tokens
            require(
                totalSupply().add(_amount) <= MAX_TOTAL_SUPPLY,
                "Max total supply exceeded"
            );
        }
        if (_to == address(0)) {
            // When burning tokens
            MAX_TOTAL_SUPPLY = MAX_TOTAL_SUPPLY.sub(
                _amount,
                "Burn amount exceeds max total supply"
            );
        }
    }

    /* ========== OWNER FUNCTIONS ========== */
    function resetMaxTotalSupply(uint256 _newCap) external onlyOwner {
        require(
            _newCap >= totalSupply(),
            "_newCap is below current total supply"
        );
        MAX_TOTAL_SUPPLY = _newCap;
        emit MaxTotalSupplyUpdated(_newCap);
    }
}
