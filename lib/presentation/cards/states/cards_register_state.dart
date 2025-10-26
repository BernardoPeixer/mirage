import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:mirage/domain/entities/entity_cards.dart';
import 'package:mirage/domain/entities/entity_crypto.dart';
import 'package:mirage/domain/entities/entity_user.dart';
import 'package:mirage/domain/exception/api_response_exception.dart';
import 'package:mirage/domain/interfaces/cards_interface.dart';

import '../../../generated/l10n.dart';

/// State management class for the card registration form.
///
/// Manages form controllers, selected cryptocurrency, list of available
/// crypto types, and communicates with [CardsUseCase] to register a card
/// or fetch crypto types. Notifies listeners on state changes.
class CardsRegisterState extends ChangeNotifier {
  /// Constructor that initializes the state with a [CardsUseCase].
  ///
  /// Automatically triggers [_init] to fetch all available crypto types.
  CardsRegisterState({required CardsUseCase useCase})
    : _cardsUseCase = useCase {
    unawaited(_init());
  }

  final CardsUseCase _cardsUseCase;

  /// =-=-=-=-=-=-=-=-=-=-=-=-=- DECLARATIONS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  /// Predefined list of available cryptocurrencies.
  final _cryptoList = <CryptoType>[];

  /// Currently selected cryptocurrency.
  CryptoType? _selectedItem;

  /// Controller and focus node for the balance input field.
  final _balanceController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
  );
  final _balanceFocus = FocusNode();

  /// Controller and focus node for the crypto value input field.
  final _cryptoValueController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    precision: 6,
  );
  final _cryptoValueFocus = FocusNode();

  /// Global key used to manage and validate the form state.
  ///
  /// This allows access to form-level operations such as validation,
  /// saving, and resetting within the registration screen.
  final _keyForm = GlobalKey<FormState>();

  /// =-=-=-=-=-=-=-=-=-=-=-=-=- GETTERS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  /// Returns the list of available cryptocurrencies.
  List<CryptoType> get cryptoList => _cryptoList;

  /// Returns the currently selected cryptocurrency.
  CryptoType? get selectedItem => _selectedItem;

  /// Returns the controller for the balance input.
  TextEditingController get balanceController => _balanceController;

  /// Returns the focus node for the balance input.
  FocusNode get balanceFocus => _balanceFocus;

  /// Returns the controller for the crypto value input.
  TextEditingController get cryptoValueController => _cryptoValueController;

  /// Returns the focus node for the crypto value input.
  FocusNode get cryptoValueFocus => _cryptoValueFocus;

  /// Returns the global key used to manage and validate the form.
  GlobalKey<FormState> get keyForm => _keyForm;

  /// =-=-=-=-=-=-=-=-=-=-=-=-=- SETTERS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  /// Updates the selected cryptocurrency and notifies listeners.
  set selectedItem(CryptoType? value) {
    _selectedItem = value;
    notifyListeners();
  }

  /// =-=-=-=-=-=-=-=-=-=-=-=-=- FUNCTIONS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

  /// Initializes the state by fetching all available crypto types.
  Future<void> _init() async {
    await listAllCryptoTypes();
  }

  /// Registers a new card using the current form values.
  ///
  /// Returns `null` on success, or an error message string if registration fails.
  Future<String?> registerCard() async {
    if(_selectedItem == null) {
      return S.current.unexpectedError;
    }

    try {
      /// TODO: Replace hardcoded user info with real user data
      final card = FestivalCard(
        userInfo: UserInfo(
          id: 1,
          username: 'Bernardo',
          walletAddress: '456790-iaujsf',
        ),
        balance: _balanceController.text,
        cryptoType: _selectedItem!,
        cryptoPrice: _cryptoValueController.text,
      );

      await _cardsUseCase.registerCard(card);
      notifyListeners();
      return null;
    } on ApiResponseException catch (e) {
      return e.cause;
    } on Exception {
      return S.current.unexpectedError;
    }
  }

  /// Clears all form fields and resets the selected cryptocurrency.
  void clearFields() {
    _balanceController.clear();
    _cryptoValueController.clear();
    _selectedItem = null;
    notifyListeners();
  }

  /// Fetches all available cryptocurrency types from the use case.
  ///
  /// Returns `null` on success, or an error message string if the fetch fails.
  Future<String?> listAllCryptoTypes() async {
    try {
      final response = await _cardsUseCase.listAllCryptoTypes();

      _cryptoList
        ..clear()
        ..addAll(response);

      notifyListeners();
      return null;
    } on ApiResponseException catch (e) {
      return e.cause;
    } on Exception {
      return S.current.unexpectedError;
    }
  }
}
