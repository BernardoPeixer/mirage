import 'package:flutter/material.dart';
import 'package:mirage/extension/context.dart';

import '../../../../default/colors.dart';
import '../../../../default/padding.dart';

class ButtonDefault extends StatelessWidget {
  const ButtonDefault({
    super.key,
    required this.onPressed,
    required this.child,
    this.fillColor,
    this.shape,
    this.buttonPadding,
    this.borderSide,
    this.splashColor,
  });

  /// Function is called when button is pressed
  ///
  /// This callback is required and defines the behavior
  /// of button on pressed
  final VoidCallback onPressed;

  /// This parameter indicates the content of the button
  final Widget child;

  /// Color is used to fill the button
  ///
  /// The default color filled is [AppColors.darkGreen]
  /// to follow the app colors default
  final Color? fillColor;

  /// Shape is used to define the button format
  ///
  /// The default shape is
  ///  RoundedRectangleBorder(
  ///         borderRadius: BorderRadius.circular(100),
  ///  ),
  final ShapeBorder? shape;

  /// Padding used inside the button
  ///
  /// The default padding is [AppPadding.buttonPadding]
  final EdgeInsets? buttonPadding;

  /// Border side used in the button
  final BorderSide? borderSide;

  /// Splash color used in the button
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: fillColor ?? Colors.transparent,
      shape:
          shape ??
          RoundedRectangleBorder(
            side: borderSide ?? BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
      padding: buttonPadding ?? AppPadding.buttonPadding,
      splashColor: splashColor,
      child: child,
    );
  }
}
