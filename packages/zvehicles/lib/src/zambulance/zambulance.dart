import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zvehicles/src/zambulance/zambulance_body.dart';
import 'package:zvehicles/src/zambulance/zambulance_cabin.dart';
import 'package:zvehicles/zvehicles.dart';

export 'zambulance_theme.dart';

/// {@template zvehicles.zambulance}
/// A [ZAmbulance] is an ambulance represented by a [ZGroup].
/// /// {@endtemplate}
class ZAmbulance extends StatelessWidget {
  /// {@macro zvehicles.zambulance}
  const ZAmbulance({
    Key? key,
    required AmbulanceThemeData theme,
  })  : _theme = theme,
        super(key: key);

  final AmbulanceThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Provider<AmbulanceThemeData>.value(
      value: _theme,
      child: ZGroup(
        sortMode: SortMode.update,
        children: [
          ZPositioned(
            translate: ZVector.only(x: -_theme.layout.cabinWidth / 2),
            child: const ZAmbulanceBody(),
          ),
          ZPositioned(
            translate: ZVector.only(
              x: _theme.layout.bodyWidth / 2,
              z: -(_theme.layout.bodyHeight - _theme.layout.cabinHeight) / 2,
            ),
            child: const ZAmbulanceCabin(),
          ),
        ],
      ),
    );
  }
}
