import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class MirageWebService {
  /// Path default to make requests
  final String domain = 'http://192.168.15.6:8182';
}

/// Print a fail request message
void logFail(http.Response response, String path) {
  Logger(
    output: ConsoleOutput(),
    printer: PrettyPrinter(printTime: true, colors: true),
  ).e('$path: ${response.body}');
}

/// Print a success request message
void logSuccess(String path, String description) {
  Logger(
    output: ConsoleOutput(),
    printer: PrettyPrinter(printTime: true, colors: true),
  ).i('$path: $description');
}

/// Print a exception request message
void logException(String path, Exception e) {
  Logger(
    output: ConsoleOutput(),
    printer: PrettyPrinter(printTime: true, colors: true),
  ).f('$path: $e');
}