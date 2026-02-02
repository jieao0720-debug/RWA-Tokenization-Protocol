// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DividendDistributor is Ownable {
    IERC20 public usdt;
    IERC20 public rwaToken;

    uint256 public totalDividends; // 累计总分红
    mapping(address => uint256) public claimedDividends; // 用户已领取的金额

    // 构造函数：告诉合约谁是钱，谁是资产
    constructor(address _usdt, address _rwaToken) Ownable(msg.sender) {
        usdt = IERC20(_usdt);
        rwaToken = IERC20(_rwaToken);
    }

    // 1. 管理员存入租金
    function depositRent(uint256 amount) external onlyOwner {
        require(usdt.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        totalDividends += amount;
    }

    // 2. 核心算法：计算用户当前应得的总分红
    // 逻辑：(用户持仓 / 总发行量) * 总分红池
    function calculateShare(address user) public view returns (uint256) {
        uint256 userBalance = rwaToken.balanceOf(user);
        uint256 totalSupply = rwaToken.totalSupply();
        if (totalSupply == 0) return 0;
        
        // 你的总份额 = (持有量 * 总分红) / 总发行量
        return (userBalance * totalDividends) / totalSupply;
    }

    // 3. 用户领取分红
    function claim() external {
        uint256 totalShare = calculateShare(msg.sender);
        uint256 withdrawable = totalShare - claimedDividends[msg.sender];
        
        require(withdrawable > 0, "No new dividends to claim");
        
        claimedDividends[msg.sender] += withdrawable;
        require(usdt.transfer(msg.sender, withdrawable), "USDT Transfer failed");
    }
}