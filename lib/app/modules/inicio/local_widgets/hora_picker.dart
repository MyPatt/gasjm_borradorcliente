import 'package:flutter/cupertino.dart';

import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/global_widgets/secondary_button.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:get/get.dart';

// Widget para seleccionar la hora de entrega del pedido
class HoraPicker extends StatelessWidget {
  const HoraPicker({Key? key}) : super(key: key);

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
                const TextDescription(text: 'Elija una hora'),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .03),
                SizedBox(
                  height: Responsive.getScreenSize(context).height * .1,
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      initialDateTime: _.horaInicial?.value,
                      minimumDate: _.horaMinima?.value,
                      maximumDate: _.horaMaxima?.value,
                      onDateTimeChanged: (value) {
                        _.horaSeleccionada.value = value;
                      }),
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .03),
                PrimaryButton(
                    texto: 'Hecho',
                    onPressed: () {
                      _.fechaHoraDeEntregaGasController.value.text =
                          _.fechaHoraPedido();
                      Navigator.of(context).pop();
                    }),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                SecondaryButton(
                    texto: 'Omitir',
                    onPressed: () {
                      _.horaSeleccionada.value = DateTime(0, 0, 0, 0, 0);
                      _.fechaHoraDeEntregaGasController.value.text =
                          _.fechaHoraPedido();
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
