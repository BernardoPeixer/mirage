import 'package:mirage/infrastructure/data_store/repository/interface/user_repository_interface.dart';
import '../entities/entity_user.dart';
import '../interfaces/user_interface.dart';

UserUseCase newUserUseCase(UserRepository userRepository) {
  return _UserInterface(userRepository: userRepository);
}

/// Use case implementation for card-related operations.
class _UserInterface extends UserUseCase {
  _UserInterface({required this.userRepository});

  final UserRepository userRepository;

  @override
  Future<void> registerUser(UserInfo user) async {
    if(user.walletAddress.isEmpty) {
      return;
    }

    return userRepository.registerUser(user);
  }
}