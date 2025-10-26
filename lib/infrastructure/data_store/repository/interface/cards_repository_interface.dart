import '../../../../domain/entities/entity_cards.dart';
import '../../../../domain/entities/entity_crypto.dart';

/// Repository interface for card-related operations.
abstract class CardsRepository {
  /// Fetches all festival cards.
  ///
  /// Returns a list of [FestivalCard].
  Future<List<FestivalCard>> listAllCards();

  /// Fetches all crypto types.
  ///
  /// Returns a list of [CryptoType].
  Future<List<CryptoType>> listAllCryptoTypes();

  /// Registers a new festival card.
  /// Implementation should handle sending the card data to the backend.
  Future<void> registerCard(FestivalCard card);

  /// Finalizes a transaction for the specified festival card.
  /// Returns a [Future] that completes when the operation is done.
  Future<void> finishTransactionCard(int cardId);
}
