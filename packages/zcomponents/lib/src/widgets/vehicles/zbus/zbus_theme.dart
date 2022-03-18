import 'package:flutter/material.dart';
import 'package:zcomponents/zcomponents.dart';

class BusThemeData {
  const BusThemeData({
    required this.colorScheme,
    required this.layout,
  });

  static final school = BusThemeData(
    colorScheme: ZBusColorScheme.school,
    layout: ZBusLayout.school(),
  );

  static final publicBus = BusThemeData(
    colorScheme: ZBusColorScheme.publicBus,
    layout: ZBusLayout.publicBus(),
  );

  final ZBusColorScheme colorScheme;
  final ZBusLayout layout;

  static BusThemeData? lerp(BusThemeData? a, BusThemeData? b, double t) {
    return BusThemeData(
      colorScheme: ZBusColorScheme.lerp(a?.colorScheme, b?.colorScheme, t)!,
      layout: b!.layout,
    );
  }
}

class ZBusColorScheme {
  const ZBusColorScheme({
    required this.busColor,
    required this.bodyShadowColor,
    required this.roofColor,
    required this.stripesColor,
    required this.windowColor,
    required this.doorColor,
    required this.fenderColor,
    required this.frontLightColor,
    required this.rearLightColor,
    required this.lightBorderColor,
    required this.bottomColor,
  });

  static final school = ZBusColorScheme(
    busColor: Colors.yellow,
    bodyShadowColor: Colors.yellow[600]!,
    roofColor: Colors.yellow,
    stripesColor: Colors.black,
    windowColor: Colors.blue[300]!,
    doorColor: Colors.blue[300]!,
    fenderColor: Colors.yellow[700]!,
    frontLightColor: Colors.yellow[200]!,
    rearLightColor: Colors.red[400]!,
    lightBorderColor: Colors.black,
    bottomColor: Colors.yellow[700]!,
  );

  static final publicBus = ZBusColorScheme(
    busColor: Colors.blueAccent,
    bodyShadowColor: Colors.blueAccent[700]!,
    roofColor: Colors.blueAccent[400]!,
    stripesColor: const Color.fromARGB(255, 11, 64, 211),
    windowColor: Colors.blueAccent[100]!,
    doorColor: Colors.blueAccent[100]!,
    fenderColor: Colors.blueAccent[700]!,
    frontLightColor: Colors.yellow[200]!,
    rearLightColor: Colors.red[400]!,
    lightBorderColor: Colors.black,
    bottomColor: Colors.blueAccent,
  );

  final Color busColor;
  final Color bodyShadowColor;
  final Color roofColor;
  final Color stripesColor;
  final Color windowColor;
  final Color doorColor;
  final Color fenderColor;
  final Color frontLightColor;
  final Color rearLightColor;
  final Color lightBorderColor;
  final Color bottomColor;

  static ZBusColorScheme? lerp(
    ZBusColorScheme? a,
    ZBusColorScheme? b,
    double t,
  ) {
    return ZBusColorScheme(
      busColor: Color.lerp(a?.busColor, b?.busColor, t)!,
      bodyShadowColor: Color.lerp(a?.bodyShadowColor, b?.bodyShadowColor, t)!,
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
    );
  }
}

class ZBusLayout {
  const ZBusLayout({
    required this.width,
    required this.height,
    required this.bodyHeight,
    required this.bodyWidth,
    required this.rearHeight,
    required this.rearWidth,
    required this.bodyTopPadding,
    required this.smallWindowWidth,
    required this.smallWindowHeight,
    required this.smallWindowHorizontalPadding,
    required this.largeWindowWidth,
    required this.largeWindowHeight,
    required this.largeWindowHorizontalPadding,
    required this.stripeHeight,
    required this.upperStripePosition,
    required this.lowerStripePosition,
    required this.doorHeight,
    required this.doorWidth,
    required this.doorHorizontalPadding,
    required this.fenderHeight,
    required this.fenderPosition,
    required this.lightDiameter,
  });

