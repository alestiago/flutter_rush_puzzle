import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zcomponents/zcomponents.dart';

// ignore: always_use_package_imports
import '_.dart';

class ZDriver extends ZRectNet {
  const ZDriver({Key? key}) : super(key: key);

  @override
  Widget get back => const _ZRear();

  @override
  Widget get bottom => const _ZFloor();

  @override
  Widget get front => const _ZFront();

  @override
  Widget get left => const _ZSide(side: ZAmbulanceSide.left);

  @override
  Widget get right => const _ZSide(side: ZAmbulanceSide.right);

  @override
  Widget get top => const _ZRoof();

  @override
  ZRectNetSize size(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZRectNetSize(
      height: theme.dimensionData.driverHeight,
      width: theme.dimensionData.driverWidth,
      depth: theme.dimensionData.rearWidth,
    );
  }
}

class _ZRear extends StatelessWidget {
  const _ZRear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZRect(
      width: theme.dimensionData.rearWidth,
      color: theme.colorScheme.bodyColor,
      height: theme.dimensionData.driverHeight,
      fill: true,
    );
  }
}

class _ZRoof extends StatelessWidget {
  const _ZRoof({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZRect(
      width: theme.dimensionData.rearWidth,
      color: theme.colorScheme.roofColor,
      height: theme.dimensionData.driverWidth,
      fill: true,
    );
  }
}

class _ZFloor extends StatelessWidget {
  const _ZFloor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZRect(
      width: theme.dimensionData.rearWidth,
      color: theme.colorScheme.floorColor,
      height: theme.dimensionData.driverWidth,
      fill: true,
    );
  }
}

class _ZFront extends StatelessWidget {
  const _ZFront({Key? key}) : super(key: key);

  static const _side = ZAmbulanceSide.front;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();
    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZRect(
          width: theme.dimensionData.rearWidth,
          color: theme.colorScheme.bodyColor,
          height: theme.dimensionData.driverHeight,
          fill: true,
        ),
        ZPositioned(
          translate: ZVector.only(
            y: -theme.dimensionData.stripeBottomPadding +
                (theme.dimensionData.bodyHeight -
                        theme.dimensionData.driverHeight) /
                    2,
          ),
          child: const _ZStripe(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            y: (theme.dimensionData.driverHeight / 2) -
                theme.dimensionData.windowPadding,
          ),
          child: const _ZWindow(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: theme.dimensionData.rearWidth / 2 -
                theme.dimensionData.lightDiameter,
            y: -theme.dimensionData.lightDiameter / 2,
          ),
          child: const _ZLight(),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -theme.dimensionData.rearWidth / 2 +
                theme.dimensionData.lightDiameter,
            y: -theme.dimensionData.lightDiameter / 2,
          ),
          child: const _ZLight(),
        ),
      ],
    );
  }
}

class _ZSide extends StatelessWidget {
  const _ZSide({
    Key? key,
    required ZAmbulanceSide side,
  })  : _side = side,
        super(key: key);

  final ZAmbulanceSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZRect(
          width: theme.dimensionData.driverWidth,
          color: theme.colorScheme.bodyColor,
          height: theme.dimensionData.driverHeight,
          fill: true,
        ),
        ZPositioned(
          translate: ZVector.only(
            y: -theme.dimensionData.stripeBottomPadding +
                (theme.dimensionData.bodyHeight -
                        theme.dimensionData.driverHeight) /
                    2,
          ),
          child: _ZStripe(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            y: -theme.dimensionData.driverHeight / 2,
          ),
          child: _ZWheel(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            y: theme.dimensionData.driverHeight / 2 -
                theme.dimensionData.windowPadding,
          ),
          child: _ZWindow(side: _side),
        ),
      ],
    );
  }
}

class _ZStripe extends StatelessWidget {
  const _ZStripe({
    Key? key,
    required ZAmbulanceSide side,
  })  : _side = side,
        super(key: key);

  final ZAmbulanceSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZRect(
      width: _side.width(theme),
      color: theme.colorScheme.stripesColor,
      height: theme.dimensionData.stripeHeight,
      fill: true,
    );
  }
}

class _ZWindow extends StatelessWidget {
  const _ZWindow({
    Key? key,
    required ZAmbulanceSide side,
  })  : _side = side,
        super(key: key);

  final ZAmbulanceSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZRect(
      width: _side.width(theme) - (theme.dimensionData.windowPadding / 2),
      color: theme.colorScheme.windowColor,
      height: theme.dimensionData.windowHeight,
      fill: true,
    );
  }
}

class _ZLight extends StatelessWidget {
  const _ZLight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          child: ZCylinder(
              diameter: theme.dimensionData.lightDiameter,
              length: 0.5,
              color: theme.colorScheme.lightBorderColor),
        ),
        ZCircle(
          diameter: theme.dimensionData.lightDiameter - 1,
          color: theme.colorScheme.frontLightColor,
          fill: true,
        ),
      ],
    );
  }
}

// TODO(jamesblasco): Replace with [ZWheel].
class _ZWheel extends StatelessWidget {
  const _ZWheel({
    Key? key,
    required ZAmbulanceSide side,
  })  : _side = side,
        super(key: key);

  final ZAmbulanceSide _side;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          rotate: ZVector.only(x: _side.isLeft ? tau / 2 : 0),
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

extension on ZAmbulanceSide {
  double width(AmbulanceThemeData theme) {
    switch (this) {
      case ZAmbulanceSide.front:
      case ZAmbulanceSide.rear:
        return theme.dimensionData.rearWidth;
      case ZAmbulanceSide.right:
      case ZAmbulanceSide.left:
        return theme.dimensionData.driverWidth;
    }
  }
}
