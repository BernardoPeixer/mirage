import 'package:mirage/domain/interfaces/cards_interface.dart';
import 'package:mirage/infrastructure/data_store/repository/interface/cards_repository_interface.dart';

import '../entities/entity_cards.dart';

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
}