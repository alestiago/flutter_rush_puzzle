import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zvehicles/src/zbus/zbus_body.dart';
import 'package:zvehicles/zvehicles.dart';

export 'zbus_theme.dart';

/// {@template zvehicles.zbus}
/// A [ZBus] is a bus represented by a [ZGroup].
/// {@endtemplate}
class ZBus extends StatelessWidget {
  /// {@macro zvehicles.zbus}
  const ZBus({
    Key? key,
    required BusThemeData theme,
  })  : _theme = theme,
        super(key: key);

  final BusThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Provider<BusThemeData>.value(
      value: _theme,
      child: ZGroup(
        sortMode: SortMode.stack,
        children: const [
          ZBusBody(),
        ],
      ),
    );
  }
}
