import '../entities/entity_cards.dart';

/// Use case interface for card-related operations.
///
/// Defines the contract for fetching festival cards from the repository.
abstract class CardsUseCase {
  /// Fetches all festival cards.
  ///
  /// Returns a list of [FestivalCard]. The list is guaranteed to be non-null,
  /// but it can be empty if no cards are available.
  Future<List<FestivalCard>> listAllCards();
}