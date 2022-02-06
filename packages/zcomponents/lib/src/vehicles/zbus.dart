import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zflutter/zflutter.dart';

class ZBus extends StatelessWidget {
  const ZBus({
    Key? key,
    this.length = 3,
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
      color: Colors.pink,
    );
  }

  double _getWidth() {
    return length * size + space * (length - 1);
  }
}
