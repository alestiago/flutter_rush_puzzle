import 'package:flutter/material.dart';
import 'package:zcomponents/zcomponents.dart';

// TODO(alestiago): Include Truck bonnet.
class TruckThemeData {
  TruckThemeData({
    required this.colorScheme,
  }) : dimensionData = ZTruckDimensionData.school();

  final ZTruckColorScheme colorScheme;
  final ZTruckDimensionData dimensionData;

  static TruckThemeData? lerp(TruckThemeData? a, TruckThemeData? b, double t) {
    return TruckThemeData(
      colorScheme: ZTruckColorScheme.lerp(a?.colorScheme, b?.colorScheme, t)!,
    );
  }
}

class ZTruckColorScheme {
  const ZTruckColorScheme({
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
  });

  final Color truckColor;

  final Color roofColor;
  final Color stripesColor;
  final Color windowColor;
  final Color backColor;
  final Color cabinColor;
  final Color fenderColor;
  final Color frontLightColor;
  final Color rearLightColor;
  final Color lightBorderColor;
  final Color bottomColor;

  static ZTruckColorScheme? lerp(
    ZTruckColorScheme? a,
    ZTruckColorScheme? b,
    double t,
  ) {
    return ZTruckColorScheme(
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
    );
  }
}

class ZTruckDimensionData {
  const ZTruckDimensionData({
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
    required this.cabinHorizontalPadding,
    required this.fenderHeight,
    required this.fenderPosition,
  });

