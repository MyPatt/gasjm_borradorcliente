import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/login/login_controller.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) => LayoutBuilder(
        builder: (context, constraint) {
          return Padding(
            padding: EdgeInsets.only(bottom: constraint.maxHeight * .1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Iniciar sesión",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: AppTheme.blue, fontWeight: FontWeight.w900),
                ),
                Text(
                  "Ingrese su contraseña",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.black38, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .05),
                InputText(
                    iconPrefix: Icons.person_outlined,
                    iconColor: AppTheme.light,
                    border: InputBorder.none,
                    keyboardType: TextInputType.emailAddress,
                    //validator: null,
                    labelText: "Usuario",
                    filled: false,
                    enabledBorderColor: Colors.black26,
                    focusedBorderColor: AppTheme.blueBackground,
                    fontSize: 14.0,
                    fontColor: Colors.black45,
                    onChanged: _.onChangedNombreUsuario),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                Obx(
                  () => InputText(
                    iconPrefix: Icons.lock_outlined,
                    iconColor: AppTheme.light,
                    border: InputBorder.none,
                    keyboardType: TextInputType.text,
                    obscureText: _.isOscure.value,
                    maxLines: 1,
                    //validator: null,
                    labelText: "Contraseña",
                    filled: false,
                    enabledBorderColor: Colors.black26,
                    focusedBorderColor: AppTheme.blueBackground,
                    fontSize: 14.0,
                    fontColor: Colors.black45,
                    suffixIcon: GestureDetector(
                      onTap: _.showPassword,
                      child: Icon(
                        _.isOscure.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppTheme.light,
                      ),
                    ),
                    onChanged: _.onChangedContrasenaUsuario,
                  ),
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .03),
                PrimaryButton(
                  texto: "Iniciar sesión",
                  onPressed: _.cargarInicio,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Contraseña olvidada",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.signup),
                      child: Text(
                        "Crear una cuenta nueva",
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: AppTheme.blueDark,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
