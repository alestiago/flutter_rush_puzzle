import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zcomponents/zcomponents.dart';

// ignore: always_use_package_imports
import '_.dart';

class ZBody extends ZRectNet {
  const ZBody({Key? key}) : super(key: key);

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
      height: theme.dimensionData.bodyHeight,
      width: theme.dimensionData.bodyWidth,
      depth: theme.dimensionData.rearWidth,
    );
  }
}

class _ZRoof extends StatelessWidget {
  const _ZRoof({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZRect(
      width: theme.dimensionData.bodyHeight,
      color: theme.colorScheme.roofColor,
      height: theme.dimensionData.bodyWidth,
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
      width: theme.dimensionData.bodyHeight,
      color: theme.colorScheme.floorColor,
      height: theme.dimensionData.bodyWidth,
      fill: true,
    );
  }
}

class _ZRear extends StatelessWidget {
  const _ZRear({Key? key}) : super(key: key);

  static const _side = ZAmbulanceSide.rear;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    final body = ZRect(
      width: theme.dimensionData.rearWidth,
      color: theme.colorScheme.bodyColor,
      height: theme.dimensionData.rearHeight,
      fill: true,
    );

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        body,
        const _ZRearDoor(),
        ZPositioned(
          translate: ZVector.only(y: -theme.dimensionData.stripeBottomPadding),
          child: const _ZStripe(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            y: -theme.dimensionData.stripeBottomPadding +
                theme.dimensionData.crossHeight,
          ),
          child: const _ZCross(),
        ),
        ZPositioned(
          translate: theme.dimensionData.fenderPosition,
          child: const _ZFender(side: _side),
        ),
      ],
    );
  }
}

class _ZRearDoor extends StatelessWidget {
  const _ZRearDoor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    return ZRect(
      width: 0.01,
      height: theme.dimensionData.rearHeight,
      color: theme.colorScheme.rearDoorColor,
      fill: true,
    );
  }
}

class _ZFront extends StatelessWidget {
  const _ZFront({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AmbulanceThemeData>();

    final body = ZRect(
      width: theme.dimensionData.rearWidth,
      color: theme.colorScheme.bodyColor,
      height: theme.dimensionData.rearHeight,
      fill: true,
    );

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        body,
        ZPositioned(
          translate: theme.dimensionData.fenderPosition,
          child: const _ZFender(side: ZAmbulanceSide.rear),
        ),
        ZPositioned(
          translate: ZVector.only(y: -theme.dimensionData.stripeBottomPadding),
          child: const _ZStripe(side: ZAmbulanceSide.rear),
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

    final body = ZRect(
      width: theme.dimensionData.bodyWidth,
      color: theme.colorScheme.bodyColor,
      height: theme.dimensionData.bodyHeight,
      fill: true,
    );

    return ZGroup(
      sortMode: SortMode.stack,
      children: [
        body,
        ZPositioned(
          translate: theme.dimensionData.fenderPosition,
          child: _ZFender(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -body.width * 0.3,
            y: -body.height / 2,
          ),
          child: _ZWheel(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            y: -theme.dimensionData.stripeBottomPadding +
                theme.dimensionData.crossHeight,
          ),
          child: const _ZCross(),
        ),
        ZPositioned(
          translate: ZVector.only(y: -theme.dimensionData.stripeBottomPadding),
          child: _ZStripe(side: _side),
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

class _ZFender extends StatelessWidget {
  const _ZFender({
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
      color: theme.colorScheme.fenderColor,
      height: theme.dimensionData.fenderHeight,
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
          width: theme.dimensionData.crossWidth,
          color: theme.colorScheme.crossColor,
          height: theme.dimensionData.crossHeight,
          fill: true,
        ),
        ZRect(
          width: theme.dimensionData.crossHeight,
          color: theme.colorScheme.crossColor,
          height: theme.dimensionData.crossWidth,
          fill: true,
        )
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
        return theme.dimensionData.bodyWidth;
    }
  }
}
