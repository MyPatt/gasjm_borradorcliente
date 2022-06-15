import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/background.dart';
import 'package:gasjm/app/global_widgets/header/clipper_global.dart';
import 'package:gasjm/app/modules/identificacion/widgets/form_identificacion.dart';

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: FormIdentificacion()),
      ),
      /* Stack(
        alignment: Alignment.bottomLeft,
        children: [WavyFooter(), CircleSecond(), CircleFirst()],
      )*/
    ]);
  }
}
