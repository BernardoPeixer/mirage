import 'package:flutter/material.dart';

/// Class responsible for controlling all routes used in the app
class AppRoutes {
  /// Route responsible for the user login screen
  static const loginRoute = '/login';

  /// Route responsible for the cards main screen
  static const cardsRoute = '/cards';
}

/// Returns a route with a fade (opacity) transition.
///
/// [child] is the widget to be displayed on the new route.
Route<void> fadeRoute({required Widget child}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fadeAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );
      return FadeTransition(opacity: fadeAnimation, child: child);
    },
  );
}

/// Returns a route with a slide transition from right to left.
///
/// Typical Material (Android) navigation behavior.
/// [child] is the widget to be displayed on the new route.
Route<void> slideRightToLeftRoute({required Widget child}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: Curves.easeInOut));
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
