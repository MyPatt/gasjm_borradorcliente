import 'package:flutter/material.dart'; 
 import 'package:gasjm/app/modules/perfil/widgets/form_perfil.dart';

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20), child: FormPerfil()),
      ),
      /* Stack(
        alignment: Alignment.bottomLeft,
        children: [WavyFooter(), CircleSecond(), CircleFirst()],
      )*/
    ]);
  }
}
