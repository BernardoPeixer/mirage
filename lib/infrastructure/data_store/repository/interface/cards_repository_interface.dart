import '../../../../domain/entities/entity_cards.dart';

/// Repository interface for card-related operations.
abstract class CardsRepository {
  /// Fetches all festival cards.
  ///
  /// Returns a list of [FestivalCard].
  Future<List<FestivalCard>> listAllCards();
}
