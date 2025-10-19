import 'dart:convert';

import 'package:http/http.dart';

import '../../generated/l10n.dart';

/// Exception throne when a request to the webservice API fails
class ApiResponseException implements Exception {
  /// Default constructor
  ApiResponseException.fromCause(
      this._cause,
      ) : response = null;

  /// Standard constructor
  ApiResponseException(this.response) {
    switch (response!.statusCode) {
      case 500:
        final message = jsonDecode(response!.body)['message'];
        _cause = message ?? '';
        break;
      case 401:
        final message = jsonDecode(response!.body)['message'];
        _cause = message ?? '';

      default:
        _cause = S.current.unexpectedError;
    }
  }

  /// Response of the http request
  final Response? response;

  late String _code;

  late String _cause;

  /// Return the cause
  String get cause => _cause;

  /// Return the internal code exception
  String get code => _code;
}
