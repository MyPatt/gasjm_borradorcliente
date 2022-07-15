import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/theme/text_theme.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:get/get.dart';

class FormPedirGas extends StatelessWidget {
  const FormPedirGas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
        builder: (_) => Container(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Form(
                  key: _.formKey,
                  child: ListView(
                    shrinkWrap: true,
                    /*    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,*/
                    children: [
                      const Text(
                        "Nuevo Pedido",
                        style: TextoTheme.subtitleStyle1,
                        textAlign: TextAlign.center,
                      ),
                      const TextDescription(
                          text: "Ingrese los datos para realizar su pedido"),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .03),
                      InputText(
                        controller: _.direccionTextoController,
                        keyboardType: TextInputType.streetAddress,
                        iconPrefix: Icons.room_outlined,
                        iconColor: AppTheme.light,
                        border: InputBorder.none,
                        labelText: "Dirección",
                        validator: Validacion.validarDireccion,
                        readOnly: true,
                        filled: false,
                      ),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .02),
                      InputText(
                        iconPrefix: Icons.pin_outlined,
                        iconColor: AppTheme.light,
                        border: InputBorder.none,
                        keyboardType: TextInputType.phone,
                        //validator: null,
                        labelText: "Cantidad",
                        initialValue: "1",
                        inputFormatters: <TextInputFormatter>[
                          //FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.allow(RegExp(r'\d{1,2}')),
                        ],
                        validator: Validacion.validarCantidadGas,
                        filled: false,
                      ),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .02),
                      InputText(
                        keyboardType: TextInputType.streetAddress,
                        iconPrefix: Icons.note_outlined,
                        iconColor: AppTheme.light,
                        border: InputBorder.none,
                        labelText: "Nota",
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp(r'[^\w]')),
                        ],
                        filled: false,
                      ),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .05),
                      PrimaryButton(
                        texto: "Pedir el gas",
                        onPressed: () {
                          if (_.formKey.currentState?.validate() == true) {
                            Navigator.pop(context);
                            Mensajes.showToastBienvenido("Pedido con éxito.");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
