
import 'package:gasjm/app/modules/inicio_repartidor/inicio_repartidor_controller.dart';
import 'package:get/get.dart';

class InicioRepartidorBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut(() => InicioRepartidorController());
  }
}