  factory ZTruckDimensionData.school() {
    const length = 3;
    const size = 30.0;
    const space = 10.0;

    const width = length * size + space * (length - 1);
    const height = size;
    //const height = width / 2.5;

    const rearWidth = height;
    const smallWindowWidth = height / 2;
    const windowHorizontalPadding = smallWindowWidth * 0.3;

    const stripePadding = height * 0.05;
    const stripeHeight = height * 0.02;
    const upperStripePosition = ZVector.only(
      y: -stripeHeight / 2 - stripePadding,
    );

    final lowerStripePosition = upperStripePosition +
        const ZVector.only(
          y: -stripeHeight - stripePadding,
        );

    const fenderHeight = height * 0.05;
    const bodyWidth = width * 1;
    const bodyHeight = height;

    return ZTruckDimensionData(
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
      stripeHeight: bodyHeight * 0.02,
      upperStripePosition: upperStripePosition,
      lowerStripePosition: lowerStripePosition,
      cabinWidth: width / 5,
      cabinHeight: bodyHeight,
      cabinHorizontalPadding: 0,
      fenderHeight: fenderHeight,
      fenderPosition: const ZVector.only(
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
  // TODO(alestiago): remove positioning form here.
  final ZVector upperStripePosition;
  final ZVector lowerStripePosition;

  final double fenderHeight;
  // TODO(alestiago): remove positioning form here.
  final ZVector fenderPosition;

  final double cabinHeight;
  final double cabinWidth;
  final double cabinHorizontalPadding;
}

class ZTruck extends StatelessWidget {
  const ZTruck({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final TruckThemeData theme;

  @override
  Widget build(BuildContext context) {
    final topFace = ZPositioned(
      translate: ZVector.only(
        z: theme.dimensionData.bodyHeight / 2,
      ),
      rotate: const ZVector.only(z: -tau / 4),
      child: _ZRoof.fromTheme(theme),
    );

    final backFace = ZPositioned(
      translate: ZVector.only(
        z: theme.dimensionData.bodyWidth / 2,
      ),
      rotate: const ZVector.only(z: -tau / 4),
      child: ZPositioned(
        rotate: const ZVector.only(y: tau / 4),
        child: _ZTruckBackSide(theme: theme),
      ),
    );

    final frontFace = ZPositioned(
      translate: ZVector.only(
        z: -(theme.dimensionData.bodyWidth / 2),
      ),
      rotate: const ZVector.only(z: -tau / 4),
      child: ZPositioned(
        rotate: const ZVector.only(y: tau / 4),
        child: _ZTruckFrontSide(theme: theme),
      ),
    );

    final leftFace = ZPositioned(
      translate: ZVector.only(
        y: -theme.dimensionData.rearWidth / 2,
      ),
      rotate: const ZVector.only(x: tau / 4),
      child: _ZTruckBodySide(
        theme: theme,
      ),
    );

    final rightFace = ZPositioned(
      translate: ZVector.only(
        y: theme.dimensionData.rearWidth / 2,
      ),
      rotate: const ZVector.only(x: tau / 4),
      child: _ZTruckBodySide(
        theme: theme,
        side: ZWheelSide.right,
      ),
    );

    return ZGroup(
      sortMode: SortMode.update,
      children: [
        topFace,
        backFace,
        frontFace,
        leftFace,
        rightFace,
      ],
    );
  }
}



class _ZRoof extends StatelessWidget {
  const _ZRoof({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.cabinColor,
    required this.cabinWidth,
  }) : super(key: key);

  factory _ZRoof.fromTheme(TruckThemeData theme) {
    return _ZRoof(
      width: theme.dimensionData.rearWidth,
      height: theme.dimensionData.bodyWidth,
      color: theme.colorScheme.roofColor,
      cabinColor: theme.colorScheme.cabinColor,
      cabinWidth: theme.dimensionData.cabinWidth,
    );
  }

  final double width;
  final double height;
  final Color color;

  final Color cabinColor;

  final double cabinWidth;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZRect(
          width: width,
          color: color,
          height: height,
          fill: true,
        ),
        ZPositioned(
          translate: ZVector.only(y: height / 2 - cabinWidth / 2),
          child: ZRect(
            width: width,
            color: cabinColor,
            height: cabinWidth,
            fill: true,
          ),
        )
      ],
    );
  }
}

class _ZTruckBackSide extends StatelessWidget {
  const _ZTruckBackSide({
    Key? key,
    required TruckThemeData theme,
  })  : theme = theme,
        super(key: key);

  final TruckThemeData theme;

  @override
  Widget build(BuildContext context) {
    final body = ZRect(
      width: theme.dimensionData.rearWidth,
      color: theme.colorScheme.truckColor,
      height: theme.dimensionData.rearHeight,
      fill: true,
    );

    final window = _ZWindow.truckBack(theme);
    final fender = _ZFender.rearfromTheme(theme);
    final leftLight = _ZLight.rearFromTheme(theme);
    final rightLight = _ZLight.rearFromTheme(theme);

    final lightHeight =
        theme.dimensionData.fenderPosition.y + leftLight.diameter * 1.5 - 5;

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        body,
        ZPositioned(
          translate: ZVector.only(
            y: (body.height / 2) -
                (window.height / 2) -
                theme.dimensionData.bodyTopPadding,
          ),
          child: window,
        ),
        ZPositioned(
          translate: theme.dimensionData.upperStripePosition,
          child: _ZStripe.rearfromTheme(theme),
        ),
        ZPositioned(
          translate: theme.dimensionData.lowerStripePosition,
          child: _ZStripe.rearfromTheme(theme),
        ),
        ZPositioned(
          translate: theme.dimensionData.fenderPosition,
          child: fender,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -window.width / 2 + leftLight.diameter / 2,
            y: lightHeight,
          ),
          child: leftLight,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: window.width / 2 - leftLight.diameter / 2,
            y: lightHeight,
          ),
          child: rightLight,
        ),
      ],
    );
  }
}

