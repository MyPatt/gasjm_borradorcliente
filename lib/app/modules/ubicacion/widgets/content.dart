import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/ubicacion/widgets/form_ubicacion.dart';

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
         child: FormUbicacion()),
      )])
      );
      
    
  }
}
