import 'package:gasjm/app/modules/registrar/registrar_controller.dart';
import 'package:gasjm/app/modules/registrar/registrar_page.dart';
import 'package:get/get.dart';

class RegistrarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrarController());
  }
}
