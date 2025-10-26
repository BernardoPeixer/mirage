import 'package:flutter/cupertino.dart';
import 'package:mirage/domain/entities/entity_user.dart';
import 'package:mirage/domain/interfaces/user_interface.dart';

class LoginState extends ChangeNotifier {
  LoginState({required UserUseCase useCase}) : userUseCase = useCase;

  final UserUseCase userUseCase;

  Future<void> registerUser(UserInfo user) async {

  }
}
