import 'package:cloud_firestore/cloud_firestore.dart';

class PedidoModel {
  final String? idPedido;
  final String idProducto;
  final String idCliente;
  final String idRepartidor;
  final Direccion direccion;
  final String idEstadoPedido;
  final Timestamp fechaPedido;
  final Timestamp? fechaHoraEntregaPedido;

  final int cantidadPedido;
  final String? notaPedido;
  final double totalPedido;

  //
  

  PedidoModel(
      {this.idPedido,
      required this.idProducto,
      required this.idCliente,
      required this.idRepartidor,
      required this.direccion,
      required this.idEstadoPedido,
      required this.fechaPedido,
      required this.fechaHoraEntregaPedido,
      required this.cantidadPedido,
      required this.notaPedido,
      required this.totalPedido});

  factory PedidoModel.fromJson(Map<String, dynamic> json) => PedidoModel(
        idPedido: json["idPedido"],
        idProducto: json["idProducto"],
        idCliente: json["idCliente"],
        idRepartidor: json["idRepartidor"],
        idEstadoPedido: json["idEstadoPedido"],
        fechaPedido: json["fechaPedido"],
        notaPedido: json["horaPedido"],
        totalPedido: json["totalPedido"],
        fechaHoraEntregaPedido: json["fechaEntregaPedido"],
        direccion: Direccion.fromMap(json["direccion"]),
        cantidadPedido: json["cantidadPedido"],
      );

  Map<String, dynamic> toJson() => {
        "idPedido": idPedido,
        "idProducto": idProducto,
        "idCliente": idCliente,
        "idRepartidor": idRepartidor,
        "idEstadoPedido": idEstadoPedido,
        "fechaPedido": fechaPedido,
        "horaPedido": notaPedido,
        "totalPedido": totalPedido,
        "fechaEntregaPedido": fechaHoraEntregaPedido,
        "direccion": direccion.toMap(),
        "cantidadPedido": cantidadPedido,
      };
}

class Direccion {
  Direccion({
    required this.latitud,
    required this.longitud,
  });

  final double latitud;
  final double longitud;

  factory Direccion.fromMap(Map<String, dynamic> json) => Direccion(
        latitud: json["latitud"],
        longitud: json["longitud"],
      );

  Map<String, dynamic> toMap() => {
        "latitud": latitud,
        "longitud": longitud,
      };
}
