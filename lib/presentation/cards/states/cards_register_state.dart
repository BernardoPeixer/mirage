import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:mirage/domain/entities/entity_crypto.dart';
import 'package:mirage/domain/interfaces/cards_interface.dart';

/// State management class for the card registration form.
class CardsRegisterState extends ChangeNotifier {
  CardsRegisterState({required CardsUseCase useCase}) : _cardsUseCase = useCase;

  final CardsUseCase _cardsUseCase;

  /// =-=-=-=-=-=-=-=-=-=-=-=-=- DECLARATIONS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  /// Predefined list of available cryptocurrencies.
  final _cryptoList = <CryptoType>[
    CryptoType(id: 1, symbol: 'BTC', name: 'Bitcoin', statusCode: 0),
    CryptoType(id: 2, symbol: 'ETH', name: 'Ethereum', statusCode: 0),
    CryptoType(id: 3, symbol: 'PYUSD', name: 'PayPal USD', statusCode: 0),
  ];

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
    precision: 8
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

  void registerCard() {
    if (_keyForm.currentState!.validate()) {
      return;
    }
  }
}
