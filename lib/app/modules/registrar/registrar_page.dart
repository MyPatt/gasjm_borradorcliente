import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/registrar/registrar_controller.dart';
import 'package:gasjm/app/modules/registrar/widgets/content.dart';
import 'package:get/get.dart';

class RegistrarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrarController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: BackButton(
            color: AppTheme.blueDark,
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: Content()
            ),
          ),
        ),
      ),
    );
  }
}
