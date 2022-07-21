import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/modules/inicio_repartidor/local_widgets/menu_appbar.dart';
import 'package:gasjm/app/modules/inicio_repartidor/local_widgets/menu_lateral.dart'; 
import 'package:gasjm/app/modules/inicio_repartidor/local_widgets/repartidor_mapa.dart';

 

//Pantalla de inicio del cliente
class InicioRepartidorPage extends StatelessWidget {
  const InicioRepartidorPage({key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Container(
                height: Responsive.getScreenSize(context).height * .50,
                child: const RepartidorMapa()),
          ),
          //
        ]),
      
    );
  }
}
