import 'package:mirage/domain/interfaces/cards_interface.dart';
import 'package:mirage/infrastructure/data_store/repository/interface/cards_repository_interface.dart';

import '../entities/entity_cards.dart';
import '../entities/entity_crypto.dart';

/// Creates a new [CardsUseCase] using the given [CardsRepository].
CardsUseCase newCardsUseCase(CardsRepository cardsRepository) {
  return _CardsInterface(cardsRepository: cardsRepository);
}

/// Use case implementation for card-related operations.
class _CardsInterface extends CardsUseCase {
  _CardsInterface({required this.cardsRepository});

  final CardsRepository cardsRepository;

  /// Fetches all festival cards through the repository.
  @override
  Future<List<FestivalCard>> listAllCards() => cardsRepository.listAllCards();

  /// Fetches all crypto types through the repository.
  @override
  Future<List<CryptoType>> listAllCryptoTypes() =>
      cardsRepository.listAllCryptoTypes();

  /// Delegates the card registration to the repository.
  /// Sends the given [FestivalCard] to be persisted.
  @override
  Future<void> registerCard(FestivalCard card) =>
      cardsRepository.registerCard(card);

  /// Executes the use case to finalize a festival card transaction.
  /// Delegates the operation to the [cardsRepository].
  @override
  Future<void> finishTransactionCard(int cardId) =>
      cardsRepository.finishTransactionCard(cardId);
}
