import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:path/path.dart' as path;

class FirebaseProvider {
  //Par devolver el usuario actual conectado
  User get usuarioActual {
    final usuario = FirebaseAuth.instance.currentUser;
    if (usuario == null) throw Exception('Excepción no autenticada');
    return usuario;
  }

  //Instancia de firestore
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  //Instancia de firestore
  final firestoreInstance = FirebaseFirestore.instance;

  //Obtner perfil del usuario actual
  Future<UsuarioModel?> getUsuario() async {
    final snapshot = await firestoreInstance
        .collection('usuarios')
        .doc(usuarioActual.uid)
        .get();
    if (snapshot.exists) {
      return UsuarioModel.fromFirebaseMap(snapshot.data()!);
    } else {
      print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
    }
    return null;
  }
}
