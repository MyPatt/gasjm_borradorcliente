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
      builder: (_) => Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(children: <Widget>[
            const TextDescription(text: 'Elije una fecha'),
            Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .03),
                  SizedBox(
                    height: Responsive.getScreenSize(context).height * .1,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                     /*   minimumDate: _.fechaActual,
                        // initialDateTime: DateTime.parse(_.cambiarFormatoFecha(_.fechaSeleccionada.value)),
                        maximumDate: _.fechaMaxima,
                        //
                        dateOrder: DatePickerDateOrder.dmy,
                        onDateTimeChanged: (value) {
                          print(_.fechaActual);
                          print("object+\n");
                          print(_.fechaMaxima);
                          _.fechaSeleccionada.value = value;*/
                         onDateTimeChanged: (DateTime value) {  },),
                  ),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .03),
                  PrimaryButton(
                      texto: 'Siguiente',
                      onPressed: () {
                        Navigator.of(context).pop();
                   
                        //
                        /* if (_.cambiarFormatoFecha(_.fechaActual) ==
                            _.cambiarFormatoFecha(_.fechaSeleccionada.value)) {
                          print(
                              "AFTER: ${_.cambiarFormatoFecha(_.fechaActual)} - ${ _.cambiarFormatoFecha(_.fechaSeleccionada.value)}");
                        } else {
                          print(
                              "BEFORE: ${_.cambiarFormatoFecha(_.fechaActual)} - ${ _.cambiarFormatoFecha(_.fechaSeleccionada.value)}");
                        }*/
                        //
                        showModalBottomSheet(
                            context: context,
                            builder: (_) => const HoraPicker());
                      }),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .02),
                  SecondaryButton(
                      texto: 'Cerrar',
                      onPressed: () {
                        //Cerrar y asignar la fecha seleccionada
                        /* _.fechaHoraDeEntregaGasController.value.text =
                            _.cambiarFormatoFecha(_.fechaSeleccionada.value);*/
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          ])),
    );
  }
}
