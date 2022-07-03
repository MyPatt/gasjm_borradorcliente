 

import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/registrar/widgets/form_registrar.dart';

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Container(
          alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const FormRegistrar()),
      ),
      /* Stack(
        alignment: Alignment.bottomLeft,
        children: [WavyFooter(), CircleSecond(), CircleFirst()],
      )*/
    ]);
  }
}
