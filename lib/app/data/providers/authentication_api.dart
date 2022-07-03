import 'package:dio/dio.dart'; 
import 'package:gasjm/app/core/utils/constants.dart';
import 'package:gasjm/app/data/models/request_token.dart';
import 'package:get/get.dart'; 

class AuthenticationAPI {
  final Dio _dio = Get.find<Dio>();

  Future<RequestToken> newRequestToken() async {
    final response = await _dio.get(
      '/authentication/token/new',
      queryParameters: {
        "api_key": Constants.THE_MOVIE_DB_API_KEY,
      },
    );
    return RequestToken.fromJson(response.data);
  }

  Future<RequestToken> validarConLogin({
    required String usuario,
    required String contrasena,
    required String requestToken,
  }) async {
    final response = await _dio
        .post('/authentication/token/validate_with_login', queryParameters: {
      "api_key": Constants.THE_MOVIE_DB_API_KEY,
    }, data: {
      "username": usuario,
      "password": contrasena,
      "request_token": requestToken,
    });
    return RequestToken.fromJson(response.data);
  }
}
