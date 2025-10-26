import 'package:flutter/material.dart';
import 'package:mirage/extension/context.dart';

import '../../../../default/text_styles.dart';
import '../../../../generated/l10n.dart';
import 'button_default.dart';

class OutlinedButtonDefault extends StatelessWidget {
  const OutlinedButtonDefault({
    super.key,
    this.borderRadius,
    this.color,
    this.padding,
    this.borderSide,
    this.splashColor,
    this.isLoading = false,
    required this.child,
    required this.onPressed,
  });

  const OutlinedButtonDefault.loading({
    super.key,
    this.borderRadius,
    this.color,
    this.padding,
    this.borderSide,
    this.splashColor,
    required this.isLoading,
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

  /// IsLoading references if the button is loading
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ButtonDefault(
      borderSide: borderSide,
      buttonPadding: padding,
      onPressed: isLoading ? () {} : onPressed,
      fillColor: color,
      splashColor: splashColor,
      shape: RoundedRectangleBorder(
        side: borderSide ?? BorderSide.none,
        borderRadius: borderRadius ?? BorderRadius.circular(30),
      ),
      child: isLoading
          ? Row(
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.current.loading,
                  style: TextStylesDefault.robotButtonStyle.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                CircularProgressIndicator(
                  strokeWidth: 2,
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  constraints: BoxConstraints(
                    maxHeight: 15,
                    maxWidth: 20,
                    minHeight: 15,
                    minWidth: 15,
                  ),
                ),
              ],
            )
          : child,
    );
  }
}
