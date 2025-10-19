import 'package:mirage/domain/entities/entity_cards.dart';
import 'package:mirage/infrastructure/data_store/repository/interface/cards_repository_interface.dart';
import 'package:mirage/infrastructure/data_store/repository/webservice/cards_webservice.dart';

/// Creates a new [CardsRepository] using the given [CardsWebservice].
CardsRepository newCardsRepository(CardsWebservice cardsWS) {
  return _CardsRepositoryInterface(cardsWS);
}

/// Repository implementation for card-related data.
class _CardsRepositoryInterface extends CardsRepository {
  _CardsRepositoryInterface(this._cardsWebservice);

  final CardsWebservice _cardsWebservice;

  /// Fetches all festival cards from the webservice.
  ///
  /// Returns a list of [FestivalCard].
  /// Throws [ApiResponseException] if the webservice request fails.
  @override
  Future<List<FestivalCard>> listAllCards() async {
    final response = await _cardsWebservice.listAllCards();

    final festivalCards = <FestivalCard>[];

    for(final item in response) {
      final card = FestivalCard.fromJson(json: item);
      festivalCards.add(card);
    }

    return festivalCards;
  }
}
