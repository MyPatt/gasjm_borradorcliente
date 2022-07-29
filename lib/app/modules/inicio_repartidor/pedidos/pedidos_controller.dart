 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:get/get.dart'; 

class PedidosController extends GetxController {
  @override
  void onInit() {
    
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
     _loadHouses();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //PEDIDOS EN ESPERA
  final _houseRepository = Get.find<PedidoRepository>();
  
    RxList<PedidoModel> _houses = RxList<PedidoModel>([]);
  RxList<PedidoModel> get houses => _houses;
  
  _loadHouses() async {
    try {
  
      _houses.value = (await _houseRepository.getPedidos(    ))!;
    } on FirebaseException catch (e) {
      Get.snackbar(
        'Mensaje',
        e.message??'Se produjo un error inesperado.',
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppTheme.blueDark,
      );
    }
  }
}
