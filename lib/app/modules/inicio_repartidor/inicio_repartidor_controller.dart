import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:gasjm/app/modules/inicio_repartidor/local_widgets/ir_content.dart';
import 'package:gasjm/app/modules/inicio_repartidor/local_widgets/navegacion_content.dart';
import 'package:gasjm/app/modules/inicio_repartidor/pedidos/pedidos_page.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InicioRepartidorController extends GetxController {
  @override
  void onInit() {
    _cargarDatosIniciales();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /* DATOS DEL USUARIO */
  /* Variables para obtener datos del usuario */
  //Repositorio de usuario
  final _userRepository = Get.find<MyUserRepository>();
  //
  Rx<UsuarioModel?> usuario = Rx(null);
  Future<void> _getUsuarioActual() async {
    usuario.value = await _userRepository.getUsuario();
  }

  void _cargarDatosIniciales() {
    _getUsuarioActual();
  }

  /* MANEJO DE PANTALLA POR NAVEGACION BOTTOM*/
  RxInt indexPantallaSeleccionada = 0.obs;
  final List pantallasInicioRepartidor = [
    {"screen": const ExplorarRepartidorPage()},
    {"screen": const IniciarRecorridoRepartidor()},
    //  {"screen": const PedidosPage()},
    {"screen": const Center(child: CircularProgressIndicator())},
  ];

//Metodo que escucha el onTap de las pantallas
  pantallaSeleccionadaOnTap(int index, BuildContext context) {
    if (indexPantallaSeleccionada.value == 2 && index == 2) {
    } else {
      if (indexPantallaSeleccionada.value == 2) {
        Navigator.pop(context);
      }
      indexPantallaSeleccionada.value = index;
      if (index == 2) {
        _cargarPedidosPage();
        print(2);
      }
    }
  }

  _cargarPedidosPage() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.toNamed(AppRoutes.pedidos);
    } catch (e) {
      print(e);
    }
  }
  /* MAPA PARA LA OPCION DE EXPLORACION*/

  //Cambiar el estilo de mapa
  onMapaCreated(GoogleMapController controller) {
    controller.setMapStyle(estiloMapa);
    //

    _cargarMarcadoresPedidos();
  }

  //Ubicacion actual
  Future<LocationData?> currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    Location location = Location();

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

  //
  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();
  Future<void> cargarMarcadorRepartidor(LatLng posicion) async {
    //Actualizar las posiciones del mismo marker la cedula del usuario conectado como ID
    final id = usuario.value?.cedula ?? 'MakerIdRepartidor';
    //
    final markerId = MarkerId(id);

    //Marcador repartidor personalizado
    BitmapDescriptor _markerbitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icons/gpsrepartidor.png",
    );
    final marker = Marker(
      markerId: markerId,
      position: posicion,
      draggable: false,
      icon: _markerbitmap,
    );
    _markers[markerId] = marker;

    print("REPARTIDOR\n");
  }

  //Marcadores para visualizar los pedidos
  final _pedidoRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();

  Future<void> _cargarMarcadoresPedidos() async {
    //Marcador pedido
    BitmapDescriptor _marcadorPedido = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icons/marcadorpedido.png",
    );
//Actualizar las posiciones del mismo marker la cedula del usuario conectado como ID

    //
    final listaPedidos = await _pedidoRepository.getPedidos();
    print(listaPedidos?.length);

    listaPedidos?.forEach((element) async {
      final nombreCliente = await _personaRepository.getNombresPersonaPorCedula(
          cedula: element.idCliente);
      print(nombreCliente);
      //final id = element.idCliente;
      final id = _markers.length.toString();
      print("- $id\n");
      final markerId = MarkerId(id);
      final posicion =
          LatLng(element.direccion.latitud, element.direccion.longitud);

      final marker = Marker(
          markerId: markerId,
          position: posicion,
          draggable: false,
          icon: _marcadorPedido,
          infoWindow: InfoWindow(
              title: nombreCliente,
              snippet:
                  'Para ${element.fechaHoraEntregaPedido?.toDate().day}/${element.fechaHoraEntregaPedido?.toDate().month},  ${element.cantidadPedido} cilindro/s de gas.',
              onTap: () {
                print(_markers.length);
                //Marcadores para pedidos 2 (infoWindow onTap)
              }));
      _markers[markerId] = marker;
    });
    print("PEDIDOS\n");
  }
}
