import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';



abstract class ProgressDialog {
  static void show(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => WillPopScope(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black12,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: AppTheme.blueBackground,
              //value: 1,
            ),
          ),
          onWillPop: () async => false),
    );
  }
}
