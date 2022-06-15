import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class InicioController extends GetxController {
  //Formulario Pedir el Gas visible
  RxBool visibleFormPedirGas = false.obs;
  //
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
}
