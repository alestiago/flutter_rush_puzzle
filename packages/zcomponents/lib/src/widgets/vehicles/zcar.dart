import 'package:flutter/material.dart';
import 'package:zcomponents/zcomponents.dart';

const trunkDepth = 10.0;

const wheelOutterRadius = 7.0;

const _size = 30.0;
const _halfSize = _size / 2;

const int length = 2;

class ZCar extends StatelessWidget {
  const ZCar({
    Key? key,
    required this.theme,
  }) : super(key: key);

  static const space = 10.0;

  final CarThemeData theme;

  @override
  Widget build(BuildContext context) {
    final sideColor = theme.sideColor ?? theme.color;

    final doorSideColor = theme.doorSideColor ?? sideColor;
    final topColor = theme.topColor ?? theme.color;
    final topMiddleColor = theme.topMiddleColor ?? topColor;
    final topBoxColor = theme.topBoxColor;

    const width = length * _size + space * (length - 1);
    const halfWidth = width / 2;

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
            ),
            //ZPositioned(
            //  translate:
            //      const ZVector(distanceWheel, -half_size, -distanceZWheel),
            //  child: ZGroup(
            //    sortMode: SortMode.update,
            //    sortPoint: const ZVector(0, 0, 8),
            //    children: const [
            //      ZWheel(),
            //    ],
            //  ),
            //),
            //ZPositioned(
            //  translate:
            //      const ZVector(-distanceWheel, -half_size, -distanceZWheel),
            //  child: ZGroup(
            //    sortMode: SortMode.update,
            //    sortPoint: const ZVector(0, 0, 8),
            //    children: const [
            //      ZWheel(),
            //    ],
            //  ),
            //),
          ],
        ),

        // Right side
        _ZCarSide(
          side: ZCarSide.right,
          sideColor: sideColor,
          doorSideColor: doorSideColor,
        ),

        /// Top of the car
        ZGroup(
          children: [
            // top
            ZPositioned(
              translate: const ZVector.only(z: _halfSize - 4),
              child: ZRect(
                width: _size - 8,
                height: _size,
                color: topMiddleColor,
                fill: true,
              ),
            ),

            // top front
            ZPositioned(
              translate: const ZVector.only(x: _size + space / 2 - 10 / 2),
              child: ZRect(
                width: 10,
                height: _size,
                color: topColor,
                fill: true,
              ),
            ),
            // top back (trunk door)
            ZPositioned(
              translate:
                  const ZVector.only(x: -_size - space / 2 + trunkDepth / 2),
              child: ZRect(
                width: trunkDepth,
                height: _size,
                color: topColor,
                fill: true,
              ),
            ),

            // front (hood car)
            ZPositioned(
              rotate: const ZVector.only(y: tau / 4),
              child: ZPositioned(
                translate: const ZVector.only(
                  x: halfWidth,
                  z: -(_size - 8) / 4,
                ),
                child: ZGroup(
                  sortMode: SortMode.update,
                  children: [
                    ZRect(
                      width: _halfSize - 4,
                      height: _size,
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
                    const ZVector.only(x: -halfWidth, z: -(_size - 8) / 4),
                child: ZRect(
                  width: _halfSize - 4,
                  height: _size,
                  color: sideColor,
                  fill: true,
                ),
              ),
            ),

            // front windshield
            ZPositioned(
              child: ZPositioned(
                child: ZShape(
                  path: [
                    ZMove(_halfSize - 4, -_halfSize, _halfSize - 4),
                    ZLine(_halfSize - 4, _halfSize, _halfSize - 4),
                    ZLine(width / 2 - trunkDepth, _halfSize, 0),
                    ZLine(width / 2 - trunkDepth, -_halfSize, 0),
                  ],
                  color: Colors.blue,
                  fill: true,
                ),
              ),
            ),
            // back windshield
            ZPositioned(
              child: ZPositioned(
                child: ZShape(
                  path: [
                    ZMove(-_halfSize + 4, -_halfSize, _halfSize - 4),
                    ZLine(-_halfSize + 4, _halfSize, _halfSize - 4),
                    ZLine(-width / 2 + trunkDepth, _halfSize, 0),
                    ZLine(-width / 2 + trunkDepth, -_halfSize, 0),
                  ],
                  color: Colors.blue,
                  fill: true,
                ),
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
        )
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
  }) : super(key: key);

  final ZCarSide side;

  final Color sideColor;
  final Color doorSideColor;

  @override
  Widget build(BuildContext context) {
    const distanceWheel = _size / 1.5;
    return ZPositioned(
      rotate: const ZVector.only(x: -tau / 4),
      child: ZPositioned(
        translate: ZVector.only(
          y: side == ZCarSide.left ? _halfSize : -_halfSize,
        ),
        child: ZGroup(
          sortMode: SortMode.update,
          sortPoint: ZVector.only(
            y: side == ZCarSide.left ? _halfSize : -_halfSize,
          ),
          children: [
            ZGroup(
              sortMode: SortMode.stack,
              children: [
                ZRect(
                  width: _size - 8,
                  height: _size - 8,
                  color: doorSideColor,
                  fill: true,
                ),
                ZShape(
                  path: [
                    ZMove(_halfSize - 4, _halfSize - 4, 0),
                    ZLine(_halfSize + 20, _halfSize - 4, 0),
                    ZLine(_halfSize + 20, 0, 0),
                    ZLine(_halfSize + 20 - trunkDepth, 0, 0),
                    ZLine(_halfSize - 4, -_halfSize + 4, 0),
                  ],
                  color: sideColor,
                  fill: true,
                ),
                ZShape(
                  path: [
                    ZMove(-_halfSize + 4, _halfSize - 4, 0),
                    ZLine(-_halfSize - 20, _halfSize - 4, 0),
                    ZLine(-_halfSize - 20, 0, 0),
                    ZLine(-_halfSize - 20 + trunkDepth, 0, 0),
                    ZLine(-_halfSize + 4, -_halfSize + 4, 0),
                  ],
                  color: sideColor,
                  fill: true,
                ),
                ZPositioned(
                  translate: const ZVector(distanceWheel, _halfSize - 4, 0),
                  child: ZWheel(side: side, tyreDiameter: 10),
                ),
                ZPositioned(
                  translate: const ZVector(-distanceWheel, _halfSize - 4, 0),
                  child: ZWheel(side: side, tyreDiameter: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
