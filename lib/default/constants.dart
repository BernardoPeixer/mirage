import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Constants {
  /// wallet address of the user
  static String walletAddress = 'wallet_address';

  /// reown project ID
  static String reownProjectId = '56c6230f17501e971e9572ac3e6b7d09';

  /// this method return the token from [FlutterSecureStorage]
  static Future<String> getWalletAddress() async {
    final token = await const FlutterSecureStorage().read(
      key: Constants.walletAddress,
      aOptions: getAndroidOptions(),
      iOptions: getIOSOptions(),
    );

    return token ?? '';
  }
}

/// Key for shared preferences of token for ios
IOSOptions getIOSOptions() => const IOSOptions(
  accessibility: KeychainAccessibility.first_unlock,
);

/// Key for shared preferences of token for android
AndroidOptions getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);