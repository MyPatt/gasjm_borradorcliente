import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/theme/text_theme.dart';
import 'package:gasjm/app/global_widgets/button_small.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/inicio_repartidor/pedidos/pedidos_controller.dart';
import 'package:get/get.dart';

class PedidosEnEsperaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PedidosController>(
      builder: (_) => CustomScrollView(
        slivers: <Widget>[
          /*   SliverAppBar(
                actions: <Widget>[
                  Icon(
                    Icons.person,
                    size: 40,
                  )
                ],
                title: Text("SliverList Example"),
                leading: Icon(Icons.menu),
                backgroundColor: Colors.green,
                expandedHeight: 100.0,
                floating: true,
                pinned: true),*/
          SliverList(
              delegate: SliverChildListDelegate(
                  _buildList(15, context))), // Place sliver widgets here
        ],
      ),
    );
  }
}

List<Widget> _buildList(int count, BuildContext context) {
  List<Widget> listItems = [];
  for (int i = 0; i < count; i++) {
    listItems.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            _cardTipo1())); /* child: Text('Sliver Item ${i.toString()}',
            style: const TextStyle(fontSize: 22.0))));*/
  }
  return listItems;
}

Widget _cardTipo1() {
  return Card(
    shape: Border.all(color: AppTheme.light, width: 0.5),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              TextSubtitle(
                text: "Cliente Cliente",
                style: TextoTheme.subtitleStyle2,
              ),
              TextSubtitle(text: '5', style: TextoTheme.subtitleStyle2)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              TextDescription(text: "Santa Rosa"),
              TextDescription(text: '5 min')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              TextDescription(text: "Hoy, 29/07"),
              TextDescription(text: '300m')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonSmall(
                  texto: "Rechazar", color: AppTheme.light, onPressed: () {}),
              ButtonSmall(texto: "Aceptar", onPressed: () {})
            ],
          ),
        ],
      ),
    ),
  );
}
