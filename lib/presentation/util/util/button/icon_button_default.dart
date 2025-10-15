import 'package:flutter/material.dart';

import '../../../../default/colors.dart';

class IconButtonDefault extends StatelessWidget {
  const IconButtonDefault({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints(
        minWidth: kMinInteractiveDimension,
        minHeight: kMinInteractiveDimension,
      ),
      onPressed: () {
        onPressed == null ? Navigator.pop(context) : onPressed!();
      },
      shape: CircleBorder(
        side: BorderSide(
          color: AppColors.mindfulBrown80,
        ),
      ),
      child: Icon(
        Icons.back_hand,
        color: AppColors.mindfulBrown80,
      ),
    );
  }
}
