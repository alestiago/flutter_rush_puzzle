import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zflutter/zflutter.dart';

// ignore: always_use_package_imports
import '_.dart';

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
          const ZBody(),
          ZPositioned(
            translate: ZVector.only(
              x: theme.dimensionData.bodyWidth / 2 +
                  theme.dimensionData.driverWidth / 2,
              z: -(theme.dimensionData.bodyHeight -
                      theme.dimensionData.driverHeight) /
                  2,
            ),
            child: const ZDriver(),
          ),
        ],
      ),
    );
  }
}
