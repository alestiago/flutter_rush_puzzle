import 'dart:math' as math show pi;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:zvehicles/zvehicles.dart';

class ZVehicle extends StatelessWidget {
  const ZVehicle({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Vehicle data;

  @override
  Widget build(BuildContext context) {
    final Widget child;
    const quarterTurn = math.pi / 2;

    switch (data.type) {
      case VehicleType.car:
        child = ZCar(
          theme: context.select((ZVehiclesThemeData d) => d.car),
        );
        break;
      case VehicleType.taxi:
        child = ZCar(
          theme: context.select((ZVehiclesThemeData d) => d.taxi),
        );
        break;
      case VehicleType.police:
        child = ZCar(
          theme: context.select((ZVehiclesThemeData d) => d.police),
        );
        break;
      case VehicleType.ambulance:
        child = ZAmbulance(
          theme: context.select((ZVehiclesThemeData d) => d.ambulance),
        );
        break;
      case VehicleType.bus:
        child = ZBus(
          theme: context.select((ZVehiclesThemeData d) => d.bus),
        );
        break;
      case VehicleType.secondaryBus:
        child = ZBus(
          theme: context.select((ZVehiclesThemeData d) => d.secondaryBus),
        );
        break;
      case VehicleType.truck:
        child = ZTruck(
          theme: context.select((ZVehiclesThemeData d) => d.truck),
        );
        break;
      case VehicleType.secondaryTruck:
        child = ZTruck(
          theme: context.select((ZVehiclesThemeData d) => d.secondaryTruck),
        );
        break;
    }

    return ZPositioned(
      rotate: ZVector.only(
        z: data.steering == Steering.horizontal ? 0 : quarterTurn,
      ),
      child: child,
    );
  }
}
