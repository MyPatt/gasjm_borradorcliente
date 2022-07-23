// screen_b.dart
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/inicio_repartidor/inicio_repartidor_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ScreenB extends StatelessWidget {
  ScreenB({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
     final controller = Get.find<InicioRepartidorController>();
    return FutureBuilder<LocationData?>(
      
        future: controller.currentLocation(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
          print(snapchat.hasData);
          if (snapchat.hasData) {
            final LocationData currentLocation = snapchat.data;
            /*  _.cargarMarcadorRepartidor(LatLng(
                    currentLocation.latitude!, currentLocation.longitude!));*/
            return GoogleMap(
              //  onMapCreated: _.onMapaCreated,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation.latitude!, currentLocation.longitude!),
                  zoom: 15),
              //  markers: _.markers,
              myLocationButtonEnabled: false,
              compassEnabled: false,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              mapToolbarEnabled: false,
              trafficEnabled: false,
              tiltGesturesEnabled: false,
              scrollGesturesEnabled: false,
              rotateGesturesEnabled: false,
              myLocationEnabled: false,
              liteModeEnabled: false,
              indoorViewEnabled: false,
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
