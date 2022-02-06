import 'package:flutter/widgets.dart';
import 'package:zflutter/zflutter.dart';

class ZTile extends StatelessWidget {
  ZTile({
    required this.size,
    required this.depth,
    required this.frontColor,
    required this.sideColor,
  });

  final double size;
  final double depth;

  final Color frontColor;
  final Color sideColor;

  Widget get _frontFace => ZPositioned(
        translate: ZVector.only(z: depth / 2),
        child: ZRect(
          color: frontColor,
          fill: true,
          width: size,
          height: size,
        ),
      );

  Widget get _leftFace => ZPositioned(
        translate: ZVector.only(x: -size / 2),
        rotate: const ZVector.only(y: -tau / 4),
        child: ZRect(
          width: depth,
          height: size,
          color: sideColor,
          fill: true,
        ),
      );

  Widget get _rightFace => ZPositioned(
        translate: ZVector.only(x: size / 2),
        rotate: const ZVector.only(y: tau / 4),
        child: ZRect(
          width: depth,
          color: sideColor,
          height: size,
          fill: true,
        ),
      );

  Widget get _topFace => ZPositioned(
        translate: ZVector.only(y: -size / 2),
        rotate: const ZVector.only(x: -tau / 4),
        child: ZRect(
          width: size,
          color: sideColor,
          height: depth,
          fill: true,
        ),
      );

  Widget get _bottomFace => ZPositioned(
        translate: ZVector.only(y: size / 2),
        rotate: const ZVector.only(x: tau / 4),
        child: ZRect(
          width: size,
          color: sideColor,
          fill: true,
          height: depth,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        _frontFace,
        _leftFace,
        _rightFace,
        _topFace,
        _bottomFace,
      ],
    );
  }
}
