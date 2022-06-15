import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ButtonNavigator extends StatelessWidget {
  const ButtonNavigator({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
      builder: (_) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: kBottomNavigationBarHeight * 1.1,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          decoration: BoxDecoration(
            color: AppTheme.blueBackground,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: PrimaryButton(
            texto: "Pedir el gas",
            onPressed: _.verFormPedirGas(),
          ),
        ),
      ),
    );
  }
}
