import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class InicioController extends GetxController {
  @override
  void onInit() {
    //Obtiene datos del usuario que inicio sesion
    getUsuarioActual();
    //Obtiene ubicacion actual del dispositivo
    getLocation();
    //
    _cargarFechaInicial();

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
  //Repositorio de pedidos
  final _pedidoRepository = Get.find<PedidoRepository>();
  //Metodos para insertar un nuevo pedido
  insertarPedido() async {
    try {
      PedidoModel pedidoModel = PedidoModel(
          idProducto: 'idProducto',
          idCliente: 'idCliente',
          idRepartidor: 'idRepartidor',
          direccion: Direccion(latitud: 00000, longitud: 00000),
          idEstadoPedido: 'idEstadoPedido',
          fechaPedido: DateTime.now(),
          fechaEntregaPedido: DateTime.now(),
          horaEntregaPedido: DateTime.now(),
          notaPedido: 'notaPedido',
          totalPedido: 555555);

      /*PedidoModel oPedido = PedidoModel(
          idProducto: 'idProducto',
          idCliente: 'idCliente',
          idRepartidor: 'idRepartidor',
          idEstadoPedido: 'idEstadoPedido',
          fechaPedido: DateTime.now(),
          horaPedido: DateTime.now(),
          totalPedido: 1000);*/

      final result =
          await _pedidoRepository.insertPedido(pedidoModel: pedidoModel);
      Get.back();
      Get.snackbar(
        'Message',
        'result',
        duration: const Duration(seconds: 4),
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppTheme.blueDark,
        colorText: Colors.white,
      );
    } on FirebaseException catch (e) {
      Get.snackbar(
        'Message',
        e.message ?? 'SIN ERROR',
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppTheme.cyan,
      );
    }
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
  final posicionMarcadorCliente = const LatLng(-0.2053476, -79.4894387).obs;

  //final initialCameraPosition =    const CameraPosition(target: LatLng(-0.2053476, -79.4894387), zoom: 15);

  //Cambiar el estilo de mapa
  onMapaCreated(GoogleMapController controller) {
    controller.setMapStyle(estiloMapa);

    //Cargar marcadores
    cargarMarcadores();
  }

//
  void onTap(LatLng position) {
    posicionInicial.value = position;
    posicionMarcadorCliente.value = position;
    // final id = _markers.length.toString(); para generar muchos markers
//Actualizar las posiciones del mismo marker la cedula del usuario conectado como ID
    final id = usuario.value?.cedula ?? 'MakerIdCliente';

    final markerId = MarkerId(id);

    final marker = Marker(
        markerId: markerId,
        position: posicionInicial.value,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        onDragEnd: (newPosition) {
          posicionInicial.value = newPosition;
          _getDireccionXLatLng(newPosition);
        });
//

    _markers.clear();
//
    _markers[markerId] = marker;
    _getDireccionXLatLng(posicionMarcadorCliente.value);
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
      posicionInicial.value = LatLng(posicion.latitude, posicion.longitude);
    });
  }

//Obtener direccion a partir de latitud y longitud
  Future<void> _getDireccionXPosition(Position posicion) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(posicion.latitude, posicion.longitude);

    Placemark lugar = placemark[0];
    //
    posicionInicial.value = LatLng(posicion.latitude, posicion.longitude);
    //
    direccion.value = _getDireccion(lugar);
    direccionTextoController.text = direccion.value;
  }

  String _getDireccion(Placemark lugar) {
    //
    if (lugar.subLocality?.isEmpty == true) {
      return lugar.street.toString();
    } else {
      return '${lugar.street}, ${lugar.subLocality}';
    }
  }

  Future<void> _getDireccionXLatLng(LatLng posicion) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(posicion.latitude, posicion.longitude);
    Placemark lugar = placemark[0];
    //
    print('>>>>>>>>>>>>>>>$posicion\n');
//
    direccion.value = _getDireccion(lugar);
    direccionTextoController.text = direccion.value;
  }

  Set<Marker> marcadores = {};

  void cargarMarcadores() {
    //Marcador cliente
    posicionMarcadorCliente.value = posicionInicial.value;

//Actualizar las posiciones del mismo marker la cedula del usuario conectado como ID
    final id = usuario.value?.cedula ?? 'MakerIdCliente';
//
    final markerId = MarkerId(id);
    // marcadores.add(Marker(
    final marker = Marker(
        markerId: markerId,
        position: posicionMarcadorCliente.value,
        draggable: true,
        //212.2
        icon: BitmapDescriptor.defaultMarkerWithHue(208),
        onDragEnd: (newPosition) {
          // ignore: avoid_print
          posicionMarcadorCliente.value = newPosition;
          _getDireccionXLatLng(posicionMarcadorCliente.value);
        });
    _markers[markerId] = marker;
    //
    _getDireccionXLatLng(posicionMarcadorCliente.value);
  }

  /*  FECHA PARA AGENDAR EN FORM PEDIR GAS */
  final fechaHoraDeEntregaGasController = TextEditingController().obs;
  final itemSeleccionadoDia = 0.obs;
  //
  void _cargarFechaInicial() {
    fechaHoraDeEntregaGasController.value.text = "Ahora";
  }

  String cambiarFormatoFecha(DateTime fecha) {
//return DateFormat("EEEEE, dd MMMM").format(fecha);
    return DateFormat("dd MMMM").format(fecha);
  }

  /*  HORA PARA AGENDAR EN FORM PEDIR GAS */
  final horaActual = DateTime.now();
  final horaSeleccionada = DateTime.now().obs;
  String cambiarFormatoHora(DateTime hora) {
    return DateFormat("HH:mm").format(hora);
  }

  //Mostrar resultado
  String fechaHoraPedido() {
    
    if (itemSeleccionadoDia.value == 0 &&
        cambiarFormatoHora(horaSeleccionada.value) != '00:00') {
      return "Ahora, ${cambiarFormatoHora(horaSeleccionada.value)}";
    } else if (itemSeleccionadoDia.value == 1 &&
        cambiarFormatoHora(horaSeleccionada.value) == '00:00') {
      return "Mañana";
    } else if (itemSeleccionadoDia.value == 1 &&
        cambiarFormatoHora(horaSeleccionada.value) != '00:00') {
      return "Mañana, ${cambiarFormatoHora(horaSeleccionada.value)}";
    }
    return "Ahora";
  }

  //
  Rx<DateTime>? horaInicial;
  Rx<DateTime>? horaMinima;
  Rx<DateTime>? horaMaxima;
  //
  seleccionarHoraInicial() {
    if (itemSeleccionadoDia.value == 0) {
      horaMinima?.value = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, DateTime.now().hour, DateTime.now().minute + 10);
      horaInicial?.value = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, DateTime.now().hour, DateTime.now().minute + 30);

      horaMaxima?.value = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 19, 0);
    } else {
      horaMinima?.value = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 1, 6, 0);
      horaInicial?.value = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 1, 6, 0);
      horaMaxima?.value = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 1, 19, 0);
    }
  }
}
//TODO: Obtener el horario desde la BD
//TODO: Ajustar horario

 
//TODO: Optimizar variables para fecha y hora
//TODO: Horarios de atencion
//TODO: FechaHoraActual para comparar que no sea local sino de red

