import 'dart:io';

import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/providers/firebase_provider.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';

class MyUserRepositoryImp extends MyUserRepository {
  final provider = FirebaseProvider();

  @override
  Future<UsuarioModel?> getUsuario() => provider.getUsuario();
  

 
}
