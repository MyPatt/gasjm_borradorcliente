import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller copy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ContentMap extends StatelessWidget {
  const ContentMap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<InicioController, bool>(
      selector: (_, controller) => controller.loading,
      builder: (context, loading, loadingWidget) {
        if (loading) {
          return loadingWidget;
        }
      },
      child: Consumer<InicioController>(
          builder: (_, controller, __) => (GoogleMap(
                markers: controller.markers,
                onMapCreated: controller.onMapaCreated,
                initialCameraPosition: controller.initialCameraPosition,
                myLocationButtonEnabled: false,
                compassEnabled: false,
                onTap: controller.onTap,
              ))),
    );
  }
}
