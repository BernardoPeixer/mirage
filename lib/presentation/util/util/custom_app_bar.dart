import 'package:flutter/material.dart';
import 'package:mirage/extension/context.dart';
import '../../../default/colors.dart';
import '../../../default/padding.dart';
import 'button/icon_button_default.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.onPressed,
    this.content,
    this.showButton = true,
  });

  /// Title defines a text in the center of app bar
  final String title;

  /// OnPressed defines a action on tap button
  final VoidCallback? onPressed;

  /// Content defines an extra content on right side of app bar
  final Widget? content;

  /// ShowButton defines if button is appear or not
  final bool? showButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      height: preferredSize.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (showButton!) ?
          IconButtonDefault(
            onPressed: onPressed,
          ) : SizedBox(
            width: kMinInteractiveDimension,
            height: kMinInteractiveDimension,
          ),
          Padding(padding: AppPadding.itemHorizontal),
          Expanded(
            child: Text(
              title,
              style: context.mediumBody.copyWith(
                color: AppColors.mindfulBrown80,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(padding: AppPadding.itemHorizontal),
          if(content != null)
            content!,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
