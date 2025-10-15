import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../default/colors.dart';
import '../generated/l10n.dart';
import '../presentation/util/util/date_time_format.dart';

extension BuildContextExtension on BuildContext {
  /// Variable for resume for get S.of(context).[variable]
  S get s => S.of(this);

  /// Instance of text styles to get styles default
  TextTheme get textStyles => Theme.of(this).textTheme;

  /// Media query of screen // context
  Size get media => MediaQuery.sizeOf(this);

  /// Text style used to medium text sizes
  TextStyle get mediumBody => GoogleFonts.urbanist(
        fontWeight: FontWeight.w800,
        fontSize: 18,
        color: Colors.white,
      );

  /// Text style to descriptions and complements
  TextStyle get descriptionStyle => GoogleFonts.urbanist(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: AppColors.optimisticGray,
  );

  /// Get dateTime of transform in [dd/MM/yyyy] ?? ''
  String dateFormatDefault(DateTime? dateTime) {
    return tryFormatDate('dd/MM/yyyy', dateTime) ?? '';
  }

  /// Get dateTime of transform in [dd/MM/yyyy HH-mm-ss] ?? ''
  String dateTimeFormatDefault(DateTime? dateTime) {
    return tryFormatDate('dd/MM/yyyy HH-mm-ss', dateTime) ?? '';
  }

  ///convert a string to a date time
  DateTime? toDate(String date) {
    return tryParseDate(formattedFullDateTime, date);
  }

  ///Gets the formatted time
  String time(DateTime? dateTime) {
    return tryFormatDate('HH:mm', dateTime) ?? '';
  }

  /// Height of screen card default
  /// media.height < 800 ? media.height / 2 : media.height / 1.16
  double get heightScreen {
    if (media.height <= 600) {
      return media.height / 1.32;
    }
    if (media.height <= 800) {
      return media.height / 1.24;
    }
    return media.height / 1.18;
  }
  /// Height of screen card default
  /// media.height < 800 ? media.height / 2 : media.height / 1.16
  double get heightScreenRegister {
    if (media.height <= 600) {
      return media.height / 10;
    }
    if (media.height <= 800) {
      return media.height / 0;
    }
    return media.height / 10;
  }



  /// media.height < 800 ? media.height / 2 : media.height / 1.16
  double get heightScreenCenterEmployee {
    if (media.height <= 380) {
      return media.height / 1.30;
    }
    if (media.height <= 450) {
      return media.height / 1.22;
    }
    if (media.height <= 560) {
      return media.height / 1.18;
    }
    if (media.height <= 720) {
      return media.height / 1.14;
    }
    if (media.height <= 850) {
      return media.height / 1.11;
    }
    return media.height / 1.10;
  }
}
