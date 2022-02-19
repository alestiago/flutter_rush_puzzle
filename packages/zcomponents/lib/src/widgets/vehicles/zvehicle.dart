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
    if (data.length == 2) {
      return ZCar(
        theme: context.select((VehiclesThemeData d) => d.car),
      );
    } else {
      return const ZBus();
    }
  }
}
