class PersonaModel {
  PersonaModel({
    required this.cedulaPersona,
    required this.nombrePersona,
    required this.apellidoPersona,
    required this.fotoPersona,
    required this.direccionPersona,
    required this.celularPersona,
    required this.fechaNaciPersona,
    required this.idPerfil,
  });

  final String cedulaPersona;
  final String nombrePersona;
  final String apellidoPersona;
  final String? fotoPersona;
  final String? direccionPersona;
  final String? celularPersona;
  final String fechaNaciPersona;
  final String idPerfil;

  factory PersonaModel.fromMap(Map<String, dynamic> json) => PersonaModel(
        cedulaPersona: json["cedulaPersona"],
        nombrePersona: json["nombrePersona"],
        apellidoPersona: json["apellidoPersona"],
        fotoPersona: json["fotoPersona"],
        direccionPersona: json["direccionPersona"],
        celularPersona: json["celularPersona"],
        fechaNaciPersona: json["fechaNaciPersona"],
        idPerfil: json["idPerfil"],
      );

  Map<String, dynamic> toMap() => {
        "cedulaPersona": cedulaPersona,
        "nombrePersona": nombrePersona,
        "apellidoPersona": apellidoPersona,
        "fotoPersona": fotoPersona,
        "direccionPersona": direccionPersona,
        "celularPersona": celularPersona,
        "fechaNaciPersona": fechaNaciPersona,
        "idPerfil": idPerfil,
      };
}
