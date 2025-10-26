import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mirage/domain/entities/entity_user.dart';
import 'package:mirage/domain/exception/api_response_exception.dart';
import 'package:mirage/infrastructure/data_store/repository/webservice/user_webservice.dart';

import '../../../default/constants.dart';
import 'interface/user_repository_interface.dart';

/// Provides a [UserRepository] implementation using [UserWebservice] and secure storage.
UserRepository newUserRepository(UserWebservice userWS) {
  return _UserRepositoryInterface(userWS);
}

class _UserRepositoryInterface extends UserRepository {
  _UserRepositoryInterface(this._userWebservice);

  final UserWebservice _userWebservice;

  /// Registers a new user via the webservice and stores the wallet address
  /// securely.
  @override
  Future<void> registerUser(UserInfo user) async {
    try {
      await _userWebservice.registerUser(user);

      await const FlutterSecureStorage().write(
        key: Constants.walletAddress,
        value: user.walletAddress,
        iOptions: getIOSOptions(),
        aOptions: getAndroidOptions(),
      );
    } on Exception {
      rethrow;
    }
  }

  /// Checks if a user exists for the given [walletAddress].
  /// Returns true if the user is valid, false otherwise.
  @override
  Future<bool> checkUser(String walletAddress) async {
    final response = await _userWebservice.checkUser(walletAddress);

    if (response == null) {
      return false;
    }

    final validUser = response['valid_user'];

    return validUser;
  }
}
