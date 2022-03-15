import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:zclouds/zclouds.dart';
import 'package:zflutter/zflutter.dart';

/// {@template zclouds.zcumulus}
/// Represents a [ZCloudType.cumulus] cloud.
/// {@endtemplate}
@internal
class ZCumulus extends StatelessWidget {
  /// {@macro zclouds.zcumulus}
  const ZCumulus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ZCloudStyle>();
    final color = theme.color.withOpacity(theme.opacity);
    final frontColor = theme.frontColor?.withOpacity(theme.opacity) ?? color;
    final sideColor = theme.sideColor?.withOpacity(theme.opacity) ?? color;

    return ZGroup(
      sortMode: SortMode.update,
      sortPoint: ZVector.zero,
      children: [
        ZBox(
          width: 80,
          height: 40,
          depth: 40,
          color: color,
          frontColor: frontColor,
          leftColor: sideColor,
          rightColor: sideColor,
          stroke: 0,
        ),
        ZPositioned(
          translate: const ZVector.only(x: -40 - 12, y: 10, z: -10),
          child: ZBox(
            width: 20,
            height: 20,
            depth: 20,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
            stroke: 0,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(x: 15, z: 35),
          child: ZBox(
            width: 40,
            height: 20,
            depth: 10,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
            stroke: 0,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(x: -40 - 14, y: -35),
          child: ZBox(
            width: 15,
            height: 15,
            depth: 18,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
            stroke: 0,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(x: -25, y: 35),
          child: ZBox(
            width: 20,
            height: 5,
            depth: 12,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
            stroke: 0,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(x: -100, y: 20),
          child: ZBox(
            width: 20,
            height: 8,
            depth: 12,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
            stroke: 0,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(x: -80, z: -30),
          child: ZBox(
            width: 12,
            height: 12,
            depth: 12,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
            stroke: 0,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(x: 60, y: -20, z: 30),
          child: ZBox(
            width: 12,
            height: 12,
            depth: 12,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
            stroke: 0,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(x: 60, y: -20 - 12, z: 30 + 12),
          child: ZBox(
            width: 4,
            height: 4,
            depth: 4,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
            stroke: 0,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(x: 40, y: 20 + 12, z: 30 + 12),
          child: ZBox(
            width: 40,
            height: 4,
            depth: 10,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
            stroke: 0,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(x: -20, y: 20 + 20, z: 30 + 12),
          child: ZBox(
            width: 10,
            height: 8,
            depth: 10,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
            stroke: 0,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(x: 10, y: -20 - 10, z: 10),
          child: ZBox(
            width: 6,
            height: 10,
            depth: 20,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
            stroke: 0,
          ),
        ),
      ],
    );
  }
}
