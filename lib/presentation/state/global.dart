import 'package:mirage/domain/interfaces/cards_interface.dart';
import 'package:mirage/domain/interfaces/user_interface.dart';
import 'package:mirage/domain/usecases/cards_usecase.dart';
import 'package:mirage/domain/usecases/user_usecase.dart';
import 'package:mirage/infrastructure/data_store/repository/cards_repository.dart';
import 'package:mirage/infrastructure/data_store/repository/user_repository.dart';
import 'package:mirage/infrastructure/data_store/repository/webservice/cards_webservice.dart';
import 'package:mirage/infrastructure/data_store/repository/webservice/user_webservice.dart';

/// Global instance of the cards use case
late final CardsUseCase cardsUseCase;

/// Global instance of the user use case
late final UserUseCase userUseCase;

/// Initialize the application repositories and use cases
void initializeState({
  required CardsWebservice cardsWebService,
  required UserWebservice userWebService,
}) {
  /// Cards use case
  cardsUseCase = newCardsUseCase(newCardsRepository(cardsWebService));

  /// User use case
  userUseCase = newUserUseCase(newUserRepository(userWebService));
}
