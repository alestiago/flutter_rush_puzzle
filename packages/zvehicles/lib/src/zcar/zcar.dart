import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zvehicles/src/zcar/zcar_body.dart';
import 'package:zvehicles/zvehicles.dart';

export 'zcar_theme.dart';

/// {@template zvehicles.zcar}
/// A [ZCar] is a car represented by a [ZGroup].
/// {@endtemplate}
class ZCar extends StatelessWidget {
  /// {@macro zvehicles.zcar}
  const ZCar({
    Key? key,
    required CarThemeData theme,
  })  : _theme = theme,
        super(key: key);

  final CarThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Provider<CarThemeData>.value(
      value: _theme,
      child: const ZCarBody(),
    );
  }
}
