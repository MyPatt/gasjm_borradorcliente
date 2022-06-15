import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/button_navigator.dart';
import 'package:gasjm/app/global_widgets/cliente/menu_lateral.dart';
import 'package:gasjm/app/global_widgets/cliente/menu_appbar.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller copy.dart';
import 'package:gasjm/app/modules/inicio/local_widgets/content_map.dart';
import 'package:gasjm/app/modules/inicio/local_widgets/form_pedirgas.dart';
import 'package:provider/provider.dart';

class InicioPage extends StatelessWidget {
  //InicioPage({key}) : super(key: key);
//
  final controller = InicioController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InicioController>(
      create: (_) {
        controller.onMarkerTap.listen((String id) {
          // ignore: avoid_print
          print("go to $id");
        });
        return controller;
      },
      child: Scaffold(
        drawer: const MenuLateral(),
        appBar: AppBar(
          backgroundColor: AppTheme.blueBackground,
          elevation: 0.0,
          actions: const [MenuAppBar()],
        ),
        backgroundColor: AppTheme.background,
        body:
            //ContentMap()
            Stack(
          children: [
            /* Positioned.fill(
              // ignore: avoid_unnecessary_containers
              child: Container(child: const ContentMap()),
            ),*/

            Positioned.fill(
              // ignore: avoid_unnecessary_containers
              child: Container(
                  // height: Responsive.getScreenSize(context).height * .40,
                  child: const ContentMap()),
            ),
            ButtonNavigator(),
            const FormPedirGas(),
          ],
        ),
      ),
    );
  }
}
