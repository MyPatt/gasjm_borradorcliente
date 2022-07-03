import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:get/get.dart';

class MyUserController extends GetxController {
  final _userRepository = Get.find<MyUserRepository>();

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  final correoController = TextEditingController();
  final contrasenaController = TextEditingController(); 

  Rx<File?> pickedImage = Rx(null);
  Rx<bool> isLoading = Rx(false);
  Rx<bool> isSaving = Rx(false);
  Rx<UsuarioModel?> user = Rx(null);

  @override
  void onInit() {
    getMyUser();
    super.onInit();
  }

  void setImage(File? imageFile) async {
    pickedImage.value = imageFile;
  }

  Future<void> getMyUser() async {
    isLoading.value = true;
    user.value = await _userRepository.getMyUser();
    nameController.text = user.value?.nombre ?? '';
    lastNameController.text = user.value?.apellido ?? '';
    //ageController.text = user.value?.age.toString() ?? '';
    isLoading.value = false;
  }

  Future<void> saveMyUser() async {
    isSaving.value = true;
    final uid =
        Get.find<AutenticacionController>().autenticacionUsuario.value!.uid;
    final name = nameController.text;
    final lastName = lastNameController.text;
        final correo = correoController.text;
    final contrasena =contrasenaController.text;
    //final age = int.tryParse(ageController.text) ?? 0; 
    final newUser =UsuarioModel( name, lastName, correo, contrasena);
    user.value = newUser;

    // For testing add delay
    await Future.delayed(const Duration(seconds: 3));
    await _userRepository.saveMyUser(newUser, pickedImage.value);
    isSaving.value = false;
  }
}
