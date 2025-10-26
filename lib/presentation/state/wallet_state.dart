import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:mirage/default/constants.dart';
import 'package:mirage/domain/entities/entity_user.dart';
import 'package:mirage/extension/context.dart';
import 'package:reown_appkit/modal/appkit_modal_impl.dart';
import 'package:reown_appkit/reown_appkit.dart';

import '../../domain/exception/api_response_exception.dart';

/// State management class for handling wallet connections using Reown AppKit.
class WalletState extends ChangeNotifier {
  WalletState();

  ReownAppKitModal? _appKitModal;

  // =-=-=-=-=-=-=-=-=-=-=-=-=- DECLARATIONS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  /// Indicates whether the modal has been initialized.
  bool _initialized = false;

  // =-=-=-=-=-=-=-=-=-=-=-=-=- GETTERS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

  /// Returns true if the wallet is connected, false if disconnected, or null if unknown.
  bool? get isConnected => _appKitModal?.isConnected;

  ///
  String? get walletAddress {
    final fullAddress = _appKitModal?.session?.getAddress('eip155');

    if(fullAddress == null) {
      return null;
    }

    return fullAddress.split(':').last;
  }

  // =-=-=-=-=-=-=-=-=-=-=-=-=- FUNCTIONS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  /// Initializes the Reown AppKit modal with project metadata.
  ///
  /// Sets up listeners for connect and disconnect events.
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

    _appKitModal?.onModalConnect.subscribe((session) {
      notifyListeners();
    });

    _appKitModal?.onModalDisconnect.subscribe((_) {
      notifyListeners();
    });

    _initialized = true;
  }

  /// Opens the wallet connection modal.
  ///
  /// Returns a [RegisterResult] indicating success or failure, with a message.
  Future<RegisterResult> openModalVisual(BuildContext context) async {
    await init(context);

    if (!_initialized) {
      return RegisterResult(
        success: false,
        message: context.s.unexpectedError,
      );
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

  /// Disconnects the wallet and notifies listeners.
  Future<void> disconnect() async {
    await _appKitModal?.disconnect();
    notifyListeners();
  }

  /// Returns the underlying ReownAppKit modal instance.
  ReownAppKitModal? get modal => _appKitModal;

  /// Registers the current user based on the wallet session.
  ///
  /// Currently creates a [UserInfo] object with the wallet address.
  Future<void> registerUser() async {
    if (_appKitModal!.session == null) {
      return;
    }

    final address = _appKitModal!.session!.getAddress('eip155');

    final user = UserInfo(walletAddress: address ?? '');
  }
}
