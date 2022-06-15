import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/request_token.dart';
import 'package:gasjm/app/data/repository/authentication_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _repository = Get.find<AuthenticationRepository>();

  String _usuario = '', _contrasena = '';

  void onChangedNombreUsuario(String texto) {
    _usuario = texto;
  }

  void onChangedContrasenaUsuario(String texto) {
    _contrasena = texto;
  }

  Future<void> submit() async {
    try {
      RequestToken requestToken = await _repository.newRequestToken();
      final RequestToken authRequestToken = await _repository.authConLogin(
          usuario: _usuario,
          contrasena: _contrasena,
          requestToken: requestToken.requestToken);
      print("ok");
    } catch (e) {
      print(e);
      String mensaje = "error";
      if (e is DioError) {
        if (e.response != null) {
          mensaje = e.response.statusMessage;
        } else {
          mensaje = e.message;
        }
      }
      Get.dialog(AlertDialog(
        title: Text("ERROR"),
        content: Text(mensaje),
        actions: [
          FlatButton(
              onPressed: () {
                Get.back();
              },
              child: Text("OK"))
        ],
      ));
      await Future.delayed(Duration(seconds: 2));
      Get.offNamed(
        AppRoutes.inicio,
      );
    }
  }

  /* final _authRepository = Get.find<AuthenticationRepository>();
  final _authStorage = Get.find<AuthStorageRepository>();

  RequestToken _oRequestToken = RequestToken();
  RequestToken get oRequestToken => _oRequestToken;
*/
  RxBool _isOscure = true.obs;
  RxBool get isOscure => _isOscure;

  /* String _email = "";
  String _password = ""; */
  String _email = "gqcrispin@gmail.com";
  String _password = "123456";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void onChangedEmail(String value) {
    print(value);
    _email = value;
  }

  void onChangedPassword(String value) {
    print(value);
    _password = value;
  }

  void showPassword() {
    _isOscure.value = _isOscure.value ? false : true;
  }

  auth() async {
    /*  try {
      _oRequestToken = await _authRepository.authentication(
        email: _email,
        password: _password,
      );

      //Guardar datos en storage
      _authStorage.setSession(requestToken: _oRequestToken);

      if (_oRequestToken.success) {
        Get.offNamed(AppRoutes.HOME, arguments: _oRequestToken.requestToken);
      }
    } on DioError catch (e) {
      Get.snackbar(
        'Message',
        e.response.data["message"],
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppTheme.blueBackground,
      );
    }*/
  }

  cargarInicio() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      Get.offNamed(AppRoutes.inicio);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
