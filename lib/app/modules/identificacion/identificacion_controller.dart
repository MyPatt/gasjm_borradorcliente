import 'package:flutter/material.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class IdentificacionController extends GetxController {
  //Controller para texto de la cedula
  final cedulaTextoController = TextEditingController();
  //
  final cargando = RxBool(false);
  final formKey = GlobalKey<FormState>();
  @override
  void onInit() {
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

//Guardar cedula de forma local
  _guardarCedula() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("cedula_usuario", cedulaTextoController.text);
  }

  cargarPerfil() async {
    try {
      cargando.value = true;
      await Future.delayed(const Duration(seconds: 1));
      _guardarCedula();
      Get.offNamed(AppRoutes.perfil);
    } catch (e) {
      print(e);
    }
    cargando.value = false;
  }
}
