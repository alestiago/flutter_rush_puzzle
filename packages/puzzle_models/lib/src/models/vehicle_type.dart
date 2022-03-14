import 'package:puzzle_models/puzzle_models.dart';

/// {@template vehicle_type}
/// The aesthethic associated to a [Vehicle].
/// {@endtemplate vehicle_type}
enum VehicleType {
  /// Taxi aesthethic.
  taxi,

  car,

  police,

  /// Bus aesthethic.
  bus,

  /// Bus aesthethic.
  secondaryBus,

  truck,
  secondaryTruck,

  ambulance,
}

/// Extension to [VehicleType].
///
/// Provides utility methods and information of [VehicleType] value.
extension VeehicleTypeX on VehicleType {
  /// The [length] associated to this [VehicleType].
  int get length {
    late final int value;

    switch (this) {
      case VehicleType.car:
      case VehicleType.taxi:
      case VehicleType.police:
      case VehicleType.ambulance:
        value = 2;
        break;

      case VehicleType.bus:
      case VehicleType.secondaryBus:
      case VehicleType.truck:
      case VehicleType.secondaryTruck:
        value = 3;
        break;
    }

    assert(value > 0, 'VehicleType length must be greater than 0.');
    return value;
  }
}
