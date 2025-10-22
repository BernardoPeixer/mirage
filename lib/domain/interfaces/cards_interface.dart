import '../entities/entity_cards.dart';
import '../entities/entity_crypto.dart';

/// Use case interface for card-related operations.
///
/// Defines the contract for fetching festival cards from the repository.
abstract class CardsUseCase {
  /// Fetches all festival cards.
  ///
  /// Returns a list of [FestivalCard]. The list is guaranteed to be non-null,
  /// but it can be empty if no cards are available.
  Future<List<FestivalCard>> listAllCards();

  /// Fetches all crypto types.
  ///
  /// Returns a list of [CryptoType]. The list is guaranteed to be non-null,
  /// but it can be empty if no crypto types are available.
  Future<List<CryptoType>> listAllCryptoTypes();

  /// Registers the provided [FestivalCard].
  /// Implementation is left to the concrete class.
  Future<void> registerCard(FestivalCard card);
}