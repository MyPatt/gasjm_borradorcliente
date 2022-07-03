import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class FormPedirGas extends StatelessWidget {
  const FormPedirGas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
      builder: (_) =>
          /* Obx(() {
        return 
          Visibility(
        visible: _.visibleFormPedirGas.value,*/
          Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: Responsive.getScreenSize(context).height * .60,
          decoration: const BoxDecoration(color: Colors.white
              /* borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.0),
              topRight: Radius.circular(35.0),
            ),*/
              ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputText(
                  keyboardType: TextInputType.streetAddress,
                  iconPrefix: Icons.maps_home_work_outlined,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  labelText: "Barrio / Sector",
                  filled: false,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                InputText(
                  keyboardType: TextInputType.streetAddress,
                  iconPrefix: Icons.streetview_sharp,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  labelText: "Calle principal",
                  filled: false,
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .02),
                InputText(
                  keyboardType: TextInputType.streetAddress,
                  iconPrefix: Icons.streetview_outlined,
                  iconColor: AppTheme.light,
                  border: InputBorder.none,
                  labelText: "Calle secundaria",
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
                    height: Responsive.getScreenSize(context).height * .03),
                PrimaryButton(
                  texto: "Pedir el gas",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
