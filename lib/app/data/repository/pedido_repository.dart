import 'package:gasjm/app/data/models/pedido_model.dart';

abstract class PedidoRepository {
  Future<List<PedidoModel>?> getPedidos();
  Future<String> insertPedido({required PedidoModel pedidoModel});

 
}