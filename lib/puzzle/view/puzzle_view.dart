// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/vehicle/vehicle.dart';
import 'package:zcomponents/zcomponents.dart';
import 'package:zvehicles/zvehicles.dart';

class PuzzleView extends StatelessWidget {
  const PuzzleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardTheme = BoardThemeData.fromMaterialColor(Colors.blue);
    final state = context.select((PuzzleBloc b) => b.state);
    final perspective = state.status.isPlaying
        ? state.perspective
        : GameLayoutPerspective.presentation;

    final vehicleTheme = state.status.isTutorial
        ? ZVehiclesThemeData.fallback
        : ZVehiclesThemeData.fallback;

    final vehicles = state.puzzle.vehicles.values;
    final jammedVehicle = vehicles.firstWhereOrNull(
      (v) => v.id == state.puzzle.jammedVehicleId,
    );

    final body = Stack(
      clipBehavior: Clip.none,
      children: [
        const ZClouds(),
        if (state.status == GameStatus.finished) const Fireworks(),
        ZGame(
          key: const Key('puzzlePage_game'),
          theme: boardTheme,
          perspective: perspective,
          padding: const EdgeInsets.symmetric(vertical: 20),
          vehicles: [
            if (state.status == GameStatus.finished)
              ZGroup(
                children: [
                  ZVehicleView(
                    key: Key('Vehicle${jammedVehicle!.id}'),
                    vehicle: jammedVehicle,
                  ),
                  PuzzleZFinishGroup(boardTheme: boardTheme),
                ],
              )
            else if (state.status.isPlaying)
              ZGroup(
                children: [
                  for (final vehicle in vehicles)
                    ZVehicleView(
                      key: Key('Vehicle${vehicle.id}'),
                      vehicle: vehicle,
                    ),
                  const ZScoreBoard(),
                ],
              )
            else ...[
              const PuzzleZSetupView(),
            ],
          ],
        ),
        if (state.status == GameStatus.playing) ...[
          Align(
            alignment: Alignment.bottomRight,
            child: SafeArea(
              minimum: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  PerspectiveSegmentedControl(),
                  TutorialButton(),
                ],
              ),
            ),
          ),
        ]
      ],
    );

    return TimerHandler(
      child: GestureDetector(
        onTap: () {
          if (state.status == GameStatus.setup) {
            context.read<PuzzleBloc>().add(const PuzzleStarted());
          } else if (state.status == GameStatus.finished) {
            context.read<PuzzleBloc>().add(const PuzzleShared());
          }
        },
        child: Scaffold(
          backgroundColor: boardTheme.backgroundColor,
          body: AnimatedVehiclesTheme(
            data: vehicleTheme,
            child: body,
          ),
        ),
      ),
    );
  }
}
