import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class PrimaryMediumButton extends StatelessWidget {
  PrimaryMediumButton({
    required this.texto,
    required this.onPressed,
  });
  final void Function() onPressed;
  final String texto;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: AppTheme.blueBackground,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: MaterialButton(
        minWidth: 100,
        height: 50.0,
        //onPressed: () {},
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(
            texto,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
