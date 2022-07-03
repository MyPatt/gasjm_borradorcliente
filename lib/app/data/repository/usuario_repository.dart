import 'dart:io';

import 'package:gasjm/app/data/models/usuario_model.dart';

abstract class MyUserRepository {
  Future<UsuarioModel?> getMyUser();

  Future<void> saveMyUser(UsuarioModel user, File? image);
}
