import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zvehicles/src/helpers/helpers.dart';
import 'package:zvehicles/src/zvehicle_side.dart';
import 'package:zvehicles/zvehicles.dart';

/// {@template zvehicles.zambulance.zambulance_cabin}
/// The cabin of the [ZAmbulance].
///
/// This cabin is where the driver is sitting.
/// {@endtemplate}
class ZAmbulanceCabin extends ZRectNet {
  /// {@macro zvehicles.zambulance.zambulance_cabin}
  const ZAmbulanceCabin({Key? key}) : super(key: key);

  @override
  Widget get back => const _ZRear();

  @override
  Widget get bottom => const _ZFloor();

  @override
  Widget get front => const _ZFront();

  @override
  Widget get left => const _ZSide(side: ZVehicleSide.left);

  @override
  Widget get right => const _ZSide(side: ZVehicleSide.right);

  @override
  Widget get top => const _ZRoof();

  @override
  ZRectNetSize size(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZRectNetSize(
      height: theme.layout.cabinHeight,
      width: theme.layout.cabinWidth,
      depth: theme.layout.rearWidth,
    );
  }
}

class _ZRear extends StatelessWidget {
  const _ZRear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZRect(
      width: theme.layout.rearWidth,
      color: theme.colorScheme.bodyColor,
      height: theme.layout.cabinHeight,
      fill: true,
    );
  }
}

class _ZRoof extends StatelessWidget {
  const _ZRoof({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZRect(
          width: theme.layout.rearWidth,
          color: theme.colorScheme.roofColor,
          height: theme.layout.cabinWidth,
          fill: true,
        ),
        const _ZSiren(),
      ],
    );
  }
}

class _ZFloor extends StatelessWidget {
  const _ZFloor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZRect(
      width: theme.layout.rearWidth,
      color: theme.colorScheme.floorColor,
      height: theme.layout.cabinWidth,
      fill: true,
    );
  }
}

class _ZFront extends StatelessWidget {
  const _ZFront({Key? key}) : super(key: key);

  static const _side = ZVehicleSide.front;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();
    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZRect(
          width: theme.layout.rearWidth,
          color: theme.colorScheme.bodyColor,
          height: theme.layout.cabinHeight,
          fill: true,
        ),
        ZPositioned(
          translate: ZVector.only(
            y: -theme.layout.stripeBottomPadding +
                (theme.layout.bodyHeight - theme.layout.cabinHeight) / 2,
          ),
          child: const _ZStripe(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            y: (theme.layout.cabinHeight / 2) - theme.layout.windowTopPadding,
          ),
          child: const _ZWindow(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: theme.layout.rearWidth / 2 - theme.layout.lightDiameter * 1.5,
            y: -theme.layout.lightDiameter / 2 -
                theme.layout.stripeBottomPadding -
                theme.layout.stripeHeight,
          ),
          child: const _ZLight(),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -theme.layout.rearWidth / 2 + theme.layout.lightDiameter * 1.5,
            y: -theme.layout.lightDiameter / 2 -
                theme.layout.stripeBottomPadding -
                theme.layout.stripeHeight,
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
    required ZVehicleSide side,
  })  : _side = side,
        super(key: key);

  final ZVehicleSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZRect(
          width: theme.layout.cabinWidth,
          color: theme.colorScheme.shadowColor,
          height: theme.layout.cabinHeight,
          fill: true,
        ),
        ZPositioned(
          translate: ZVector.only(
            y: -theme.layout.stripeBottomPadding +
                (theme.layout.bodyHeight - theme.layout.cabinHeight) / 2,
          ),
          child: _ZStripe(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            y: theme.layout.cabinHeight / 2 - theme.layout.windowTopPadding,
            x: theme.layout.sideWindowLeftPadding / 2,
          ),
          child: _ZWindow(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            y: -theme.layout.cabinHeight / 2,
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
    required ZVehicleSide side,
  })  : _side = side,
        super(key: key);

  final ZVehicleSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZRect(
      width: _side.width(theme),
      color: theme.colorScheme.stripesColor,
      height: theme.layout.stripeHeight,
      fill: true,
    );
  }
}

class _ZWindow extends StatelessWidget {
  const _ZWindow({
    Key? key,
    required ZVehicleSide side,
  })  : _side = side,
        super(key: key);

  final ZVehicleSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZRect(
      width: _side.width(theme) -
          (_side.isSide ? theme.layout.sideWindowLeftPadding : 0),
      color: theme.colorScheme.windowColor,
      height: theme.layout.windowHeight,
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
          child: ZRect(
            width: theme.layout.lightDiameter,
            height: theme.layout.lightDiameter * 0.75,
            color: theme.colorScheme.lightBorderColor,
          ),
        ),
        ZRect(
          width: theme.layout.lightDiameter - 1,
          height: theme.layout.lightDiameter * 0.75 - 0.5,
          color: theme.colorScheme.frontLightColor,
          fill: true,
        ),
      ],
    );
  }
}

class _ZSiren extends StatelessWidget {
  const _ZSiren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZGroup(
      sortMode: SortMode.update,
      children: [
        ZPositioned(
          translate: ZVector.only(
            x: -theme.layout.sirenSize,
          ),
          child: ZBox(
            width: theme.layout.sirenSize * 2,
            height: theme.layout.sirenSize / 2,
            depth: theme.layout.sirenSize / 2,
            color: theme.colorScheme.primarySirenShadowColor,
            frontColor: theme.colorScheme.primarySirenColor,
            stroke: 0,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: theme.layout.sirenSize,
          ),
          child: ZBox(
            width: theme.layout.sirenSize * 2,
            height: theme.layout.sirenSize / 2,
            depth: theme.layout.sirenSize / 2,
            color: theme.colorScheme.secondarySirenShadowColor,
            frontColor: theme.colorScheme.secondarySirenColor,
            stroke: 0,
          ),
        ),
      ],
    );
  }
}

// TODO(jamesblasco): Replace with [ZWheel].
class _ZWheel extends StatelessWidget {
  const _ZWheel({
    Key? key,
    required ZVehicleSide side,
  })  : _side = side,
        super(key: key);

  final ZVehicleSide _side;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZPositioned(
          rotate: ZVector.only(x: _side.isLeft ? tau / 2 : 0),
          child: ZGroup(
            sortMode: SortMode.stack,
            children: [
              ZCylinder(
                diameter: theme.layout.wheelDiameter,
                length: 2,
                color: theme.colorScheme.tyreColor,
              ),
              ZPositioned(
                translate: const ZVector(0, 0, -2.1),
                child: ZCircle(
                  diameter: theme.layout.wheelDiameter / 2.3,
                  fill: true,
                  color: theme.colorScheme.rimColor,
                ),
              ),
              ZPositioned(
                translate: const ZVector(0, 0, -1),
                child: ZShape(
                  visible: false,
                  color: theme.colorScheme.rimColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

extension on ZVehicleSide {
  double width(AmbulanceThemeData theme) {
    switch (this) {
      case ZVehicleSide.front:
      case ZVehicleSide.rear:
        return theme.layout.rearWidth;
      case ZVehicleSide.right:
      case ZVehicleSide.left:
        return theme.layout.cabinWidth;
    }
  }
}
