import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_cubic_text/z_cubic_text.dart';
import 'package:zflutter/zflutter.dart';

class ZCube extends StatelessWidget {
  const ZCube({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = context.read<ZCubicTextStyle>();

    return ZBox(
      width: style.fontSize,
      height: style.fontSize,
      depth: style.fontSize / 2,
      color: style.color,
      frontColor: style.frontColor,
      rearColor: style.rearColor,
      leftColor: style.leftColor,
      rightColor: style.rightColor,
      topColor: style.topColor,
      bottomColor: style.bottomColor,
    );
  }
}
