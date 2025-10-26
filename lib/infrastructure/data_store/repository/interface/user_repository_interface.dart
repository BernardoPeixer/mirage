import '../../../../domain/entities/entity_user.dart';

/// UserRepository defines the contract for user-related data operations.
abstract class UserRepository {
  /// Registers a new user with the given [UserInfo].
  Future<void> registerUser(UserInfo user);

  /// Checks if a user exists for the given [walletAddress].
  /// Returns true if the user exists, false otherwise.
  Future<bool> checkUser(String walletAddress);
}
