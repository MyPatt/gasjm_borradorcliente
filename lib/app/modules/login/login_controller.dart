import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';

import 'package:get/get.dart';

import 'package:fluttertoast/fluttertoast.dart';

class LoginController extends GetxController {
  ///

  final RxBool _contrasenaOculta = true.obs;
  RxBool get contrasenaOculta => _contrasenaOculta;

  //Variables para el form
  final formKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool isProcessing = false;
  //Toast para notificar el inicio de sesion
  Fluttertoast? flutterToast;

  @override
  void onInit() {
    //
    flutterToast = Fluttertoast();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void mostrarContrasena() {
    _contrasenaOculta.value = _contrasenaOculta.value ? false : true;
  }

  //** Autenticacion para iniciar sesion **
  //Dependencia de AutenticacionRepository
  final _autenticacioRepository = Get.find<AutenticacionRepository>();
  //Existe algun error si o no
  final errorParaSocialMedia = Rx<String?>(null);
  //Se cago si o no
  final cargandoParaSocialMedia = RxBool(false);

//Iniciar sesion con Google
  Future<void> iniciarSesionConGoogle() =>
      _iniciarSesion(_autenticacioRepository.iniciarSesionConGoogle);

//Iniciar sesion con  Facebook
  Future<void> iniciarSesionConFacebook() =>
      _iniciarSesion(_autenticacioRepository.inicarSesionConFacebook);

  //Metodo que rige para iniciar sesion con el progress
  Future<void> _iniciarSesion(
      Future<AutenticacionUsuario?> Function() auxUsuario) async {
    try {
      cargandoParaSocialMedia.value = true;
      errorParaSocialMedia.value = null;
      await auxUsuario();
      //
      _showToastBienvenido();
    } catch (e) {
      errorParaSocialMedia.value = e.toString();
    }
    cargandoParaSocialMedia.value = false;
  }

//Inicar sesion con correo

  //Existe algun error si o no
  final errorParaCorreo = Rx<String?>(null);
  //Se cago si o no
  final cargandoParaCorreo = RxBool(false);

  Future<void> iniciarSesionConCorreoYContrasena() async {
    if (formKey.currentState?.validate() == true) {
      try {
        cargandoParaCorreo.value = true;
        errorParaCorreo.value = null;
        await _autenticacioRepository.iniciarSesionConCorreoYContrasena(
          emailTextController.text,
          passwordTextController.text,
        );
        //
        _showToastBienvenido();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          errorParaCorreo.value =
              'Ningún usuario encontrado con ese correo electrónico';
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          errorParaCorreo.value = 'Contraseña incorrecta';

          print('Wrong password provided for that user.');
        }
      } catch (e) {
        errorParaCorreo.value = e.toString();
      }
      cargandoParaCorreo.value = false;
    }
  }

  //Sin usar
  _showToast() {
    // this will be our toast UI
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );

    /* flutterToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
    );*/
  }

//Mensaje toast que muestra al iniciar sesion con exito
  void _showToastBienvenido() {
    Fluttertoast.showToast(
        msg: 'Bienvenido',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: AppTheme.blueBackground);
  }
}
