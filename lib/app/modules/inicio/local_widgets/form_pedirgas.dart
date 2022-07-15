import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/theme/text_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
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
                child: ListView(
                  shrinkWrap: true,
          /*    mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,*/
                  children: [
                    const Text(
                        "GasJ&M",
                        style: TextoTheme.subtitleStyle1
                            ),
                        
                    const  TextDescription(text: "Ingrese los datos para realizar su pedido"),
                       SizedBox(
                        height: Responsive.getScreenSize(context).height * .05),
                    InputText(
                      controller: _.direccionTextoController,
                      keyboardType: TextInputType.streetAddress,
                      iconPrefix: Icons.room_outlined,
                      iconColor: AppTheme.light,
                      border: InputBorder.none,
                      labelText: "Dirección",
                      readOnly: true,
                      filled: false,
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    InputText(
                      keyboardType: TextInputType.streetAddress,
                      iconPrefix: Icons.home_outlined,
                      iconColor: AppTheme.light,
                      border: InputBorder.none,
                      labelText: "Referencia",
                      filled: false,
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    InputText(
                      iconPrefix: Icons.pin_outlined,
                      iconColor: AppTheme.light,
                      border: InputBorder.none,
                      keyboardType: TextInputType.phone,
                      //validator: null,
                      labelText: "Cantidad",
                      initialValue: "1",
                      filled: false, 
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .05),
                    PrimaryButton(
                      texto: "Pedir el gas",
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ));
  }
}
