import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirage/default/padding.dart';
import 'package:mirage/default/text_styles.dart';
import 'package:mirage/extension/context.dart';
import 'package:mirage/presentation/util/util/button/outlined_button_default.dart';
import 'package:mirage/presentation/util/util/custom_chip_default.dart';

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
          child: SingleChildScrollView(
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
                Padding(padding: AppPadding.itemLargeVertical),
                for(var i = 0; i < 15; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: _CardDefault(),
                ),
              ],
            ),
          ),
        ),
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

class _CardDefault extends StatelessWidget {
  const _CardDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
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
                '100 Credits',
                style: TextStylesDefault.robotoTitleBold.copyWith(
                  fontSize: 18,
                  color: Color(0xffA8744F),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  color: Color(0xffDCEB88),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Available',
                  style: TextStylesDefault.robotoTitleBold.copyWith(
                    fontSize: 14,
                    color: Color(0xffF29C6A),
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
                  SvgPicture.asset(AppAssets.ethereumPath, height: 20),
                  Text(
                    '0.3ETH',
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
                onPressed: () {},
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
