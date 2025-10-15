import 'package:flutter/material.dart';
import 'package:mirage/default/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [],
      supportedLocales: [Locale('en', ''), Locale('es', ''), Locale('pt', '')],
      debugShowCheckedModeBanner: false,
      title: 'FestChain',
      initialRoute: AppRoutes.loginRoute,
      routes: {AppRoutes.loginRoute: (context) => Scaffold()},
    );
  }
}
