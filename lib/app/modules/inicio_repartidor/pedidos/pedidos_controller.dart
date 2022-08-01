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

    _cargarListaPedidosEnEspera();
    _cargarListaPedidosAceptados();
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

  final RxList<PedidoModel> _pedidosAceptados = RxList<PedidoModel>([]);
  RxList<PedidoModel> get pedidosAceptados => _pedidosAceptados;

  final RxList<String> _nombresClientes = RxList<String>([]);
  RxList<String> get nombresClientes => _nombresClientes;

  final RxList<String> _direccionClientes = RxList<String>([]);
  RxList<String> get direccionClientes => _direccionClientes;


    final RxList<String> _nombresClientesAceptados = RxList<String>([]);
  RxList<String> get nombresClientesAceptados => _nombresClientesAceptados;

  final RxList<String> _direccionClientesAceptados  = RxList<String>([]);
  RxList<String> get direccionClientesAceptados  => _direccionClientesAceptados ;

  Future<void> _cargarNombresClienteParaPedidosEspera() async {
    for (var item in _pedidosenespera) {
      final nombre = await _personaRepository.getNombresPersonaPorCedula(
          cedula: item.idCliente);
      _nombresClientes.add(nombre!);

      final direccion = await getDireccionXLatLng(
          LatLng(item.direccion.latitud, item.direccion.longitud));
      _direccionClientes.add(direccion);
    }
  }

  Future<void> _cargarNombresClienteParaPedidosAceptados() async {
    for (var item in _pedidosenespera) {
      final nombre = await _personaRepository.getNombresPersonaPorCedula(
          cedula: item.idCliente);
      _nombresClientesAceptados .add(nombre!);

      final direccion = await getDireccionXLatLng(
          LatLng(item.direccion.latitud, item.direccion.longitud));
      _direccionClientesAceptados .add(direccion);
    }
  }

  _cargarListaPedidosEnEspera() async {
    try {
      _pedidosenespera.value = (await _pedidosRepository.getPedidoPorField(
          field: 'idEstadoPedido', dato: 'estado1'))!;
      _cargarNombresClienteParaPedidosEspera();
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

  _cargarListaPedidosAceptados() async {
    try {
      _pedidosAceptados.value = (await _pedidosRepository.getPedidoPorField(
          field: 'idEstadoPedido', dato: 'estado2'))!;
      _cargarNombresClienteParaPedidosAceptados();
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
    return _getDireccion(lugar);
  }
}
