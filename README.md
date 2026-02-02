# 🏙️ RWA Asset Tokenization Protocol

## Project Overview
This project implements a simplified Real World Asset (RWA) tokenization protocol on the Ethereum Sepolia Testnet. It features strict KYC compliance for asset transfer and an automated on-chain dividend distribution mechanism.

## 🔗 Verified Contracts (Sepolia)
- **RWA Asset Token (HRET)**: [View on Etherscan](https://sepolia.etherscan.io/address/你的RWA地址)
- **Dividend Distributor**: [View on Etherscan](https://sepolia.etherscan.io/address/你的分红合约地址)
- **Mock USDT**: [View on Etherscan](https://sepolia.etherscan.io/address/你的USDT地址)

## 核心功能 Key Features

### 1. Asset Tokenization & Compliance
- Implements `RealEstateToken` (ERC20).
- **On-chain KYC**: Overrides the `_update` function to enforce a whitelist check on every transfer. Only whitelisted addresses can hold the asset.

### 2. Dividend Distribution
- Implements `DividendDistributor`.
- Assets managers deposit stablecoins (USDT) as rent.
- Token holders claim dividends based on their real-time holding percentage.

## Tech Stack
- **Language**: Solidity 0.8.20
- **Framework**: OpenZeppelin (ERC20, Ownable)
- **Tools**: Remix IDE, MetaMask
