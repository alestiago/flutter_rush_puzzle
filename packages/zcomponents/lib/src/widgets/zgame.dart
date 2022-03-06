import 'package:flutter/material.dart';
import 'package:zcomponents/src/widgets/zinteraction.dart';

import 'package:zcomponents/zcomponents.dart';

final GameLayout layout = GameLayout(tileSize: 30, tileSpace: 10);
enum GameLayoutPerspective {
  p2D,
  p3D,
  presentation,
}

extension on GameLayoutPerspective {
  ZPosition get position {
    switch (this) {
      case GameLayoutPerspective.p2D:
        return const ZPosition();
      case GameLayoutPerspective.p3D:
        return const ZPosition(
          scale: ZVector.all(0.75),
          rotate: ZVector.only(x: tau / 7, z: -tau / 8 + tau / 4),
        );
      case GameLayoutPerspective.presentation:
        return const ZPosition(
          scale: ZVector.all(0.75),
          rotate: ZVector.only(x: -0.25, y: -0.75),
        );
    }
  }
}

class ZGame extends StatelessWidget {
  const ZGame({
    Key? key,
    required this.theme,
    this.vehiclesTheme,
    this.vehicles = const [],
    this.perspective = GameLayoutPerspective.p2D,
  }) : super(key: key);

  final List<Widget> vehicles;

  final BoardThemeData theme;

  final VehiclesThemeData? vehiclesTheme;

  final GameLayoutPerspective perspective;

  @override
  Widget build(BuildContext context) {
    return AnimatedBoardTheme(
      data: theme,
      child: ZInteraction(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final scale = constraints.biggest.shortestSide / layout.boardSize;
            return ZIllustration(
              clipBehavior: Clip.none,
              zoom: scale,
              children: [
                ZInterationPositioned(
                  child: ZAnimatedPositioned.position(
                    position: perspective.position,
                    duration: const Duration(milliseconds: 600),
                    child: ZGroup(
                      children: [
                        ZBoard(
                          layout: layout,
                        ),
                        ZPositioned(
                          translate: layout.boardTopLeft,
                          child: Builder(
                            builder: (context) {
                              return ZGroup(
                                sortMode: SortMode.update,
                                sortPoint: const ZVector.only(z: 2000),
                                children: vehicles,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
