class PedidoModel {
  final String? idPedido;
  final String idProducto;
  final String idCliente;
  final String idRepartidor;
  final Direccion direccion;
  final String idEstadoPedido;
  final DateTime fechaPedido;
  final DateTime? fechaEntregaPedido;
  final DateTime? horaEntregaPedido;
  final String? notaPedido;
  final double totalPedido;

  PedidoModel( 
      {this.idPedido,
      required this.idProducto,
      required this.idCliente,
      required this.idRepartidor,
      required this.direccion,
      required this.idEstadoPedido,
      required this.fechaPedido,
      required this.fechaEntregaPedido,
      required this.horaEntregaPedido, 
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
        fechaEntregaPedido: json["fechaEntregaPedido"],
         horaEntregaPedido: json["horaEntregaPedido"],
          direccion: Direccion.fromMap(json["direccion"]),
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
          "fechaEntregaPedido": fechaEntregaPedido ,
         "horaEntregaPedido":  horaEntregaPedido ,
          "direccionn": direccion.toMap(),
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
