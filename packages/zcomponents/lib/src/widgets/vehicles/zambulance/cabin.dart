import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zcomponents/zcomponents.dart';

class ZCabin extends ZRectNet {
  const ZCabin({Key? key}) : super(key: key);

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
      children: [
        ZRect(
          width: theme.layout.rearWidth,
          color: theme.colorScheme.roofColor,
          height: theme.layout.cabinWidth,
          fill: true,
        ),
        _ZSiren(),
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
            x: theme.layout.rearWidth / 2 - theme.layout.lightDiameter,
            y: -theme.layout.lightDiameter / 2,
          ),
          child: const _ZLight(),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: -theme.layout.rearWidth / 2 + theme.layout.lightDiameter,
            y: -theme.layout.lightDiameter / 2,
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
            y: -theme.layout.cabinHeight / 2,
          ),
          child: _ZWheel(side: _side),
        ),
        ZPositioned(
          translate: ZVector.only(
            y: theme.layout.cabinHeight / 2 - theme.layout.windowTopPadding,
            x: theme.layout.sideWindowLeftPadding / 2,
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
            x: -theme.layout.sirenSize / 4,
          ),
          child: ZBox(
            width: theme.layout.sirenSize / 2,
            height: theme.layout.sirenSize / 2,
            depth: theme.layout.sirenSize / 2,
            color: theme.colorScheme.primarySirenColor,
            rearColor: theme.colorScheme.primarySirenShadowColor,
            rightColor: theme.colorScheme.primarySirenShadowColor,
            topColor: theme.colorScheme.primarySirenShadowColor,
            leftColor: theme.colorScheme.primarySirenShadowColor,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(
            x: theme.layout.sirenSize / 4,
          ),
          child: ZBox(
            width: theme.layout.sirenSize / 2,
            height: theme.layout.sirenSize / 2,
            depth: theme.layout.sirenSize / 2,
            color: theme.colorScheme.secondarySirenColor,
            rearColor: theme.colorScheme.secondarySirenShadowColor,
            leftColor: theme.colorScheme.secondarySirenShadowColor,
            topColor: theme.colorScheme.secondarySirenShadowColor,
            rightColor: theme.colorScheme.secondarySirenShadowColor,
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
