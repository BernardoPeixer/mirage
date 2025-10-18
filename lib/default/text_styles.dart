import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// Class responsible for controlling all text styles used in the app
class TextStylesDefault {
  /// Style responsible to set title font
  static final robotoTitleBold = GoogleFonts.roboto(
    color: AppColors.warmBrown,
    fontWeight: FontWeight.bold,
  );

  /// Style responsible to set subtitle font
  static final robotoSubtitleSemiBold = GoogleFonts.roboto(
    color: AppColors.softOrange,
    fontWeight: FontWeight.w600,
  );

  /// Style responsible to set button text font
  static final robotButtonStyle = GoogleFonts.roboto(
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
}
