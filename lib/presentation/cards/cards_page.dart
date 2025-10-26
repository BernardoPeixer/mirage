import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirage/default/padding.dart';
import 'package:mirage/default/text_styles.dart';
import 'package:mirage/domain/entities/entity_cards.dart';
import 'package:mirage/domain/entities/entity_crypto.dart';
import 'package:mirage/domain/exception/api_response_exception.dart';
import 'package:mirage/extension/context.dart';
import 'package:mirage/presentation/cards/states/cards_page_state.dart';
import 'package:mirage/presentation/cards/states/cards_register_state.dart';
import 'package:mirage/presentation/state/global.dart';
import 'package:mirage/presentation/state/wallet_state.dart';
import 'package:mirage/presentation/util/util/button/outlined_button_default.dart';
import 'package:mirage/presentation/util/util/custom_snack_bar.dart';
import 'package:mirage/presentation/util/util/eth_loading_default.dart';
import 'package:mirage/presentation/util/util/input/drop_down_default.dart';
import 'package:provider/provider.dart';

import '../../default/colors.dart';
import '../../generated/l10n.dart';
import '../util/util/input/text_form_box_default.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CardsPageState>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.scaffoldColorDefault,
      floatingActionButton: state.isLoading ? null : _AddFestivalCardFAB(),
      body: SafeArea(
        child: Padding(padding: AppPadding.screen, child: _ScreenContent()),
      ),
    );
  }
}

class _AddFestivalCardFAB extends StatelessWidget {
  const _AddFestivalCardFAB();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CardsPageState>(context);
    final registerState = Provider.of<CardsRegisterState>(context);

    return FloatingActionButton(
      backgroundColor: AppColors.softOrange,
      child: Center(child: Icon(Icons.add, color: Colors.white)),
      onPressed: () async {
        final result = await showModalBottomSheet<RegisterResult>(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: _RegisterCardBottomSheet(state: registerState),
            );
          },
        );

        if (result != null && result.success) {
          await state.listAllCards();

          showSnackBarDefault(
            context: context,
            message: context.s.cardListedSuccessfully,
          );
        } else {
          showSnackBarDefault(
            context: context,
            message: result?.message ?? context.s.unexpectedError,
          );
        }
      },
    );
  }
}

class _ScreenContent extends StatelessWidget {
  const _ScreenContent();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CardsPageState>(context);
    final walletState = Provider.of<WalletState>(context);

    if (state.isLoading) {
      return EthereumLoadingDefault(loadingText: context.s.loadingCards);
    }

