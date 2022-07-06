import 'dart:io';

import 'package:gasjm/app/data/models/usuario_model.dart';

abstract class MyUserRepository {
  Future<UsuarioModel?> getUsuario();

 
}
