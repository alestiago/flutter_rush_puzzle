import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:zflutter/zflutter.dart';

/// A quarter of a turn. 45 degrees or pi/2 radians
const double quarterTurn = math.pi / 2;

/// Squared game tiles
class ZTile extends StatelessWidget {
  /// Squared game tiles
  ZTile({
    Key? key,
    required this.size,
    required this.depth,
    required this.color,
    required this.sideColor,
  }) : super(key: key);

  /// Width and height of the tile
  final double size;

  /// Width and height of the tile
  final double depth;

  /// Tile color
  final Color color;

  /// Color of the sides of the
  final Color sideColor;

  late final Widget _frontFace = ZPositioned(
    translate: ZVector.only(z: depth / 2),
    child: ZRect(
      key: const Key('tile_frontFace'),
      color: color,
      fill: true,
      width: size,
      height: size,
    ),
  );

  late final Widget _leftFace = ZPositioned(
    translate: ZVector.only(x: -size / 2),
    rotate: const ZVector.only(y: -quarterTurn),
    child: ZRect(
      key: const Key('tile_leftFace'),
      width: depth,
      height: size,
      color: sideColor,
      fill: true,
    ),
  );

  late final _rightFace = ZPositioned(
    translate: ZVector.only(x: size / 2),
    rotate: const ZVector.only(y: quarterTurn),
    child: ZRect(
      key: const Key('tile_rightFace'),
      width: depth,
      color: sideColor,
      height: size,
      fill: true,
    ),
  );

  late final _topFace = ZPositioned(
    translate: ZVector.only(y: -size / 2),
    rotate: const ZVector.only(x: -quarterTurn),
    child: ZRect(
      key: const Key('tile_topFace'),
      width: size,
      color: sideColor,
      height: depth,
      fill: true,
    ),
  );

  late final _bottomFace = ZPositioned(
    translate: ZVector.only(y: size / 2),
    rotate: const ZVector.only(x: quarterTurn),
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
