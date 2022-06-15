import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';

import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/modules/identificacion/identificacion_controller.dart';
import 'package:get/get.dart';

class FormIdentificacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IdentificacionController>(
      builder: (_) => LayoutBuilder(
        builder: (context, constraint) {
          return Padding(
            padding: EdgeInsets.only(bottom: constraint.maxHeight * .1),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    height: 96,
                    child: const Image(
                      image: AssetImage("assets/icons/identificacion.png"),
                    )
                    ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .05),
                Text(
                  "Identificación",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: AppTheme.blue, fontWeight: FontWeight.w900),
                ),
                Text(
                  "Ingrese su número de identificación para iniciar sesión",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.black38, fontWeight: FontWeight.w400),
                ),
                /* SizedBox(
                    height: Responsive.getScreenSize(context).height * .05),*/
                InputText(
                  keyboardType: TextInputType.number,
                  iconPrefix: Icons.credit_card,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  validator: null,
                  labelText: "Cédula o NIC",
                  filled: false,
                  enabledBorderColor: Colors.black26,
                  focusedBorderColor: AppTheme.blueBackground,
                  fontSize: 14.0,
                  fontColor: Colors.black45,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .03),
                PrimaryButton(
                  texto: "Siguiente",
                  onPressed: _.cargarPerfil,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
