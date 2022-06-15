import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _cargarPermisoUbicacion();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  _cargarPermisoUbicacion() async {
    try {
      await Future.delayed(Duration(seconds: 3));
      Get.offNamed(
        AppRoutes.ubicacion,
      );
    } catch (e) {
      print(e);
    }
  }
}
