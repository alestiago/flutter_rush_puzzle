import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zcomponents/src/widgets/vehicles/ztruck/ztruck_body.dart';
import 'package:zcomponents/zcomponents.dart';

export 'ztruck_theme.dart';

class ZTruck extends StatelessWidget {
  const ZTruck({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final TruckThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: theme,
      child: const ZTruckBody(),
    );
  }
}