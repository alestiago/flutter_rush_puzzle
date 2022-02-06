import 'package:flutter/material.dart';
import 'package:zcomponents/zcomponents.dart';
import 'package:zflutter/zflutter.dart';

class ZVehicle extends StatelessWidget {
  const ZVehicle({
    Key? key,
    this.length = 2,
  }) : super(key: key);

  final int length;

  final size = 30.0;
  final space = 10.0;
  @override
  Widget build(BuildContext context) {
    return ZBox(
      width: _getWidth(),
      height: size,
      depth: size,
      color: Colors.white,
    );
  }

  double _getWidth() {
    return length * size + space * (length - 1);
  }
}
