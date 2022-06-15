import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/header/header_global.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/identificacion/identificacion_controller.dart';
import 'package:gasjm/app/modules/identificacion/widgets/content.dart';
import 'package:get/get.dart';

class IdentificacionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IdentificacionController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: BackButton(
            color: AppTheme.blueDark,
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: Content(),
            ),
          ),
        ),
      ),
    );
  }
}
