// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class CarThemeData {
  const CarThemeData._({
    required this.colorScheme,
    required this.layout,
  });

  final ZCarColorScheme colorScheme;
  final ZCarLayout layout;

  static CarThemeData? lerp(CarThemeData? a, CarThemeData? b, double t) {
    return CarThemeData._(
      colorScheme: ZCarColorScheme.lerp(a?.colorScheme, b?.colorScheme, t)!,
      layout: b!.layout,
    );
  }
}

class ZCarColorScheme {
  const ZCarColorScheme._({
    required this.color,
    required this.sideColor,
    required this.topColor,
    required this.topMiddleColor,
    required this.doorSideColor,
    required this.topBoxColor,
    required this.windowColor,
    required this.windowSideColor,
  });

  final Color color;
  final Color sideColor;
  final Color topColor;
  final Color topMiddleColor;
  final Color doorSideColor;
  final Color windowSideColor;
  final Color windowColor;

  /// Color of box above the car.
  ///
  /// Used for police and taxi cars.
  final Color? topBoxColor;

  static ZCarColorScheme? lerp(
    ZCarColorScheme? a,
    ZCarColorScheme? b,
    double t,
  ) {
    return ZCarColorScheme._(
      color: Color.lerp(a?.color, b?.color, t)!,
      sideColor: Color.lerp(a?.sideColor, b?.sideColor, t)!,
      topColor: Color.lerp(a?.topColor, b?.topColor, t)!,
      topMiddleColor: Color.lerp(a?.topMiddleColor, b?.topMiddleColor, t)!,
      doorSideColor: Color.lerp(a?.doorSideColor, b?.doorSideColor, t)!,
      topBoxColor: Color.lerp(a?.topBoxColor, b?.topBoxColor, t)!,
      windowColor: Color.lerp(a?.windowColor, b?.windowColor, t)!,
      windowSideColor: Color.lerp(a?.windowSideColor, b?.windowSideColor, t)!,
    );
  }
}

class ZCarLayout {}
