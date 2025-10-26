import 'package:flutter/cupertino.dart';
import 'package:mirage/domain/entities/entity_user.dart';
import 'package:mirage/domain/interfaces/user_interface.dart';

import '../../../domain/exception/api_response_exception.dart';
import '../../../generated/l10n.dart';

class LoginState extends ChangeNotifier {
  LoginState({required UserUseCase useCase}) : _userUseCase = useCase;

  final UserUseCase _userUseCase;

  // =-=-=-=-=-=-=-=-=-=-=-=-=- DECLARATIONS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  bool _buttonLoading = false;

  // =-=-=-=-=-=-=-=-=-=-=-=-=- GETTERS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

  bool get buttonLoading => _buttonLoading;

  // =-=-=-=-=-=-=-=-=-=-=-=-=- SETTERS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

  set buttonLoading(bool value) {
    _buttonLoading = value;
    notifyListeners();
  }

  // =-=-=-=-=-=-=-=-=-=-=-=-=- FUNCTIONS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  /// Registers the current user based on the wallet session.
  ///
  /// Currently creates a [UserInfo] object with the wallet address.
  Future<RegisterResult> registerUser(String walletAddress) async {
    final user = UserInfo(walletAddress: walletAddress);

    try {
      await _userUseCase.registerUser(user);
    } on Exception {
      return RegisterResult(
        success: false,
        message: S.current.userRegistrationFailed,
      );
    }

    return RegisterResult(success: true);
  }

  Future<(bool, RegisterResult)> checkUser(String walletAddress) async {
    buttonLoading = true;
    bool validUser = false;

    try {
      validUser = await _userUseCase.checkUser(walletAddress);
      return (validUser, RegisterResult(success: true));
    } on Exception {
      buttonLoading = false;
    }

    return (
      validUser,
      RegisterResult(success: false, message: S.current.unexpectedError),
    );
  }
}
