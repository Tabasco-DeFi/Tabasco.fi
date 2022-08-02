// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TestPool {
    using SafeMath for uint256;
    IERC20 token;

    constructor(address _token) {
        token = IERC20(_token);
    }
    
}