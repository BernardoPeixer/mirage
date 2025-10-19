import 'dart:convert';

import 'package:mirage/domain/exception/api_response_exception.dart';
import 'package:mirage/infrastructure/data_store/repository/webservice/mirage_webservice.dart';
import 'package:http/http.dart' as http;

/// Webservice responsible for handling card-related API requests.
class CardsWebservice extends MirageWebService {
  /// Fetches all cards from the API.
  ///
  /// Returns a JSON-decoded map containing the list of cards.
  /// Throws [ApiResponseException] if the response status is not 200.
  Future<List<dynamic>> listAllCards() async {
    final url = '$domain/api/cards/list';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        logFail(response, url);
        throw ApiResponseException(response);
      }

      logSuccess(url, 'Success on request list cards');
      return jsonDecode(response.body);
    } on Exception catch (e) {
      logException(url, e);
      rethrow;
    }
  }
}
