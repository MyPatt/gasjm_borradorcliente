import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilController extends GetxController {
  final RxBool _isOscure = true.obs;
  RxBool get isOscure => _isOscure;

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

  cargarLogin(String perfil) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      print("=====================#${perfil}\n");
      _guardarPerfil(perfil);
      Get.offNamed(AppRoutes.login);
    } catch (e) {
      print(e);
    }
  }

//Guardar perfil del usaurio de forma local
  _guardarPerfil(String perfil) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("perfil_usuario", perfil);
  }
}
