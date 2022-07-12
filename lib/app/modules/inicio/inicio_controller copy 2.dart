import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class InicioController extends GetxController {
  final _userRepository = Get.find<MyUserRepository>();
  //
  Rx<UsuarioModel?> usuario = Rx(null);
  //Formulario Pedir el Gas visible
  RxBool visibleFormPedirGas = false.obs;
  //Obtener nombre del usuario

  @override
  void onInit() {
    getUsuarioActual();
    getLocation();
    super.onInit();
  }

  Future<void> getUsuarioActual() async {
    usuario.value = await _userRepository.getUsuario();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _markersController.close();
    super.onClose();
  }

  // Metodo para cambiar la visibilidad del Formulario Pedir el Gas visible
  verFormPedirGas() {
    // ignore: avoid_print
    print(visibleFormPedirGas.value.toString());
    visibleFormPedirGas.value = true;
    // ignore: avoid_print
    print(visibleFormPedirGas.value.toString());
  }

  //Ir a la pantalla de agenda
  cargarAgenda() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.agenda);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  cargarLogin() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.login);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    cargarLogin;
  }

  /*MAPA */
  //Mapa marcador
  getPosicionActual() async {
    var location = await currentLocation.getLocation();
    final s = LatLng(location.latitude ?? 0, location.longitude ?? 0);
  }

  var initialCameraPosition =
      const CameraPosition(target: LatLng(0, 0), zoom: 15);
  //Marcadore
  final Map<MarkerId, Marker> _markers = {};
  Set<Marker> get markers => _markers.obs.values.toSet();

  final _markersController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markersController.stream;

  onMapaCreated(GoogleMapController controller) {
    controllerr = controller.setMapStyle(estiloMapa) as GoogleMapController;
  }

  void onTap(LatLng position) {
    print("*******\n");
    final id = _markers.length.toString();
    final markerId = MarkerId(id);
    final marker = Marker(
        markerId: markerId,
        position: position,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        onTap: () {
          print("*******ontap\n");

          _markersController.sink.add(id);
        },
        onDragEnd: (newPosition) {
          // ignore: avoid_print
          print("*******new position ${newPosition}\n");
        });

    _markers[markerId] = marker;
  }

  //Posicion actual
  GoogleMapController? controllerr;
  Location currentLocation = Location();
  RxSet<Marker> markerss = <Marker>{}.obs;
  void getLocation() async {
    currentLocation.onLocationChanged.listen((LocationData loc) {
      controllerr?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));
      initialCameraPosition =
          const CameraPosition(target: LatLng(0, 0), zoom: 15);
      // setState(() {
      final id = markerss.length.toString();
      final markerId = MarkerId(id);
      markerss.add(Marker(
          markerId: markerId,
          position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
          draggable: true,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          onTap: () {
            print("*******ontap\n");
          },
          onDragEnd: (newPosition) {
            // ignore: avoid_print
            print("*******new position ${newPosition}\n");
          }));
      // });
    });
  }
  //

}
