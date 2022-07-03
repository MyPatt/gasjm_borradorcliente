//Clase con metodo de validaciones de campos
class Validator {
  //Metodo para validar que el nombre nu sea nulo y vacio

  static String? validarNombre(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'Ingrese un nombre';
    }

    return null;
  }

  //Metodo para validar que el apellido nu sea nulo y vacio
  static String? validarApellido(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'Ingrese un apellido';
    }

    return null;
  }
  //

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Ingresar un correo electrónico';

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (!emailRegExp.hasMatch(value)) {
      return 'Ingrese un correo electrónico válido';
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Ingresar una contraseña';
    if (value.length < 6)
      return 'La contraseña debe tener al menos 6 caracteres';

    return null;
  }

  //Metodo para validar que el correo electronico nu sea nulo y vacio

  static String? validarCorreoElectronico(String? correoElectronico) {
    if (correoElectronico == null) {
      return '';
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (correoElectronico.isEmpty) {
      return 'Ingrese un correo electrónico';
    } else if (!emailRegExp.hasMatch(correoElectronico)) {
      return 'Ingrese un correo electrónico válido';
    }

    return null;
  }

  static String? validarContrasena(String? contrasena) {
    if (contrasena == null) {
      return '-';
    }
    if (contrasena.isEmpty) {
      return 'Ingresar una contraseña';
    } else if (contrasena.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }

    return null;
  }
}
