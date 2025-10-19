import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirage/default/padding.dart';
import 'package:mirage/default/text_styles.dart';
import 'package:mirage/domain/entities/entity_cards.dart';
import 'package:mirage/extension/context.dart';
import 'package:mirage/presentation/cards/states/cards_page_state.dart';
import 'package:mirage/presentation/state/global.dart';
import 'package:mirage/presentation/util/util/button/outlined_button_default.dart';
import 'package:mirage/presentation/util/util/custom_chip_default.dart';
import 'package:mirage/presentation/util/util/eth_loading_default.dart';
import 'package:provider/provider.dart';

import '../../default/app_assets.dart';
import '../../default/colors.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColorDefault,
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screen,
          child: ChangeNotifierProvider(
            create: (context) => CardsPageState(useCase: cardsUseCase),
            child: _ScreenContent(),
          ),
        ),
      ),
    );
  }
}

class _ScreenContent extends StatelessWidget {
  const _ScreenContent();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CardsPageState>(context);

    if (state.isLoading) {
      return EthereumLoadingDefault(loadingText: 'Carregando anúncios...');
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
              child: _FestivalCard(card: item, onPressed: () {},),
            ),
        ],
      ),
    );
  }
}

/// TODO: Implements filter row in next MVP version
class _ChipFilterRow extends StatelessWidget {
  const _ChipFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        CustomChipDefault(label: 'Available', index: 0, selectedIndex: 1),
        CustomChipDefault(label: 'Unavailable', index: 1, selectedIndex: 1),
        CustomChipDefault(label: 'My Cards', index: 2, selectedIndex: 2),
      ],
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
