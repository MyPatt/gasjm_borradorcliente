import 'package:flutter/material.dart';
class PedidosEnEsperaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
              child: 
              Text('First Activity Screen', 
                style: TextStyle(fontSize: 21),)
              )
            )
          );
  }
}