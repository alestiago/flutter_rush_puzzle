import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:puzzle_models/puzzle_models.dart';

import 'package:zcomponents/zcomponents.dart';

final GameLayout layout = GameLayout(tileSize: 30, tileSpace: 10);

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

  final ZPosition? transform;

  @override
  Widget build(BuildContext context) {
    return AnimatedBoardTheme(
      data: theme,
      child: AnimatedVehiclesTheme(
        data: vehiclesTheme,
        child: ZDragDetector(
          builder: (context, controller) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final scale =
                    constraints.biggest.shortestSide / layout.boardSize;
                return ZIllustration(
                  children: [
                    ZPositioned(
                      scale: ZVector.all(scale),
                      child: ZAnimatedPositioned.position(
                        position: transform ?? ZPosition(),
                        duration: const Duration(milliseconds: 600),
                        child: ZPositioned(
                          rotate: controller.value,
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
                                      children: vehicles,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
