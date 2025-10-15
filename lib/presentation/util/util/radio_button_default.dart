import 'package:flutter/material.dart';
import 'package:mirage/extension/context.dart';

import '../../../default/colors.dart';
import '../../../default/padding.dart';

class RadioButtonDefault extends StatelessWidget {
  const RadioButtonDefault({
    super.key,
    required this.text,
    required this.onChanged,
    required this.value,
    required this.groupValue,
    this.icon,
  });

  /// Text references the main content of radio button
  final String text;

  /// OnChanged reference on radio button is selected
  final ValueChanged<int?> onChanged;

  /// Value is the value returned in the radio button
  final int value;

  /// GroupValue is the value checked in the radio button
  final int groupValue;

  /// Icon references the icon of the left side in button
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        onChanged(value);
      },
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: Duration(milliseconds: 400),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mediumGreen : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: isSelected
              ? Border.all(
                  color: Colors.white.withOpacity(0.6),
                  width: 4,
                )
              : null,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.optimisticGray30,
              ),
              Padding(
                padding: AppPadding.itemHorizontal,
              ),
            ],
            Expanded(
              child: Text(
                text,
                style: context.mediumBody.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: isSelected ? Colors.white : AppColors.mindfulBrown80,
                ),
              ),
            ),
            Radio(
              value: value,
              groupValue: groupValue,
              onChanged: (value) {
                onChanged(value);
              },
              fillColor: isSelected
                  ? WidgetStatePropertyAll<Color>(Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
