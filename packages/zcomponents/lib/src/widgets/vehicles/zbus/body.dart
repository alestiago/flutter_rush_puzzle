import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zcomponents/zcomponents.dart';

class ZBody extends ZRectNet {
  const ZBody({Key? key}) : super(key: key);

  @override
  Widget get back => const _ZRear();

  @override
  Widget get bottom => const _ZFloor();

  @override
  Widget get front => const _ZFront();

  @override
  Widget get left => _ZSide(side: ZVehicleSide.left);

  @override
  Widget get right => _ZSide(side: ZVehicleSide.right);

  @override
  Widget get top => const _ZRoof();

  @override
  ZRectNetSize size(BuildContext context) {
    final theme = Provider.of<BusThemeData>(context);

    return ZRectNetSize(
      width: theme.layout.bodyWidth,
      height: theme.layout.bodyHeight,
      depth: theme.layout.rearWidth,
    );
  }
}

class _ZFloor extends StatelessWidget {
  const _ZFloor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<BusThemeData>();

    return ZRect(
      width: theme.layout.rearWidth,
      height: theme.layout.bodyWidth,
      color: theme.colorScheme.bottomColor,
      fill: true,
    );
  }
}

class _ZRoof extends StatelessWidget {
  const _ZRoof({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<BusThemeData>();

    return ZRect(
      width: theme.layout.rearWidth,
      height: theme.layout.bodyWidth,
      color: theme.colorScheme.roofColor,
      fill: true,
    );
  }
}

class _ZRear extends StatelessWidget {
  const _ZRear({Key? key}) : super(key: key);

  static const _side = ZVehicleSide.rear;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<BusThemeData>();

    final window = _ZWindow.largeFromTheme(theme);

    final lightHeight =
        theme.layout.fenderPosition.y + theme.layout.lightDiameter * 1.5;

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZRect(
          width: theme.layout.rearWidth,
          color: theme.colorScheme.bodyShadowColor,
          height: theme.layout.rearHeight,
          fill: true,
        ),
        ZPositioned(
          translate: ZVector.only(
            y: (theme.layout.bodyHeight / 2) -
                (window.height / 2) -
                theme.layout.bodyTopPadding,
          ),
          child: window,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -window.width / 2 + theme.layout.lightDiameter / 2,
            y: lightHeight,
          ),
          child: const _ZLight(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: window.width / 2 - theme.layout.lightDiameter / 2,
            y: lightHeight,
          ),
          child: const _ZLight(side: _side),
        ),
        ZPositioned(
          translate: theme.layout.upperStripePosition,
          child: const _ZStripe(side: _side),
        ),
        ZPositioned(
          translate: theme.layout.lowerStripePosition,
          child: const _ZStripe(side: _side),
        ),
        ZPositioned(
          translate: theme.layout.fenderPosition,
          child: const _ZFender(side: _side),
        ),
      ],
    );
  }
}

class _ZFront extends StatelessWidget {
  const _ZFront({Key? key}) : super(key: key);

  static const _side = ZVehicleSide.front;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<BusThemeData>();

    final window = _ZWindow.doubleLargeFromTheme(theme);
    const fender = _ZFender(side: _side);

    final lightHeight = (theme.layout.bodyHeight / 2) -
        (window.height) -
        (theme.layout.bodyTopPadding * 2) -
        (theme.layout.lightDiameter / 2);

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZRect(
          width: theme.layout.rearWidth,
          color: theme.colorScheme.bodyShadowColor,
          height: theme.layout.rearHeight,
          fill: true,
        ),
        ZPositioned(
          translate: theme.layout.fenderPosition,
          child: fender,
        ),
        ZPositioned(
          translate: theme.layout.upperStripePosition,
          child: const _ZStripe(side: _side),
        ),
        ZPositioned(
          translate: theme.layout.lowerStripePosition,
          child: const _ZStripe(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            y: (theme.layout.bodyHeight / 2) -
                (window.height / 2) -
                theme.layout.bodyTopPadding,
          ),
          child: window,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -window.width / 2 + theme.layout.lightDiameter / 2,
            y: lightHeight,
          ),
          child: const _ZLight(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: window.width / 2 - theme.layout.lightDiameter / 2,
            y: lightHeight,
          ),
          child: const _ZLight(side: _side),
        ),
      ],
    );
  }
}

class _ZSide extends StatelessWidget {
  _ZSide({
    Key? key,
    required ZVehicleSide side,
  })  : assert(side.isSide, 'Side must be right or left.'),
        _side = side,
        super(key: key);

