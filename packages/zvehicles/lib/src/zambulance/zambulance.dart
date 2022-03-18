import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zvehicles/src/zambulance/zambulance_body.dart';
import 'package:zvehicles/src/zambulance/zambulance_cabin.dart';
import 'package:zvehicles/zvehicles.dart';

export 'zambulance_theme.dart';

class ZAmbulance extends StatelessWidget {
  const ZAmbulance({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final AmbulanceThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Provider<AmbulanceThemeData>.value(
      value: theme,
      child: ZGroup(
        sortMode: SortMode.update,
        children: [
          ZPositioned(
            translate: ZVector.only(x: -theme.layout.cabinWidth / 2),
            child: const ZAmbulanceBody(),
          ),
          ZPositioned(
            translate: ZVector.only(
              x: theme.layout.bodyWidth / 2,
              z: -(theme.layout.bodyHeight - theme.layout.cabinHeight) / 2,
            ),
            child: const ZAmbulanceCabin(),
          ),
        ],
      ),
    );
  }
}
