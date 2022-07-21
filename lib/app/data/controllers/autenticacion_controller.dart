//Estados de sutenticacion
import 'dart:async';

import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

enum AutenticacionEstado { sesionNoIniciada, sesionIniciada }

//Controlador de autenticacion que rige en toda la app
class AutenticacionController extends GetxController {
  final _autenticacionRepository = Get.find<AutenticacionRepository>();
  late StreamSubscription _autenticacionSuscripcion;

  final Rx<AutenticacionEstado> autenticacionEstado =
      Rx(AutenticacionEstado.sesionNoIniciada);

  final Rx<AutenticacionUsuario?> autenticacionUsuario = Rx(null);

  @override
  void onInit() async {
    // TSolo para testear. Permitir la pantalla de splash luego unos pocos segundos
    await Future.delayed(const Duration(seconds: 3));
    //Testea la suscripcion del cambio de estado de inicio sesion para ir a la pagina de introduccion u login
    _autenticacionSuscripcion = _autenticacionRepository
        .enEstadDeAutenticacionCambiado
        .listen(_estadoAutenticacionCambiado);

    super.onInit();
  }

  void _estadoAutenticacionCambiado(AutenticacionUsuario? usuario) {
    if (usuario == null) {
      autenticacionEstado.value = AutenticacionEstado.sesionNoIniciada;

      Get.offAllNamed(AppRoutes.ubicacion);
    } else {
      autenticacionEstado.value = AutenticacionEstado.sesionIniciada;
      //Buscar perfil de usuario

      _getUsuarioActual();
      final perfil = _usuario?.perfil;
      print("----->-${_autenticacionRepository.autenticacionUsuario?.perfil} ");
      ;
      print("------${perfil} ");

      if (perfil == "Cliente") {
        Get.offAllNamed(AppRoutes.inicio);
      } else {
        Get.offAllNamed(AppRoutes.iniciorepartidor);
      }
    }
    autenticacionUsuario.value = usuario;
  }

//

  //
  UsuarioModel? _usuario;
  Future<void> _getUsuarioActual() async {
    //Repositorio de usuario
    final _userRepository = Get.find<MyUserRepository>();
    final uid = _autenticacionRepository.autenticacionUsuario?.uid ?? '';
    _usuario = await _userRepository.getPerfilUsuarioPorUid(uid: uid);
  }

//
  Future<void> cerrarSesion() async {
    await _autenticacionRepository.cerrarSesion();
  }

  @override
  void onClose() {
    _autenticacionSuscripcion.cancel();
    super.onClose();
  }
}
