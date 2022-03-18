import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zvehicles/src/zvehicle_side.dart';
import 'package:zvehicles/zvehicles.dart';

extension on BuildContext {
  TruckThemeData get theme => watch<TruckThemeData>();
}

class ZTruckBody extends StatelessWidget {
  const ZTruckBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final topFace = ZPositioned(
      translate: ZVector.only(
        z: theme.layout.bodyHeight / 2,
      ),
      rotate: const ZVector.only(z: -tau / 4),
      child: const _ZRoof(),
    );

    final backFace = ZPositioned(
      translate: ZVector.only(
        z: theme.layout.bodyWidth / 2,
      ),
      rotate: const ZVector.only(z: -tau / 4),
      child: const ZPositioned(
        rotate: ZVector.only(y: tau / 4),
        child: _ZRear(),
      ),
    );

    final frontFace = ZPositioned(
      translate: ZVector.only(
        z: -(theme.layout.bodyWidth / 2 - theme.layout.cabinStride),
      ),
      rotate: const ZVector.only(z: -tau / 4),
      child: const ZPositioned(
        rotate: ZVector.only(y: tau / 4),
        child: _ZBodyFront(),
      ),
    );

    final leftFace = ZPositioned(
      translate: ZVector.only(
        y: -theme.layout.rearWidth / 2,
        x: -theme.layout.cabinStride / 2,
      ),
      rotate: const ZVector.only(x: tau / 4),
      child: const _ZTruckBodySide(
        side: ZVehicleSide.left,
      ),
    );

    final rightFace = ZPositioned(
      translate: ZVector.only(
        y: theme.layout.rearWidth / 2,
        x: -theme.layout.cabinStride / 2,
      ),
      rotate: const ZVector.only(x: tau / 4),
      child: const _ZTruckBodySide(
        side: ZVehicleSide.right,
      ),
    );

    final topCabinFace = ZPositioned(
      translate: ZVector.only(
        z: theme.layout.bodyHeight / 2 -
            (theme.layout.bodyHeight - theme.layout.cabinHeight),
      ),
      rotate: const ZVector.only(z: -tau / 4),
      child: const _ZCabinRoof(),
    );

    final backCabinFace = ZPositioned(
      translate: ZVector.only(
        z: -(theme.layout.bodyWidth / 2 - theme.layout.cabinWidth),
        x: -(theme.layout.bodyHeight - theme.layout.cabinHeight) / 2,
      ),
      rotate: const ZVector.only(z: -tau / 4),
      child: const ZPositioned(
        rotate: ZVector.only(y: tau / 4),
        child: _ZCabinBackSide(),
      ),
    );

    final frontCabinFace = ZPositioned(
      translate: ZVector.only(
        z: -(theme.layout.bodyWidth / 2),
      ),
      rotate: const ZVector.only(z: -tau / 4),
      child: const ZPositioned(
        rotate: ZVector.only(y: tau / 4),
        child: _ZCabinFrontSide(),
      ),
    );

    final leftCabinFace = ZPositioned(
      translate: ZVector.only(
        y: -theme.layout.rearWidth / 2,
      ),
      rotate: const ZVector.only(x: tau / 4),
      child: const _ZCabinBodySide(
        side: ZVehicleSide.left,
      ),
    );

    final rightCabinFace = ZPositioned(
      translate: ZVector.only(
        y: theme.layout.rearWidth / 2,
      ),
      rotate: const ZVector.only(x: tau / 4),
      child: const _ZCabinBodySide(
        side: ZVehicleSide.right,
      ),
    );

    return ZGroup(
      sortMode: SortMode.update,
      children: [
        ZGroup(
          sortMode: SortMode.update,
          children: [
            topFace,
            backFace,
            frontFace,
            leftFace,
            rightFace,
          ],
        ),
        ZGroup(
          sortMode: SortMode.update,
          children: [
            topCabinFace,
            backCabinFace,
            frontCabinFace,
            leftCabinFace,
            rightCabinFace,
          ],
        ),
      ],
    );
  }
}

class _ZRoof extends StatelessWidget {
  const _ZRoof({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          translate: ZVector.only(y: -theme.layout.cabinStride / 2),
          child: ZRect(
            width: theme.layout.rearWidth,
            color: theme.colorScheme.roofColor,
            height: theme.layout.bodyWidth - theme.layout.cabinStride,
            fill: true,
          ),
        ),
      ],
    );
  }
}

