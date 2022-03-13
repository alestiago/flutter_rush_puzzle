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

    switch (data.type) {
      case VehicleType.car:
        child = ZSquaredCar(
          theme: context.select((VehiclesThemeData d) => d.car),
        );
        break;
      case VehicleType.taxi:
        child = ZSquaredCar(
          theme: context.select((VehiclesThemeData d) => d.taxi),
        );
        break;
      case VehicleType.police:
        child = ZSquaredCar(
          theme: context.select((VehiclesThemeData d) => d.police),
        );
        break;
      case VehicleType.ambulance:
        child = ZAmbulance(
          theme: context.select((VehiclesThemeData d) => d.ambulance),
        );
        break;
      case VehicleType.bus:
        child = ZBus(
          theme: context.select((VehiclesThemeData d) => d.bus),
        );
        break;
      case VehicleType.truck:
        child = ZTruck(
          theme: context.select((VehiclesThemeData d) => d.truck),
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
