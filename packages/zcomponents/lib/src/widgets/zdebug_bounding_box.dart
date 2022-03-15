import 'package:flutter/material.dart';
import 'package:zcomponents/zcomponents.dart';

class ZDebugBoundingBox extends StatelessWidget {
  const ZDebugBoundingBox({Key? key, required this.box}) : super(key: key);

  final BoundingBox box;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ZPositioned(
          translate: box.zMinPosition,
          child: ZCircle(
            diameter: 4,
            color: Colors.blue,
            stroke: 4,
          ),
        ),
        ZPositioned(
          translate: box.zMaxPosition,
          child: ZCircle(
            diameter: 4,
            color: Colors.green,
            stroke: 4,
          ),
        ),
      ],
    );
  }
}
