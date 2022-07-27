import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/inicio_repartidor/inicio_repartidor_controller.dart';
import 'package:gasjm/app/modules/inicio_repartidor/local_widgets/bottom_repartidor.dart';
import 'package:gasjm/app/modules/inicio_repartidor/local_widgets/menu_appbar.dart';
import 'package:gasjm/app/modules/inicio_repartidor/local_widgets/menu_lateral.dart';
import 'package:get/get.dart';

//Pantalla de inicio del cliente
class InicioRepartidorPage extends StatelessWidget {
  InicioRepartidorPage({key}) : super(key: key);
  final controller = InicioRepartidorController();
//
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioRepartidorController>(
        builder: (_) => Scaffold(
            //Menú deslizable a la izquierda con opciones del  usuario
            drawer: MenuLateral(),
            //Barra de herramientas de opciones para  agenda y  historial
            appBar: AppBar(
              backgroundColor: AppTheme.blueBackground,
              actions: const [MenuAppBar()],
              title: const Text('GasJ&M'),
            ),
            //Body
            body: Stack(children: [
              //Widget Mapa
              Positioned.fill(
                // ignore: sized_box_for_whitespace
                child: Obx(() => _.pantallasInicioRepartidor[
                    _.indexPantallaSeleccionada.value]['screen']),

                //
              )
            ]),
            //Navegacion del repartidor
            bottomNavigationBar: const BottomNavigationRepartidor()));

  }
}
