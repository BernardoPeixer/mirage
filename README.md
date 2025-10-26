<div align="center">
  <h1 align="center">
    <img src="https://github.com/BernardoPeixer/mirage/blob/314d322b234e7a7ac9e6a76a24d35f4df19d88c2/logo.png" alt="Atlas Logo" width="200">
  </h1> 
  <h3>◦ Buy, manage, and use consumption cards seamlessly at the festival. Powered by blockchain for instant, secure transactions.</h3>
</div>

---

## 📖 Table of Contents

- [📍 Overview](#-overview)
- [✨ Features](#-features)
- [🏗 Architecture](#-architecture)
- [🔧 Tech Stack](#-tech-stack)
- [🍺 How It Works](#-how-it-works)
- [🚀 Getting Started](#-getting-started)
- [📱 Installation](#-installation)
- [🔐 Configuration](#-configuration)
- [🌍 Localization](#-localization)

---

## 📍 Overview

**FestChain** revolutionizes festival payments by bringing consumption cards to the blockchain. This Flutter application enables festival-goers to buy, manage, and trade digital consumption cards directly from their Web3 wallet, eliminating long waits at ticket counters and ensuring instant, secure transactions powered by smart contracts.

### Key Benefits

- ⚡ **Instant Transactions** - Blockchain-powered payments without delays
- 🔐 **Secure & Decentralized** - Your funds are protected by Web3 technology
- 📱 **Mobile-First** - Native mobile experience for iOS and Android
- 🌍 **Multi-Language** - Support for English, Spanish, and Portuguese
- 💳 **PYUSD Integration** - PayPal stablecoin for stable value transactions

---

## ✨ Features

### 🔗 Wallet Integration
- **WalletConnect Support** - Connect via MetaMask, Trust Wallet, or any compatible Web3 wallet
- **Seamless Authentication** - Fast wallet connection using Reown AppKit
- **Secure Storage** - Biometric authentication support for added security

### 💳 Card Management
- **Register Cards** - Create custom festival consumption cards
- **View Balances** - Track card balances and transaction history
- **Purchase with Crypto** - Buy cards using PYUSD (PayPal USD) stablecoin
- **Smart Contract Integration** - Automated blockchain transactions via mediator contracts

### 🌐 User Experience
- **Beautiful UI** - Clean, modern design with intuitive navigation
- **Real-time Updates** - Instant balance and status updates
- **Error Handling** - Comprehensive error messages and user feedback
- **Loading States** - Smooth loading indicators for async operations

---

## 🏗 Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                      # Core services (wallet, blockchain)
├── domain/                     # Business logic layer
│   ├── entities/              # Domain models
│   ├── exception/             # Custom exceptions
│   ├── interfaces/            # Repository contracts
│   └── usecases/              # Business use cases
├── infrastructure/            # Data layer
│   └── data_store/
│       └── repository/        # Implementation of repositories
├── presentation/              # UI layer
│   ├── cards/                 # Card management UI
│   ├── login/                 # Authentication UI
│   ├── state/                 # Global state management
│   └── util/                  # UI utilities
├── default/                   # App-wide defaults (colors, styles, routes)
├── extension/                 # Dart extensions
├── generated/                 # Generated code (i18n)
└── l10n/                      # Localization files
```

### State Management
- **Provider Pattern** - Centralized state management using Provider
- **State Classes** - Separate state classes for Login, Cards, and Wallet
- **Reactive UI** - Automatic UI updates on state changes

---

## 🔧 Tech Stack

### Frontend
- **Flutter** (^3.9.2) - Cross-platform mobile framework
- **Provider** (^6.1.5) - State management
- **Material Design** - UI components and theming

### Blockchain & Web3
- **Reown AppKit** (^1.7.0) - WalletConnect integration
- **web3dart** (^2.5.0) - Ethereum blockchain interactions
- **flutter_web3** (^2.1.9) - Web3 functionality
- **PYUSD** - PayPal USD stablecoin

### Utilities
- **flutter_secure_storage** (^9.2.4) - Secure credential storage
- **local_auth** (^2.3.0) - Biometric authentication
- **intl** (^0.20.2) - Internationalization
- **Google Fonts** (^6.3.2) - Typography
- **flutter_svg** (^2.2.1) - SVG rendering
- **http** (^1.5.0) - HTTP requests

### Development
- **Dart SDK** 3.9.2+
- **flutter_lints** (^5.0.0) - Code quality

---

## 🍺 How It Works

### 1. Connect Your Wallet
Open the app and tap "Connect Wallet". Choose your preferred Web3 wallet (MetaMask, Trust Wallet, etc.) and authorize the connection. The app uses WalletConnect for seamless wallet integration.

### 2. Register or View Cards
Once connected, you can:
- **View existing cards** from the main dashboard
- **Register new cards** with custom balance and cryptocurrency
- **Track transaction status** in real-time

### 3. Purchase Cards
Tap any available card to purchase:
1. Review card details (balance, crypto price, status)
2. Tap "Buy Now" to initiate transaction
3. Approve the transaction in your wallet
4. Wait for blockchain confirmation
5. Card updates to "Purchased" status

### 4. Smart Contract Flow
The app interacts with smart contracts on the blockchain:
- **PYUSD Token Contract** - Handles the stablecoin transfers
- **Mediator Contract** - Manages card purchases and transactions
- **Unique Order IDs** - Prevents duplicate transactions

---

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK** 3.9.2 or higher
- **Dart SDK** 3.9.2 or higher
- **Android Studio / VS Code** with Flutter extensions
- **Git** for version control
- **Web3 Wallet** (MetaMask, Trust Wallet, etc.)

### Clone the Repository
```bash
git clone https://github.com/BernardoPeixer/mirage.git
cd mirage
```

---

## 📱 Installation

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run the App
```bash
# Run on connected device/emulator
flutter run

# Build for specific platform
flutter build apk        # Android
flutter build ios        # iOS
flutter build web        # Web
```

### 3. Code Generation (if needed)
```bash
# Generate localization files
flutter pub run intl_utils:generate
```

---

## 🔐 Configuration

### Blockchain Configuration
Update blockchain settings in `lib/default/constants.dart`:
- RPC URL for Ethereum network
- PYUSD token contract address
- Mediator contract address
- Chain ID for your network

### API Configuration
Configure backend API endpoints in the infrastructure layer:
- User WebService
- Cards WebService

---

## 🌍 Localization

The app supports multiple languages:
- 🇺🇸 **English** (`en`)
- 🇪🇸 **Spanish** (`es`)
- 🇧🇷 **Portuguese** (`pt`)

Localization files are located in:
- `lib/l10n/` - ARB files (source of truth)
- `lib/generated/` - Generated Dart code

### Adding/Updating Translations
1. Edit the appropriate `.arb` file in `lib/l10n/`
2. Run `flutter pub run intl_utils:generate`
3. Use `context.s.yourKey` in your widgets

---

## 📄 License

This project is available under the MIT License.

---

## 👥 Contributors

- **[Bernardo Peixer](https://github.com/BernardoPeixer)**

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

