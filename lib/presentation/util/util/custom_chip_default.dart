import 'package:flutter/material.dart';
import 'package:mirage/default/text_styles.dart';

import '../../../default/colors.dart';

class CustomChipDefault extends StatelessWidget {
  const CustomChipDefault({
    super.key,
    required this.label,
    required this.index,
    required this.selectedIndex,
  });

  final String label;

  final int index;

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? Color(0xffFF9A4D) : Color(0xffFFECB3),
        border: Border.all(color: Color(0xff70655B)),
      ),
      child: Align(
        alignment: AlignmentGeometry.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStylesDefault.robotoTitleBold.copyWith(
            fontSize: 14,
            color: isSelected ? Colors.white : AppColors.softOrange,
          ),
        ),
      ),
    );
  }
}
