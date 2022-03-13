import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:zcomponents/zcomponents.dart';

class ZCloud extends StatelessWidget {
  ZCloud({
    Key? key,
  }) : super(key: key);

  final Color color = Colors.white;
  final Color frontColor = Colors.grey[200]!;
  final Color sideColor = Colors.grey[100]!;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ZBox(
          width: 80,
          height: 40,
          depth: 40,
          color: color,
          frontColor: frontColor,
          leftColor: sideColor,
          rightColor: sideColor,
        ),
        ZPositioned(
          translate: ZVector.only(x: -40 - 12, y: 10, z: -10),
          child: ZBox(
            width: 20,
            height: 20,
            depth: 20,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(x: 15, y: 0, z: 35),
          child: ZBox(
            width: 40,
            height: 20,
            depth: 10,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(x: -40 - 14, y: -35, z: 0),
          child: ZBox(
            width: 15,
            height: 15,
            depth: 18,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(x: -25, y: 35, z: 0),
          child: ZBox(
            width: 20,
            height: 5,
            depth: 12,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(x: -100, y: 20, z: 0),
          child: ZBox(
            width: 20,
            height: 8,
            depth: 12,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(x: -80, y: 0, z: -30),
          child: ZBox(
            width: 12,
            height: 12,
            depth: 12,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(x: 60, y: -20, z: 30),
          child: ZBox(
            width: 12,
            height: 12,
            depth: 12,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(x: 60, y: -20 - 12, z: 30 + 12),
          child: ZBox(
            width: 4,
            height: 4,
            depth: 4,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(x: 40, y: 20 + 12, z: 30 + 12),
          child: ZBox(
            width: 40,
            height: 4,
            depth: 10,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(x: -20, y: 20 + 20, z: 30 + 12),
          child: ZBox(
            width: 10,
            height: 8,
            depth: 10,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(x: 10, y: -20 -10, z: 10),
          child: ZBox(
            width: 6,
            height: 10,
            depth: 20,
            color: color,
            frontColor: frontColor,
            leftColor: sideColor,
            rightColor: sideColor,
          ),
        ),
      ],
    );
  }
}
