import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/global_widgets/secondary_button.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/modules/perfil/perfil_controller.dart';
import 'package:get/get.dart';

class FormPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerfilController>(
      builder: (_) => LayoutBuilder(
        builder: (context, constraint) {
          return Padding(
            padding: EdgeInsets.only(bottom: constraint.maxHeight * .1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    height: 96,
                    child: Image(
                      image: AssetImage("assets/icons/perfil.png"),
                    )),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .05),
                Text(
                  "¿Es usted cliente o repartidor?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: AppTheme.blue, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .05),
                PrimaryButton(
                  texto: "Cliente",
                  onPressed: _.cargarRegistrar,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .03),
                SecondaryButton(
                  texto: "Repartidor",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
