// screen_a.dart
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/inicio_repartidor/inicio_repartidor_controller.dart';
import 'package:gasjm/app/modules/inicio_repartidor/local_widgets/repartidor_mapa.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepartidorMapa();
    /* return GetBuilder<InicioRepartidorController>(
        builder: (_) => FutureBuilder<LocationData?>(
              future: _currentLocation(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
                if (snapchat.hasData) {
                  final LocationData currentLocation = snapchat.data;
                  return Text("Hola");
                }
                return Center(child: CircularProgressIndicator());
              },
            ));
  }*/
  }
}

Future<LocationData?> _currentLocation() async {
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  Location location = new Location();

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }
  return await location.getLocation();
}
