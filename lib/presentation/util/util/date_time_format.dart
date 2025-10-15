import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

/// Standard date and time format to store timestamps on the database
/// 'yyyy-MM-dd HH:mm:ss'.
const formattedFullDateTime = 'yyyy-MM-dd HH:mm:ss';

/// Default datetime format for storing timestamps in shared preferences
/// yyyy-MM-dd
const formattedDateTime = 'yyyy-MM-dd HH:mm';

/// Default datetime format for storing timestamps in shared preferences
/// yyyy-MM-dd
const formattedDate = 'yyyy-MM-dd';

/// Default datetime format for storing timestamps in shared preferences
/// HH:mm
const formattedHour = 'HH:mm';

/// Default datetime format for storing timestamps in shared preferences
/// HH:mm:ss
const formattedHourFull = 'HH:mm:ss';

/// dd/MM/yyyy HH:mm:ss": This format represents the date and time in
/// the order day/month/year followed by hours:minutes:seconds.
const fullDateTime = 'dd/MM/yyyy HH:mm:ss';

/// dd/MM/yyyy HH:mm": This format represents the date and time in the order
/// day/month/year followed by hours:minutes.
const dateTime = 'dd/MM/yyyy HH:mm';

/// dd/MM/yyyy": This format represents the date in the order day/month/year.
const dateFormat = 'dd/MM/yyyy';

/// HH:mm": This format represents the hour in the order hour:minutes.
const hourFormat = 'HH:mm';

/// Try to parse the provided string as date with the provided format template.
/// Returns null if the string can't be parsed as a date
DateTime? tryParseDate(String template, String? date) {
  if (date == null || date.isEmpty) {
    return null;
  }

  try {
    return DateFormat(template).parseStrict(date);
  } on FormatException catch (e, stack) {
    logFailString('Error parsing date $e, stask: $stack');
    return null;
  }
}

/// Try to format the provided date as string with the provided format template.
/// Returns null if the date can't be parsed as a string
String? tryFormatDate(String template, DateTime? date) {
  if (date == null) {
    return null;
  }

  try {
    return DateFormat(template).format(date);
  } on FormatException catch (e, stack) {
    logFailString('Error formatting date $e stack: $stack');
    return null;
  }
}

/// Print a fail request message
void logFailString(String messageError) {
  Logger(
    output: ConsoleOutput(),
    printer: SimplePrinter(printTime: true, colors: true),
  ).e(messageError);
}