class _ZRear extends StatelessWidget {
  const _ZRear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final body = ZRect(
      width: theme.layout.rearWidth,
      color: theme.colorScheme.backColor,
      height: theme.layout.rearHeight,
      fill: true,
    );

    final window = _ZWindow.truckBack(theme);
    final fender = _ZFender(width: theme.layout.rearWidth);
    final leftLight = _ZLight.rearFromTheme(theme);
    final rightLight = _ZLight.rearFromTheme(theme);

    final lightHeight =
        theme.layout.fenderPosition.y + leftLight.size * 1.5 - 5;

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        body,
        ZPositioned(
          translate: ZVector.only(
            y: (body.height / 2) -
                (window.height / 2) -
                theme.layout.bodyTopPadding,
          ),
          child: window,
        ),
        ZPositioned(
          translate: theme.layout.upperStripePosition,
          child: _ZStripe(width: theme.layout.rearWidth),
        ),
        ZPositioned(
          translate: theme.layout.lowerStripePosition,
          child: _ZStripe(width: theme.layout.rearWidth),
        ),
        ZPositioned(
          translate: theme.layout.fenderPosition,
          child: fender,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -window.width / 2 + leftLight.size / 2,
            y: lightHeight,
          ),
          child: leftLight,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: window.width / 2 - leftLight.size / 2,
            y: lightHeight,
          ),
          child: rightLight,
        ),
      ],
    );
  }
}

class _ZBodyFront extends StatelessWidget {
  const _ZBodyFront({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZRect(
          width: theme.layout.rearWidth,
          color: theme.colorScheme.backColor,
          height: theme.layout.rearHeight,
          fill: true,
        ),
      ],
    );
  }
}

class _ZTruckBodySide extends StatelessWidget {
  const _ZTruckBodySide({
    Key? key,
    required ZVehicleSide side,
  })  : _side = side,
        super(key: key);

  final ZVehicleSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZRect(
          width: theme.layout.bodyWidth - theme.layout.cabinStride,
          color: theme.colorScheme.truckColor,
          height: theme.layout.bodyHeight,
          fill: true,
        ),
        ZPositioned(
          translate: theme.layout.upperStripePosition,
          child: _ZStripe(
            width: theme.layout.bodyWidth - theme.layout.cabinStride,
          ),
        ),
        ZPositioned(
          translate: theme.layout.lowerStripePosition,
          child: _ZStripe(
            width: theme.layout.bodyWidth - theme.layout.cabinStride,
          ),
        ),
        ZPositioned(
          translate: theme.layout.fenderPosition,
          child: _ZFender(
            width: theme.layout.bodyWidth - theme.layout.cabinStride,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -(theme.layout.bodyWidth - theme.layout.cabinStride) * 0.35,
            y: -theme.layout.bodyHeight / 2,
          ),
          child: _ZWheel(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: (theme.layout.bodyWidth - theme.layout.cabinStride) * 0.3,
            y: -theme.layout.bodyHeight / 2,
          ),
          child: _ZWheel(side: _side),
        ),
      ],
    );
  }
}

class _ZStripe extends StatelessWidget {
  const _ZStripe({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final height = theme.layout.stripeHeight;
    final color = theme.colorScheme.stripesColor;
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
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final height = theme.layout.fenderHeight;
    final color = theme.colorScheme.fenderColor;
    return ZRect(
      width: width,
      color: color,
      height: height,
      fill: true,
    );
  }
}

class _Zcabin extends StatelessWidget {
  const _Zcabin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ZRect(
      width: theme.layout.cabinWidth,
      color: theme.colorScheme.cabinColor,
      height: theme.layout.cabinHeight,
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
        width: theme.layout.largeWindowWidth -
            (theme.layout.largeWindowHorizontalPadding * 2),
        height: theme.layout.largeWindowHeight * 2.5,
        color: theme.colorScheme.backColor,
      );

  factory _ZWindow.doubleLargeFromTheme(TruckThemeData theme) => _ZWindow(
        width: theme.layout.largeWindowWidth -
            (theme.layout.largeWindowHorizontalPadding * 2),
        height: theme.layout.largeWindowHeight * 1.5,
        color: theme.colorScheme.windowColor,
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
    required this.size,
  }) : super(key: key);

  factory _ZLight.frontFromTheme(TruckThemeData theme) {
    return _ZLight(
      color: theme.colorScheme.frontLightColor,
      borderColor: theme.colorScheme.lightBorderColor,
      size: 3.5,
    );
  }

