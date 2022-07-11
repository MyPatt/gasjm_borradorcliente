import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContentMap extends StatelessWidget {
  const ContentMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
        builder: (_) =>

            //_.currentLatLng == null ? Center(child:CircularProgressIndicator()) :
            Obx(
              () => GoogleMap(
                markers: _.markers,
                onMapCreated: _.onMapaCreated,
                initialCameraPosition: CameraPosition(target:  _.posicionInicial.value, zoom: 15),
                myLocationButtonEnabled: false,
                compassEnabled: false,
                onTap: _.onTap,
              ),
            ));
  }
}
