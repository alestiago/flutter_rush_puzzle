import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zvehicles/src/helpers/helpers.dart';
import 'package:zvehicles/src/zvehicle_side.dart';
import 'package:zvehicles/zvehicles.dart';

/// {@template zvehicles.zambulance.zambulance_body}
/// The body of the [ZAmbulance].
///
/// This body of an ambulance is where a patient is usually sitting.
/// {@endtemplate}
class ZAmbulanceBody extends ZRectNet {
  /// {@macro zvehicles.zambulance.zambulance_body}
  const ZAmbulanceBody({Key? key}) : super(key: key);

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
      height: theme.layout.bodyHeight,
      width: theme.layout.bodyWidth,
      depth: theme.layout.rearWidth,
    );
  }
}

class _ZRoof extends StatelessWidget {
  const _ZRoof({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZGroup(
      children: [
        ZRect(
          width: theme.layout.bodyHeight,
          color: theme.colorScheme.roofColor,
          height: theme.layout.bodyWidth,
          fill: true,
        ),
        const _ZCross(),
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
      width: theme.layout.bodyHeight,
      color: theme.colorScheme.floorColor,
      height: theme.layout.bodyWidth,
      fill: true,
    );
  }
}

class _ZRear extends StatelessWidget {
  const _ZRear({Key? key}) : super(key: key);

  static const _side = ZVehicleSide.rear;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    final body = ZRect(
      width: theme.layout.rearWidth,
      color: theme.colorScheme.shadowColor,
      height: theme.layout.rearHeight,
      fill: true,
    );

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        body,
        ZPositioned(
          translate: ZVector.only(y: -theme.layout.stripeBottomPadding),
          child: const _ZStripe(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            y: -theme.layout.stripeBottomPadding + theme.layout.crossHeight,
          ),
          child: const _ZCross(),
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

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    final body = ZRect(
      width: theme.layout.rearWidth,
      color: theme.colorScheme.shadowColor,
      height: theme.layout.rearHeight,
      fill: true,
    );

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        body,
        ZPositioned(
          translate: theme.layout.fenderPosition,
          child: const _ZFender(side: ZVehicleSide.rear),
        ),
        ZPositioned(
          translate: ZVector.only(y: -theme.layout.stripeBottomPadding),
          child: const _ZStripe(side: ZVehicleSide.rear),
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

    final body = ZRect(
      width: theme.layout.bodyWidth,
      color: theme.colorScheme.shadowColor,
      height: theme.layout.bodyHeight,
      fill: true,
    );

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        body,
        ZPositioned(
          translate: theme.layout.fenderPosition,
          child: _ZFender(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            y: -theme.layout.stripeBottomPadding + theme.layout.crossHeight,
          ),
          child: const _ZCross(),
        ),
        ZPositioned(
          translate: ZVector.only(y: -theme.layout.stripeBottomPadding),
          child: _ZStripe(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -body.width * 0.3,
            y: -body.height / 2,
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

class _ZFender extends StatelessWidget {
  const _ZFender({
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
      color: theme.colorScheme.fenderColor,
      height: theme.layout.fenderHeight,
      fill: true,
    );
  }
}

class _ZCross extends StatelessWidget {
  const _ZCross({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        ZRect(
          width: theme.layout.crossWidth,
          color: theme.colorScheme.crossColor,
          height: theme.layout.crossHeight,
          fill: true,
        ),
        ZRect(
          width: theme.layout.crossHeight,
          color: theme.colorScheme.crossColor,
          height: theme.layout.crossWidth,
          fill: true,
        )
      ],
    );
  }
}

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
                color: Colors.black,
              ),
              ZPositioned(
                translate: const ZVector(0, 0, -2.1),
                child: ZCircle(
                  diameter: theme.layout.wheelDiameter / 2.3,
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

extension on ZVehicleSide {
  double width(AmbulanceThemeData theme) {
    switch (this) {
      case ZVehicleSide.front:
      case ZVehicleSide.rear:
        return theme.layout.rearWidth;
      case ZVehicleSide.right:
      case ZVehicleSide.left:
        return theme.layout.bodyWidth;
    }
  }
}
