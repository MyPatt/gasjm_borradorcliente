import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({@required this.texto, @required this.onPressed});

  final void Function() onPressed;
  final String texto;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: AppTheme.blueBackground)),
      child: MaterialButton(
        minWidth: double.infinity,
        height: 60.0,
        //onPressed: () {},
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(
            texto,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: AppTheme.blueBackground, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
