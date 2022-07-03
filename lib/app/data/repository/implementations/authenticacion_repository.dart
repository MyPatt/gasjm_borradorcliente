import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AutenticacionRepositoryImpl extends AutenticacionRepository {
  final _firebaseAutenticacion = FirebaseAuth.instance;

//Modelo User de Firebase
  AutenticacionUsuario? _usuarioDeFirebase(User? usuario) => usuario == null
      ? null
      : AutenticacionUsuario(usuario.uid, usuario.displayName);

  @override
  AutenticacionUsuario? get autenticacionUsuario =>
      _usuarioDeFirebase(_firebaseAutenticacion.currentUser);

  @override
  Stream<AutenticacionUsuario?> get enEstadDeAutenticacionCambiado =>
      _firebaseAutenticacion.authStateChanges().asyncMap(_usuarioDeFirebase);

  @override
  Future<AutenticacionUsuario?> crearUsuarioConCorreoYContrasena(
      String correo, String contrasena) async {
    try {
      //Registro de correo y contraena
      final resultadoAutenticacion = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: correo, password: contrasena);
      //Actualizar Nombre y apellido

      //
      return _usuarioDeFirebase(resultadoAutenticacion.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('La contraseña es demasiado débil');
      } else if (e.code == 'email-already-in-use') {
        print('La cuenta ya existe para ese correo electrónico');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<AutenticacionUsuario?> iniciarSesionConCorreoYContrasena(
      String correo, String contrasena) async {
    final resultadoAutenticacion = await _firebaseAutenticacion
        .signInWithEmailAndPassword(email: correo, password: contrasena);
    return _usuarioDeFirebase(resultadoAutenticacion.user);
  }

  @override
  Future<AutenticacionUsuario?> iniciarSesionConGoogle() async {
    final usuarioGoogle = await GoogleSignIn().signIn();
    final autenticacionGoogle = await usuarioGoogle?.authentication;

    final credencial = GoogleAuthProvider.credential(
      accessToken: autenticacionGoogle?.accessToken,
      idToken: autenticacionGoogle?.idToken,
    );
    try {
      final resultadoAutenticacion =
          await FirebaseAuth.instance.signInWithCredential(credencial);
      return _usuarioDeFirebase(resultadoAutenticacion.user);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    return null;
  }

  @override
  Future<AutenticacionUsuario?> inicarSesionConFacebook() async {
    final resultado = await FacebookAuth.instance.login();
    print("****\n");
    final fbAutenticacionCredencial =
        FacebookAuthProvider.credential(resultado.accessToken!.token);

    final autenticacionResultado = await FirebaseAuth.instance
        .signInWithCredential(fbAutenticacionCredencial);

    return _usuarioDeFirebase((autenticacionResultado.user));
  }

  @override
  Future<void> cerrarSesion() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAutenticacion.signOut();
  }

  @override
  Future<AutenticacionUsuario?> crearUsuario(UsuarioModel usuario) async {
    try {
      //Registro de correo y contraena
      final resultadoAutenticacion = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: usuario.correo, password: usuario.contrasena);
      //Actualizar Nombre y apellido del usuario creado
      await resultadoAutenticacion.user!.updateDisplayName(
        "${usuario.nombre} ${usuario.apellido}",
      );
      //
      return _usuarioDeFirebase(resultadoAutenticacion.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('La contraseña es demasiado débil');
      } else if (e.code == 'email-already-in-use') {
        print('La cuenta ya existe para ese correo electrónico');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
