import 'package:flutter/widgets.dart';
import 'package:zcomponents/zcomponents.dart';

class ZVectorTween extends Tween<ZVector> {
  ZVectorTween({
    ZVector? begin,
    ZVector? end,
  }) : super(begin: begin, end: end);

  @override
  ZVector lerp(double t) {
    return ZVector.lerp(begin!, end, t);
  }
}
