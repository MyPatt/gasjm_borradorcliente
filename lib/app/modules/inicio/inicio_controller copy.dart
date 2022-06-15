import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/modules/inicio/local_widgets/form_pedirgas.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InicioController extends ChangeNotifier {
  //Mapa marcador
  final initialCameraPosition =
      const CameraPosition(target: LatLng(0, 0), zoom: 15);
//
  bool _loading = true;
  bool get loading => _loading;

  bool _gpsEnabled;
  bool get gpsEnabled => _gpsEnabled;
//
  final Map<MarkerId, Marker> _markers = {};
  Set<Marker> get markers => _markers.values.toSet();

  final _markersController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markersController.stream;

/* MAPA */

  onMapaCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  void onTap(LatLng position) {
    final id = _markers.length.toString();
    final markerId = MarkerId(id);
    final marker = Marker(
        markerId: markerId,
        position: position,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        onTap: () {
          _markersController.sink.add(id);
        },
        onDragEnd: (newPosition) {
          // ignore: avoid_print
          print("*******new position $newPosition");
        });

    _markers[markerId] = marker;
    notifyListeners();
  }

  @override
  void dispose() {
    _markersController.close();
    super.dispose();
  }

  /* visibleFormPedirGas */

}
