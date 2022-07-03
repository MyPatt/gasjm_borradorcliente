//Clase para el usuario
import 'package:equatable/equatable.dart';

class UsuarioModel extends Equatable{
  final String? id;

  final String? cedula;
  final String nombre;
  final String apellido; 
    final String correo;
      final String contrasena;
  final String? foto; 

  const UsuarioModel(

      this.nombre,
      this.apellido,    this.correo, this.contrasena,{      this.id,this.cedula,this.foto
      });

  Map<String, Object?> toFirebaseMap({String? newFoto}) {
    return <String, Object?>{
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'cedula': cedula,
      'foto': newFoto ?? foto,
    };
  }
  
  UsuarioModel.fromFirebaseMap(Map<String,Object?> data)
  :  id= data['id'] as String,
   nombre= data['nombre'] as String,
     apellido= data['apellido'] as String,    
     correo= data['correo'] as String,
     contrasena= data['contrasena'] as String, 
     cedula= data['cedula'] as String, 
     foto= data['foto'] as String;

 

  @override
  
  List<Object?> get props => [id,nombre,apellido,cedula,foto];
}
