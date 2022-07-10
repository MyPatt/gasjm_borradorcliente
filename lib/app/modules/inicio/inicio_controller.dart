import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InicioController extends GetxController {
  @override
  void onInit() {
    //Obtener ubicacion actual del usuario
    getLocation();
    //Obtiene datos del usuario que inicio sesion
    getUsuarioActual();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // streamSubscription.cancel();
    super.onClose();
  }

  /* DATOS DEL USUARIO */
  /* Variables para obtener datos del usuario */
  //Repositorio de usuario
  final _userRepository = Get.find<MyUserRepository>();
  //
  Rx<UsuarioModel?> usuario = Rx(null);
  Future<void> getUsuarioActual() async {
    usuario.value = await _userRepository.getUsuario();
  }

  /* FORMULARIO PARA PEDIR EL GAS */
  //Variables para el form
  final formKey = GlobalKey<FormState>();

  final direccionTextoController = TextEditingController();

  //Variable para la visibilidad del formulario
  RxBool visibleFormPedirGas = false.obs;

  // Metodo para cambiar la visibilidad del formulario
  verFormPedirGas() {
    visibleFormPedirGas.value = true;
  }

/* MANEJO DE RUTAS DEL MENU */
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

  /* GOOGLE MAPS */
  //final initialCameraPosition =  CameraPosition(target: center.value??LatLng(0, 0), zoom: 15);
  final Map<MarkerId, Marker> _markers = {};
  Set<Marker> get markers => _markers.values.toSet();

  final _markersController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markersController.stream;
  onMapaCreated(GoogleMapController _controller) {
    _controller.setMapStyle(estiloMapa);
  }

/*
  void onTap(LatLng position) {
    position = currentLatLng?.value ?? const LatLng(0, 0);
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
          currentLatLng?.value = newPosition;
          // ignore: avoid_print
          print("*******new position ${currentLatLng?.value}");
        });

    _markers[markerId] = marker;
    //notifyListeners();
  }

*/
  //Variables
  var latitud = 'Getting latitude..'.obs;
  var longitud = 'Getting longitude..'.obs;
  var direccion = 'Getting addres..'.obs;
  late StreamSubscription<Position> streamSubscription;

  GoogleMapController? controller;
//Posicion inicial
  Rx<LatLng> center = const LatLng(-30.034399, -51.212597).obs;

//Obtener ubicacion
  getLocation() async {
    bool servicioHbilitado;

    LocationPermission permiso;

    //Esta habilitado el servicio?
    servicioHbilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicioHbilitado) {
      //si la ubicacion esta deshabilitado tieneactivarse
      await Geolocator.openLocationSettings();
      return Future.error('Servicio de ubicación deshabilitada.');
    }
    permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        //Si la ubicacion sigue dehabilitado mostrar sms
        return Future.error('Permiso de ubicación denegado.');
      }
    }
    if (permiso == LocationPermission.deniedForever) {
      //Permiso denegado por siempre
      return Future.error('Permiso de ubicación denegado de forma permanente.');
    }

    //Al obtener el permiso de ubicacion se accede a las coordenadas de la posicion
    streamSubscription =
        Geolocator.getPositionStream().listen((Position posicion) {
      latitud.value = 'Latitud: ${posicion.latitude}';
      longitud.value = 'Longitud: ${posicion.longitude}';
          //
    center.value = LatLng(posicion.latitude, posicion.longitude);
      getDireccionDesdeLatLang(posicion);
    });
  }

//Obtener direccion a partir de latitud y longitud
  Future<void> getDireccionDesdeLatLang(Position posicion) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(posicion.latitude, posicion.longitude);

    Placemark lugar = placemark[0];
    direccion.value = ' ${lugar.street}, ${lugar.locality} ';


    //
    direccionTextoController.text = direccion.value;
  }
}
