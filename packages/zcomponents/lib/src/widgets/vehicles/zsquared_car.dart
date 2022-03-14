import 'package:flutter/material.dart';
import 'package:zcomponents/zcomponents.dart';

const _trunkDepth = 20.0;

const _tileSize = 30.0;
const _halfSize = _tileSize / 2;
const _width = _length * _tileSize + _space * (_length - 1);
const _space = 10.0;

const _length = 2;

class ZSquaredCar extends StatelessWidget {
  const ZSquaredCar({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final CarThemeData theme;

  @override
  Widget build(BuildContext context) {
    final sideColor = theme.sideColor ?? theme.color;

    final doorSideColor = theme.doorSideColor ?? sideColor;
    final windowSideColor = theme.windowSideColor ?? doorSideColor;
    final topColor = theme.topColor ?? theme.color;
    final topMiddleColor = theme.topMiddleColor ?? topColor;
    final topBoxColor = theme.topBoxColor;

    const halfWidth = _width / 2;
    const distanceWheel = _tileSize / 1.5;

    return ZGroup(
      sortMode: SortMode.update,
      children: [
        // Left side

        ZGroup(
          children: [
            _ZCarSide(
              side: ZCarSide.left,
              sideColor: sideColor,
              doorSideColor: doorSideColor,
              windowSideColor: windowSideColor,
            ),
          ],
        ),

        // Right side
        _ZCarSide(
          side: ZCarSide.right,
          sideColor: sideColor,
          doorSideColor: doorSideColor,
          windowSideColor: windowSideColor,
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
                      child: _Ligth(),
                    ),
                    ZPositioned(
                      translate: ZVector.only(y: -10),
                      child: _Ligth(),
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
              color: theme.windowColor ?? Colors.blue,
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
              color: theme.windowColor ?? Colors.blue,
              fill: true,
            ),
          ),
        ),
      ],
    );
  }
}

class _Ligth extends StatelessWidget {
  const _Ligth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ZPositioned(
          translate: const ZVector.only(z: -0.5),
          child: ZCylinder(
            diameter: 4,
            length: 0.5,
            color: Colors.yellow,
          ),
        ),
        ZCircle(
          diameter: 5,
          color: Colors.grey,
          fill: true,
        ),
      ],
    );
  }
}

class _ZCarSide extends StatelessWidget {
  const _ZCarSide({
    Key? key,
    required this.side,
    required this.sideColor,
    required this.doorSideColor,
    required this.windowSideColor,
  }) : super(key: key);

  final ZCarSide side;

  final Color sideColor;
  final Color doorSideColor;
  final Color windowSideColor;

  @override
  Widget build(BuildContext context) {
    const distanceWheel = _tileSize / 1.4;
    return ZPositioned(
      rotate: const ZVector.only(x: -tau / 4),
      child: ZPositioned(
        translate: ZVector.only(
          y: side == ZCarSide.left ? _halfSize : -_halfSize,
        ),
        child: ZGroup(
          children: [
            ZGroup(
              sortMode: SortMode.stack,
              children: [
                ZPositioned(
                  translate: const ZVector.only(
                    x: _width / 2 - trunkDepth,
                    y: (_halfSize - 4) / 2,
                  ),
                  child: ZRect(
                    width: _trunkDepth,
                    height: _halfSize - 4,
                    color: sideColor,
                    fill: true,
                  ),
                ),
                ZPositioned(
                  translate: const ZVector(distanceWheel, _halfSize - 4, 0),
                  child: ZWheel(side: side, tyreDiameter: 10),
                ),
              ],
            ),
            ZGroup(
              sortMode: SortMode.stack,
              children: [
                ZPositioned(
                  translate: const ZVector.only(
                    x: -_width / 2 + trunkDepth,
                    y: (_halfSize - 4) / 2,
                  ),
                  child: ZRect(
                    width: _trunkDepth,
                    height: _halfSize - 4,
                    color: sideColor,
                    fill: true,
                  ),
                ),
                ZPositioned(
                  translate: const ZVector(-distanceWheel, _halfSize - 4, 0),
                  child: ZWheel(side: side, tyreDiameter: 10),
                ),
              ],
            ),
            ZPositioned(
              translate: const ZVector(0, -_halfSize / 4 - 2, 0),
              child: ZRect(
                width: _width - _trunkDepth * 2 - 2,
                height: _tileSize / 2 - 4,
                color: windowSideColor,
                fill: true,
              ),
            ),
            ZPositioned(
              translate: const ZVector(-0, _halfSize / 4 + 2, 0),
              child: ZRect(
                width: _width - _trunkDepth * 2 - 2,
                height: _tileSize / 2 - 4,
                color: doorSideColor,
                fill: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
