import '../../../../domain/entities/entity_user.dart';

abstract class UserRepository {
  Future<void> registerUser(UserInfo user);
}