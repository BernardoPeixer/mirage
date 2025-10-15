import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../default/colors.dart';
import '../../../../default/padding.dart';

class TextFormBoxDefault extends StatelessWidget {
  const TextFormBoxDefault({
    super.key,
    this.header,
    required this.controller,
    this.fillColor,
    required this.focus,
    this.prefix,
    this.textStyle,
    this.keyboardType,
    this.hintText,
    this.obscureText,
    this.suffix,
  });

  /// This parameter defines a header ahead of text form
  final String? header;

  /// This parameter defines a text controller of form box
  final TextEditingController controller;

  /// This parameter defines a fill color of text box
  ///
  /// The color default is [Colors.white]
  final Color? fillColor;

  /// This parameter defines a focus node of textbox
  final FocusNode focus;

  /// This parameter defines a prefix of form box
  final Widget? prefix;

  /// This parameter defines a text style inside of form box
  final TextStyle? textStyle;

  /// This parameter defines a keyboard type
  final TextInputType? keyboardType;

  /// This parameter defines a hint text inside text box
  final String? hintText;

  /// This parameter defines if show the text
  ///
  /// Usually used in password forms
  final bool? obscureText;

  /// This parameter defines a suffix of form box
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _TextFormBoxDefaultState(
        focus: focus,
        controller: controller,
      ),
      child: Consumer<_TextFormBoxDefaultState>(builder: (context, state, _) {
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
              ),
            ],
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: state.borderColor,
                ),
                borderRadius: BorderRadius.circular(50),
                color: fillColor ?? Colors.white,
              ),
              padding: AppPadding.textForm,
              child: Row(
                children: [
                  if (prefix != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: prefix!,
                    ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        if (state.showHintText)
                          Text(
                            hintText!,
                            style: GoogleFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.optimisticGray,
                            ),
                          ),
                        EditableText(
                          obscureText: obscureText ?? false,
                          controller: controller,
                          style: textStyle ??
                              GoogleFonts.urbanist(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                          focusNode: focus,
                          backgroundCursorColor: Colors.black,
                          cursorColor: Colors.black,
                          textAlign: TextAlign.left,
                          keyboardType: keyboardType ?? TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                  if(suffix != null) Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: suffix!,
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _TextFormBoxDefaultState extends ChangeNotifier {
  _TextFormBoxDefaultState({
    required FocusNode focus,
    required TextEditingController controller,
  })  : _focus = focus,
        _controller = controller {
    init();
  }

  final FocusNode _focus;

  final TextEditingController _controller;

  void init() {
    _focus.addListener(_onFocusChange);
    _controller.addListener(_onControllerChange);
  }

  void _onFocusChange() {
    notifyListeners();
  }

  void _onControllerChange() {
    notifyListeners();
  }

  Color get borderColor =>
      _focus.hasFocus ? AppColors.empathyOrange : Colors.transparent;

  bool get showHintText => _controller.text.isEmpty;

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _controller.removeListener(_onControllerChange);
    super.dispose();
  }
}
