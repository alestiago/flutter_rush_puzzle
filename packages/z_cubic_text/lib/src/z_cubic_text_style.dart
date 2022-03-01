import 'package:flutter/widgets.dart';

class ZCubicTextStyle {
  const ZCubicTextStyle({
    this.fontSize = 10.0,
    this.color = const Color(0xFF000000),
    this.frontColor,
    this.rearColor,
    this.leftColor,
    this.rightColor,
    this.topColor,
    this.bottomColor,
  });

  final double fontSize;
  final Color color;
  final Color? frontColor;
  final Color? rearColor;
  final Color? leftColor;
  final Color? rightColor;
  final Color? topColor;
  final Color? bottomColor;
}
