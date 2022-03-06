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
    required this.bus,
    required this.truck,
  });

  static final VehiclesThemeData fallback = VehiclesThemeData(
    car: CarThemeData(
      color: Colors.green[700]!,
      sideColor: Colors.green[700],
      topColor: Colors.green[600],
    ),
    taxi: CarThemeData(
      color: Colors.yellow[700]!,
      sideColor: Colors.yellow[700],
      topColor: Colors.yellow[600],
      topBoxColor: Colors.black,
    ),
    bus: BusThemeData.school,
    truck: TruckThemeData(
      colorScheme: ZTruckColorScheme(
        truckColor: Colors.red,
        roofColor: Colors.red[600]!,
        stripesColor: Colors.transparent,
        windowColor: Colors.blue[300]!,
        backColor: Colors.red[700]!,
        cabinColor: Colors.white,
        fenderColor: Colors.black,
        frontLightColor: Colors.yellow[200]!,
        rearLightColor: Colors.red[400]!,
        lightBorderColor: Colors.black,
        bottomColor: Colors.black,
      ),
    ),
  );

  /// Car theme
  final CarThemeData car;

  /// Taxi theme
  final CarThemeData taxi;

  /// Bus theme
  final BusThemeData bus;

  /// Bus theme
  final TruckThemeData truck;

  /// Linearly interpolate between two board themes.
  ///
  /// The arguments must not be null.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static VehiclesThemeData? lerp(
    VehiclesThemeData? a,
    VehiclesThemeData? b,
    double t,
  ) {
    return VehiclesThemeData(
      car: CarThemeData.lerp(a?.car, b?.car, t)!,
      taxi: CarThemeData.lerp(a?.taxi, b?.taxi, t)!,
      bus: BusThemeData.lerp(a?.bus, b?.bus, t)!,
      truck: TruckThemeData.lerp(a?.truck, b?.truck, t)!,
    );
  }

  @override
  List<Object?> get props => [car, taxi];
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

/// Defines the configuration of the overall visual [AnimatedVehiclesTheme] for
/// a widget subtree within the app.
class CarThemeData extends Equatable {
  /// Create a [CarThemeData] that's used to configure a
  /// [AnimatedVehiclesTheme].
  const CarThemeData({
    required this.color,
    this.sideColor,
    this.topColor,
    this.topMiddleColor,
    this.doorSideColor,
    this.topBoxColor,
  });

  /// Default color of the car
  final Color color;

  /// Color of the sides of the car
  final Color? sideColor;

  /// Roof, top trunk and top hood color
  final Color? topColor;

  /// Roof color
  final Color? topMiddleColor;

  /// Color of the doors of the car
  final Color? doorSideColor;

  /// Color of box above the car
  /// Used for police and taxi cars
  final Color? topBoxColor;

  /// Linearly interpolate between two board themes.
  ///
  /// The arguments must not be null.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static CarThemeData? lerp(CarThemeData? a, CarThemeData? b, double t) {
    return CarThemeData(
      color: Color.lerp(a?.color, b?.color, t)!,
      sideColor: Color.lerp(a?.sideColor, b?.sideColor, t),
      topColor: Color.lerp(a?.topColor, b?.topColor, t),
      topMiddleColor: Color.lerp(a?.topMiddleColor, b?.topMiddleColor, t),
      doorSideColor: Color.lerp(a?.doorSideColor, b?.doorSideColor, t),
      topBoxColor: Color.lerp(a?.topBoxColor, b?.topBoxColor, t),
    );
  }

  @override
  List<Object?> get props => [
        color,
        sideColor,
        topColor,
        topMiddleColor,
        doorSideColor,
        topBoxColor,
      ];
}
