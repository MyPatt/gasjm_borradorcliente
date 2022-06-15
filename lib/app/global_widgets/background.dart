import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

/*
class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Expanded(
        child: FormUbicacion(),
      ),
      Stack(
        alignment: Alignment.bottomLeft,
        children: [WavyFooter(), CircleSecond(), CircleFirst()],
      )
    ]);
  }
}
*/
class CircleSecond extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Transform.translate(
      offset: Offset(-70.0, 90.0),
      child: Material(
        color: AppTheme.blueBackground,
        child: Padding(
          padding: EdgeInsets.all(95),
        ),
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 10.0)),
      ),
    );
  }
}

class CircleFirst extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Transform.translate(
      offset: Offset(0.0, 210.0),
      child: Material(
        color: AppTheme.blueBackground,
        child: Padding(
          padding: EdgeInsets.all(130),
        ),
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 10.0)),
      ),
    );
  }
}

class WavyHeader extends StatelessWidget {
  @override
  Widget build(Object context) {
    return ClipPath(
      clipper: TopWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: AppTheme.blueGradients,
                begin: Alignment.topLeft,
                end: Alignment.center)),
        height: MediaQuery.of(context).size.height / 2.5,
      ),
    );
  }
}

class WavyFooter extends StatelessWidget {
  @override
  Widget build(Object context) {
    return ClipPath(
      clipper: FooterWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: AppTheme.blueGradients,
                begin: Alignment.center,
                end: Alignment.bottomRight)),
        height: MediaQuery.of(context).size.height / 7,
      ),
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);

    var firstControlPoint = new Offset(size.width / 7, size.height - 30);
    var firstEndPoint = new Offset(size.width / 6, size.height / 1.5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = new Offset(size.width / 5, size.height / 4);
    var secondEndPoint = new Offset(size.width / 1.5, size.height / 5);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = new Offset(size.width / 9, size.height / 6);
    var thirdEndPoint = new Offset(size.width, 0.0);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class FooterWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height - 60);

    var secondControlPoint =
        new Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = new Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
