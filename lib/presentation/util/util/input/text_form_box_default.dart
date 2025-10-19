import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../default/colors.dart';
import '../../../../default/padding.dart';

/// A custom text input box using [EditableText] that supports
/// headers, prefixes, suffixes, hint text, and form validation.
///
/// This widget is designed to behave similarly to [TextFormField],
/// but uses [EditableText] directly while keeping full control over styling.
class TextFormBoxDefault extends StatelessWidget {
  /// Creates a [TextFormBoxDefault] widget.
  const TextFormBoxDefault({
    super.key,
    required this.controller,
    required this.focus,
    this.header,
    this.hintText,
    this.prefix,
    this.suffix,
    this.textStyle,
    this.keyboardType,
    this.fillColor,
    this.obscureText,
    this.readOnly = false,
    this.validator,
  });

  /// Controller for the text input.
  final TextEditingController controller;

  /// Focus node for the input.
  final FocusNode focus;

  /// Optional header displayed above the input.
  final String? header;

  /// Optional hint text displayed when the field is empty.
  final String? hintText;

  /// Optional prefix widget displayed at the start of the input.
  final Widget? prefix;

  /// Optional suffix widget displayed at the end of the input.
  final Widget? suffix;

  /// Text style used inside the input.
  final TextStyle? textStyle;

  /// Keyboard type for the input.
  final TextInputType? keyboardType;

  /// Fill color for the input container.
  final Color? fillColor;

  /// Whether the input should obscure text (e.g., passwords).
  final bool? obscureText;

  /// Whether the input is read-only.
  final bool readOnly;

  /// Optional validator function for form validation.
  final String? Function(String?)? validator;

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
          const SizedBox(height: 4),
        ],
        FormField<String>(
          initialValue: controller.text,
          validator: validator,
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: focus.hasFocus
                            ? AppColors.empathyOrange
                            : const Color(0xff5B734D)),
                    borderRadius: BorderRadius.circular(16),
                    color: fillColor ?? Colors.white,
                  ),
                  padding: AppPadding.textForm,
                  child: Row(
                    children: [
                      if (prefix != null) ...[
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: prefix!,
                        ),
                      ],
                      Expanded(
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            if (controller.text.isEmpty && hintText != null)
                              Text(
                                hintText!,
                                style: GoogleFonts.urbanist(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.optimisticGray,
                                ),
                              ),
                            EditableText(
                              controller: controller,
                              focusNode: focus,
                              readOnly: readOnly,
                              obscureText: obscureText ?? false,
                              style: textStyle ??
                                  GoogleFonts.urbanist(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                              cursorColor: Colors.black,
                              backgroundCursorColor: Colors.black,
                              keyboardType: keyboardType ?? TextInputType.text,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      if (suffix != null) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: suffix!,
                        ),
                      ],
                    ],
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
