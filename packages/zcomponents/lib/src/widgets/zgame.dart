import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:puzzle_models/puzzle_models.dart';

import 'package:zcomponents/zcomponents.dart';

final GameRect game = GameRect(tileSize: 30, tileSpace: 10);

class ZGame extends StatelessWidget {
  const ZGame({
    Key? key,
    required this.theme,
    this.vehiclesTheme,
    this.vehicles = const [],
    this.transform,
  }) : super(key: key);

  final List<Widget> vehicles;

  final BoardThemeData theme;
  final VehiclesThemeData? vehiclesTheme;

  final ZTransform? transform;

  @override
  Widget build(BuildContext context) {
    return AnimatedBoardTheme(
      data: theme,
      child: AnimatedVehiclesTheme(
        data: vehiclesTheme,
        child: TweenAnimationBuilder<ZTransform?>(
          tween: ZTransformTween(
            begin: transform,
            end: transform,
          ),
          duration: const Duration(milliseconds: 600),
          builder: (_, animatedTransform, __) => ZDragDetector(
            builder: (context, controller) {
              final transform = animatedTransform ?? ZTransform();
              return LayoutBuilder(
                builder: (context, constraints) {
                  final scale =
                      constraints.biggest.shortestSide / game.boardSize;
                  return Align(
                    child: ZIllustration(
                      children: [
                        ZPositioned(
                          rotate: transform.rotate,
                          scale: ZVector.all(scale),
                          translate: transform.translate,
                          child: ZPositioned(
                            rotate: controller.value,
                            child: ZGroup(
                              children: [
                                ZBoard(
                                  rect: game,
                                ),
                                ZPositioned(
                                  translate: game.boardTopLeft,
                                  child: ZGroup(
                                    children: vehicles,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
