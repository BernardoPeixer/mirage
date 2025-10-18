import 'package:flutter/material.dart';

import 'button_default.dart';

class OutlinedButtonDefault extends StatelessWidget {
  const OutlinedButtonDefault({
    super.key,
    this.borderRadius,
    this.color,
    this.padding,
    this.borderSide,
    this.splashColor,
    required this.child,
    required this.onPressed,
  });

  /// The border radius of the button.
  final BorderRadius? borderRadius;

  /// The background color of the button.
  final Color? color;

  /// The content displayed inside the button.
  final Widget child;

  /// The callback triggered when the button is pressed.
  final void Function() onPressed;

  /// The internal padding of the button.
  final EdgeInsets? padding;

  /// The border style of the outlined button.
  final BorderSide? borderSide;

  /// Splash color used in the button
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    return ButtonDefault(
      borderSide: borderSide,
      buttonPadding: padding,
      onPressed: onPressed,
      fillColor: color,
      splashColor: splashColor,
      shape: RoundedRectangleBorder(
        side: borderSide ?? BorderSide.none,
        borderRadius: borderRadius ?? BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
