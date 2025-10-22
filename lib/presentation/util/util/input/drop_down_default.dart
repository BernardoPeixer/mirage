import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../default/colors.dart';

/// A generic dropdown widget that supports a header, hint,
/// and custom validation, with default styling.
class CustomDropdown<T> extends StatelessWidget {
  /// Creates a [CustomDropdown] widget.
  const CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
    required this.dropDownChildItem,
    this.header,
    this.validator,
  });

  /// The list of all items available in the dropdown.
  final List<T> items;

  /// The currently selected item.
  final T? value;

  /// Callback executed when the user selects an item.
  final void Function(T? value)? onChanged;

  /// Optional hint text displayed when no item is selected.
  final String? hint;

  /// List of [DropdownMenuItem] widgets used to build the dropdown.
  final List<DropdownMenuItem<T>> dropDownChildItem;

  /// Optional header displayed above the dropdown.
  final String? header;

  /// Optional validator function for form validation.
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) ...[
          Text(
            header!,
            style: GoogleFonts.urbanist(
              color: AppColors.mindfulBrown80,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
        ],
        DropdownButtonFormField<T>(
          dropdownColor: Color(0xffFFF9E6),
          validator: validator,
          initialValue: value,
          hint: hint != null ? Text(hint!) : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
          onChanged: onChanged,
          items: dropDownChildItem,
        ),
      ],
    );
  }
}
