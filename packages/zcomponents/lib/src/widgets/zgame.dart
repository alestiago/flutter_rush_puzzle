import 'package:flutter/material.dart';
import 'package:zcomponents/src/widgets/zinteraction.dart';

import 'package:zcomponents/zcomponents.dart';

const zTileSize = 30.0;
final GameLayout layout = GameLayout(tileSize: zTileSize, tileSpace: 10);
enum GameLayoutPerspective {
  p2D,
  p3D,
  presentation,
}

extension GameLayoutPerspectivePosition on GameLayoutPerspective {
  ZPosition get position {
    switch (this) {
      case GameLayoutPerspective.p2D:
        return const ZPosition();
      case GameLayoutPerspective.p3D:
        return const ZPosition(
          scale: ZVector.all(0.8),
          translate: ZVector.only(y: 32),
          rotate: ZVector.only(x: tau / 7, z: -tau / 8 + tau / 4 - 0.04),
        );
      case GameLayoutPerspective.presentation:
        return const ZPosition(
          scale: ZVector.all(0.8),
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
    this.padding = EdgeInsets.zero,
    this.debug = false,
  }) : super(key: key);

  final List<Widget> vehicles;

  final BoardThemeData theme;

  final VehiclesThemeData? vehiclesTheme;

  final GameLayoutPerspective perspective;

  final EdgeInsets padding;

  final bool debug;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: DebugGame(
        key: const Key('_debugGame'),
        debug: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final scale = constraints.biggest.shortestSide / layout.boardSize;
            return AnimatedBoardTheme(
              data: theme,
              child: ZInteraction(
                enabled: perspective == GameLayoutPerspective.p3D,
                child: ZIllustration(
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