class _ZTruckFrontSide extends StatelessWidget {
  const _ZTruckFrontSide({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final TruckThemeData theme;

  @override
  Widget build(BuildContext context) {
    final body = ZRect(
      width: theme.dimensionData.rearWidth,
      color: theme.colorScheme.cabinColor,
      height: theme.dimensionData.rearHeight,
      fill: true,
    );

    final window = _ZWindow.doubleLargeFromTheme(theme);
    final fender = _ZFender.rearfromTheme(theme);
    final leftLight = _ZLight.frontFromTheme(theme);
    final rightLight = _ZLight.frontFromTheme(theme);

    final lightHeight = (body.height / 2) -
        (window.height) -
        (theme.dimensionData.bodyTopPadding * 2) -
        (leftLight.diameter / 2) -
        2;

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        body,
        ZPositioned(
          translate: theme.dimensionData.fenderPosition,
          child: fender,
        ),
        ZPositioned(
          translate: theme.dimensionData.upperStripePosition,
          child: _ZStripe.rearfromTheme(theme),
        ),
        ZPositioned(
          translate: theme.dimensionData.lowerStripePosition,
          child: _ZStripe.rearfromTheme(theme),
        ),
        ZPositioned(
          translate: ZVector.only(
            y: (body.height / 2) -
                (window.height / 2) -
                theme.dimensionData.bodyTopPadding,
          ),
          child: window,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -window.width / 2 + leftLight.diameter / 2 + 2,
            y: lightHeight,
          ),
          child: leftLight,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: window.width / 2 - leftLight.diameter / 2 - 2,
            y: lightHeight,
          ),
          child: rightLight,
        ),
      ],
    );
  }
}

class _ZTruckBodySide extends StatelessWidget {
  const _ZTruckBodySide({
    Key? key,
    required this.theme,
    this.side = ZWheelSide.left,
  }) : super(key: key);

  final TruckThemeData theme;

  final ZWheelSide side;
  @override
  Widget build(BuildContext context) {
    final body = ZRect(
      width: theme.dimensionData.bodyWidth,
      color: theme.colorScheme.truckColor,
      height: theme.dimensionData.bodyHeight,
      fill: true,
    );

    final cabin = _Zcabin.fromTheme(theme: theme);
    final fender = _ZFender.sidefromTheme(theme);

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        body,
        ZPositioned(
          translate: ZVector.only(
            y: (body.height / 2) - (cabin.height / 2),
            x: (body.width / 2) - (cabin.width / 2),
          ),
          child: cabin,
        ),
        ZPositioned(
          translate: ZVector.only(
            y: (body.height / 2) -
                (theme.dimensionData.largeWindowHeight * 1.5 / 2) -
                theme.dimensionData.bodyTopPadding,
            x: (body.width / 2) - (cabin.width / 2 / 1.5),
          ),
          child: ZRect(
            width: theme.dimensionData.cabinWidth / 1.5,
            height: theme.dimensionData.largeWindowHeight * 1.5,
            color: theme.colorScheme.windowColor,
            fill: true,
          ),
        ),
        ZPositioned(
          translate: theme.dimensionData.fenderPosition,
          child: fender,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -body.width * 0.4,
            y: -body.height / 2,
          ),
          child: _ZWheel(side: side),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: body.width * 0.1,
            y: -body.height / 2,
          ),
          child: _ZWheel(side: side),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: body.width * 0.35,
            y: -body.height / 2,
          ),
          child: _ZWheel(side: side),
        ),
        ZPositioned(
          translate: theme.dimensionData.upperStripePosition,
          child: _ZStripe.sidefromTheme(theme),
        ),
        ZPositioned(
          translate: theme.dimensionData.lowerStripePosition,
          child: _ZStripe.sidefromTheme(theme),
        ),
      ],
    );
  }
}

