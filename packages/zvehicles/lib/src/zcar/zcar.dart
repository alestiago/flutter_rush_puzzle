import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zvehicles/src/zcar/zcar_body.dart';
import 'package:zvehicles/zvehicles.dart';

export 'zcar_theme.dart';

class ZCar extends StatelessWidget {
  const ZCar({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final CarThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Provider<CarThemeData>.value(
      value: theme,
      child: const ZCarBody(),
    );
  }
}
