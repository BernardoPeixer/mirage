import 'package:flutter/material.dart';
import 'package:mirage/default/routes.dart';
import 'package:mirage/infrastructure/data_store/repository/webservice/cards_webservice.dart';
import 'package:mirage/infrastructure/data_store/repository/webservice/user_webservice.dart';
import 'package:mirage/presentation/cards/cards_page.dart';
import 'package:mirage/presentation/cards/states/cards_page_state.dart';
import 'package:mirage/presentation/cards/states/cards_register_state.dart';
import 'package:mirage/presentation/login/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mirage/presentation/login/states/login_state.dart';
import 'package:mirage/presentation/state/global.dart';
import 'package:mirage/presentation/state/wallet_state.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final cardsWebService = CardsWebservice();
  final userWebService = UserWebservice();

  initializeState(
    cardsWebService: cardsWebService,
    userWebService: userWebService,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CardsRegisterState(useCase: cardsUseCase),
        ),
        ChangeNotifierProvider(
          create: (context) => CardsPageState(useCase: cardsUseCase),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginState(useCase: userUseCase),
        ),
        ChangeNotifierProvider(
          create: (context) => WalletState(),
        ),
      ],
      child: const Application(),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: Locale('en'),
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'FestChain',
      initialRoute: AppRoutes.loginRoute,
      routes: {
        AppRoutes.loginRoute: (context) => LoginPage(),
        AppRoutes.cardsRoute: (context) => CardsPage(),
      },
    );
  }
}