class _ZStripe extends StatelessWidget {
  const _ZStripe({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  factory _ZStripe.sidefromTheme(TruckThemeData theme) {
    return _ZStripe(
      width: theme.dimensionData.bodyWidth,
      height: theme.dimensionData.stripeHeight,
      color: theme.colorScheme.stripesColor,
    );
  }

  factory _ZStripe.rearfromTheme(TruckThemeData theme) {
    return _ZStripe(
      width: theme.dimensionData.rearWidth,
      height: theme.dimensionData.stripeHeight,
      color: theme.colorScheme.stripesColor,
    );
  }

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ZRect(
      width: width,
      color: color,
      height: height,
      fill: true,
    );
  }
}

class _ZFender extends StatelessWidget {
  const _ZFender({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  factory _ZFender.sidefromTheme(TruckThemeData theme) {
    return _ZFender(
      width: theme.dimensionData.bodyWidth,
      height: theme.dimensionData.fenderHeight,
      color: theme.colorScheme.fenderColor,
    );
  }

  factory _ZFender.rearfromTheme(TruckThemeData theme) {
    return _ZFender(
      width: theme.dimensionData.rearWidth,
      height: theme.dimensionData.fenderHeight,
      color: theme.colorScheme.fenderColor,
    );
  }

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ZRect(
      width: width,
      color: color,
      height: height,
      fill: true,
    );
  }
}

class _Zcabin extends StatelessWidget {
  const _Zcabin({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  factory _Zcabin.fromTheme({
    required TruckThemeData theme,
  }) =>
      _Zcabin(
        width: theme.dimensionData.cabinWidth,
        height: theme.dimensionData.cabinHeight,
        color: theme.colorScheme.cabinColor,
      );

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ZRect(
      width: width,
      color: color,
      height: height,
      fill: true,
    );
  }
}

class _ZWindow extends StatelessWidget {
  const _ZWindow({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  factory _ZWindow.truckBack(TruckThemeData theme) => _ZWindow(
        width: theme.dimensionData.largeWindowWidth -
            (theme.dimensionData.largeWindowHorizontalPadding * 2),
        height: theme.dimensionData.largeWindowHeight * 2.5,
        color: theme.colorScheme.backColor,
      );

  factory _ZWindow.doubleLargeFromTheme(TruckThemeData theme) => _ZWindow(
        width: theme.dimensionData.largeWindowWidth -
            (theme.dimensionData.largeWindowHorizontalPadding * 2),
        height: theme.dimensionData.largeWindowHeight * 1.5,
        color: theme.colorScheme.windowColor,
      );

  final double width;
  final double height;
  final Color color;

  /// Fills an area with windows.
  List<Widget> fillArea({
    required double width,
    required double height,
    ZVector offset = ZVector.zero,
    double padding = 0,
  }) {
    final numberOfWindows = width / (this.width + padding);

    final windowStartPos = ZVector.only(
      y: (height / 2) - (this.height / 2) + offset.y,
      x: (-width / 2) + (this.width / 2) + padding + offset.x,
      z: offset.z,
    );
    return List<Widget>.generate(numberOfWindows.toInt(), (i) {
      final pos = windowStartPos +
          ZVector.only(
            x: (this.width + padding) * i,
          );

      return ZPositioned(
        translate: pos,
        child: copyWith(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZRect(
      width: width,
      color: color,
      height: height,
      fill: true,
    );
  }

  _ZWindow copyWith({
    double? width,
    double? height,
    Color? color,
  }) =>
      _ZWindow(
        width: width ?? this.width,
        height: height ?? this.height,
        color: color ?? this.color,
      );
}

class _ZLight extends StatelessWidget {
  const _ZLight({
    Key? key,
    required this.borderColor,
    required this.color,
    required this.diameter,
  }) : super(key: key);

  factory _ZLight.frontFromTheme(TruckThemeData theme) {
    return _ZLight(
      color: theme.colorScheme.frontLightColor,
      borderColor: theme.colorScheme.lightBorderColor,
      diameter: 4,
    );
  }

  factory _ZLight.rearFromTheme(TruckThemeData theme) {
    return _ZLight(
      color: theme.colorScheme.rearLightColor,
      borderColor: theme.colorScheme.lightBorderColor,
      diameter: 5,
    );
  }

  final Color borderColor;
  final Color color;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          child: ZCylinder(
            diameter: diameter,
            length: 0.5,
            color: borderColor,
          ),
        ),
        ZCircle(
          diameter: diameter - 1,
          color: color,
          fill: true,
        ),
      ],
    );
  }
}

class _ZWheel extends StatelessWidget {
  const _ZWheel({
    Key? key,
    this.side = ZWheelSide.left,
  }) : super(key: key);

  final ZWheelSide side;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          rotate: ZVector.only(x: side == ZWheelSide.left ? tau / 2 : 0),
          child: ZGroup(
            sortMode: SortMode.stack,
            children: [
              ZCylinder(
                diameter: 12,
                length: 2,
                color: Colors.black,
              ),
              ZPositioned(
                translate: const ZVector(0, 0, -2.1),
                child: ZCircle(
                  diameter: 4,
                  fill: true,
                  color: Colors.grey,
                ),
              ),
              ZPositioned(
                translate: const ZVector(0, 0, -1),
                child: ZShape(
                  visible: false,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
