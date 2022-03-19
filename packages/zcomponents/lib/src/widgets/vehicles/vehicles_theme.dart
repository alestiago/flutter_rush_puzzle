import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zcomponents/src/widgets/widgets.dart';

/// Animated board theme which automatically transitions the colors,
/// etc, over a given duration whenever the given theme changes.
class AnimatedVehiclesTheme extends StatelessWidget {
  /// Animated board theme
  const AnimatedVehiclesTheme({
    Key? key,
    this.data,
    required this.child,
    this.duration = kThemeAnimationDuration,
  }) : super(key: key);

  /// Specifies the color values for descendant widgets.
  final VehiclesThemeData? data;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// The duration over which to animate the parameters.
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    final theme = data ?? VehiclesThemeData.fallback;
    return TweenAnimationBuilder<VehiclesThemeData?>(
      tween: VehiclesThemeTween(
        begin: theme,
        end: theme,
      ),
      duration: duration,
      builder: (context, value, child) {
        return Provider<VehiclesThemeData>.value(
          value: value!,
          child: child,
        );
      },
      child: child,
    );
  }
}

/// Defines the configuration of the overall visual [AnimatedVehiclesTheme] for
/// a widget subtree within the app.
class VehiclesThemeData extends Equatable {
  /// Create a [VehiclesThemeData] that's used to configure a
  /// [AnimatedVehiclesTheme].
  const VehiclesThemeData({
    required this.car,
    required this.taxi,
    required this.police,
    required this.bus,
    required this.ambulance,
    required this.truck,
    required this.secondaryTruck,
    required this.secondaryBus,
  });

  static final VehiclesThemeData fallback = VehiclesThemeData(
    car: CarThemeData(
      color: Colors.red[700]!,
      sideColor: Colors.red[700],
      topColor: Colors.red[400],
      windowColor: Colors.blue[100],
    ),
    police: CarThemeData(
      color: Colors.black,
      sideColor: Colors.grey[900],
      topMiddleColor: Colors.white,
      doorSideColor: Colors.grey[900],
      topColor: Colors.grey[800],
      topBoxColor: Colors.blue,
      windowSideColor: Colors.grey[100],
    ),
    taxi: CarThemeData(
      color: Colors.yellow[700]!,
      sideColor: Colors.yellow[700],
      topColor: Colors.yellow[600],
      topBoxColor: Colors.black,
    ),
    bus: BusThemeData.school,
    secondaryBus: BusThemeData.publicBus,
    ambulance: AmbulanceThemeData.white,
    truck: TruckThemeData(
      colorScheme: ZTruckColorScheme(
        truckColor: Colors.green,
        roofColor: Colors.green[600]!,
        stripesColor: Colors.transparent,
        windowColor: Colors.blue[300]!,
        backColor: Colors.green[700]!,
        cabinColor: Colors.white,
        backCabinColor: Colors.grey[400],
        fenderColor: Colors.black,
        frontLightColor: Colors.amber[200]!,
        rearLightColor: Colors.green[400]!,
        lightBorderColor: Colors.black,
        bottomColor: Colors.black,
      ),
    ),
    secondaryTruck: TruckThemeData(
      colorScheme: ZTruckColorScheme(
        truckColor: Colors.orange,
        roofColor: Colors.orange[600]!,
        stripesColor: Colors.orange[700]!,
        windowColor: Colors.blue[300]!,
        backColor: Colors.orange[700]!,
        cabinColor: Colors.white,
        backCabinColor: Colors.grey[400],
        fenderColor: Colors.black,
        frontLightColor: Colors.amber[200]!,
        rearLightColor: Colors.orange[400]!,
        lightBorderColor: Colors.black,
        bottomColor: Colors.black,
      ),
    ),
  );

  /// Car theme
  final CarThemeData car;

  /// Taxi theme
  final CarThemeData taxi;

  /// Police theme
  final CarThemeData police;

  /// Bus theme
  final BusThemeData bus;

  /// Bus theme
  final BusThemeData secondaryBus;
  // Ambulance theme
  final AmbulanceThemeData ambulance;

  /// Truck theme
  final TruckThemeData truck;

  /// Truck theme
  final TruckThemeData secondaryTruck;

  /// Linearly interpolate between two board themes.
  /// The arguments must not be null.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static VehiclesThemeData? lerp(
    VehiclesThemeData? a,
    VehiclesThemeData? b,
    double t,
  ) {
    return VehiclesThemeData(
      police: CarThemeData.lerp(a?.car, b?.car, t)!,
      car: CarThemeData.lerp(a?.car, b?.car, t)!,
      taxi: CarThemeData.lerp(a?.taxi, b?.taxi, t)!,
      bus: BusThemeData.lerp(a?.bus, b?.bus, t)!,
      secondaryBus: BusThemeData.lerp(a?.secondaryBus, b?.secondaryBus, t)!,
      ambulance: AmbulanceThemeData.lerp(a?.ambulance, b?.ambulance, t)!,
      truck: TruckThemeData.lerp(a?.truck, b?.truck, t)!,
      secondaryTruck:
          TruckThemeData.lerp(a?.secondaryTruck, b?.secondaryTruck, t)!,
    );
  }

  @override
  List<Object?> get props => [
        car,
        taxi,
        police,
        bus,
        secondaryBus,
        ambulance,
        truck,
        secondaryTruck,
      ];
}

/// A [VehiclesThemeData] tween.

class VehiclesThemeTween extends Tween<VehiclesThemeData?> {
  /// Creates a [VehiclesThemeData] tween.
  VehiclesThemeTween({VehiclesThemeData? begin, VehiclesThemeData? end})
      : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  VehiclesThemeData? lerp(double t) => VehiclesThemeData.lerp(begin, end, t);
}
