import 'package:flutter/material.dart';

import '../curve/loginscreen_curve.dart';

class CurveLayout extends StatelessWidget {
  const CurveLayout({super.key, this.color, this.xOffset, this.yOffset});
  final Color? color;
  final double? xOffset;
  final double? yOffset;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LoginScreenCurve(
          color: color ?? Colors.black,
          xOffset: xOffset ?? 0.0,
          yOffset: yOffset ?? 0.0),
      child: Container(),
    );
  }
}
