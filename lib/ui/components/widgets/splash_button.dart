import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class SplashButtonCustom extends StatelessWidget {
  const SplashButtonCustom({
    super.key,
    this.backgroundColor,
    this.onTap,
    this.splashColor,
    this.outlined = false,
    this.outlineWidth,
    this.borderRadius,
    this.text,
    this.padding,
  });
  final VoidCallback? onTap;
  final Color? splashColor;
  final Color? backgroundColor;
  final String? text;
  final bool outlined;
  final double? outlineWidth;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: splashColor ?? darkYellow,
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: !outlined ? backgroundColor ?? darkYellow : null,
          border: outlined
              ? Border.all(
                  color: backgroundColor ?? darkYellow,
                  width: outlineWidth ?? 1.0)
              : null,
          borderRadius: BorderRadius.circular(
            borderRadius ?? 1.0,
          ),
        ),
        child: Center(
            child: Text(
          text ?? '',
          style: GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
