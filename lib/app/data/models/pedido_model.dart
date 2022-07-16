class PedidoModel {
  final String? idPedido;
  final String idProducto;
  final String idCliente;
  final String idRepartidor;
  final String idEstadoPedido;
  final DateTime fechaPedido;
  final DateTime horaPedido;
  final int totalPedido;

  PedidoModel(
      { this.idPedido,
      required this.idProducto, 
      required this.idCliente,
      required this.idRepartidor,
      required this.idEstadoPedido,
      required this.fechaPedido,
      required this.horaPedido,
      required this.totalPedido});

  factory PedidoModel.fromJson(Map<String, dynamic> json) => PedidoModel(
        idPedido: json["idPedido"],
        idProducto: json["idProducto"],
        idCliente: json["idCliente"],
        idRepartidor: json["idRepartidor"],
        idEstadoPedido: json["idEstadoPedido"],
        fechaPedido: json["fechaPedido"],
        horaPedido: json["horaPedido"],
        totalPedido: json["totalPedido"],
      );

  Map<String, dynamic> toJson() => {
        "idPedido": idPedido,
        "idProducto": idProducto,
        "idCliente": idCliente,
        "idRepartidor": idRepartidor,
        "idEstadoPedido": idEstadoPedido,
        "fechaPedido": fechaPedido,
        "horaPedido": horaPedido,
        "totalPedido": totalPedido,
      };
}
