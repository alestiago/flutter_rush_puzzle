import 'package:flutter/material.dart';
import 'package:zcomponents/zcomponents.dart';

const trunkDepth = 10.0;

const wheelOutterRadius = 7.0;

const size = 30.0;

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

    const width = length * size + space * (length - 1);
    const halfWidth = width / 2;
    const distanceWheel = size / 1.5;
    const distanceZWheel = size / 2 - 5;
    return ZGroup(
      sortMode: SortMode.update,
      children: [
        // Left side

        ZGroup(
          children: [
            _ZCarSide(
              side: ZWheelSide.left,
              sideColor: sideColor,
              doorSideColor: doorSideColor,
            ),
            ZPositioned(
              translate:
                  const ZVector(distanceWheel, -size / 2, -distanceZWheel),
              child: ZGroup(
                sortMode: SortMode.update,
                sortPoint: const ZVector(0, 0, 8),
                children: const [
                  ZWheel(),
                ],
              ),
            ),
            ZPositioned(
              translate:
                  const ZVector(-distanceWheel, -size / 2, -distanceZWheel),
              child: ZGroup(
                sortMode: SortMode.update,
                sortPoint: const ZVector(0, 0, 8),
                children: const [
                  ZWheel(),
                ],
              ),
            ),
          ],
        ),

        // Right side
        _ZCarSide(
          side: ZWheelSide.right,
          sideColor: sideColor,
          doorSideColor: doorSideColor,
        ),
        // Wheels
        ZPositioned(
          translate: const ZVector(distanceWheel, size / 2, -distanceZWheel),
          child: ZGroup(
            sortMode: SortMode.update,
            sortPoint: const ZVector(0, 0, 20),
            children: const [
              ZWheel(
                side: ZWheelSide.right,
              ),
            ],
          ),
        ),
        ZPositioned(
          translate: const ZVector(-distanceWheel, size / 2, -distanceZWheel),
          child: ZGroup(
            sortMode: SortMode.update,
            sortPoint: const ZVector(0, 0, 20),
            children: const [
              ZWheel(
                side: ZWheelSide.right,
              ),
            ],
          ),
        ),

        /// Top of the car
        ZGroup(
          children: [
            // top
            ZPositioned(
              translate: const ZVector.only(z: size / 2 - 4),
              child: ZRect(
                width: size - 8,
                height: size,
                color: topMiddleColor,
                fill: true,
              ),
            ),

            // top front
            ZPositioned(
              translate: const ZVector.only(x: size + space / 2 - 10 / 2),
              child: ZRect(
                width: 10,
                height: size,
                color: topColor,
                fill: true,
              ),
            ),
            // top back (trunk door)
            ZPositioned(
              translate:
                  const ZVector.only(x: -size - space / 2 + trunkDepth / 2),
              child: ZRect(
                width: trunkDepth,
                height: size,
                color: topColor,
                fill: true,
              ),
            ),

            // front (hood car)
            ZPositioned(
              rotate: const ZVector.only(y: tau / 4),
              child: ZPositioned(
                translate: const ZVector.only(x: halfWidth, z: -(size - 8) / 4),
                child: ZGroup(
                  sortMode: SortMode.update,
                  children: [
                    ZRect(
                      width: (size - 8) / 2,
                      height: size,
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
                    const ZVector.only(x: -halfWidth, z: -(size - 8) / 4),
                child: ZRect(
                  width: (size - 8) / 2,
                  height: size,
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
                    ZMove((size - 8) / 2, -size / 2, (size - 8) / 2),
                    ZLine((size - 8) / 2, size / 2, (size - 8) / 2),
                    ZLine(width / 2 - trunkDepth, size / 2, 0),
                    ZLine(width / 2 - trunkDepth, -size / 2, 0),
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
                    ZMove(-(size - 8) / 2, -size / 2, (size - 8) / 2),
                    ZLine(-(size - 8) / 2, size / 2, (size - 8) / 2),
                    ZLine(-width / 2 + trunkDepth, size / 2, 0),
                    ZLine(-width / 2 + trunkDepth, -size / 2, 0),
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
                translate: const ZVector.only(z: size / 2 - 4 + 2),
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

  final ZWheelSide side;

  final Color sideColor;
  final Color doorSideColor;

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      rotate: const ZVector(-tau / 4, 0, 0),
      child: ZPositioned(
        translate: ZVector(
          0,
          side == ZWheelSide.left ? -size / 2 : size / 2,
          0,
        ),
        child: ZGroup(
          children: [
            ZPositioned(
              child: ZRect(
                width: size - 8,
                height: size - 8,
                color: doorSideColor,
                fill: true,
              ),
            ),
            ZShape(
              path: [
                ZMove(size / 2 - 4, (size - 8) / 2, 0),
                ZLine(size / 2 - 3, (size - 8) / 2, 0),
                ZBezier(const [
                  ZVector(size / 2 - 3, (size - 8) / 2 - 12, 0),
                  ZVector(size / 2 + 13, (size - 8) / 2 - 12, 0),
                  ZVector(size / 2 + 13, (size - 8) / 2, 0),
                ]),
                ZLine(size / 2 + 20, (size - 8) / 2, 0),
                ZLine(size / 2 + 20, 0, 0),
                ZLine(size / 2 + 20 - trunkDepth, 0, 0),
                ZLine(size / 2 - 4, -(size - 8) / 2, 0),
              ],
              color: sideColor,
              fill: true,
            ),
            ZShape(
              path: [
                ZMove(-size / 2 + 4, (size - 8) / 2, 0),
                ZLine(-size / 2 + 3, (size - 8) / 2, 0),
                ZBezier(const [
                  ZVector(-size / 2 + 3, (size - 8) / 2 - 12, 0),
                  ZVector(-size / 2 - 13, (size - 8) / 2 - 12, 0),
                  ZVector(-size / 2 - 13, (size - 8) / 2, 0),
                ]),
                ZLine(-size / 2 - 20, (size - 8) / 2, 0),
                ZLine(-size / 2 - 20, 0, 0),
                ZLine(-size / 2 - 20 + trunkDepth, 0, 0),
                ZLine(-size / 2 + 4, -(size - 8) / 2, 0),
              ],
              color: sideColor,
              fill: true,
            ),
          ],
        ),
      ),
    );
  }
}
