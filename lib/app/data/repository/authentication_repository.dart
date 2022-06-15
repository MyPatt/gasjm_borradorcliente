import 'package:gasjm/app/data/models/request_token.dart';
import 'package:gasjm/app/data/providers/authentication_api.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart' show required;

class AuthenticationRepository {
  final AuthenticationAPI _api = Get.find<AuthenticationAPI>();

  Future<RequestToken> newRequestToken() => _api.newRequestToken();
  Future<RequestToken> authConLogin({
    @required String usuario,
    @required String contrasena,
    @required String requestToken,
  }) =>
      _api.validarConLogin(
        usuario:usuario,
          contrasena: contrasena,
           requestToken: requestToken
           );
}
