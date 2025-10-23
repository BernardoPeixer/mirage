import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirage/default/app_assets.dart';
import 'package:mirage/default/colors.dart';
import 'package:mirage/default/routes.dart';
import 'package:mirage/default/text_styles.dart';
import 'package:mirage/extension/context.dart';
import 'package:reown_appkit/reown_appkit.dart';
import '../util/util/button/outlined_button_default.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColorDefault,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.logoPath, height: 300),
            Text(
              'FestChain',
              style: TextStylesDefault.robotoTitleBold.copyWith(fontSize: 40),
              textAlign: TextAlign.center,
            ),
            Text(
              context.s.cryptoForFestivalPerks,
              style: TextStylesDefault.robotoSubtitleSemiBold.copyWith(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            Align(
              alignment: AlignmentGeometry.center,
              child: SizedBox(
                width: 200,
                child: OutlinedButtonDefault(
                  borderSide: BorderSide(
                    color: AppColors.secondaryGreen,
                    width: 1,
                  ),
                  onPressed: () async {
                    final _appKitModal = ReownAppKitModal(
                      context: context,
                      projectId: '56c6230f17501e971e9572ac3e6b7d09',
                      metadata: PairingMetadata(
                        name: 'FestChain',
                        description: 'Pagamentos em cripto',
                        url: 'https://fest-chain.com',
                        icons: ['https://www.fest-chain.com/assets/festchain-logo-BZ2JMyrZ.png'],
                        redirect: Redirect(
                          native: 'festchain://',
                          universal: 'https://festchain.com',
                          linkMode: true,
                        ),
                      ),
                    );

                    await _appKitModal.init();
                    await _appKitModal.openModalView();

                    Navigator.of(context).pushNamed(AppRoutes.cardsRoute);
                  },
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.softOrange,
                  splashColor: AppColors.terracottaRed.withAlpha(
                    (0.3 * 255).toInt(),
                  ),
                  child: Text(
                    context.s.connectWalletButton,
                    style: TextStylesDefault.robotButtonStyle.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
