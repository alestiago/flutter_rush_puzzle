import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart' show ZVector;

class AmbulanceThemeData {
  const AmbulanceThemeData({
    required this.colorScheme,
    required this.layout,
  });

  static final white = AmbulanceThemeData(
    colorScheme: ZAmbulanceColorScheme.white,
    layout: ZAmbulanceLayout.white(),
  );

  final ZAmbulanceColorScheme colorScheme;
  final ZAmbulanceLayout layout;

  static AmbulanceThemeData? lerp(
      AmbulanceThemeData? a, AmbulanceThemeData? b, double t) {
    return AmbulanceThemeData(
      colorScheme:
          ZAmbulanceColorScheme.lerp(a?.colorScheme, b?.colorScheme, t)!,
      layout: b!.layout,
    );
  }
}

class ZAmbulanceColorScheme {
  const ZAmbulanceColorScheme({
    required this.bodyColor,
    required this.roofColor,
    required this.stripesColor,
    required this.windowColor,
    required this.fenderColor,
    required this.frontLightColor,
    required this.rearLightColor,
    required this.lightBorderColor,
    required this.bottomColor,
    required this.crossColor,
    required this.floorColor,
    required this.shadowColor,
    required this.primarySirenColor,
    required this.primarySirenShadowColor,
    required this.secondarySirenColor,
    required this.secondarySirenShadowColor,
  });

  static final white = ZAmbulanceColorScheme(
    bodyColor: Colors.white,
    shadowColor: Colors.grey[100]!,
    roofColor: Colors.white,
    floorColor: Colors.grey[300]!,
    stripesColor: Colors.red,
    windowColor: Colors.blue[300]!,
    fenderColor: Colors.grey[300]!,
    frontLightColor: Colors.yellow[200]!,
    rearLightColor: Colors.red[400]!,
    lightBorderColor: Colors.black,
    bottomColor: Colors.grey[300]!,
    crossColor: Colors.red,
    primarySirenColor: Colors.red[400]!,
    secondarySirenColor: Colors.blue[400]!,
    primarySirenShadowColor: Colors.red[700]!,
    secondarySirenShadowColor: Colors.blue[700]!,
  );

  final Color bodyColor;
  final Color shadowColor;
  final Color roofColor;
  final Color stripesColor;
  final Color windowColor;
  final Color fenderColor;
  final Color frontLightColor;
  final Color rearLightColor;
  final Color lightBorderColor;
  final Color bottomColor;
  final Color crossColor;
  final Color floorColor;
  final Color primarySirenColor;
  final Color primarySirenShadowColor;
  final Color secondarySirenColor;
  final Color secondarySirenShadowColor;

  static ZAmbulanceColorScheme? lerp(
    ZAmbulanceColorScheme? a,
    ZAmbulanceColorScheme? b,
    double t,
  ) {
    return ZAmbulanceColorScheme(
      bodyColor: Color.lerp(a?.bodyColor, b?.bodyColor, t)!,
      shadowColor: Color.lerp(a?.shadowColor, b?.shadowColor, t)!,
      roofColor: Color.lerp(a?.roofColor, b?.roofColor, t)!,
      stripesColor: Color.lerp(a?.stripesColor, b?.stripesColor, t)!,
      windowColor: Color.lerp(a?.windowColor, b?.windowColor, t)!,
      fenderColor: Color.lerp(a?.fenderColor, b?.fenderColor, t)!,
      frontLightColor: Color.lerp(a?.frontLightColor, b?.frontLightColor, t)!,
      rearLightColor: Color.lerp(a?.rearLightColor, b?.rearLightColor, t)!,
      lightBorderColor:
          Color.lerp(a?.lightBorderColor, b?.lightBorderColor, t)!,
      bottomColor: Color.lerp(a?.bottomColor, b?.bottomColor, t)!,
      crossColor: Color.lerp(a?.crossColor, b?.crossColor, t)!,
      floorColor: Color.lerp(a?.floorColor, b?.floorColor, t)!,
      primarySirenColor:
          Color.lerp(a?.primarySirenColor, b?.primarySirenColor, t)!,
      secondarySirenColor:
          Color.lerp(a?.secondarySirenColor, b?.secondarySirenColor, t)!,
      primarySirenShadowColor: Color.lerp(
          a?.primarySirenShadowColor, b?.primarySirenShadowColor, t)!,
      secondarySirenShadowColor: Color.lerp(
          a?.secondarySirenShadowColor, b?.secondarySirenShadowColor, t)!,
    );
  }
}

class ZAmbulanceLayout {
  const ZAmbulanceLayout({
    required this.width,
    required this.height,
    required this.bodyHeight,
    required this.bodyWidth,
    required this.cabinHeight,
    required this.cabinWidth,
    required this.rearHeight,
    required this.rearWidth,
    required this.bodyTopPadding,
    required this.stripeHeight,
    required this.stripeBottomPadding,
    required this.fenderHeight,
    required this.fenderPosition,
    required this.crossHeight,
    required this.crossWidth,
    required this.windowHeight,
    required this.windowTopPadding,
    required this.sideWindowLeftPadding,
    required this.lightDiameter,
    required this.sirenSize,
    required this.wheelDiameter,
  });

  factory ZAmbulanceLayout.white() {
    const length = 2;
    const size = 30.0;
    const space = 10.0;

    const width = length * size + space * (length - 1);
    const height = size;

    const rearWidth = height;

    const fenderHeight = height * 0.05;
    const bodyWidth = width * 0.8;
    const bodyHeight = height;
    const driverWidth = width - bodyWidth;
    const driverHeight = height * 0.85;

    return const ZAmbulanceLayout(
      width: width,
      height: height,
      bodyWidth: bodyWidth,
      bodyHeight: bodyHeight,
      cabinHeight: driverHeight,
      cabinWidth: driverWidth,
      rearHeight: bodyHeight,
      rearWidth: rearWidth,
      bodyTopPadding: bodyHeight * 0.1,
      stripeHeight: bodyHeight * 0.05,
      stripeBottomPadding: bodyHeight * 0.25,
      fenderHeight: fenderHeight,
      fenderPosition: ZVector.only(
        y: -bodyHeight / 2 + fenderHeight / 2,
      ),
      crossHeight: 10,
      crossWidth: 2,
      windowHeight: driverHeight * 0.35,
      windowTopPadding: driverHeight * 0.3,
      sideWindowLeftPadding: 5,
      lightDiameter: 3,
      sirenSize: 4,
      wheelDiameter: 10,
    );
  }

  final double width;
  final double height;

  final double bodyWidth;
  final double bodyHeight;

  final double rearWidth;
  final double rearHeight;

  final double cabinWidth;
  final double cabinHeight;

  final double bodyTopPadding;

  final double stripeHeight;
  final double stripeBottomPadding;

  final double fenderHeight;
  // TODO(alestiago): remove positioning from here.
  final ZVector fenderPosition;

  final double crossHeight;
  final double crossWidth;

  final double windowHeight;
  final double windowTopPadding;
  final double sideWindowLeftPadding;

  final double lightDiameter;
  final double sirenSize;

  final double wheelDiameter;
}
