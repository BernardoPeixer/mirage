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

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: fillColor ?? AppColors.darkGreen,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
      padding: buttonPadding ?? AppPadding.buttonPadding,
      child: child,
    );
  }

  factory ButtonDefault.icon({
    required VoidCallback onPressed,
    required String textContent,
    required IconData icon,
    required BuildContext context,
  }) {
    return ButtonDefault(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textContent,
            style: context.mediumBody,
          ),
          Padding(padding: AppPadding.itemHorizontal),
          Icon(
            icon,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
