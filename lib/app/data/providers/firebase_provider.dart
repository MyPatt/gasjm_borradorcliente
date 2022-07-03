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

  //Instancia de storage
  FirebaseStorage get storage => FirebaseStorage.instance;

  //Obtner usuario con future que puede ser nulo
  Future<UsuarioModel?> getUsuario() async {
    final snapshot = await firestore.doc('user/${usuarioActual.uid}').get();
    //si se encuentra los datos del usuario se retornan dichos datos
    if (snapshot.exists) return UsuarioModel.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  //Guardar datos del usuario en firestore
  Future<void> guadarUsuario(UsuarioModel usuario, File? foto) async {
    final ref = firestore.doc('user/${usuarioActual.uid}');
    //Guardar foto
    if (foto != null) {
      final fotoPath =
          '${usuarioActual.uid}/profile/${path.basename(foto.path)}';
      final storageRef = storage.ref(fotoPath);
      await storageRef.putFile(foto);
      final url = await storageRef.getDownloadURL();
      await ref.set(usuario.toFirebaseMap(newFoto: url), SetOptions(merge: true));
    } 
    else
    {
      //En caso de que no hay foto guardarsolo el usuario
      await ref.set(usuario.toFirebaseMap(), SetOptions(merge: true));
    }
  }
}
