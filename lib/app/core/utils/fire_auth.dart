 

class AutenticacionForebase {
  static iniciarSesioConCorreoYContrasena({String? correoElectronico, String? contrasena}) {}
}
 /* static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    print(">>>> " + firebaseApp.name);
  }
*
/*** */
  // Metodo para registrar un nuevo usuario
  static Future<User> registrarUsuarioPorCorreoElectronico(
      {UsuarioModel? nuevoUsuario}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: nuevoUsuario!.correoElectronico,
        password: nuevoUsuario.contrasena,
      );

      user = userCredential.user!;
      await user.updateProfile(displayName: nuevoUsuario.nombre);
      await user.reload();
      user = auth.currentUser!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('La contraseña proporcionada es demasiado débil');
      } else if (e.code == 'email-already-in-use') {
        print('La cuenta ya existe para ese correo electrónico..');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  // Metodo para iniciar sesión como usuario (ya  registrado)
  static Future<User> iniciarSesioConCorreoYContrasena({
    @required String correoElectronico,
    @required String contrasena,
  }) async {
    FirebaseAuth autenticacionFirebase = FirebaseAuth.instance;
    User usuario;

    try {
      UserCredential credencialDeUsuario =
          await autenticacionFirebase.signInWithEmailAndPassword(
        email: correoElectronico,
        password: contrasena,
      );
      usuario = credencialDeUsuario.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Ningún usuario encontrado para este correo electrónico');
      } else if (e.code == 'wrong-password') {
        print('Contraseña incorrecta');
      }
    }

    return usuario;
  }

  static Future<User> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User refreshedUser = auth.currentUser;

    return refreshedUser;*/
