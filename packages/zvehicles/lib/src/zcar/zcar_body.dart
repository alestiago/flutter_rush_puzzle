// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zvehicles/src/zvehicle_side.dart';
import 'package:zvehicles/zvehicles.dart';

extension on BuildContext {
  CarThemeData get theme => watch<CarThemeData>();
}

const _trunkDepth = 20.0;
const _tileSize = 30.0;
const _halfSize = _tileSize / 2;
const _width = _length * _tileSize + _space * (_length - 1);
const _space = 10.0;
const _length = 2;

// TODO(alestiago): Refactor and decompose this class.
class ZCarBody extends StatelessWidget {
  const ZCarBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final sideColor = theme.colorScheme.sideColor;
    final topColor = theme.colorScheme.topColor;
    final topMiddleColor = theme.colorScheme.topMiddleColor;
    final topBoxColor = theme.colorScheme.topBoxColor;

    const halfWidth = _width / 2;

    return ZGroup(
      sortMode: SortMode.update,
      children: [
        // Left side

        ZGroup(
          children: const [
            _ZCarSide(
              side: ZVehicleSide.left,
            ),
          ],
        ),

        // Right side
        const _ZCarSide(
          side: ZVehicleSide.right,
        ),

        /// Top of the car
        ZGroup(
          sortMode: SortMode.update,
          sortPoint: const ZVector.only(z: _halfSize - 4),
          children: [
            // top
            ZPositioned(
              translate: const ZVector.only(z: _halfSize - 4),
              child: ZRect(
                width: _width - _trunkDepth * 2,
                height: _tileSize,
                color: topMiddleColor,
                fill: true,
              ),
            ),

            // top box for taxi or police car
            if (topBoxColor != null)
              ZPositioned(
                key: const Key('topBoxColor'),
                translate: const ZVector.only(z: _halfSize - 4 + 2),
                child: ZBox(
                  width: 2,
                  height: 10,
                  depth: 2,
                  color: topBoxColor,
                ),
              ),
          ],
        ),
        ZGroup(
          children: [
            // top front

            ZPositioned(
              translate: const ZVector.only(x: -_width / 2 + _trunkDepth / 2),
              child: ZRect(
                width: _trunkDepth,
                height: _tileSize,
                color: topColor,
                fill: true,
                stroke: 0,
              ),
            ),
            // top back (trunk door)
            ZPositioned(
              translate: const ZVector.only(x: _width / 2 - _trunkDepth / 2),
              child: ZRect(
                width: _trunkDepth,
                height: _tileSize,
                color: topColor,
                fill: true,
                stroke: 0,
              ),
            ),
          ],
        ),
        // front (hood car)
        ZPositioned(
          rotate: const ZVector.only(y: tau / 4),
          child: ZPositioned(
            translate:
                const ZVector.only(x: halfWidth, z: -(_tileSize - 8) / 4),
            child: ZGroup(
              sortMode: SortMode.update,
              children: [
                ZRect(
                  width: _halfSize - 4,
                  height: _tileSize,
                  color: sideColor,
                  fill: true,
                ),
                ZGroup(
                  sortMode: SortMode.update,
                  children: const [
                    ZPositioned(
                      translate: ZVector.only(y: 10),
                      child: _ZLigth(),
                    ),
                    ZPositioned(
                      translate: ZVector.only(y: -10),
                      child: _ZLigth(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // back
        ZPositioned(
          rotate: const ZVector.only(y: tau / 4),
          child: ZPositioned(
            translate:
                const ZVector.only(x: -halfWidth, z: -(_tileSize - 8) / 4),
            child: ZRect(
              width: _halfSize - 4,
              height: _tileSize,
              color: sideColor,
              fill: true,
            ),
          ),
        ),

        // front windshield
        ZPositioned(
          child: ZPositioned(
            translate: const ZVector.only(x: _width / 2 - _trunkDepth),
            child: ZShape(
              path: [
                ZMove(0, -_halfSize, _halfSize - 4),
                ZLine(0, _halfSize, _halfSize - 4),
                ZLine(0, _halfSize, 0),
                ZLine(0, -_halfSize, 0),
              ],
              color: theme.colorScheme.windowColor,
              fill: true,
            ),
          ),
        ),
        // back windshield
        ZPositioned(
          child: ZPositioned(
            translate: const ZVector.only(x: -_width / 2 + _trunkDepth),
            child: ZShape(
              path: [
                ZMove(0, -_halfSize, _halfSize - 4),
                ZLine(0, _halfSize, _halfSize - 4),
                ZLine(0, _halfSize, 0),
                ZLine(0, -_halfSize, 0),
              ],
              color: theme.colorScheme.windowColor,
              fill: true,
            ),
          ),
        ),
      ],
    );
  }
}

class _ZLigth extends StatelessWidget {
  const _ZLigth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ZGroup(
      children: [
        ZPositioned(
          translate: const ZVector.only(z: -0.5),
          child: ZCylinder(
            diameter: 4,
            length: 0.5,
            color: theme.colorScheme.lightColor,
          ),
        ),
        ZCircle(
          diameter: 5,
          color: theme.colorScheme.lightBorderColor,
          fill: true,
        ),
      ],
    );
  }
}

class _ZCarSide extends StatelessWidget {
  const _ZCarSide({
    Key? key,
    required ZVehicleSide side,
  })  : _side = side,
        super(key: key);

  final ZVehicleSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    const distanceWheel = _tileSize / 1.4;

    return ZPositioned(
      rotate: const ZVector.only(x: -tau / 4),
      child: ZPositioned(
        translate: ZVector.only(
          y: _side.isLeft ? _halfSize : -_halfSize,
        ),
        child: ZGroup(
          children: [
            ZGroup(
              sortMode: SortMode.stack,
              children: [
                ZPositioned(
                  translate: const ZVector.only(
                    x: _width / 2 - _trunkDepth / 2,
                    y: (_halfSize - 4) / 2,
                  ),
                  child: ZRect(
                    width: _trunkDepth,
                    height: _halfSize - 4,
                    color: theme.colorScheme.sideColor,
                    fill: true,
                  ),
                ),
                ZPositioned(
                  translate: const ZVector(distanceWheel, _halfSize - 4, 0),
                  child: _ZWheel(side: _side, tyreDiameter: 10),
                ),
              ],
            ),
            ZGroup(
              sortMode: SortMode.stack,
              children: [
                ZPositioned(
                  translate: const ZVector.only(
                    x: -_width / 2 + _trunkDepth / 2,
                    y: (_halfSize - 4) / 2,
                  ),
                  child: ZRect(
                    width: _trunkDepth,
                    height: _halfSize - 4,
                    color: theme.colorScheme.sideColor,
                    fill: true,
                  ),
                ),
                ZPositioned(
                  translate: const ZVector(-distanceWheel, _halfSize - 4, 0),
                  child: _ZWheel(side: _side, tyreDiameter: 10),
                ),
              ],
            ),
            ZPositioned(
              translate: const ZVector(0, -_halfSize / 4 - 2, 0),
              child: ZRect(
                width: _width - _trunkDepth * 2 - 2,
                height: _tileSize / 2 - 4,
                color: theme.colorScheme.windowSideColor,
                fill: true,
              ),
            ),
            ZPositioned(
              translate: const ZVector(-0, _halfSize / 4 + 2, 0),
              child: ZRect(
                width: _width - _trunkDepth * 2 - 2,
                height: _tileSize / 2 - 4,
                color: theme.colorScheme.doorSideColor,
                fill: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ZWheel extends StatelessWidget {
  const _ZWheel({
    Key? key,
    required ZVehicleSide side,
    this.tyreDiameter = 12,
    this.tyreDepth = 2,
    this.rimDiameter = 4,
  })  : _side = side,
        super(key: key);

  final ZVehicleSide _side;

  final double tyreDiameter;
  final double tyreDepth;
  final double rimDiameter;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          rotate: ZVector.only(x: _side.isLeft ? tau / 2 : 0),
          child: ZGroup(
            sortMode: SortMode.stack,
            children: [
              ZCylinder(
                diameter: tyreDiameter,
                length: tyreDepth,
                color: theme.colorScheme.tyreColor,
              ),
              ZPositioned(
                translate: ZVector.only(z: -tyreDepth),
                child: ZCircle(
                  diameter: rimDiameter,
                  fill: true,
                  color: theme.colorScheme.rimColor,
                ),
              ),
              ZPositioned(
                translate: const ZVector(0, 0, -1),
                child: ZShape(
                  visible: false,
                  color: theme.colorScheme.rimColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
