import 'package:flutter/material.dart';
import 'package:gasjm/app/routes/app_routes.dart';
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

  cargarLogin() async {
    //Get.lazyPut(() => LoginController());
    // Get.offNamed(AppRoutes.LOGIN);
    //  Get.offNamed(AppRoutes.LOGIN);
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.login);
    } catch (e) {
      print(e);
    }
  }

  cargarPerfil() async {
    try {
      cargando.value = true;
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.perfil);
    } catch (e) {
      print(e);
    }
    cargando.value = false;
  }
}
