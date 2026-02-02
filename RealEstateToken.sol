// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RealEstateToken is ERC20, Ownable {
    // 白名单映射：地址 -> 是否通过KYC
    mapping(address => bool) public isWhitelisted;

    constructor() ERC20("Hubei Real Estate Token", "HRET") Ownable(msg.sender) {
        // 1. 将你自己（管理员）自动加入白名单，否则你没法接收初始代币
        isWhitelisted[msg.sender] = true;
        // 2. 发行 1000 份房产份额给管理员
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    // 管理员专用函数：添加合规投资人
    function addToWhitelist(address _user) external onlyOwner {
        isWhitelisted[_user] = true;
    }

    // 核心逻辑：拦截每一笔转账进行检查
    // 在 OpenZeppelin v5 中，_update 是所有铸造、销毁、转账的底层函数
    function _update(address from, address to, uint256 value) internal override {
        // 如果不是铸造(from=0) 也不是销毁(to=0)，就要检查接收方
        if (from != address(0) && to != address(0)) {
            require(isWhitelisted[to], "Receiver is not whitelisted (KYC Required)");
        }
        super._update(from, to, value);
    }
}