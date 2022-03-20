// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class CarThemeData {
  CarThemeData._({
    required this.colorScheme,
  }) : layout = ZCarLayout();

  static final red = CarThemeData._(
    colorScheme: ZCarColorScheme.red,
  );

  static final police = CarThemeData._(
    colorScheme: ZCarColorScheme.police,
  );

  static final taxi = CarThemeData._(
    colorScheme: ZCarColorScheme.taxi,
  );

  final ZCarColorScheme colorScheme;
  final ZCarLayout layout;

  static CarThemeData? lerp(CarThemeData? a, CarThemeData? b, double t) {
    return CarThemeData._(
      colorScheme: ZCarColorScheme.lerp(a?.colorScheme, b?.colorScheme, t)!,
    );
  }
}

class ZCarColorScheme {
  const ZCarColorScheme._({
    required this.bodyColor,
    required this.sideColor,
    required this.topColor,
    required this.topMiddleColor,
    required this.doorSideColor,
    required this.windowColor,
    required this.windowSideColor,
    this.topBoxColor,
  });

  final Color bodyColor;
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

  static final red = ZCarColorScheme._(
    bodyColor: Colors.red[700]!,
    sideColor: Colors.red[700]!,
    topMiddleColor: Colors.red[400]!,
    topColor: Colors.red[400]!,
    windowColor: Colors.blue[400]!,
    doorSideColor: Colors.red[700]!,
    windowSideColor: Colors.red[700]!,
  );

  static final police = ZCarColorScheme._(
    bodyColor: Colors.black,
    sideColor: Colors.grey[900]!,
    topMiddleColor: Colors.white,
    doorSideColor: Colors.grey[900]!,
    topColor: Colors.grey[800]!,
    topBoxColor: Colors.blue,
    windowColor: Colors.blue[400]!,
    windowSideColor: Colors.grey[100]!,
  );

  static final taxi = ZCarColorScheme._(
    bodyColor: Colors.yellow[700]!,
    sideColor: Colors.yellow[700]!,
    topColor: Colors.yellow[600]!,
    topBoxColor: Colors.black,
    doorSideColor: Colors.yellow[700]!,
    topMiddleColor: Colors.yellow[600]!,
    windowColor: Colors.blue[400]!,
    windowSideColor: Colors.yellow[700]!,
  );

  static ZCarColorScheme? lerp(
    ZCarColorScheme? a,
    ZCarColorScheme? b,
    double t,
  ) {
    return ZCarColorScheme._(
      bodyColor: Color.lerp(a?.bodyColor, b?.bodyColor, t)!,
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

class ZCarLayout {
  // TODO(alestiago): define measures.
}
