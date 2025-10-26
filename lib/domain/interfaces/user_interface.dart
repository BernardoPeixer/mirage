import '../entities/entity_user.dart';

/// UserUseCase defines the business logic contract for user-related operations.
abstract class UserUseCase {
  /// Registers a new user with the provided [UserInfo].
  Future<void> registerUser(UserInfo user);

  /// Checks if a user exists for the given [walletAddress].
  /// Returns true if the user exists, false otherwise.
  Future<bool> checkUser(String walletAddress);
}