    if (state.cards.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Festival Cards',
              style: TextStylesDefault.robotoTitleBold.copyWith(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                context.s.noCardFound,
                style: TextStylesDefault.robotoTitleBold.copyWith(
                  fontSize: 18,
                  color: Color(0xffA8744F),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Festival Cards',
              style: TextStylesDefault.robotoTitleBold.copyWith(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          Padding(padding: AppPadding.itemLargeVertical),
          for (final item in state.cards)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: _FestivalCard(
                card: item,
                onPressed: () async {
                  if (item.id == null) {
                    return;
                  }

                  final result = await walletState.transferPYUSD(item, context);

                  if (result.message != null) {
                    showSnackBarDefault(
                      context: context,
                      message: result.message!,
                      backgroundColor: Colors.redAccent,
                    );

                    return;
                  }

                  final finishResult = await state.finishTransactionCard(
                    item.id!,
                  );

                  if (finishResult.message != null) {
                    showSnackBarDefault(
                      context: context,
                      message: finishResult.message!,
                      isError: true,
                    );

                    return;
                  }

                  showSnackBarDefault(
                    context: context,
                    message: context.s.cardPurchaseSuccess,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

/// Widget that displays a single festival card with balance, crypto info,
/// status, and a "Buy Now" button.
///
/// Uses [FestivalCard] to populate all relevant information and styles.
class _FestivalCard extends StatelessWidget {
  /// Constructs a [_FestivalCard] with the given [card] data.
  const _FestivalCard({required this.card, required this.onPressed});

  /// The festival card data displayed by this widget.
  final FestivalCard card;

  /// Callback triggered when the button or interactive element is pressed.
  /// Typically used to perform actions such as navigation, API calls, or
  /// updating state.
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 0),
            blurRadius: 6,
            color: Color(0xff5B734D).withAlpha((0.3 * 255).toInt()),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: Color(0xffFFECB3),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${card.balance} ${context.s.credits}',
                style: TextStylesDefault.robotoTitleBold.copyWith(
                  fontSize: 18,
                  color: Color(0xffA8744F),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  color: card.cardStatusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  card.cardStatus,
                  style: TextStylesDefault.robotoTitleBold.copyWith(
                    fontSize: 14,
                    color: card.cardTextStatusColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                spacing: 4,
                children: [
                  SvgPicture.asset(card.cryptoType.cryptoImage(), height: 20),
                  Text(
                    card.cryptoPriceFormatted,
                    style: TextStylesDefault.robotoSubtitleSemiBold.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (card.statusCode == 0)
                OutlinedButtonDefault(
                  borderSide: BorderSide(
                    color: AppColors.secondaryGreen,
                    width: 1,
                  ),
                  onPressed: onPressed,
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.softOrange,
                  splashColor: AppColors.terracottaRed.withAlpha(
                    (0.3 * 255).toInt(),
                  ),
                  padding: EdgeInsets.zero,
                  child: Text(
                    context.s.buyNowButton,
                    style: TextStylesDefault.robotButtonStyle.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RegisterCardBottomSheet extends StatelessWidget {
  const _RegisterCardBottomSheet({required this.state});

  final CardsRegisterState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      height: 300,
      decoration: BoxDecoration(
        color: Color(0xffFFF1D9),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 4,
        children: [
          Text(
            context.s.cardRegistration,
            style: TextStylesDefault.robotoTitleBold.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Form(
            key: state.keyForm,
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomDropdown<CryptoType>(
                  header: context.s.cryptoType,
                  items: state.cryptoList,
                  value: state.selectedItem,
                  onChanged: (value) {
                    state.selectedItem = value;
                  },
                  validator: (value) {
                    if (state.selectedItem == null) {
                      return context.s.fieldRequired;
                    }

                    return null;
                  },
                  dropDownChildItem: [
                    for (final item in state.cryptoList)
                      DropdownMenuItem<CryptoType>(
                        value: item,
                        child: Row(
                          spacing: 4,
                          children: [
                            SvgPicture.asset(item.cryptoImage(), height: 30),
                            Text('${item.name} (${item.symbol})'),
                          ],
                        ),
                      ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Expanded(
                      child: TextFormBoxDefault(
                        validator: (value) {
                          if (value == null) {
                            return context.s.fieldRequired;
                          }

                          return validateBalanceField(
                            state.balanceController.text,
                          );
                        },
                        keyboardType: TextInputType.number,
                        controller: state.balanceController,
                        focus: state.balanceFocus,
                        header: context.s.balance,
                        fillColor: Color(0xffFFF9E6),
                        hintText: '',
                      ),
                    ),
                    Expanded(
                      child: TextFormBoxDefault(
                        validator: (value) {
                          if (value == null) {
                            return context.s.fieldRequired;
                          }

                          return validateBalanceField(
                            state.cryptoValueController.text,
                          );
                        },
                        keyboardType: TextInputType.number,
                        controller: state.cryptoValueController,
                        focus: state.cryptoValueFocus,
                        header: context.s.cryptoValue,
                        fillColor: Color(0xffFFF9E6),
                        hintText: '',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          OutlinedButtonDefault(
            borderSide: BorderSide(color: AppColors.secondaryGreen, width: 1),
            onPressed: () async {
              if (state.keyForm.currentState!.validate()) {
                final message = await state.registerCard();
                state.clearFields();

                final result = RegisterResult(
                  success: message == null,
                  message: message,
                );

                Navigator.pop(context, result);
              }
            },
            borderRadius: BorderRadius.circular(16),
            color: AppColors.softOrange,
            splashColor: AppColors.terracottaRed.withAlpha((0.3 * 255).toInt()),
            padding: EdgeInsets.zero,
            child: Text(
              context.s.registerButton,
              style: TextStylesDefault.robotButtonStyle.copyWith(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String? validateBalanceField(String value) {
  String cleaned = value.replaceAll(RegExp(r'[^\d,]'), '');
  cleaned = cleaned.replaceAll(',', '.');

  final number = double.tryParse(cleaned);

  if (number == null || number <= 0) {
    return S.current.fieldRequired;
  }

  return null;
}
