import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mirage/domain/entities/entity_user.dart';
import 'package:mirage/infrastructure/data_store/repository/webservice/mirage_webservice.dart';

import '../../../../domain/exception/api_response_exception.dart';

///
class UserWebservice extends MirageWebService {
  ///
  Future<void> registerUser(UserInfo user) async {
    final url = '$domain/api/user/register';
    final uri = Uri.parse(url);

    try {
      final response = await http.post(
        uri,
        body: jsonEncode({'wallet_address': user.walletAddress}),
      );

      if (response.statusCode != 200) {
        logFail(response, url);
        throw ApiResponseException(response);
      }

      logSuccess(url, 'Success on register user');
    } on Exception catch (e) {
      logException(url, e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> checkUser(String walletAddress) async {
    final url = '$domain/api/user/checkUser';
    final uri = Uri.parse(url);

    try {
      final response = await http.post(
        uri,
        body: jsonEncode({'wallet_address': walletAddress}),
      );

      if (response.statusCode != 200) {
        logFail(response, url);
        throw ApiResponseException(response);
      }

      logSuccess(url, 'Success on check user');
      return jsonDecode(response.body);
    } on Exception catch (e) {
      logException(url, e);
      rethrow;
    }
  }
}
