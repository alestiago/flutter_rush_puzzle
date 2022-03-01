import 'package:flutter/material.dart';
import 'package:zcomponents/zcomponents.dart';

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

class ZAxis extends StatelessWidget {
  const ZAxis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: _ZArrowAxis.values
          .map(
            (axis) => _ZArrow(axis: axis),
          )
          .toList(),
    );
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
