import 'package:flutter/animation.dart';
import 'package:zcomponents/zcomponents.dart';

class ZTransformTween extends Tween<ZTransform?> {
  /// Creates a [Color] tween.
  ///
  /// The [begin] and [end] properties may be null; the null value
  /// is treated as transparent.
  ///
  /// We recommend that you do not pass [Colors.transparent] as [begin]
  /// or [end] if you want the effect of fading in or out of transparent.
  /// Instead prefer null. [Colors.transparent] refers to black transparent and
  /// thus will fade out of or into black which is likely unwanted.
  ZTransformTween({ZTransform? begin, ZTransform? end})
      : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  ZTransform? lerp(double t) {
    return ZTransform(
      rotate: ZVector.lerp(begin!.rotate, end?.rotate, t),
      translate: ZVector.lerp(begin!.translate, end?.translate, t),
      scale: ZVector.lerp(begin!.scale, end?.scale, t),
    );
  }
}
