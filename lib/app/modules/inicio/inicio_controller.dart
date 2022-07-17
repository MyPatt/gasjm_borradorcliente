import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/global_widgets/secondary_button.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
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
    cargarFechaInicial();
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
     
      PedidoModel oPedido = PedidoModel(
          idProducto: 'idProducto',
          idCliente: 'idCliente',
          idRepartidor: 'idRepartidor',
          idEstadoPedido: 'idEstadoPedido',
          fechaPedido: DateTime.now(),
          horaPedido: DateTime.now(),
          totalPedido: 1000);

     final result = await _pedidoRepository.insertPedido(pedidoModel: oPedido);
      Get.back();
      Get.snackbar(
        'Message',
        'result',
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppTheme.cyan,
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
  RxString fecha = DateFormat.yMd().format(DateTime.now()).obs;
  void cargarFechaInicial() {
    fechaHoraDeEntregaGasController.value = TextEditingController(text: 'Hoy');
  }

  // Modal para seleccionar la fecha de entrega del pedido
  void mostrarFechaParaPedir(ctx) {
    //
    showModalBottomSheet(
        context: ctx,
        builder: (_) => Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const TextDescription(text: 'Elije una fecha'),
                    SizedBox(
                        height: Responsive.getScreenSize(ctx).height * .03),
                    SizedBox(
                      height: Responsive.getScreenSize(ctx).height * .1,
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          minimumDate: DateTime.now(),
                          initialDateTime: DateTime.now(),
                          //
                          dateOrder: DatePickerDateOrder.dmy,
                          onDateTimeChanged: (val) {
                            if (val != null) //if the user has selected a date
                            {
                              // Asignar fecha a la variable
                              fecha.value =
                                  DateFormat.yMMMMd("en_US").format(val);
                            }
                          }),
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(ctx).height * .03),
                    PrimaryButton(
                        texto: 'Siguiente',
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          _mostrarHoraParaPedir(ctx);
                        }),
                    SizedBox(
                        height: Responsive.getScreenSize(ctx).height * .02),
                    SecondaryButton(
                        texto: 'Cerrar',
                        onPressed: () {
                          if (DateFormat.yMd().format(DateTime.now()) ==
                              fecha.value) {
                            fecha.value = 'Hoy';
                          }
                          fechaHoraDeEntregaGasController.value =
                              TextEditingController(text: fecha.value);
                          Navigator.of(ctx).pop();
                        }),
                  ],
                ),
              ),
            ));
  }

  /*  HORA PARA AGENDAR EN FORM PEDIR GAS */

  RxString hora = DateFormat('hh:mm').format(DateTime.now()).obs;
  Rx<DateTime>? horaInicial;
  // Modal para seleccionar la hora de entrega del pedido
  void _mostrarHoraParaPedir(ctx) {
    print(fecha.value);
    print(DateFormat.yMd().format(DateTime.now()));
    //
    if (fecha.value == DateFormat.yMd().format(DateTime.now())) {
      horaInicial?.value = (DateTime.now());
      print('[[[[[[[[[[[[[$horaInicial\n');
    } else {
      horaInicial?.value = (DateFormat('hh:mm').parse('00:00'));
    }
    showModalBottomSheet(
        context: ctx,
        builder: (_) => Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const TextDescription(text: 'Elije una hora'),
                    SizedBox(
                        height: Responsive.getScreenSize(ctx).height * .03),
                    SizedBox(
                      height: Responsive.getScreenSize(ctx).height * .1,
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          minimumDate: DateTime.now(),
                          initialDateTime: horaInicial?.value,
                          //
                          onDateTimeChanged: (val) {
                            if (val != null) //if the user has selected a date
                            {
                              // Asignar fecha a la variable
                              hora.value = DateFormat('hh:mm').format(val);
                            }
                          }),
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(ctx).height * .03),
                    PrimaryButton(
                        texto: 'Hecho',
                        onPressed: () {
                          if (DateFormat.yMd().format(DateTime.now()) ==
                              fecha.value) {
                            fecha.value = 'Hoy';
                          }
                          fechaHoraDeEntregaGasController.value =
                              TextEditingController(
                                  text: '${fecha.value}, ${hora.value}');
                          Navigator.of(ctx).pop();
                        }),
                    SizedBox(
                        height: Responsive.getScreenSize(ctx).height * .02),
                    SecondaryButton(
                        texto: 'Omitir',
                        onPressed: () {
                          if (DateFormat.yMd().format(DateTime.now()) ==
                              fecha.value) {
                            fecha.value = 'Hoy';
                          }
                          fechaHoraDeEntregaGasController.value =
                              TextEditingController(text: fecha.value);
                          Navigator.of(ctx).pop();
                        }),
                  ],
                ),
              ),
            ));
  }
}
//TODO: Separa interfaz y controller de seleccion de fecha y hora
//TODO: Hora de inicio arreglar

//TODO: Mejorar interfaz de seleccion de fecha y hora
//TODO: Optimizar variables para fecha y hora
//TODO: Horarios de atencion
//TODO: FechaHoraActual para comparar que no sea local sino de red

