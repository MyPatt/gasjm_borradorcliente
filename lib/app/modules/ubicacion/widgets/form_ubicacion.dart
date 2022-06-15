import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/modules/ubicacion/blocs/blocs.dart';
import 'package:gasjm/app/modules/ubicacion/ubicacion_controller.dart';
import 'package:get/get.dart';

class FormUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UbicacionController>(
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
                      image: AssetImage("assets/icons/gps.png"),
                    )),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .05),
                Text(
                  "Permisos de ubicación",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: AppTheme.blue, fontWeight: FontWeight.w900),
                ),
                Text(
                  "Esta aplicación requiere el permiso de ubicación para funcionar correctamente.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.black38, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .03),
                PrimaryButton(
                  texto: "Permitir",
                  onPressed:
                      // _.cargarIdentificacion
                      () {
                    final gpsBloc = BlocProvider.of<GpsBloc>(context);
                   gpsBloc.askGpsAccess();
                    
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
