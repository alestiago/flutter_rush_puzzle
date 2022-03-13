import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

enum ZCarSide { left, right }

class ZWheel extends StatelessWidget {
  const ZWheel({
    Key? key,
    this.side = ZCarSide.left,
    this.tyreDiameter = 12,
    this.tyreDepth = 2,
    this.rimDiameter = 4,
  }) : super(key: key);

  final ZCarSide side; // TODO(alestiago): Refactor to use ZVehicleSide

  final double tyreDiameter;
  final double tyreDepth;
  final double rimDiameter;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          rotate: ZVector.only(x: side == ZCarSide.left ? tau / 2 : 0),
          child: ZGroup(
            sortMode: SortMode.stack,
            children: [
              ZCylinder(
                diameter: tyreDiameter,
                length: tyreDepth,
                color: Colors.black,
              ),
              ZPositioned(
                translate: ZVector.only(z: -tyreDepth),
                child: ZCircle(
                  diameter: rimDiameter,
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
