import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:zcomponents/zcomponents.dart';

class ZVehicle extends StatelessWidget {
  const ZVehicle({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Vehicle data;

  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (data.length == 2) {
      child = ZCar(
        theme: context.select((VehiclesThemeData d) => d.car),
      );
    } else {
      child = const ZBus();
    }

    return ZPositioned(
      rotate: ZVector.only(
        z: data.steering == Steering.horizontal ? 0 : quarterTurn,
      ),
      child: child,
    );
  }
}
