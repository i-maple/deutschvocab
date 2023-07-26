import 'package:flutter/material.dart';
import 'dart:math';

class LoginScreenCurve extends CustomPainter {
  const LoginScreenCurve(
      {this.color = Colors.green, this.xOffset = 0.0, this.yOffset = 0.0});
  final Color color;
  final double xOffset;
  final double yOffset;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var amplitude = 80, frequency = 0.01;
    var path = Path();
    path.moveTo(xOffset, yOffset);
    for (double i = 0; i < size.width; i++) {
      double j = amplitude * sin(frequency * i) + yOffset;
      path.lineTo(i, j);
    }
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(xOffset, yOffset);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
