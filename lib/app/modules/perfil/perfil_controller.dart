import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

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

  cargarRegistrar() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.login);
    } catch (e) {
      print(e);
    }
  }
}
