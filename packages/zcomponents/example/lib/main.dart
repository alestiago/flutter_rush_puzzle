import 'package:flutter/material.dart';
import 'package:zcomponents/zcomponents.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: VehicleView(),
    );
  }
}

class VehicleView extends StatelessWidget {
  const VehicleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ZDragDetector(
        builder: ((context, controller) {
          return LayoutBuilder(builder: (context, constraints) {
            final scale = constraints.biggest.shortestSide / layout.boardSize;
            final rotation = controller.value.y * scale;

            return ZIllustration(
              children: [
                ZPositioned(
                  scale: ZVector.all(3),
                  rotate: controller.rotate,
                  // rotate: ZVector.only(x: tau / 7, z: -tau / 8 + tau / 4),
                  child: ZGroup(
                    children: [
                      ZBus(),
                      ..._ZArrowAxis.values
                          .map(
                            (axis) => _ZArrow(axis: axis),
                          )
                          .toList(),
                    ],
                  ),
                )
              ],
            );
          });
        }),
      ),
    );
  }
}

enum _ZArrowAxis { z, x, y }

extension on _ZArrowAxis {
  ZLine get line {
    const value = 100.0;
    switch (this) {
      case _ZArrowAxis.x:
        return ZLine(value, 0, 0);
      case _ZArrowAxis.y:
        return ZLine(0, value, 0);
      case _ZArrowAxis.z:
        return ZLine(0, 0, value);
    }
  }

  Color get color {
    switch (this) {
      case _ZArrowAxis.x:
        return Colors.red;
      case _ZArrowAxis.y:
        return Colors.blue;
      case _ZArrowAxis.z:
        return Colors.orange;
    }
  }
}

class _ZArrow extends StatelessWidget {
  const _ZArrow({
    Key? key,
    required this.axis,
  }) : super(key: key);

  final _ZArrowAxis axis;

  @override
  Widget build(BuildContext context) {
    return ZShape(
      color: axis.color,
      stroke: 10,
      path: [
        ZMove(0, 0, 0),
        axis.line,
      ],
    );
  }
}
