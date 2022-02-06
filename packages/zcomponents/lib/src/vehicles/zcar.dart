import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

class ZCar extends StatelessWidget {
  const ZCar({
    Key? key,
    this.length = 1,
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
      color: Colors.red,
    );
  }

  double _getWidth() {
    return length * size + space * (length - 1);
  }
}
