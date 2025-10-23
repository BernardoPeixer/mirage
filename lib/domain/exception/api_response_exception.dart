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

/// Represents the result of a card registration operation.
///
/// This class indicates whether the registration was successful and provides
/// an optional message with additional information or error details.
class RegisterResult {
  RegisterResult({required this.success, this.message});

  /// Indicates whether the registration was successful.
  final bool success;

  /// Optional message describing additional details about the operation,
  /// such as an error reason or success confirmation.
  final String? message;
}

