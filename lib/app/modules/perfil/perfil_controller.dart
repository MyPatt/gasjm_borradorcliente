import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/login/login_controller.dart';
import 'package:gasjm/app/modules/login/login_page.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {
  RxBool _isOscure = true.obs;
  RxBool get isOscure => _isOscure;

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

  cargarRegistrar() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      Get.offNamed(AppRoutes.registrar);
    } catch (e) {
      print(e);
    }
  }
}
