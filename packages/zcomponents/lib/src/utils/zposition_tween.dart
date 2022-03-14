import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zcomponents/zcomponents.dart';

class ZAnimatedPositioned extends StatelessWidget {
  ZAnimatedPositioned({
    Key? key,
    ZVector scale = ZVector.identity,
    ZVector translate = ZVector.zero,
    ZVector rotate = ZVector.zero,
    this.curve,
    required this.duration,
    required this.child,
  })  : position =
            ZPosition(scale: scale, translate: translate, rotate: rotate),
        super(key: key);

  const ZAnimatedPositioned.position({
    Key? key,
    required this.position,
    this.curve,
    required this.duration,
    required this.child,
  }) : super(key: key);

  final Widget child;

  final Duration duration;

  final Curve? curve;

  final ZPosition position;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<ZPosition?>(
      tween: ZPositionTween(
        begin: position,
        end: position,
      ),
      duration: duration,
      curve: curve ?? Curves.linear,
      builder: (_, animatedTransform, child) {
        final transform = animatedTransform ?? const ZPosition();
        return ZPositioned(
          rotate: transform.rotate,
          scale: transform.scale,
          translate: transform.translate,
          child: child!,
        );
      },
      child: child,
    );
  }
}

class ZPosition extends Equatable {
  const ZPosition({
    this.rotate = ZVector.zero,
    this.translate = ZVector.zero,
    this.scale = ZVector.identity,
  });

  final ZVector rotate;
  final ZVector translate;
  final ZVector scale;

  @override
  List<Object?> get props => [rotate, translate, scale];
}

class ZPositionTween extends Tween<ZPosition?> {
  /// Creates a [Color] tween.
  ///
  /// The [begin] and [end] properties may be null; the null value
  /// is treated as transparent.
  ///
  /// We recommend that you do not pass [Colors.transparent] as [begin]
  /// or [end] if you want the effect of fading in or out of transparent.
  /// Instead prefer null. [Colors.transparent] refers to black transparent and
  /// thus will fade out of or into black which is likely unwanted.
  ZPositionTween({ZPosition? begin, ZPosition? end})
      : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  ZPosition? lerp(double t) {
    return ZPosition(
      rotate: ZVector.lerp(begin!.rotate, end?.rotate, t),
      translate: ZVector.lerp(begin!.translate, end?.translate, t),
      scale: ZVector.lerp(begin!.scale, end?.scale, t),
    );
  }
}
