import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';

class PedidoProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;

  Future<List<PedidoModel>?> getPedidos() async {
    final snapshot = await _firestoreInstance.collection('pedido').get();

    return (snapshot.docs)
        .map((item) => PedidoModel.fromJson(item.data()))
        .toList();
  }

  Future<String> insertPedido({required PedidoModel pedidoModel}) async {
   
        _firestoreInstance.collection('pedido').doc().set(pedidoModel.toJson());
    return "insert";
  }
}
