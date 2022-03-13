import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zcomponents/zcomponents.dart';

import 'body.dart';
import 'cabin.dart';

export 'theme.dart';

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
            child: const ZBody(),
          ),
          ZPositioned(
            translate: ZVector.only(
              x: theme.layout.bodyWidth / 2,
              z: -(theme.layout.bodyHeight - theme.layout.cabinHeight) / 2,
            ),
            child: const ZCabin(),
          ),
        ],
      ),
    );
  }
}
