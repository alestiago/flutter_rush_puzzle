import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

class TruckThemeData {
  TruckThemeData._({
    required this.colorScheme,
  }) : layout = ZTrucklayout.primary();

  static final orange = TruckThemeData._(
    colorScheme: ZTruckColorScheme.orange,
  );

  static final green = TruckThemeData._(
    colorScheme: ZTruckColorScheme.green,
  );

  final ZTruckColorScheme colorScheme;
  final ZTrucklayout layout;

  static TruckThemeData? lerp(TruckThemeData? a, TruckThemeData? b, double t) {
    return TruckThemeData._(
      colorScheme: ZTruckColorScheme.lerp(a?.colorScheme, b?.colorScheme, t)!,
    );
  }
}

class ZTruckColorScheme {
  const ZTruckColorScheme._({
    required this.truckColor,
    required this.roofColor,
    required this.stripesColor,
    required this.windowColor,
    required this.cabinColor,
    required this.fenderColor,
    required this.frontLightColor,
    required this.rearLightColor,
    required this.lightBorderColor,
    required this.bottomColor,
    required this.backColor,
    Color? backCabinColor,
  }) : backCabinColor = backCabinColor ?? cabinColor;

  final Color truckColor;

  final Color roofColor;
  final Color stripesColor;
  final Color windowColor;
  final Color backColor;
  final Color cabinColor;
  final Color backCabinColor;
  final Color fenderColor;
  final Color frontLightColor;
  final Color rearLightColor;
  final Color lightBorderColor;
  final Color bottomColor;

  static final orange = ZTruckColorScheme._(
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
  );

  static final green = ZTruckColorScheme._(
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
  );

  static ZTruckColorScheme? lerp(
    ZTruckColorScheme? a,
    ZTruckColorScheme? b,
    double t,
  ) {
    return ZTruckColorScheme._(
      truckColor: Color.lerp(a?.truckColor, b?.truckColor, t)!,
      roofColor: Color.lerp(a?.roofColor, b?.roofColor, t)!,
      stripesColor: Color.lerp(a?.stripesColor, b?.stripesColor, t)!,
      windowColor: Color.lerp(a?.windowColor, b?.windowColor, t)!,
      cabinColor: Color.lerp(a?.cabinColor, b?.cabinColor, t)!,
      fenderColor: Color.lerp(a?.fenderColor, b?.fenderColor, t)!,
      frontLightColor: Color.lerp(a?.frontLightColor, b?.frontLightColor, t)!,
      rearLightColor: Color.lerp(a?.rearLightColor, b?.rearLightColor, t)!,
      lightBorderColor:
          Color.lerp(a?.lightBorderColor, b?.lightBorderColor, t)!,
      bottomColor: Color.lerp(a?.bottomColor, b?.bottomColor, t)!,
      backColor: Color.lerp(a?.backColor, b?.backColor, t)!,
      backCabinColor: Color.lerp(a?.backCabinColor, b?.backCabinColor, t),
    );
  }
}

class ZTrucklayout {
  const ZTrucklayout._({
    required this.width,
    required this.height,
    required this.bodyHeight,
    required this.bodyWidth,
    required this.rearHeight,
    required this.rearWidth,
    required this.bodyTopPadding,
    required this.largeWindowWidth,
    required this.largeWindowHeight,
    required this.largeWindowHorizontalPadding,
    required this.stripeHeight,
    required this.upperStripePosition,
    required this.lowerStripePosition,
    required this.cabinHeight,
    required this.cabinWidth,
    required this.cabinStride,
    required this.cabinHorizontalPadding,
    required this.fenderHeight,
    required this.fenderPosition,
  });

  factory ZTrucklayout.primary() {
    const length = 3;
    const size = 30.0;
    const space = 10.0;

    const width = length * size + space * (length - 1);
    const height = size;

    const rearWidth = height;
    const fenderHeight = height * 0.05;

    const bodyWidth = width * 1;
    const bodyHeight = height;

    const stripeHeight = height * 0.2;
    const upperStripePosition = ZVector.only(
      y: -bodyHeight / 2 + stripeHeight,
    );
    const lowerStripePosition = upperStripePosition;

    return const ZTrucklayout._(
      width: width,
      height: height,
      bodyWidth: bodyWidth,
      bodyHeight: bodyHeight,
      rearHeight: bodyHeight,
      rearWidth: rearWidth,
      bodyTopPadding: bodyHeight * 0.1,
      largeWindowWidth: rearWidth,
      largeWindowHeight: bodyHeight / 3.5,
      largeWindowHorizontalPadding: 0,
      stripeHeight: stripeHeight,
      upperStripePosition: upperStripePosition,
      lowerStripePosition: lowerStripePosition,
      cabinStride: width / 5 + 3,
      cabinWidth: width / 5,
      cabinHeight: bodyHeight - 5,
      cabinHorizontalPadding: 0,
      fenderHeight: fenderHeight,
      fenderPosition: ZVector.only(
        y: -bodyHeight / 2 + fenderHeight / 2,
      ),
    );
  }

  final double width;
  final double height;

  final double bodyWidth;
  final double bodyHeight;

  final double rearWidth;
  final double rearHeight;

  final double bodyTopPadding;

  final double largeWindowWidth;
  final double largeWindowHeight;
  final double largeWindowHorizontalPadding;

  final double stripeHeight;

  final ZVector upperStripePosition;
  final ZVector lowerStripePosition;

  final double fenderHeight;

  final ZVector fenderPosition;

  final double cabinHeight;
  final double cabinWidth;
  final double cabinStride;
  final double cabinHorizontalPadding;
}
