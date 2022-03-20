import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zvehicles/src/ztruck/ztruck_body.dart';
import 'package:zvehicles/zvehicles.dart';

export 'ztruck_theme.dart';

/// {@template zvehicles.ztruck}
/// A [ZTruck] is a truck represented by a [ZGroup].
/// {@endtemplate}
class ZTruck extends StatelessWidget {
  /// {@macro zvehicles.ztruck}
  const ZTruck({
    Key? key,
    required TruckThemeData theme,
  })  : _theme = theme,
        super(key: key);

  final TruckThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: _theme,
      child: const ZTruckBody(),
    );
  }
}
