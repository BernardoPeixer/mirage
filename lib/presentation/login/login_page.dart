import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirage/default/app_assets.dart';
import 'package:mirage/default/colors.dart';
import 'package:mirage/default/routes.dart';
import 'package:mirage/default/text_styles.dart';
import 'package:mirage/domain/exception/api_response_exception.dart';
import 'package:mirage/extension/context.dart';
import 'package:mirage/presentation/login/states/login_state.dart';
import 'package:mirage/presentation/state/wallet_state.dart';
import 'package:mirage/presentation/util/util/custom_snack_bar.dart';
import 'package:provider/provider.dart';
import '../util/util/button/outlined_button_default.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final walletState = Provider.of<WalletState>(context);
    final loginState = Provider.of<LoginState>(context);

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
              child: SizedBox(width: 200, child: _ConnectWalletButton()),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConnectWalletButton extends StatelessWidget {
  const _ConnectWalletButton();

  @override
  Widget build(BuildContext context) {
    return Selector<LoginState, bool>(
      selector: (_, loginState) => loginState.buttonLoading,
      builder: (context, buttonLoading, _) {
        return OutlinedButtonDefault.loading(
          isLoading: buttonLoading,
          borderSide: BorderSide(color: AppColors.secondaryGreen, width: 1),
          onPressed: () async {
            final walletState = Provider.of<WalletState>(
              context,
              listen: false,
            );
            final loginState = Provider.of<LoginState>(context, listen: false);

            loginState.buttonLoading = true;
            final result = await walletState.openModalVisual(context);

            if (result.message != null) {
              showSnackBarDefault(
                context: context,
                message: result.message!,
                isError: true,
              );

              loginState.buttonLoading = false;
              return;
            }

            final walletAddress = walletState.walletAddress ?? '';

            final (bool validUser, RegisterResult checkResult) =
                await loginState.checkUser(walletAddress);

            if (checkResult.message != null) {
              showSnackBarDefault(
                context: context,
                message: checkResult.message!,
                isError: true,
              );

              return;
            }

            if (!validUser) {
              final registerResult = await loginState.registerUser(
                walletAddress,
              );

              if (registerResult.message != null) {
                showSnackBarDefault(
                  context: context,
                  message: registerResult.message!,
                  isError: true,
                );

                return;
              }

              showSnackBarDefault(
                context: context,
                message: context.s.userRegisteredSuccessfully,
              );
            }

            loginState.buttonLoading = false;

            showSnackBarDefault(
              context: context,
              message: context.s.walletConnectedSuccessfully,
            );

            Navigator.pushNamed(context, AppRoutes.cardsRoute);
          },
          borderRadius: BorderRadius.circular(16),
          color: AppColors.softOrange,
          splashColor: AppColors.terracottaRed.withAlpha((0.3 * 255).toInt()),
          child: Text(
            context.s.connectWalletButton,
            style: TextStylesDefault.robotButtonStyle.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }
}
