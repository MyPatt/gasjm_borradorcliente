import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:gasjm/app/modules/inicio_repartidor/inicio_repartidor_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RepartidorMapa extends StatelessWidget {
  const RepartidorMapa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
    return GetBuilder<InicioRepartidorController>(
        builder: (_) => const Expanded(
                child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(-1.24, 0.74), zoom: 15),
              myLocationButtonEnabled: false,
              compassEnabled: false,
            )));
  }
}
//TODO: Boton para regresar a la ubicacion inicial