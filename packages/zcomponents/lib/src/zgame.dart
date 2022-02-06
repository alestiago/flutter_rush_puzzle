import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zcomponents/zcomponents.dart';
import 'package:zflutter/zflutter.dart';

class ZGame extends StatelessWidget {
  const ZGame({
    Key? key,
    required this.theme,
    this.transform,
  }) : super(key: key);

  final BoardTheme theme;
  final ZTransform? transform;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<BoardTheme?>(
      tween: BoardThemeTween(
        begin: theme,
        end: theme,
      ),
      duration: const Duration(milliseconds: 600),
      builder: (_, value, __) => TweenAnimationBuilder<ZTransform?>(
        tween: ZTransformTween(
          begin: transform,
          end: transform,
        ),
        duration: const Duration(milliseconds: 600),
        builder: (_, animatedTransform, __) => ZDragDetector(
          builder: (context, controller) {
            final transform = animatedTransform ?? ZTransform();
            return Align(
              child: ZIllustration(
                children: [
                  ZPositioned(
                    rotate: transform.rotate,
                    scale: transform.scale,
                    translate: transform.translate,
                    child: ZPositioned(
                      rotate: controller.value,
                      child: ZBoard(
                        theme: value!,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

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

class BoardThemeTween extends Tween<BoardTheme?> {
  /// Creates a [Color] tween.
  ///
  /// The [begin] and [end] properties may be null; the null value
  /// is treated as transparent.
  ///
  /// We recommend that you do not pass [Colors.transparent] as [begin]
  /// or [end] if you want the effect of fading in or out of transparent.
  /// Instead prefer null. [Colors.transparent] refers to black transparent and
  /// thus will fade out of or into black which is likely unwanted.
  BoardThemeTween({BoardTheme? begin, BoardTheme? end})
      : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  BoardTheme? lerp(double t) => BoardTheme.lerp(begin, end, t);
}

class BoardTheme {
  BoardTheme({
    required this.frontTileColor,
    required this.borderTileColor,
    required this.frontContainerColor,
    required this.innerBorderContainerColor,
    required this.innerBackgroundContainerColor,
    required this.outterBorderContainerColor,
    required this.backContainerColor,
    required this.background,
  });

  factory BoardTheme.fromMaterialColor(MaterialColor color) {
    return BoardTheme(
      frontTileColor: color[200],
      borderTileColor: color[300],
      frontContainerColor: color[200],
      innerBorderContainerColor: color[300],
      innerBackgroundContainerColor: color[400],
      outterBorderContainerColor: color[300],
      backContainerColor: color[500],
      background: color[100],
    );
  }

  final Color? frontTileColor;
  final Color? borderTileColor;
  final Color? frontContainerColor;
  final Color? innerBorderContainerColor;
  final Color? innerBackgroundContainerColor;
  final Color? outterBorderContainerColor;
  final Color? backContainerColor;
  final Color? background;

  static BoardTheme? lerp(BoardTheme? a, BoardTheme? b, double t) {
    return BoardTheme(
      frontTileColor: Color.lerp(a?.frontTileColor, b?.frontTileColor, t),
      borderTileColor: Color.lerp(a?.borderTileColor, b?.borderTileColor, t),
      frontContainerColor:
          Color.lerp(a?.frontContainerColor, b?.frontContainerColor, t),
      innerBorderContainerColor: Color.lerp(
        a?.innerBorderContainerColor,
        b?.innerBorderContainerColor,
        t,
      ),
      innerBackgroundContainerColor: Color.lerp(
        a?.innerBackgroundContainerColor,
        b?.innerBackgroundContainerColor,
        t,
      ),
      outterBorderContainerColor: Color.lerp(
        a?.outterBorderContainerColor,
        b?.outterBorderContainerColor,
        t,
      ),
      backContainerColor:
          Color.lerp(a?.backContainerColor, b?.backContainerColor, t),
      background: Color.lerp(a?.background, b?.background, t),
    );
  }
}
