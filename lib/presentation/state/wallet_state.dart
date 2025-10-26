import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mirage/core/wallet_service.dart';
import 'package:mirage/default/constants.dart';
import 'package:mirage/domain/entities/entity_cards.dart';
import 'package:mirage/extension/context.dart';
import 'package:reown_appkit/reown_appkit.dart';
import '../../domain/exception/api_response_exception.dart';
import '../../generated/l10n.dart';

/// State management class for handling wallet connections and PYUSD operations
/// using Reown AppKit (WalletConnect).
class WalletState extends ChangeNotifier {
  WalletState();

  // =-=-=-=-=-=-=-=-=-=-=-=-=- DECLARATIONS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ReownAppKitModal? _appKitModal;
  bool _initialized = false;

  /// Wallet service to interact with blockchain (balance, allowance, transfers).
  late WalletService? _walletService;

  // =-=-=-=-=-=-=-=-=-=-=-=-=- GETTERS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

  /// Returns true if the wallet is connected, false if disconnected, or null if unknown.
  bool? get isConnected => _appKitModal?.isConnected;

  /// Returns the current session topic or null.
  String? get topic => _appKitModal?.session?.topic;

  /// Returns the connected wallet address or null if not available.
  String? get walletAddress {
    final fullAddress = _appKitModal?.session?.getAddress('eip155');
    if (fullAddress == null) return null;
    return fullAddress.split(':').last;
  }

  /// Returns true if the wallet state is initialized.
  bool get initialized => _initialized;

  /// Returns the underlying ReownAppKit modal instance.
  ReownAppKitModal? get modal => _appKitModal;

  // =-=-=-=-=-=-=-=-=-=-=-=-=- SETTERS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  // =-=-=-=-=-=-=-=-=-=-=-=-=- FUNCTIONS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  /// Initializes the wallet modal with project metadata and sets up listeners.
  Future<void> init(BuildContext context) async {
    if (_initialized) return;

    _appKitModal = ReownAppKitModal(
      context: context,
      projectId: Constants.reownProjectId,
      metadata: const PairingMetadata(
        name: 'FestChain',
        description: 'Crypto for festival perks',
        url: 'https://fest-chain.com',
        icons: [
          'https://www.fest-chain.com/assets/festchain-logo-BZ2JMyrZ.png',
        ],
        redirect: Redirect(
          native: 'festchain://app',
          universal: 'https://fest-chain.com',
          linkMode: true,
        ),
      ),
      disconnectOnDispose: false,
    );

    await _appKitModal?.init();

    _appKitModal?.onModalConnect.subscribe((_) {
      notifyListeners();
    });

    _appKitModal?.onModalDisconnect.subscribe((_) {
      notifyListeners();
    });

    initialized = true;
  }

  /// Opens the wallet connection modal.
  /// Returns [RegisterResult] with success status and optional message.
  Future<RegisterResult> openModalVisual(BuildContext context) async {
    await init(context);

    if (!_initialized) {
      return RegisterResult(success: false, message: context.s.unexpectedError);
    }

    try {
      await _appKitModal?.openModalView();
    } on Exception {
      return RegisterResult(
        success: false,
        message: context.s.walletConnectionFailed,
      );
    }

    return RegisterResult(success: isConnected ?? false);
  }

  /// Initializes the internal WalletService instance.
  Future<void> initWalletService(ReownAppKitModal appKitModal) async {
    _walletService = WalletService(appKitModal);
  }

  /// Returns the PYUSD balance of the connected wallet.
  Future<BigInt> getBalance() async {
    if (_walletService == null || walletAddress == null) return BigInt.zero;

    try {
      final balance = await _walletService!.getBalanceDirect(walletAddress!);
      return balance;
    } catch (e) {
      return BigInt.zero;
    }
  }

  /// Returns the allowance the [spender] has for the connected wallet.
  Future<BigInt> getAllowance(String spender) async {
    if (_walletService == null || walletAddress == null) return BigInt.zero;

    try {
      final allowance = await _walletService!.getAllowance(
        walletAddress: walletAddress!,
        spenderAddress: spender,
      );
      return allowance;
    } catch (e) {
      return BigInt.zero;
    }
  }

  /// Transfers PYUSD to the recipient from [card].
  /// Checks balance and allowance first, automatically approves if needed.
  Future<RegisterResult> transferPYUSD(FestivalCard card) async {
    try {
      await initWalletService(_appKitModal!);

      if (_walletService == null || walletAddress == null) {
        return RegisterResult(
          success: false,
          message: S.current.walletConnectionFailed,
        );
      }

      BigInt balance;
      try {
        balance = await getBalance();
      } catch (e) {
        return RegisterResult(
          success: false,
          message: S.current.insufficientBalance,
        );
      }

      final amount = parsePYUSD(card.cryptoPrice);

      if (balance < amount) {
        return RegisterResult(
          success: false,
          message: S.current.insufficientBalance,
        );
      }

      final maxApproval = BigInt.parse("1000000000000000");

      BigInt currentAllowance = await getAllowance(Constants.mediatorContract);
      if (currentAllowance < amount) {
        await _walletService!.approveSpenderModal(
          spender: Constants.mediatorContract,
          amount: maxApproval,
          chainId: Constants.chainId,
          tokenAddress: Constants.pyusdToken,
        );
      }

      await _walletService!.transferPYUSD(
        mediatorContract: Constants.mediatorContract,
        recipient: card.userInfo.walletAddress,
        amount: amount,
        chainId: Constants.chainId,
      );

      return RegisterResult(success: true);
    } catch (e, st) {
      return RegisterResult(success: false, message: S.current.unexpectedError);
    }
  }
}
