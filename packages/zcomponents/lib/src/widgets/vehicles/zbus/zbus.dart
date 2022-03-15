import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zcomponents/src/widgets/vehicles/zbus/body.dart';
import 'package:zcomponents/zcomponents.dart';

export 'theme.dart';

class ZBus extends StatelessWidget {
  const ZBus({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final BusThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Provider<BusThemeData>.value(
      value: theme,
      child: ZGroup(
        sortMode: SortMode.stack,
        children: const [
          ZBody(),
        ],
      ),
    );
  }
}
