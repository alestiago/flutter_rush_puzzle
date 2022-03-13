import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_cubic_text/src/z_cubic_text_style.dart';
import 'package:zflutter/zflutter.dart';

enum ZSlabOrientation { top, bottom, right, left }

class ZSlab extends StatelessWidget {
  const ZSlab({
    Key? key,
    required this.orientation,
  }) : super(key: key);

  final ZSlabOrientation orientation;

  @override
  Widget build(BuildContext context) {
    final style = context.read<ZCubicTextStyle>();

    late final double width, height;
    switch (orientation) {
      case ZSlabOrientation.top:
      case ZSlabOrientation.bottom:
        width = style.fontSize;
        height = style.fontSize / 2;
        break;
      case ZSlabOrientation.right:
      case ZSlabOrientation.left:
        width = style.fontSize / 2;
        height = style.fontSize;
        break;
    }

    final box = ZBox(
      width: width,
      height: height,
      depth: style.fontSize / 2,
      color: style.color,
      frontColor: style.frontColor,
      rearColor: style.rearColor,
      leftColor: style.leftColor,
      rightColor: style.rightColor,
      topColor: style.topColor,
      bottomColor: style.bottomColor,
      stroke: 0,
    );

    late final double y;
    switch (orientation) {
      case ZSlabOrientation.top:
        y = -box.height / 2;
        break;
      case ZSlabOrientation.bottom:
        y = box.height / 2;
        break;
      case ZSlabOrientation.right:
      case ZSlabOrientation.left:
        y = 0;
    }

    late final double x;
    switch (orientation) {
      case ZSlabOrientation.right:
        x = box.width / 2;
        break;
      case ZSlabOrientation.left:
        x = -box.width / 2;
        break;
      case ZSlabOrientation.top:
      case ZSlabOrientation.bottom:
        x = 0;
    }

    return ZPositioned(
      translate: ZVector.only(y: y, x: x),
      child: box,
    );
  }
}
