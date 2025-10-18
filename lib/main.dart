import 'package:flutter/material.dart';
import 'package:mirage/default/routes.dart';
import 'package:mirage/presentation/cards/cards_page.dart';
import 'package:mirage/presentation/login/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [S.delegate],
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