  factory _ZLight.rearFromTheme(TruckThemeData theme) {
    return _ZLight(
      color: theme.colorScheme.rearLightColor,
      borderColor: theme.colorScheme.lightBorderColor,
      size: 5,
    );
  }

  final Color borderColor;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          child: ZRect(
            width: size,
            height: size * 0.75,
            color: borderColor,
          ),
        ),
        ZRect(
          width: size - 1,
          height: size * 0.75 - 0.5,
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
    required this.side,
  }) : super(key: key);

  final ZVehicleSide side;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          rotate: ZVector.only(x: side.isLeft ? tau / 2 : 0),
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

class _ZCabinRoof extends StatelessWidget {
  const _ZCabinRoof({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          translate: ZVector.only(
            y: theme.layout.bodyWidth / 2 - theme.layout.cabinWidth / 2,
          ),
          child: ZRect(
            width: theme.layout.rearWidth,
            color: theme.colorScheme.cabinColor,
            height: theme.layout.cabinWidth,
            fill: true,
          ),
        )
      ],
    );
  }
}

class _ZCabinBackSide extends StatelessWidget {
  const _ZCabinBackSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ZGroup(
      sortMode: SortMode.update,
      sortPoint: const ZVector.only(y: -5),
      children: [
        ZRect(
          width: theme.layout.rearWidth,
          color: theme.colorScheme.cabinColor,
          height: theme.layout.cabinHeight,
          fill: true,
        ),
      ],
    );
  }
}

class _ZCabinFrontSide extends StatelessWidget {
  const _ZCabinFrontSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final body = ZRect(
      width: theme.layout.rearWidth,
      color: theme.colorScheme.cabinColor,
      height: theme.layout.cabinHeight,
      fill: true,
    );

    final window = _ZWindow.doubleLargeFromTheme(theme);
    final fender = _ZFender(width: theme.layout.rearWidth);
    final leftLight = _ZLight.frontFromTheme(theme);
    final rightLight = _ZLight.frontFromTheme(theme);

    final lightHeight = (body.height / 2) -
        (window.height) -
        (theme.layout.bodyTopPadding * 2) -
        (leftLight.size / 2);

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          translate: ZVector.only(
            y: -(theme.layout.bodyHeight - theme.layout.cabinHeight) / 2,
          ),
          child: body,
        ),
        ZPositioned(
          translate: theme.layout.fenderPosition,
          child: fender,
        ),
        ZPositioned(
          translate: ZVector.only(
            y: (body.height / 2) -
                (window.height / 2) -
                theme.layout.bodyTopPadding,
          ),
          child: window,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -window.width / 2 + leftLight.size / 2 + 2,
            y: lightHeight,
          ),
          child: leftLight,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: window.width / 2 - leftLight.size / 2 - 2,
            y: lightHeight,
          ),
          child: rightLight,
        ),
      ],
    );
  }
}

class _ZCabinBodySide extends StatelessWidget {
  const _ZCabinBodySide({
    Key? key,
    required ZVehicleSide side,
  })  : _side = side,
        super(key: key);

  final ZVehicleSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final body = ZRect(
      width: theme.layout.bodyWidth,
      color: theme.colorScheme.truckColor,
      height: theme.layout.bodyHeight,
      fill: true,
    );

    const cabin = _Zcabin();
    final fender = _ZFender(width: theme.layout.cabinStride);

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          translate: ZVector.only(
            y: -(body.height - theme.layout.cabinHeight) / 2,
            x: (body.width / 2) - (theme.layout.cabinWidth / 2),
          ),
          child: cabin,
        ),
        ZPositioned(
          translate: ZVector.only(
            y: theme.layout.cabinHeight / 2 -
                (theme.layout.largeWindowHeight * 1.5 / 2) -
                theme.layout.bodyTopPadding,
            x: (body.width / 2) - (theme.layout.cabinWidth / 2 / 1.5),
          ),
          child: ZRect(
            width: theme.layout.cabinWidth / 1.5,
            height: theme.layout.largeWindowHeight * 1.5,
            color: theme.colorScheme.windowColor,
            fill: true,
          ),
        ),
        ZPositioned(
          translate: theme.layout.fenderPosition +
              ZVector.only(
                x: (body.width - theme.layout.cabinStride) / 2,
              ),
          child: fender,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: body.width * 0.36,
            y: -body.height / 2,
          ),
          child: _ZWheel(side: _side),
        ),
      ],
    );
  }
}