  factory ZBusLayout.school() {
    const length = 3;
    const size = 30.0;
    const space = 10.0;

    const width = length * size + space * (length - 1);
    const height = size;
    //const height = width / 2.5;

    const rearWidth = height;
    const smallWindowWidth = height / 4;
    const windowHorizontalPadding = smallWindowWidth * 0.4;

    const stripePadding = height * 0.11;
    const stripeHeight = height * 0.02;
    const upperStripePosition = ZVector.only(
      y: -stripeHeight / 2 - stripePadding / 2,
    );

    final lowerStripePosition = upperStripePosition -
        const ZVector.only(
          y: stripeHeight + stripePadding,
        );

    const fenderHeight = height * 0.05;
    const bodyWidth = width * 1;
    const bodyHeight = height;
    const doorWidth = smallWindowWidth;

    return ZBusLayout(
      width: width,
      height: height,
      bodyWidth: bodyWidth,
      bodyHeight: bodyHeight,
      rearHeight: bodyHeight,
      rearWidth: rearWidth,
      bodyTopPadding: bodyHeight * 0.1,
      smallWindowWidth: smallWindowWidth,
      smallWindowHeight: bodyHeight / 3.5,
      smallWindowHorizontalPadding: windowHorizontalPadding,
      largeWindowWidth: rearWidth,
      largeWindowHeight: bodyHeight / 3.5,
      largeWindowHorizontalPadding: windowHorizontalPadding,
      stripeHeight: bodyHeight * 0.02,
      upperStripePosition: upperStripePosition,
      lowerStripePosition: lowerStripePosition,
      doorWidth: smallWindowWidth,
      doorHeight: bodyHeight * 0.7,
      doorHorizontalPadding: doorWidth * 0.5,
      fenderHeight: fenderHeight,
      fenderPosition: const ZVector.only(
        y: -bodyHeight / 2 + fenderHeight / 2,
      ),
      lightDiameter: 3,
    );
  }

  factory ZBusLayout.publicBus() {
    const length = 3;
    const size = 30.0;
    const space = 10.0;

    const width = length * size + space * (length - 1);
    const height = size;
    //const height = width / 2.5;

    const rearWidth = height;
    const smallWindowWidth = height / 2.5;
    const windowHorizontalPadding = height / 4 * 0.4;
    const smallHorizontalPadding = height / 4 * 0.35;

    const stripePadding = height * 0.15;
    const stripeHeight = height * 0.1;
    const upperStripePosition = ZVector.only(
      y: -stripeHeight / 2 - stripePadding,
    );

    const lowerStripePosition = upperStripePosition;

    const fenderHeight = height * 0.05;
    const bodyWidth = width * 1;
    const bodyHeight = height;
    const doorWidth = smallWindowWidth;

    return const ZBusLayout(
      width: width,
      height: height,
      bodyWidth: bodyWidth,
      bodyHeight: bodyHeight,
      rearHeight: bodyHeight,
      rearWidth: rearWidth,
      bodyTopPadding: bodyHeight * 0.1,
      smallWindowWidth: smallWindowWidth,
      smallWindowHeight: bodyHeight / 3,
      smallWindowHorizontalPadding: smallHorizontalPadding,
      largeWindowWidth: rearWidth,
      largeWindowHeight: bodyHeight / 3.5,
      largeWindowHorizontalPadding: windowHorizontalPadding,
      stripeHeight: stripeHeight,
      upperStripePosition: upperStripePosition,
      lowerStripePosition: lowerStripePosition,
      doorWidth: smallWindowWidth,
      doorHeight: bodyHeight * 0.7,
      doorHorizontalPadding: doorWidth * 0.5,
      fenderHeight: fenderHeight,
      fenderPosition: ZVector.only(
        y: -bodyHeight / 2 + fenderHeight / 2,
      ),
      lightDiameter: 3,
    );
  }

  final double width;
  final double height;

  final double bodyWidth;
  final double bodyHeight;

  final double rearWidth;
  final double rearHeight;

  final double bodyTopPadding;

  final double smallWindowWidth;
  final double smallWindowHeight;
  final double smallWindowHorizontalPadding;

  final double largeWindowWidth;
  final double largeWindowHeight;
  final double largeWindowHorizontalPadding;

  final double stripeHeight;
  // TODO(alestiago): remove positioning form here.
  final ZVector upperStripePosition;
  final ZVector lowerStripePosition;

  final double fenderHeight;
  // TODO(alestiago): remove positioning form here.
  final ZVector fenderPosition;

  final double doorHeight;
  final double doorWidth;
  final double doorHorizontalPadding;

  final double lightDiameter;
}