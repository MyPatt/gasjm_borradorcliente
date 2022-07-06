import 'package:firebase_auth/firebase_auth.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart'; 
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart'; 

class InicioController extends GetxController {
  final _userRepository = Get.find<MyUserRepository>();

  //Formulario Pedir el Gas visible
  RxBool visibleFormPedirGas = false.obs;
  //
   Rx<UsuarioModel?> usuario = Rx(null);

 
  @override
  void onInit() { 
  getMyUser();
    super.onInit();
  }

    Future<void> getMyUser() async {
    
    usuario.value = await _userRepository.getUsuario();
  
  }

  @override
  void onReady() { 
    super.onReady();
  }

  @override
  void onClose() { 
    super.onClose();
  }

  // Metodo para cambiar la visibilidad del Formulario Pedir el Gas visible
  verFormPedirGas() {
    // ignore: avoid_print
    print(visibleFormPedirGas.value.toString());
    visibleFormPedirGas.value = true;
    // ignore: avoid_print
    print(visibleFormPedirGas.value.toString());
  }

  //Ir a la pantalla de agenda
  cargarAgenda() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.agenda);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  cargarLogin() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.login);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    cargarLogin;
  }
}
