

import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/providers/pedidos_provider.dart';
import 'package:gasjm/app/data/repository/implementations/pedido_repository.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void load() async {
     //Providers
    Get.put<PedidoProvider>(PedidoProvider());  

    //Local 

    //Respositories
    Get.put<PedidoRepository>(PedidoRepositoryImpl()); 

    //Local 
  }
}
