// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockUSDT is ERC20 {
    constructor() ERC20("Mock USDT", "mUSDT") {
        // 部署时直接给你自己印 100 万个币 (18位精度)
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    // 水龙头函数：任何人调用都给他发 1000 块
    function faucet() public {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}