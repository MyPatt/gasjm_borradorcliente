import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class RegistrarController extends GetxController {
  //Variables para ocultar el texto de la contrasena
  final RxBool _contrasenaOculta = true.obs;
  RxBool get contrasenaOculta => _contrasenaOculta;
//Clave del formulario de resgistro de usuario
  final claveFormRegistrar = GlobalKey<FormState>();

  //Variables para controladores de campos de texto del formulario
  final nombreTextoController = TextEditingController();
  final apellidoTextoController = TextEditingController();
  final correoElectronicoTextoController = TextEditingController();
  final contrasenaTextoController = TextEditingController();
  //
//  UsuarioModel usuario;
  @override
  void onInit() {
    /*  usuario = UsuarioModel(
        nombreTextoController.text,
        apellidoTextoController.text,
        correoElectronicoTextoController.text,
        contrasenaTextoController.text);
        */
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

//
  cargarLogin() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.toNamed(AppRoutes.login);
    } catch (e) {
      print(e);
    }
  }

  /** REGISTRO CON CORREO EN FIREBASE */
  final _authRepository = Get.find<AutenticacionRepository>();

  // final error = Rx<String?>(null);
  //final isLoading = RxBool(false);

  //Metodo para registrar

  Future<void> crearUsuarioConCorreoYContrasena() async {
    print("\\_\n");
    try {
      cargandoParaCorreo.value = true;

      errorParaCorreo.value = null;
      UsuarioModel usuarioDatos = UsuarioModel(
          nombreTextoController.text,
          apellidoTextoController.text,
          correoElectronicoTextoController.text,
          contrasenaTextoController.text);
      print("/\*/_\n");
      await _authRepository.crearUsuario(usuarioDatos);
      print("\/*\_\n");
      //Mensaje de ingreso
      _showToastBienvenido();
    } on FirebaseAuthException catch (e) {
      errorParaCorreo.value = e.code;
    } catch (e) {
      errorParaCorreo.value = e.toString();
    }
    cargandoParaCorreo.value = false;
  }

  //con Google
  //Dependencia de AutenticacionRepository
  final _autenticacioRepository = Get.find<AutenticacionRepository>();
  //Existe algun error si o no
  final errorParaSocialMedia = Rx<String?>(null);
  //Se cago si o no
  final cargandoParaSocialMedia = RxBool(false);
  //
  Future<void> iniciarSesionConGoogle() =>
      _iniciarSesion(_autenticacioRepository.iniciarSesionConGoogle);
  //credencial para google
  Future<void> _iniciarSesion(
      Future<AutenticacionUsuario?> Function() auxUsuario) async {
    try {
      cargandoParaSocialMedia.value = true;
      errorParaSocialMedia.value = null;
      await auxUsuario();
      //Mensaje de ingreso
      _showToastBienvenido();
    } on FirebaseException catch (e) {
      errorParaSocialMedia.value = e.code;
    }catch (e) {
      errorParaSocialMedia.value =    "Error de registro. Inténtalo de nuevo.";
    }
    
    cargandoParaSocialMedia.value = false;
  }

  void _showToastBienvenido() {
    Fluttertoast.showToast(
        msg: 'Bienvenido...',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: AppTheme.blueBackground);
  }

  //Existe algun error si o no
  final errorParaCorreo = Rx<String?>(null);
  //Se cago si o no
  final cargandoParaCorreo = RxBool(false);
}
