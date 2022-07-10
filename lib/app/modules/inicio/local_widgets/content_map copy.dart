import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller copy 2.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContentMap extends StatelessWidget {
  const ContentMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
      builder: (_) => GoogleMap(
          markers: _.markerss,
          // onMapCreated: _.onMapaCreated,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(estiloMapa);
            _.controllerr = controller;
          },
          initialCameraPosition: _.initialCameraPosition,
          myLocationButtonEnabled: false,
          compassEnabled: false,
          mapToolbarEnabled: false,
          zoomGesturesEnabled: true
          // onTap: _.onTap,
          ),
    );
  }
}
