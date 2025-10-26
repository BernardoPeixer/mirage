import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mirage/domain/entities/entity_cards.dart';
import 'package:mirage/domain/exception/api_response_exception.dart';
import 'package:mirage/domain/interfaces/cards_interface.dart';

import '../../../generated/l10n.dart';

/// State manager for the Cards page.
///
/// Handles fetching and storing festival cards using the provided [CardsUseCase].
/// Notifies listeners whenever the cards list is updated.
class CardsPageState extends ChangeNotifier {
  /// Creates a new instance of [CardsPageState] with the given [useCase].
  CardsPageState({required CardsUseCase useCase}) : _cardsUseCase = useCase {
    unawaited(_init());
  }

  final CardsUseCase _cardsUseCase;

  /// =-=-=-=-=-=-=-=-=-=-=-=-=- DECLARATIONS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  /// Internal list of cards.
  final _cards = <FestivalCard>[];

  /// Indices if screen is loading
  bool _isLoading = true;

  /// =-=-=-=-=-=-=-=-=-=-=-=-=- GETTERS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

  /// Public getter for the list [_cards].
  List<FestivalCard> get cards => _cards;

  /// Public getter for the boolean [_isLoading].
  bool get isLoading => _isLoading;

  /// =-=-=-=-=-=-=-=-=-=-=-=-=- SETTERS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

  /// Setter to [isLoading]
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// =-=-=-=-=-=-=-=-=-=-=-=-=- FUNCTIONS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

  Future<void> _init() async {
    isLoading = true;
    await listAllCards();
    await Future.delayed(Duration(milliseconds: 400));
    isLoading = false;
  }

  /// Fetches all festival cards from the use case.
  ///
  /// Returns `null` on success, or a localized error message if something goes wrong.
  Future<String?> listAllCards() async {
    try {
      isLoading = true;
      final response = await _cardsUseCase.listAllCards();

      _cards
        ..clear()
        ..addAll(response);

      isLoading = false;
      return null;
    } on ApiResponseException catch (e) {
      isLoading = false;
      return e.cause;
    } on Exception {
      isLoading = false;
      return S.current.unexpectedError;
    }
  }

  Future<RegisterResult> finishTransactionCard(int cardId) async {
    try {
      await _cardsUseCase.finishTransactionCard(cardId);
      await listAllCards();
      return RegisterResult(success: true);
    } on Exception {
      return RegisterResult(success: false, message: S.current.unexpectedError);
    }
  }
}
