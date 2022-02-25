// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/vehicle/vehicle.dart';
import 'package:zcomponents/zcomponents.dart';

class PuzzleGame extends StatelessWidget {
  const PuzzleGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PuzzleBloc(
        puzzleRepository: PuzzleRepository(),
      )..add(const PuzzleRequested()),
      child: const GameView(),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final themes = [
    BoardThemeData.fromMaterialColor(Colors.blue),
    BoardThemeData.fromMaterialColor(Colors.green),
    BoardThemeData.fromMaterialColor(Colors.red),
    BoardThemeData.fromMaterialColor(Colors.purple),
  ];

  late final Animatable<Color?> background = TweenSequence<Color?>([
    for (int index = 0; index < (themes.length - 1); index++)
      TweenSequenceItem(
        weight: 1,
        tween: ColorTween(
          begin: themes[index].backgroundColor,
          end: themes[index + 1].backgroundColor,
        ),
      ),
  ]);
  @override
  Widget build(BuildContext context) {
    final vehicleTheme = VehiclesThemeData(
      car: CarThemeData(
        color: Colors.green[700]!,
        sideColor: Colors.green[700],
        topColor: Colors.green[600],
      ),
      taxi: CarThemeData(
        color: Colors.yellow[700]!,
        sideColor: Colors.yellow[700],
        topColor: Colors.yellow[600],
      ),
    );
    final state = context.select((PuzzleBloc b) => b.state);
    if (state is PuzzleDataState) {
      return Scaffold(
        backgroundColor: themes.first.backgroundColor,
        body: DebugGame(
          debug: false,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ZGame(
              theme: themes.first,
              perspective: GameLayoutPerspective.p3D,
              vehiclesTheme: vehicleTheme,
              vehicles: [
                for (final vehicle in state.puzzle.vehicles.values)
                  VehicleView(
                    key: Key('Vehicle${vehicle.id}'),
                    vehicle: vehicle,
                  ),
              ],
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
