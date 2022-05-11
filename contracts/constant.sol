// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

uint256 constant _totalSupply = 1000;
uint256 constant one = 1;
uint256 constant _statebleMintTcr = (one * 9975) / 100;
uint256 constant _tokenMintTcr = (one * 25) / 10000;
uint256 constant _statebleRedeemTcr = _statebleMintTcr;
uint256 constant _tokenRedeemTcr = _tokenMintTcr;
uint256 constant _usdcToUSD = (one * 999927) / 1000000;
uint256 constant _btcToUSD = (one * 3255) / 1000000;
uint256 constant _ethToUSD = (one * 3255) / 1000000;
uint256 constant _roseToUSD = (one * 3255) / 1000000;
uint256 constant _upoToUSD = (one * 3255) / 1000000;

