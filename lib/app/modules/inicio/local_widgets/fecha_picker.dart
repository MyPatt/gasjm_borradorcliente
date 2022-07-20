import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/global_widgets/secondary_button.dart';
import 'package:gasjm/app/global_widgets/text_description.dart'; 
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:gasjm/app/modules/inicio/local_widgets/hora_picker.dart';
import 'package:get/get.dart';

// Widget para seleccionar la fecha de entrega del pedido
class FechaPicker extends StatelessWidget {
  const FechaPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
      builder: (_) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Center(
                child: ListView(
              shrinkWrap: true,
              children: [
                const TextDescription(text: 'Elija una fecha'),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .03),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .1,
                    child: CupertinoPicker(
                        itemExtent: 32.0,
                        magnification: 2.35 / 2.1,
                        squeeze: 1.25,
                        useMagnifier: true,
                        onSelectedItemChanged: (item) {
                          _.itemSeleccionadoDia.value = item;
                        },
                        children: const <Widget>[
                          Text(
                            "Ahora",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Mañana",
                            textAlign: TextAlign.center,
                          )
                        ])),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .03),
                PrimaryButton(
                    texto: 'Siguiente',
                    onPressed: () {
                      Navigator.of(context).pop();
                      _.seleccionarHoraInicial();
                      showModalBottomSheet(
                          context: context, builder: (_) => const HoraPicker());
                    }),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                SecondaryButton(
                    texto: 'Cerrar',
                    onPressed: () {
                      _.itemSeleccionadoDia.value = 0;
                      Navigator.of(context).pop();
                    }),
              ],
            )),
          )),
    );
  }
}
