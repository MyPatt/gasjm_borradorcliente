import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/cliente/menu_lateral.dart';
import 'package:gasjm/app/global_widgets/cliente/menu_appbar.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:gasjm/app/modules/inicio/local_widgets/boton_pedirgas.dart';
import 'package:gasjm/app/modules/inicio/local_widgets/form_pedirgas.dart';
import 'package:get/get.dart';

//Pantalla de inicio del cliente
class InicioPage extends StatelessWidget {
  const InicioPage({key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
      builder: (_) => Scaffold(
        //Menú deslizable a la izquierda con opciones del  usuario
        drawer:   MenuLateral(),
        //Barra de herramientas de opciones para  agenda y  historial
        appBar: AppBar(
          backgroundColor: AppTheme.blueBackground,
          elevation: 0.0,
          actions: const [MenuAppBar()],
        ),
        //Body
        backgroundColor: AppTheme.background,
        body: Stack(
          children: [
            //Widget Mapa
            Positioned.fill(
              // ignore: sized_box_for_whitespace
              child: Container(
                height: Responsive.getScreenSize(context).height * .40,
                // child: const ContentMap()
              ),
            ),
            //Widget Boton para pedir el gas
            const BotonPedirGas(),
            //Widget Formulario para pedir el gas
            Obx(() {
              return Visibility(
                visible: _.visibleFormPedirGas.value,
                child: const FormPedirGas(),
              );
            })
          ],
        ),
      ),
    );
  }
}
