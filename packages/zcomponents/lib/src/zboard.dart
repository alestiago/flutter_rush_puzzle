import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zcomponents/src/vehicles/zbus.dart';
import 'package:zcomponents/src/vehicles/zcar.dart';
import 'package:zcomponents/src/vehicles/zvehicle.dart';
import 'package:zcomponents/zcomponents.dart';
import 'package:zflutter/zflutter.dart';

import 'zvehicle_controller.dart';

const tileDepth = 8.0;

class ZBoard extends StatelessWidget {
  const ZBoard(
      {Key? key, this.depth = 20, this.size = 100, required this.theme})
      : super(key: key);

  final double depth;
  final double size;

  final BoardTheme theme;

  @override
  Widget build(BuildContext context) {
    const size = 30.0;
    const space = 10.0;
    const border = 5.0;
    const depth = 20.0;
    const innerBorder = size * 6 + space * 9.0;

    final innerBorderColor = theme.innerBorderContainerColor;
    final outterBorderColor = theme.outterBorderContainerColor;
    final background = theme.innerBackgroundContainerColor;
    final front = theme.frontContainerColor;

    return ZGroup(
      sortMode: SortMode.update,
      children: [
        const ZVehicleController(
          length: 2,
          child: ZVehicle(),
        ),
        const ZVehicleController(
          length: 1,
          offset: TileOffset(1, 1),
          child: ZCar(),
        ),
        const ZVehicleController(
          length: 3,
          offset: TileOffset(4, 1),
          axis: Axis.vertical,
          child: ZBus(),
        ),
        _BoardBorders(theme: theme),
        _Board(theme: theme),
      ],
    );
  }
}

class _Board extends StatelessWidget {
  const _Board({Key? key, required this.theme}) : super(key: key);

  final BoardTheme theme;

  @override
  Widget build(BuildContext context) {
    const size = 30.0;
    const space = 10.0;
    const border = 5.0;
    const depth = 20.0;
    const innerBorder = size * 6 + space * 9.0;

    return ZGroup(
      sortMode: SortMode.update,
      children: [
        ZGroup(
          sortMode: SortMode.update,
          children: [
            ZPositioned(
              translate: const ZVector(0, 0, -depth / 2 - 0.5),
              child: ZRect(
                color: theme.innerBackgroundContainerColor!,
                height: innerBorder + border * 2,
                fill: true,
                width: innerBorder + border * 2,
                backfaceColor: theme.backContainerColor,
              ),
            ),
            ZPositioned(
              translate: const ZVector(0, 0, -10000),
              child: ZShape(
                color: Colors.transparent,
                visible: false,
              ),
            ),
          ],
        ),
        ZGroup(
          sortMode: SortMode.update,
          children: [
            for (final i in [-3, -2, -1, 1, 2, 3])
              for (final j in [-3, -2, -1, 1, 2, 3])
                ZPositioned(
                  translate: _translateMatrix(i, j, size, space) +
                      const ZVector.only(z: -2),
                  child: ZTile(
                    sideColor: theme.borderTileColor!,
                    frontColor: theme.frontTileColor!,
                    size: size,
                    depth: tileDepth,
                  ),
                ),
          ],
        ),
        ZPositioned(
          translate: const ZVector.only(z: -10000),
          child: ZShape(color: Colors.transparent, visible: false),
        ),
      ],
    );
  }

  ZVector _translateMatrix(int i, int j, double size, double space) {
    final double dx;
    if (i < 0) {
      dx = size * (i + 0.5) + space * (i + 0.5);
    } else {
      dx = size * (i - 0.5) + space * (i - 0.5);
    }
    final double dy;
    if (j < 0) {
      dy = size * (j + 0.5) + space * (j + 0.5);
    } else {
      dy = size * (j - 0.5) + space * (j - 0.5);
    }
    return ZVector(dx, dy, 0);
  }
}

class _BoardBorders extends StatelessWidget {
  const _BoardBorders({Key? key, required this.theme}) : super(key: key);

  final BoardTheme theme;

  @override
  Widget build(BuildContext context) {
    const size = 30.0;
    const space = 10.0;
    const border = 5.0;
    const depth = 20.0;
    const innerBorder = size * 6 + space * 10.0;

    final innerBorderColor = theme.innerBorderContainerColor;
    final outterBorderColor = theme.outterBorderContainerColor;
    final background = theme.innerBackgroundContainerColor;
    final front = theme.frontContainerColor;

    const zTranslate = 0.5;

    final side = ZGroup(
      children: [
        ZPositioned(
          translate: const ZVector(
            innerBorder / 4,
            innerBorder / 2 + border / 2,
            zTranslate,
          ),
          child: ZBox(
            width: innerBorder / 2,
            height: border,
            depth: depth,
            color: front!,
            topColor: innerBorderColor,
            bottomColor: outterBorderColor,
          ),
        ),
        ZPositioned(
          translate: const ZVector(
            -innerBorder / 4,
            innerBorder / 2 + border / 2,
            zTranslate,
          ),
          child: ZBox(
            width: innerBorder / 2,
            height: border,
            depth: depth,
            color: front,
            topColor: innerBorderColor,
            bottomColor: outterBorderColor,
          ),
        ),
      ],
    );

    final corner = ZGroup(
      children: [
        ZPositioned(
          translate: const ZVector(
            innerBorder / 2 + border / 2,
            innerBorder / 2 + border / 2,
            zTranslate,
          ),
          child: ZBox(
            width: border,
            height: border,
            depth: depth,
            color: front,
            bottomColor: outterBorderColor,
            rightColor: outterBorderColor,
          ),
        )
      ],
    );

    return ZGroup(
      children: [
        // Corners
        corner,
        ZPositioned(
          rotate: const ZVector.only(z: pi / 2),
          child: corner,
        ),
        ZPositioned(
          rotate: const ZVector.only(z: pi),
          child: corner,
        ),
        ZPositioned(
          rotate: const ZVector.only(z: -pi / 2),
          child: corner,
        ),

        // bottom
        side,
        // top
        ZPositioned(
          rotate: const ZVector.only(z: pi),
          child: side,
        ),
        // Left
        ZPositioned(
          rotate: const ZVector.only(z: pi / 2),
          child: side,
        ),

        // Right
        ZPositioned(
          translate: const ZVector(
            innerBorder / 2 + border / 2,
            innerBorder / 4,
            zTranslate,
          ),
          child: ZBox(
            height: innerBorder / 2,
            width: border,
            depth: depth,
            color: front,
            leftColor: innerBorderColor,
            rightColor: outterBorderColor,
          ),
        ),
        ZPositioned(
          translate: const ZVector(
            innerBorder / 2 + border / 2,
            -innerBorder / 4 - size / 2 - space / 2,
            zTranslate,
          ),
          child: ZBox(
            height: innerBorder / 2 - size - space,
            width: border,
            depth: depth,
            color: front,
            leftColor: innerBorderColor,
            rightColor: outterBorderColor,
          ),
        ),
        ZPositioned(
          translate: const ZVector(
            innerBorder / 2 + border / 2,
            -size / 2 - space / 2,
            zTranslate - depth / 2 + tileDepth / 2,
          ),
          child: ZBox(
            height: size + space,
            width: border,
            depth: tileDepth,
            color: front,
            frontColor: background,
            leftColor: innerBorderColor,
            rightColor: outterBorderColor,
          ),
        ),
      ],
    );
  }
}
