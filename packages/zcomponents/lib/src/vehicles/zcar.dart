import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

class ZCar extends StatelessWidget {
  const ZCar({
    Key? key,
    this.length = 2,
  }) : super(key: key);

  final int length;

  final size = 30.0;
  final space = 10.0;
  @override
  Widget build(BuildContext context) {
    final distanceWheel = size / 1.5;
    final distanceZWheel = size / 2 - 5;
    return ZGroup(children: [
      ZBox(
        width: _getWidth(),
        height: size,
        depth: size,
        color: Colors.red.withOpacity(0.1),
      ),
      ZPositioned(
        translate: ZVector(0, 0, -6),
        child: ZBox(
          width: _getWidth(),
          height: size - 6,
          depth: 10,
          frontColor: Colors.red,
          color: Colors.red[700]!,
        ),
      ),
      ZPositioned(
        translate: ZVector(0, 0, 6),
        child: ZBox(
          width: size + space,
          height: size - 6,
          depth: 12,
          frontColor: Colors.red,
          color: Colors.red[700]!,
        ),
      ),
      ZPositioned(
        translate: ZVector(distanceWheel, size / 2, -distanceZWheel),
        child: ZGroup(
          children: [
            ZWheel(
              side: ZWheelSide.right,
            ),
          ],
        ),
      ),
      ZPositioned(
        translate: ZVector(-distanceWheel, size / 2, -distanceZWheel),
        child: ZGroup(
          children: [
            ZWheel(
              side: ZWheelSide.right,
            ),
          ],
        ),
      ),
      ZPositioned(
        translate: ZVector(distanceWheel, -size / 2, -distanceZWheel),
        child: ZGroup(
          children: [
            ZWheel(),
          ],
        ),
      ),
      ZPositioned(
        translate: ZVector(-distanceWheel, -size / 2, -distanceZWheel),
        child: ZGroup(
          children: [
            ZWheel(),
          ],
        ),
      ),
    ]);
  }

  double _getWidth() {
    return length * size + space * (length - 1);
  }
}

//class ZCar extends StatelessWidget {
//  const ZCar({
//    Key? key,
//    this.length = 2,
//  }) : super(key: key);
//
//  final int length;
//
//  final size = 30.0;
//  final space = 10.0;
//  @override
//  Widget build(BuildContext context) {
//    return ZBox(
//      width: _getWidth(),
//      height: size,
//      depth: size,
//      color: Colors.red,
//    );
//  }
//
//  double _getWidth() {
//    return length * size + space * (length - 1);
//  }
//}
//
//

enum ZWheelSide { left, right }

class ZWheel extends StatelessWidget {
  const ZWheel({
    Key? key,
    this.side = ZWheelSide.left,
  }) : super(key: key);

  final ZWheelSide side;

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      rotate: ZVector(
        side == ZWheelSide.left ? -tau / 4 : tau / 4,
        0,
        0,
      ),
      child: ZGroup(
        sortMode: SortMode.update,
        children: [
          ZCylinder(
            diameter: 12,
            length: 2,
            color: Colors.black,
          ),
          ZPositioned(
            translate: const ZVector(0, 0, -2.1),
            child: ZCircle(
              diameter: 4,
              fill: true,
              color: Colors.grey,
            ),
          ),
          ZPositioned(
            translate: const ZVector(0, 0, -100),
            child: ZShape(
              visible: false,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
