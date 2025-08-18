# PredictaMax 🔮

**Next-Generation Bitcoin Price Forecasting Market on Stacks Blockchain**

[![Stacks](https://img.shields.io/badge/Stacks-Blockchain-orange)](https://www.stacks.co/)
[![Clarity](https://img.shields.io/badge/Language-Clarity-blue)](https://clarity-lang.org/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

## Overview

PredictaMax is a decentralized prediction protocol that empowers users to leverage their market insights for forecasting Bitcoin's price direction within defined timeframes. By staking STX tokens, participants form collective prediction pools with fair reward distribution among accurate predictors.

The protocol reimagines financial forecasting by combining transparency, security, and game theory on the Stacks blockchain, creating a trustless environment for Bitcoin price predictions.

## 🎯 Key Features

- **🔒 Fully Decentralized**: Transparent prediction markets with no central authority
- **🤖 Oracle-Driven Settlement**: Trustless outcomes through oracle price feeds
- **⚙️ Configurable Parameters**: Adjustable minimum stakes and protocol fees
- **🛡️ Robust Security**: Double-claim prevention and comprehensive validation
- **👑 Owner Governance**: On-chain parameter management with transparency
- **💰 Fair Distribution**: Proportional reward sharing among winners

## 🏗️ System Architecture

### Contract Architecture

```
PredictaMax Contract
├── Administrative Layer
│   ├── Owner Controls
│   ├── Oracle Management
│   └── Fee Configuration
├── Market Management
│   ├── Market Creation
│   ├── Market Resolution
│   └── Market State Tracking
├── Prediction Engine
│   ├── Stake Processing
│   ├── Prediction Recording
│   └── Validation Logic
└── Settlement System
    ├── Winning Calculation
    ├── Reward Distribution
    └── Fee Collection
```

### Core Components

#### 1. Market Registry

- **Purpose**: Stores market metadata and state
- **Structure**: Maps market ID to market data including prices, stakes, and resolution status
- **Key Fields**: Start/end prices, stake totals, block ranges, resolution status

#### 2. User Predictions

- **Purpose**: Records individual user predictions and stakes
- **Structure**: Composite key (market-id, user) mapping to prediction data
- **Key Fields**: Prediction direction, stake amount, claim status

#### 3. Administrative Controls

- **Purpose**: Manages protocol parameters and governance
- **Components**: Oracle address, minimum stake, fee percentage
- **Access**: Restricted to contract owner

## 📊 Data Flow

### 1. Market Creation Flow

```
Owner → create-market() → Market Registry
  ↓
Market ID Generated → Market State Initialized
  ↓
Market Available for Predictions
```

### 2. Prediction Flow

```
User → make-prediction() → Validation Checks
  ↓
STX Transfer → Contract Balance
  ↓
Prediction Recorded → Market Stakes Updated
```

### 3. Resolution Flow

```
Oracle → resolve-market() → Market Resolution
  ↓
End Price Set → Market Marked as Resolved
  ↓
Winners Determined → Claim Period Begins
```

### 4. Claim Flow

```
Winner → claim-winnings() → Validation
  ↓
Payout Calculation → Fee Deduction
  ↓
STX Transfer → User Balance + Fee to Owner
```

## 🔧 Technical Specifications

### Smart Contract Details

| Component | Description |
|-----------|-------------|
| **Language** | Clarity |
| **Blockchain** | Stacks |
| **Token Standard** | STX (Native) |
| **Oracle Integration** | External price feed |

### Key Constants & Variables

```clarity
;; Default Configuration
minimum-stake: 1 STX (1,000,000 microSTX)
fee-percentage: 2%
oracle-address: Configurable principal

;; Error Codes
err-owner-only: u100
err-not-found: u101
err-invalid-prediction: u102
err-market-closed: u103
err-already-claimed: u104
err-insufficient-balance: u105
err-invalid-parameter: u106
```

## 🚀 Getting Started

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) for local development
- [Stacks Wallet](https://www.hiro.so/wallet) for mainnet interaction
- Node.js and npm for testing framework

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/your-repo/predicta-max.git
   cd predicta-max
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Initialize Clarinet**

   ```bash
   clarinet check
   ```

### Development Commands

```bash
# Check contract syntax
clarinet check

# Run tests
npm test

# Deploy to devnet
clarinet deploy --devnet

# Interactive console
clarinet console
```

## 📋 API Reference

### Public Functions

#### Market Management

```clarity
(create-market (start-price uint) (start-block uint) (end-block uint))
```

Creates a new prediction market. **Owner only**.

```clarity
(resolve-market (market-id uint) (end-price uint))
```

Resolves a market with final price. **Oracle only**.

#### User Interactions

```clarity
(make-prediction (market-id uint) (prediction (string-ascii 4)) (stake uint))
```

Places a prediction ("up" or "down") with STX stake.

```clarity
(claim-winnings (market-id uint))
```

Claims winnings from a resolved market.

#### Administrative

```clarity
(set-oracle-address (new-address principal))
(set-minimum-stake (new-minimum uint))
(set-fee-percentage (new-fee uint))
(withdraw-fees (amount uint))
```

### Read-Only Functions

```clarity
(get-market (market-id uint))
(get-user-prediction (market-id uint) (user principal))
(get-contract-balance)
```

## 🧪 Testing

The project includes comprehensive test coverage for all contract functions:

```bash
# Run all tests
npm test

# Run specific test file
npx vitest tests/predicta-max.test.ts
```

### Test Coverage

- ✅ Market creation and validation
- ✅ Prediction placement and validation
- ✅ Market resolution mechanics
- ✅ Winning calculations and payouts
- ✅ Administrative functions
- ✅ Error handling and edge cases

## 🔐 Security Considerations

### Access Control

- **Owner Privileges**: Limited to market creation and parameter management
- **Oracle Authority**: Exclusive market resolution rights
- **User Permissions**: Prediction placement and claiming only

### Validation Mechanisms

- **Input Validation**: All parameters checked for validity
- **Balance Verification**: Sufficient balance checks before transfers
- **State Verification**: Market timing and resolution status validation
- **Double-Claim Protection**: Claim status tracking prevents multiple claims

### Economic Security

- **Fee Structure**: Protocol sustainability through configurable fees
- **Stake Requirements**: Minimum stake prevents spam attacks
- **Fair Distribution**: Proportional reward sharing based on stake size

### Environment Configuration

Update `settings/` directory for network-specific configurations:

- `Mainnet.toml` - Production settings
- `Testnet.toml` - Testing environment
- `Devnet.toml` - Local development

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Workflow

1. Fork the repository
2. Create a feature branch
3. Write tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- **Documentation**: [Clarity Language Guide](https://clarity-lang.org/)
- **Stacks Blockchain**: [Developer Resources](https://docs.stacks.co/)
- **Discord**: [Stacks Discord](https://discord.gg/stacks)

## 🔮 Roadmap

- [ ] **V1.0**: Core prediction markets
- [ ] **V1.1**: Multi-asset support (Ethereum, other cryptocurrencies)
- [ ] **V1.2**: Advanced market types (price ranges, volatility)
- [ ] **V2.0**: Governance token integration
- [ ] **V2.1**: Automated market making
- [ ] **V3.0**: Cross-chain oracle integration
