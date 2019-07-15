import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

import 'Theme.dart';

class WaveAnimationWidget extends StatelessWidget {

  final bool isHightWave;
  WaveAnimationWidget({this.isHightWave});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        onBottom(
          AnimatedWave(
            height: isHightWave?380:80,
            speed: .3,
            offset: pi,
            color: accentColor.withAlpha(90),
          ),
        ),
        onBottom(
          AnimatedWave(
            height: isHightWave?430:130,
            speed: .4,
            offset: pi / 2,
            color: Colors.black.withAlpha(60),
          ),

        ),
        onBottom(
          AnimatedWave(
            height: isHightWave?390:90,
            speed: .2,
            offset: pi / 3,
            color: Colors.black.withAlpha(30),
          ),

        ),
      ],
    );
  }

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;
  Color color;
  AnimatedWave({this.height, this.speed, this.offset = 0.0,this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset,color,));
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;
  Color color;
  CurvePainter(this.value,this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = color;//Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
