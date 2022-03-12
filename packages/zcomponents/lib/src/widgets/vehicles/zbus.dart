import 'package:flutter/material.dart';
import 'package:zcomponents/zcomponents.dart';

// TODO(alestiago): Include bus bonnet.
class BusThemeData {
  const BusThemeData({
    required this.colorScheme,
    required this.dimensionData,
  });

  static final school = BusThemeData(
    colorScheme: ZBusColorScheme.school,
    dimensionData: ZBusDimensionData.school(),
  );

  final ZBusColorScheme colorScheme;
  final ZBusDimensionData dimensionData;

  static BusThemeData? lerp(BusThemeData? a, BusThemeData? b, double t) {
    return BusThemeData(
      colorScheme: ZBusColorScheme.lerp(a?.colorScheme, b?.colorScheme, t)!,
      dimensionData: b!.dimensionData,
    );
  }
}

class ZBusColorScheme {
  const ZBusColorScheme({
    required this.busColor,
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

  final Color busColor;
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

class ZBusDimensionData {
  const ZBusDimensionData({
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
  });

  factory ZBusDimensionData.school() {
    const length = 3;
    const size = 30.0;
    const space = 10.0;

    const width = length * size + space * (length - 1);
    const height = size;
    //const height = width / 2.5;

    const rearWidth = height;
    const smallWindowWidth = height / 4;
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
    const doorWidth = smallWindowWidth;

    return ZBusDimensionData(
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
}

class ZBus extends StatelessWidget {
  const ZBus({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final BusThemeData theme;

  @override
  Widget build(BuildContext context) {
    final topFace = ZPositioned(
      translate: ZVector.only(
        z: theme.dimensionData.bodyHeight / 2,
      ),
      rotate: const ZVector.only(z: -tau / 4),
      child: _ZRoof.fromTheme(theme),
    );

    final bottomFace = ZPositioned(
      translate: ZVector.only(
        z: -theme.dimensionData.bodyHeight / 2,
      ),
      rotate: const ZVector.only(z: -tau / 4),
      child: _ZFloor.fromTheme(theme),
    );

    final backFace = ZPositioned(
      translate: ZVector.only(
        z: theme.dimensionData.bodyWidth / 2,
      ),
      rotate: const ZVector.only(z: -tau / 4),
      child: ZPositioned(
        rotate: const ZVector.only(y: tau / 4),
        child: _ZBusBackSide(theme: theme),
      ),
    );

    final frontFace = ZPositioned(
      translate: ZVector.only(
        z: -(theme.dimensionData.bodyWidth / 2),
      ),
      rotate: const ZVector.only(z: -tau / 4),
      child: ZPositioned(
        rotate: const ZVector.only(y: tau / 4),
        child: _ZBusFrontSide(theme: theme),
      ),
    );

    final leftFace = ZPositioned(
      translate: ZVector.only(
        y: -theme.dimensionData.rearWidth / 2,
      ),
      rotate: const ZVector.only(x: tau / 4),
      child: _ZBusBodySide(
        theme: theme,
      ),
    );

    final rightFace = ZPositioned(
      translate: ZVector.only(
        y: theme.dimensionData.rearWidth / 2,
      ),
      rotate: const ZVector.only(x: tau / 4),
      child: _ZBusBodySide(
        theme: theme,
        side: ZWheelSide.right,
      ),
    );

    return ZGroup(
      sortMode: SortMode.update,
      children: [
        topFace,
        bottomFace,
        backFace,
        frontFace,
        leftFace,
        rightFace,
      ],
    );
  }
}

class _ZFloor extends StatelessWidget {
  const _ZFloor({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  factory _ZFloor.fromTheme(BusThemeData theme) {
    return _ZFloor(
      width: theme.dimensionData.rearWidth,
      height: theme.dimensionData.bodyWidth,
      color: theme.colorScheme.bottomColor,
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

class _ZRoof extends StatelessWidget {
  const _ZRoof({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  factory _ZRoof.fromTheme(BusThemeData theme) {
    return _ZRoof(
      width: theme.dimensionData.rearWidth,
      height: theme.dimensionData.bodyWidth,
      color: theme.colorScheme.roofColor,
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

class _ZBusBackSide extends StatelessWidget {
  const _ZBusBackSide({
    Key? key,
    required BusThemeData theme,
  })  : theme = theme,
        super(key: key);

  final BusThemeData theme;

  @override
  Widget build(BuildContext context) {
    final body = ZRect(
      width: theme.dimensionData.rearWidth,
      color: theme.colorScheme.busColor,
      height: theme.dimensionData.rearHeight,
      fill: true,
    );

    final window = _ZWindow.largeFromTheme(theme);
    final fender = _ZFender.rearfromTheme(theme);
    final leftLight = _ZLight.rearFromTheme(theme);
    final rightLight = _ZLight.rearFromTheme(theme);

    final lightHeight =
        theme.dimensionData.fenderPosition.y + leftLight.diameter * 1.5;

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
      ],
    );
  }
}

class _ZBusFrontSide extends StatelessWidget {
  const _ZBusFrontSide({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final BusThemeData theme;

  @override
  Widget build(BuildContext context) {
    final body = ZRect(
      width: theme.dimensionData.rearWidth,
      color: theme.colorScheme.busColor,
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
        (leftLight.diameter / 2);

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

class _ZBusBodySide extends StatelessWidget {
  const _ZBusBodySide({
    Key? key,
    required this.theme,
    this.side = ZWheelSide.left,
  }) : super(key: key);

  final BusThemeData theme;

  final ZWheelSide side;
  @override
  Widget build(BuildContext context) {
    final body = ZRect(
      width: theme.dimensionData.bodyWidth,
      color: theme.colorScheme.busColor,
      height: theme.dimensionData.bodyHeight,
      fill: true,
    );

    final windows = _ZWindow.smallFromTheme(theme).fillArea(
      width: body.width,
      height: body.height,
      padding: theme.dimensionData.smallWindowHorizontalPadding,
      offset: ZVector.only(y: -theme.dimensionData.bodyTopPadding),
    )..removeLast();

    final door = _ZDoor.fromTheme(theme: theme);
    final fender = _ZFender.sidefromTheme(theme);

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        body,
        ZPositioned(
          translate: theme.dimensionData.fenderPosition,
          child: fender,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -body.width * 0.3,
            y: -body.height / 2,
          ),
          child: _ZWheel(side: side),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: body.width * 0.3,
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
        ...windows,
        ZPositioned(
          translate: ZVector.only(
            y: (body.height / 2) -
                (door.height / 2) -
                theme.dimensionData.bodyTopPadding,
            x: (body.width / 2) -
                (door.width / 2) -
                theme.dimensionData.doorHorizontalPadding,
          ),
          child: door,
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

  factory _ZStripe.sidefromTheme(BusThemeData theme) {
    return _ZStripe(
      width: theme.dimensionData.bodyWidth,
      height: theme.dimensionData.stripeHeight,
      color: theme.colorScheme.stripesColor,
    );
  }

  factory _ZStripe.rearfromTheme(BusThemeData theme) {
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

  factory _ZFender.sidefromTheme(BusThemeData theme) {
    return _ZFender(
      width: theme.dimensionData.bodyWidth,
      height: theme.dimensionData.fenderHeight,
      color: theme.colorScheme.fenderColor,
    );
  }

  factory _ZFender.rearfromTheme(BusThemeData theme) {
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

class _ZDoor extends StatelessWidget {
  const _ZDoor({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  factory _ZDoor.fromTheme({
    required BusThemeData theme,
  }) =>
      _ZDoor(
        width: theme.dimensionData.doorWidth,
        height: theme.dimensionData.doorHeight,
        color: theme.colorScheme.doorColor,
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

  factory _ZWindow.smallFromTheme(BusThemeData theme) => _ZWindow(
        width: theme.dimensionData.smallWindowWidth,
        height: theme.dimensionData.smallWindowHeight,
        color: theme.colorScheme.windowColor,
      );

  factory _ZWindow.largeFromTheme(BusThemeData theme) => _ZWindow(
        width: theme.dimensionData.largeWindowWidth -
            (theme.dimensionData.largeWindowHorizontalPadding * 2),
        height: theme.dimensionData.largeWindowHeight,
        color: theme.colorScheme.windowColor,
      );

  factory _ZWindow.doubleLargeFromTheme(BusThemeData theme) => _ZWindow(
        width: theme.dimensionData.largeWindowWidth -
            (theme.dimensionData.largeWindowHorizontalPadding * 2),
        height: theme.dimensionData.largeWindowHeight * 2,
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

  factory _ZLight.frontFromTheme(BusThemeData theme) {
    return _ZLight(
      color: theme.colorScheme.frontLightColor,
      borderColor: theme.colorScheme.lightBorderColor,
      diameter: 5,
    );
  }

  factory _ZLight.rearFromTheme(BusThemeData theme) {
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
