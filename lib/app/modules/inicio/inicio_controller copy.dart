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
    //Obtiene datos del usuario que inicio sesion
    getUsuarioActual();
//Obtiene ubicacion actual del dispositivo
    getLocation();
    //CargarMarcadores
    //cargarMarcadores();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _markersController.close();
    streamSubscription.cancel();
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
  //Variables

  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  //
  final _markersController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markersController.stream;

  //
  //final posicionInicial = LatLng(-0.2053476, -79.4894387).obs;
  final posicionInicial = const LatLng(-0.2053476, -79.4894387).obs;
  LatLng posicionMarcadorCliente = const LatLng(-0.2053476, -79.4894387);

  //final initialCameraPosition =    const CameraPosition(target: LatLng(-0.2053476, -79.4894387), zoom: 15);

  //Cambiar el estilo de mapa
  onMapaCreated(GoogleMapController controller) {
    controller.setMapStyle(estiloMapa);

    //Cargar marcadores
    cargarMarcadores();
  }

//
  void onTap(LatLng position) {
    posicionMarcadorCliente = position;
    // final id = _markers.length.toString(); para generar muchos markers
//Actualizar las posiciones del mismo marker la cedula del usuario conectado como ID
    final id = usuario.value?.cedula ?? 'MakerIdCliente';

    final markerId = MarkerId(id);

    final marker = Marker(
        markerId: markerId,
        position: posicionMarcadorCliente,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        onTap: () {
          _markersController.sink.add(id);
        },
        onDrag: (newPosition) {
          posicionMarcadorCliente = newPosition;
        });
//

    _markers.clear();
//
    _markers[markerId] = marker;
//
    print("<<<<<<${posicionInicial.value}>>>>>>");
    print("<<<<<<${posicionMarcadorCliente}>>>>>>");
    //
  }

  // UBICACION ACTUAL

  //Variables

  var direccion = 'Buscando dirección...'.obs;
  late StreamSubscription<Position> streamSubscription;

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
      //

      _getDireccionDesdeLatLang(posicion);
    });
  }

//Obtener direccion a partir de latitud y longitud
  Future<void> _getDireccionDesdeLatLang(Position posicion) async {
    /* List<Placemark> placemark =
        await placemarkFromCoordinates(posicion.latitude, posicion.longitude);

    Placemark lugar = placemark[0];

    //
    if (lugar.locality?.isEmpty == true) {
      direccion.value = ' ${lugar.street}';
    } else {
      direccion.value = ' ${lugar.street}, ${lugar.locality} ';
    }*/
    //
    posicionInicial.value = LatLng(posicion.latitude, posicion.longitude);
    posicionMarcadorCliente =
        LatLng(posicion.latitude, posicion.longitude);
  }

//
  Future<void> _getDireccionon(LatLng posicion) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(posicion.latitude, posicion.longitude);

    Placemark lugar = placemark[0];
    //
    if (lugar.locality?.isEmpty == true) {
      direccion.value = ' ${lugar.street}';
    } else {
      direccion.value = ' ${lugar.street}, ${lugar.locality} ';
    }

    direccionTextoController.text = direccion.value;
  }

//
  Set<Marker> marcadores = {};

  void cargarMarcadores() {
    //Marcador cliente

    // final id = _markers.length.toString(); para generar muchos markers
//Actualizar las posiciones del mismo marker la cedula del usuario conectado como ID
    final id = usuario.value?.cedula ?? 'MakerIdCliente';
//
    final markerId = MarkerId(id);
    // marcadores.add(Marker(
    final marker = Marker(
        markerId: markerId,
        position: posicionMarcadorCliente,
        draggable: true,
        //
        icon: BitmapDescriptor.defaultMarkerWithHue(208),
        onTap: () {
          _markersController.sink.add(id);
        },
        onDrag: (newPosition) {
          posicionMarcadorCliente = newPosition;
          _getDireccionon(posicionMarcadorCliente);
        });
    _markers[markerId] = marker;

    //
  }
}