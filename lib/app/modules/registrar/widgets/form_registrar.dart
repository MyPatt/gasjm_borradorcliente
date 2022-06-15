import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/registrar/registrar_controller.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormRegistrar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrarController>(
      builder: (_) => LayoutBuilder(
        builder: (context, constraint) {
          return Padding(
            padding: EdgeInsets.only(bottom: constraint.maxHeight * .1),
            child: ListView(
              /* mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,*/
              children: [
                Text(
                  "Registrar",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: AppTheme.blue, fontWeight: FontWeight.w900),
                ),
                Text(
                  "Ingrese sus datos",
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
                  keyboardType: TextInputType.name,
                  //validator: ),
                  labelText: "Nombre",
                  filled: false,
                  enabledBorderColor: Colors.black26,
                  focusedBorderColor: AppTheme.blueBackground,
                  fontSize: 14.0,
                  fontColor: Colors.black45,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                InputText(
                  iconPrefix: Icons.person_outlined,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  keyboardType: TextInputType.name,
                  // //validator: null,
                  labelText: "Apellido",
                  filled: false,
                  enabledBorderColor: Colors.black26,
                  focusedBorderColor: AppTheme.blueBackground,
                  fontSize: 14.0,
                  fontColor: Colors.black45,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                InputText(
                  iconPrefix: Icons.email_outlined,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  keyboardType: TextInputType.emailAddress,
                  // //validator: null,
                  labelText: "Correo",
                  filled: false,
                  enabledBorderColor: Colors.black26,
                  focusedBorderColor: AppTheme.blueBackground,
                  fontSize: 14.0,
                  fontColor: Colors.black45,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                InputText(
                  iconPrefix: Icons.phone_outlined,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  keyboardType: TextInputType.number,
                  ////validator: null,
                  labelText: "Celular",
                  filled: false,
                  enabledBorderColor: Colors.black26,
                  focusedBorderColor: AppTheme.blueBackground,
                  fontSize: 14.0,
                  fontColor: Colors.black45,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                InputText(
                  iconPrefix: Icons.calendar_today_outlined,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  keyboardType: TextInputType.datetime,
                  ////validator: null,
                  labelText: "Fecha de nacimiento",
                  filled: false,
                  enabledBorderColor: Colors.black26,
                  focusedBorderColor: AppTheme.blueBackground,
                  fontSize: 14.0,
                  fontColor: Colors.black45,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                Obx(
                  () => InputText(
                    iconPrefix: Icons.lock,
                    iconColor: AppTheme.light,
                    border: InputBorder.none,
                    keyboardType: TextInputType.text,
                    obscureText: _.isOscure1.value,
                    maxLines: 1,
                    ////validator: null,
                    labelText: "Contraseña",
                    filled: false,
                    enabledBorderColor: Colors.black26,
                    focusedBorderColor: AppTheme.blueBackground,
                    fontSize: 14.0,
                    fontColor: Colors.black45,
                    suffixIcon: GestureDetector(
                      onTap: _.mostrarContrasena,
                      child: Icon(
                        _.isOscure1.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppTheme.light,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .03),
                PrimaryButton(texto: "Registrar", onPressed: _.cargarLogin),
              ],
            ),
          );
        },
      ),
    );
  }
}

/*
Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Registrar",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: AppTheme.blue, fontWeight: FontWeight.w900),
                ),
                Text(
                  "Ingrese sus datos",
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
                  keyboardType: TextInputType.name,
                  //validator: null,
                  labelText: "Nombre",
                  filled: false,
                  enabledBorderColor: Colors.black26,
                  focusedBorderColor: AppTheme.blueBackground,
                  fontSize: 14.0,
                  fontColor: Colors.black45,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                InputText(
                  iconPrefix: Icons.person_outlined,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  keyboardType: TextInputType.name,
                  //validator: null,
                  labelText: "Apellido",
                  filled: false,
                  enabledBorderColor: Colors.black26,
                  focusedBorderColor: AppTheme.blueBackground,
                  fontSize: 14.0,
                  fontColor: Colors.black45,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                InputText(
                  iconPrefix: Icons.email_outlined,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  keyboardType: TextInputType.emailAddress,
                  //validator: null,
                  labelText: "Correo",
                  filled: false,
                  enabledBorderColor: Colors.black26,
                  focusedBorderColor: AppTheme.blueBackground,
                  fontSize: 14.0,
                  fontColor: Colors.black45,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                InputText(
                  iconPrefix: Icons.phone_outlined,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  keyboardType: TextInputType.number,
                  //validator: null,
                  labelText: "Celular",
                  filled: false,
                  enabledBorderColor: Colors.black26,
                  focusedBorderColor: AppTheme.blueBackground,
                  fontSize: 14.0,
                  fontColor: Colors.black45,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                InputText(
                  iconPrefix: Icons.calendar_today_outlined,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  keyboardType: TextInputType.datetime,
                  //validator: null,
                  labelText: "Fecha de nacimiento",
                  filled: false,
                  enabledBorderColor: Colors.black26,
                  focusedBorderColor: AppTheme.blueBackground,
                  fontSize: 14.0,
                  fontColor: Colors.black45,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                Obx(
                  () => InputText(
                    iconPrefix: Icons.lock,
                    iconColor: AppTheme.light,
                    border: InputBorder.none,
                    keyboardType: TextInputType.text,
                    obscureText: _.isOscure1.value,
                    maxLines: 1,
                    //validator: null,
                    labelText: "Contraseña",
                    filled: false,
                    enabledBorderColor: Colors.black26,
                    focusedBorderColor: AppTheme.blueBackground,
                    fontSize: 14.0,
                    fontColor: Colors.black45,
                    suffixIcon: GestureDetector(
                      onTap: _.mostrarContrasena,
                      child: Icon(
                        _.isOscure1.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppTheme.light,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => InputText(
                    iconPrefix: Icons.lock,
                    iconColor: AppTheme.light,
                    border: InputBorder.none,
                    keyboardType: TextInputType.text,
                    obscureText: _.isOscure2.value,
                    maxLines: 1,
                    //validator: null,
                    labelText: "Contraseña",
                    filled: false,
                    enabledBorderColor: Colors.black26,
                    focusedBorderColor: AppTheme.blueBackground,
                    fontSize: 14.0,
                    fontColor: Colors.black45,
                    suffixIcon: GestureDetector(
                      onTap: _.mostrarConfirmacionContrasena,
                      child: Icon(
                        _.isOscure2.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppTheme.light,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .03),
                PrimaryButton(texto: "Registrar", onPressed: _.cargarLogin),
              ],
            ),
*/
