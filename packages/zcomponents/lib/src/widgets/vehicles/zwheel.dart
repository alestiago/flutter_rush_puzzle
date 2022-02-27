import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

enum ZWheelSide { left, right }

class ZWheel extends StatelessWidget {
  const ZWheel({
    Key? key,
    this.side = ZWheelSide.left,
  }) : super(key: key);

  final ZWheelSide side;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          rotate: ZVector.only(x: side == ZWheelSide.left ? -tau / 4 : tau / 4),
          child: ZGroup(
            sortMode: SortMode.stack,
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
                translate: const ZVector(0, 0, -1),
                child: ZShape(
                  visible: false,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
