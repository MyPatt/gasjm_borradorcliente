import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/inicio_repartidor/local_widgets/bottom_repartidor.dart';
import 'package:gasjm/app/modules/inicio_repartidor/pedidos/local_widgets/aceptados_page.dart';
import 'package:gasjm/app/modules/inicio_repartidor/pedidos/local_widgets/enespera_page.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class PedidosPage extends StatelessWidget {
  const PedidosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.blueBackground,
            title: const Text('Pedidos'),
            automaticallyImplyLeading: false, 
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'En espera'),
                Tab(
                  text: 'Aceptados',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PedidosEnEsperaPage(),
              PedidosAceptadosPage(),
            ],
          ),
          //Navegacion del repartidor
          bottomNavigationBar: const BottomNavigationRepartidor(),
        ));
  }
}
