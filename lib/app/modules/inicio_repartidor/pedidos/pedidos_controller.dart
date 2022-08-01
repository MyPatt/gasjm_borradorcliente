import 'package:firebase_auth/firebase_auth.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PedidosController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    _cargarListaPedidos();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //PEDIDOS EN ESPERA
  final _pedidosRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();

  final RxList<PedidoModel> _pedidosenespera = RxList<PedidoModel>([]);
  RxList<PedidoModel> get pedidosenespera => _pedidosenespera;

  final RxList<String> _nombresClientes = RxList<String>([]);
  RxList<String> get nombresClientes => _nombresClientes;

    final RxList<String> _direccionClientes = RxList<String>([]);
  RxList<String> get direccionClientes => _direccionClientes;

  Future<void> _cargarNombresCliente() async {
    for (var item in _pedidosenespera) {
      final nombre = await _personaRepository.getNombresPersonaPorCedula(
          cedula: item.idCliente);
      _nombresClientes.add(nombre!);

        final direccion = await getDireccionXLatLng(LatLng(item.direccion.latitud, item.direccion.longitud));
        _direccionClientes.add(direccion);
    }
  }

  _cargarListaPedidos() async {
    try {
      _pedidosenespera.value = (await _pedidosRepository.getPedidoPorField(field: 'idEstadoPedido', dato: 'estado1'))!;
      _cargarNombresCliente();
    } on FirebaseException catch (e) {
      Get.snackbar(
        'Mensaje',
        e.message ?? 'Se produjo un error inesperado.',
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppTheme.blueDark,
      );
    }
  }

      String _getDireccion(Placemark lugar) {
    //
    if (lugar.subLocality?.isEmpty == true) {
      return lugar.street.toString();
    } else {
      return '${lugar.street}, ${lugar.subLocality}';
    }
  }
  
    Future<String> getDireccionXLatLng(LatLng posicion) async {
      List<Placemark> placemark =
          await placemarkFromCoordinates(posicion.latitude, posicion.longitude);
      Placemark lugar = placemark[0];

//
     return   _getDireccion(lugar); 
    }

  
  }