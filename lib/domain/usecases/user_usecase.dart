import 'package:mirage/infrastructure/data_store/repository/interface/user_repository_interface.dart';
import '../entities/entity_user.dart';
import '../interfaces/user_interface.dart';

/// Creates a new [UserUseCase] implementation using the provided [UserRepository].
UserUseCase newUserUseCase(UserRepository userRepository) {
  return _UserInterface(userRepository: userRepository);
}

/// Implementation of [UserUseCase] handling user-related business logic.
class _UserInterface extends UserUseCase {
  _UserInterface({required this.userRepository});

  final UserRepository userRepository;

  /// Registers a user if the wallet address is not empty.
  @override
  Future<void> registerUser(UserInfo user) async {
    if (user.walletAddress.trim().isEmpty) {
      return;
    }

    return userRepository.registerUser(user);
  }

  /// Checks if a user exists for the given wallet address.
  /// Returns false if the address is empty.
  @override
  Future<bool> checkUser(String walletAddress) async {
    if (walletAddress.trim().isEmpty) {
      return false;
    }

    return userRepository.checkUser(walletAddress);
  }
}
