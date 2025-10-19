import 'package:mirage/domain/interfaces/cards_interface.dart';
import 'package:mirage/domain/usecases/cards_usecase.dart';
import 'package:mirage/infrastructure/data_store/repository/cards_repository.dart';
import 'package:mirage/infrastructure/data_store/repository/webservice/cards_webservice.dart';

/// Global instance of the cards use case
late final CardsUseCase cardsUseCase;

/// Initialize the application repositories and use cases
void initializeState(CardsWebservice cardsWebService) {
  /// Cards use case
  cardsUseCase = newCardsUseCase(newCardsRepository(cardsWebService));
}