  final ZVehicleSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<BusThemeData>();

    final windows = _ZWindow.smallFromTheme(theme).fillArea(
      width: theme.layout.bodyWidth,
      height: theme.layout.bodyHeight,
      padding: theme.layout.smallWindowHorizontalPadding,
      offset: ZVector.only(y: -theme.layout.bodyTopPadding),
    )..removeLast();

    const door = _ZDoor();
    final fender = _ZFender(
      side: _side,
    );

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZRect(
          width: theme.layout.bodyWidth,
          color: theme.colorScheme.bodyShadowColor,
          height: theme.layout.bodyHeight,
          fill: true,
        ),
        ZPositioned(
          translate: theme.layout.fenderPosition,
          child: fender,
        ),
        ZPositioned(
          translate: theme.layout.upperStripePosition,
          child: _ZStripe(side: _side),
        ),
        ZPositioned(
          translate: theme.layout.lowerStripePosition,
          child: _ZStripe(side: _side),
        ),
        ...windows,
        ZPositioned(
          translate: ZVector.only(
            y: (theme.layout.bodyHeight / 2) -
                (theme.layout.doorHeight / 2) -
                theme.layout.bodyTopPadding,
            x: (theme.layout.bodyWidth / 2) -
                (theme.layout.doorWidth / 2) -
                theme.layout.doorHorizontalPadding,
          ),
          child: door,
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -theme.layout.bodyWidth * 0.3,
            y: -theme.layout.bodyHeight / 2,
          ),
          child: ZWheel(side: _side.isLeft ? ZCarSide.left : ZCarSide.right),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: theme.layout.bodyWidth * 0.3,
            y: -theme.layout.bodyHeight / 2,
          ),
          child: ZWheel(side: _side.isLeft ? ZCarSide.left : ZCarSide.right),
        ),
      ],
    );
  }
}

class _ZStripe extends StatelessWidget {
  const _ZStripe({Key? key, required ZVehicleSide side})
      : _side = side,
        super(key: key);

  final ZVehicleSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<BusThemeData>();

    return ZRect(
      width: _side.isSide ? theme.layout.bodyWidth : theme.layout.rearWidth,
      height: theme.layout.stripeHeight,
      color: theme.colorScheme.stripesColor,
      fill: true,
    );
  }
}

class _ZFender extends StatelessWidget {
  const _ZFender({
    Key? key,
    required ZVehicleSide side,
  })  : _side = side,
        super(key: key);

  final ZVehicleSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<BusThemeData>();

    return ZRect(
      width: _side.isSide ? theme.layout.bodyWidth : theme.layout.rearWidth,
      height: theme.layout.fenderHeight,
      color: theme.colorScheme.fenderColor,
      fill: true,
    );
  }
}

class _ZDoor extends StatelessWidget {
  const _ZDoor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<BusThemeData>();

    return ZRect(
      width: theme.layout.doorWidth,
      height: theme.layout.doorHeight,
      color: theme.colorScheme.doorColor,
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
        width: theme.layout.smallWindowWidth,
        height: theme.layout.smallWindowHeight,
        color: theme.colorScheme.windowColor,
      );

  factory _ZWindow.largeFromTheme(BusThemeData theme) => _ZWindow(
        width: theme.layout.largeWindowWidth -
            (theme.layout.largeWindowHorizontalPadding * 2),
        height: theme.layout.largeWindowHeight,
        color: theme.colorScheme.windowColor,
      );

  factory _ZWindow.doubleLargeFromTheme(BusThemeData theme) => _ZWindow(
        width: theme.layout.largeWindowWidth -
            (theme.layout.largeWindowHorizontalPadding * 2),
        height: theme.layout.largeWindowHeight * 2,
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
    required ZVehicleSide side,
  })  : _side = side,
        super(key: key);

  final ZVehicleSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<BusThemeData>();

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          child: ZRect(
            width: theme.layout.lightDiameter,
            height: theme.layout.lightDiameter * 0.75,
            color: theme.colorScheme.lightBorderColor,
          ),
        ),
        ZRect(
          width: theme.layout.lightDiameter - 1,
          height: theme.layout.lightDiameter * 0.75 - 0.5,
          color: _side.isRear
              ? theme.colorScheme.rearLightColor
              : theme.colorScheme.frontLightColor,
          fill: true,
        ),
      ],
    );
  }
}
