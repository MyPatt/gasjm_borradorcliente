import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
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

  final error = Rx<String?>(null);
  //final isLoading = RxBool(false);
//Validar datos
  bool? esFormValido() {
    if (claveFormRegistrar.currentState?.validate() == true) {
      return true;
    } else {
      return false;
    }
  }

  //Metodo para registrar

  Future<void> crearUsuarioConCorreoYContrasena() async {
    print("\\_\n");
    try {
   //gtrue loa
      error.value = null;
      UsuarioModel usuarioDatos = UsuarioModel(
          nombreTextoController.text,
          apellidoTextoController.text,
          correoElectronicoTextoController.text,
          contrasenaTextoController.text);
           print("/\*/_\n");
      await _authRepository.crearUsuario(usuarioDatos);
      print("\/*\_\n");
    } catch (e) {
      error.value = e.toString();
    }
    //isLoading.value = false;
  }
 
}
