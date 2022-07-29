import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/inicio_repartidor/pedidos/pedidos_controller.dart';
import 'package:get/get.dart';

class PedidosAceptadosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PedidosController>(
        builder: (_) =>   Center(
                    child: Text(
              'Second Activity Screen',
              style: TextStyle(fontSize: 21),
            )
            ));
  }
}
