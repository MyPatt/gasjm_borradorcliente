import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/providers/pedidos_provider.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:get/get.dart';

class PedidoRepositoryImpl extends PedidoRepository {
  final _provider = Get.find<PedidoProvider>();

  @override
  Future<List<PedidoModel>?> getPedidos() => _provider.getPedidos();

  @override
  Future<String> insertPedido({required PedidoModel pedidoModel}) =>
      _provider.insertPedido(pedidoModel: pedidoModel);
}
