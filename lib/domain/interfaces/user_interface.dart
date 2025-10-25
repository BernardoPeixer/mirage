import '../entities/entity_user.dart';

abstract class UserUseCase {
  Future<void> registerUser(UserInfo user);
}