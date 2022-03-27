// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zvehicles/zvehicles.dart';

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
  final ZVehiclesThemeData? data;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// The duration over which to animate the parameters.
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    final theme = data ?? ZVehiclesThemeData.fallback;
    return TweenAnimationBuilder<ZVehiclesThemeData?>(
      tween: VehiclesThemeTween(
        begin: theme,
        end: theme,
      ),
      duration: duration,
      builder: (context, value, child) {
        return Provider<ZVehiclesThemeData>.value(
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
class ZVehiclesThemeData extends Equatable {
  /// Create a [ZVehiclesThemeData] that's used to configure a
  /// [AnimatedVehiclesTheme].
  const ZVehiclesThemeData({
    required this.ambulance,
    required this.car,
    required this.taxi,
    required this.police,
    required this.bus,
    required this.truck,
    required this.secondaryTruck,
    required this.secondaryBus,
  });

  static final ZVehiclesThemeData fallback = ZVehiclesThemeData(
    ambulance: AmbulanceThemeData.white,
    car: CarThemeData.red,
    police: CarThemeData.police,
    taxi: CarThemeData.taxi,
    bus: BusThemeData.school,
    secondaryBus: BusThemeData.blue,
    truck: TruckThemeData.green,
    secondaryTruck: TruckThemeData.orange,
  );

  static final ZVehiclesThemeData tutorial = ZVehiclesThemeData(
    ambulance: AmbulanceThemeData.white,
    car: CarThemeData.red
        .map((d) => d.copyWith(colorScheme: d.colorScheme.withOpacity(0.1))),
    police: CarThemeData.police
        .map((d) => d.copyWith(colorScheme: d.colorScheme.withOpacity(0.1))),
    taxi: CarThemeData.taxi
        .map((d) => d.copyWith(colorScheme: d.colorScheme.withOpacity(0.1))),
    bus: BusThemeData.school
        .map((d) => d.copyWith(colorScheme: d.colorScheme.withOpacity(0.1))),
    secondaryBus: BusThemeData.blue
        .map((d) => d.copyWith(colorScheme: d.colorScheme.withOpacity(0.1))),
    truck: TruckThemeData.green
        .map((d) => d.copyWith(colorScheme: d.colorScheme.withOpacity(0.1))),
    secondaryTruck: TruckThemeData.orange
        .map((d) => d.copyWith(colorScheme: d.colorScheme.withOpacity(0.1))),
  );

  final CarThemeData car;
  final CarThemeData taxi;
  final CarThemeData police;
  final BusThemeData bus;
  final BusThemeData secondaryBus;
  final AmbulanceThemeData ambulance;
  final TruckThemeData truck;
  final TruckThemeData secondaryTruck;

  /// Linearly interpolate between two board themes.
  /// The arguments must not be null.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static ZVehiclesThemeData? lerp(
    ZVehiclesThemeData? a,
    ZVehiclesThemeData? b,
    double t,
  ) {
    return ZVehiclesThemeData(
      police: CarThemeData.lerp(a?.police, b?.police, t)!,
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

/// {@template zvehicles.zvehicles_theme_tween}
/// A [ZVehiclesThemeData] tween.
/// {@endtemplate}
class VehiclesThemeTween extends Tween<ZVehiclesThemeData?> {
  /// {@macro zvehicles.zvehicles_theme_tween}
  VehiclesThemeTween({ZVehiclesThemeData? begin, ZVehiclesThemeData? end})
      : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  ZVehiclesThemeData? lerp(double t) => ZVehiclesThemeData.lerp(begin, end, t);
}
