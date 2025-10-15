import 'package:intl/intl.dart';

/// Extension to manage date times
extension DateExtension on DateTime {
  /// Converts a datetime(yyyy-MM-dd HH:mm:ss) to date(yyyy-MM-dd) format
  DateTime get toDateFormat {
    final format = DateFormat('yyyy-MM-dd');

    final dateString = format.format(this);
    return format.parse(dateString);
  }

  /// Converts a datetime(yyyy-MM-dd HH:mm:ss) to date(dd/MM/yyyy) format
  String get toDateFormatBr {
    final format = DateFormat('dd/MM/yyyy');

    final dateString = format.format(this);
    return dateString;
  }

  /// Converts the datetime to the provided format
  DateTime formattedDate({required DateFormat format}) {
    final formatted = format.format(this);
    return format.parse(formatted);
  }
}