import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_cubic_text/src/shapes/shapes.dart';
import 'package:zflutter/zflutter.dart';

enum ZLShapeOrientation { topLeft, topRight, bottomRight, bottomLeft }

class ZLShape extends StatelessWidget {
  const ZLShape({
    Key? key,
    required this.orientation,
  }) : super(key: key);

  final ZLShapeOrientation orientation;

  @override
  Widget build(BuildContext context) {
    late final ZSlabOrientation orientation1, orientation2;
    switch (orientation) {
      case ZLShapeOrientation.topLeft:
        orientation1 = ZSlabOrientation.top;
        orientation2 = ZSlabOrientation.left;
        break;
      case ZLShapeOrientation.topRight:
        orientation1 = ZSlabOrientation.top;
        orientation2 = ZSlabOrientation.right;
        break;
      case ZLShapeOrientation.bottomRight:
        orientation1 = ZSlabOrientation.bottom;
        orientation2 = ZSlabOrientation.right;
        break;
      case ZLShapeOrientation.bottomLeft:
        orientation1 = ZSlabOrientation.bottom;
        orientation2 = ZSlabOrientation.left;
        break;
    }

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZSlab(
          orientation: orientation1,
        ),
        ZSlab(
          orientation: orientation2,
        )
      ],
    );
  }
}
