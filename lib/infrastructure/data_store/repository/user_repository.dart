import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mirage/domain/entities/entity_user.dart';
import 'package:mirage/infrastructure/data_store/repository/webservice/user_webservice.dart';

import '../../../default/constants.dart';
import 'interface/user_repository_interface.dart';

/// Creates a new [CardsRepository] using the given [CardsWebservice].
UserRepository newUserRepository(UserWebservice userWS) {
  return _UserRepositoryInterface(userWS);
}

class _UserRepositoryInterface extends UserRepository {
  _UserRepositoryInterface(this._userWebservice);

  final UserWebservice _userWebservice;

  @override
  Future<void> registerUser(UserInfo user) async {
    await _userWebservice.registerUser(user);

    await const FlutterSecureStorage().write(
      key: Constants.walletAddress,
      value: user.walletAddress,
      iOptions: getIOSOptions(),
      aOptions: getAndroidOptions(),
    );
  }
}
