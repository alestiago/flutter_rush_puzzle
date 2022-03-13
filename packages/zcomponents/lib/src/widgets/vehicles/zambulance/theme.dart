import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart' show ZVector;

class AmbulanceThemeData {
  const AmbulanceThemeData({
    required this.colorScheme,
    required this.dimensionData,
  });

  static final white = AmbulanceThemeData(
    colorScheme: ZAmbulanceColorScheme.white,
    dimensionData: ZAmbulanceDimensionData.white(),
  );

  final ZAmbulanceColorScheme colorScheme;
  final ZAmbulanceDimensionData dimensionData;

  static AmbulanceThemeData? lerp(
      AmbulanceThemeData? a, AmbulanceThemeData? b, double t) {
    return AmbulanceThemeData(
      colorScheme:
          ZAmbulanceColorScheme.lerp(a?.colorScheme, b?.colorScheme, t)!,
      dimensionData: b!.dimensionData,
    );
  }
}

class ZAmbulanceColorScheme {
  const ZAmbulanceColorScheme({
    required this.bodyColor,
    required this.roofColor,
    required this.stripesColor,
    required this.windowColor,
    required this.doorColor,
    required this.fenderColor,
    required this.frontLightColor,
    required this.rearLightColor,
    required this.lightBorderColor,
    required this.bottomColor,
    required this.crossColor,
    required this.rearDoorColor,
    required this.floorColor,
  });

  static final white = ZAmbulanceColorScheme(
    bodyColor: Colors.white,
    roofColor: Colors.white,
    floorColor: Colors.grey[200]!,
    stripesColor: Colors.red,
    windowColor: Colors.blue[300]!,
    doorColor: Colors.blue[300]!,
    fenderColor: Colors.grey[200]!,
    frontLightColor: Colors.yellow[200]!,
    rearLightColor: Colors.red[400]!,
    lightBorderColor: Colors.black,
    bottomColor: Colors.grey[300]!,
    crossColor: Colors.red,
    rearDoorColor: Colors.grey[400]!,
  );

  final Color bodyColor;
  final Color roofColor;
  final Color stripesColor;
  final Color windowColor;
  final Color doorColor;
  final Color fenderColor;
  final Color frontLightColor;
  final Color rearLightColor;
  final Color lightBorderColor;
  final Color bottomColor;
  final Color crossColor;
  final Color rearDoorColor;
  final Color floorColor;

  static ZAmbulanceColorScheme? lerp(
    ZAmbulanceColorScheme? a,
    ZAmbulanceColorScheme? b,
    double t,
  ) {
    return ZAmbulanceColorScheme(
      bodyColor: Color.lerp(a?.bodyColor, b?.bodyColor, t)!,
      roofColor: Color.lerp(a?.roofColor, b?.roofColor, t)!,
      stripesColor: Color.lerp(a?.stripesColor, b?.stripesColor, t)!,
      windowColor: Color.lerp(a?.windowColor, b?.windowColor, t)!,
      doorColor: Color.lerp(a?.doorColor, b?.doorColor, t)!,
      fenderColor: Color.lerp(a?.fenderColor, b?.fenderColor, t)!,
      frontLightColor: Color.lerp(a?.frontLightColor, b?.frontLightColor, t)!,
      rearLightColor: Color.lerp(a?.rearLightColor, b?.rearLightColor, t)!,
      lightBorderColor:
          Color.lerp(a?.lightBorderColor, b?.lightBorderColor, t)!,
      bottomColor: Color.lerp(a?.bottomColor, b?.bottomColor, t)!,
      crossColor: Color.lerp(a?.crossColor, b?.crossColor, t)!,
      rearDoorColor: Color.lerp(a?.rearDoorColor, b?.rearDoorColor, t)!,
      floorColor: Color.lerp(a?.floorColor, b?.floorColor, t)!,
    );
  }
}

class ZAmbulanceDimensionData {
  const ZAmbulanceDimensionData({
    required this.width,
    required this.height,
    required this.bodyHeight,
    required this.bodyWidth,
    required this.driverHeight,
    required this.driverWidth,
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
    required this.windowPadding,
    required this.lightDiameter,
  });

  factory ZAmbulanceDimensionData.white() {
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
    const driverHeight = height * 0.8;

    return const ZAmbulanceDimensionData(
      width: width,
      height: height,
      bodyWidth: bodyWidth,
      bodyHeight: bodyHeight,
      driverHeight: driverHeight,
      driverWidth: driverWidth,
      rearHeight: bodyHeight,
      rearWidth: rearWidth,
      bodyTopPadding: bodyHeight * 0.1,
      stripeHeight: bodyHeight * 0.02,
      stripeBottomPadding: bodyHeight * 0.2,
      fenderHeight: fenderHeight,
      fenderPosition: ZVector.only(
        y: -bodyHeight / 2 + fenderHeight / 2,
      ),
      crossHeight: 10,
      crossWidth: 2,
      windowHeight: driverHeight * 0.35,
      windowPadding: driverHeight * 0.2,
      lightDiameter: 5,
    );
  }

  final double width;
  final double height;

  final double bodyWidth;
  final double bodyHeight;

  final double rearWidth;
  final double rearHeight;

  final double driverWidth;
  final double driverHeight;

  final double bodyTopPadding;

  final double stripeHeight;
  final double stripeBottomPadding;

  final double fenderHeight;
  // TODO(alestiago): remove positioning from here.
  final ZVector fenderPosition;

  final double crossHeight;
  final double crossWidth;

  final double windowHeight;
  final double windowPadding;

  final double lightDiameter;
}
