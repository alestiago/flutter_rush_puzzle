// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/game/cubit/counter_cubit.dart';
import 'package:rush_hour_puzzle/vehicle/widgets/vehicle_view.dart';
import 'package:zcomponents/zcomponents.dart';

final vehicles = [
  Vehicle(
    id: 'A',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(0, 0),
  ),
  Vehicle(
    id: 'B',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(1, 0),
  ),
  Vehicle(
    id: 'C',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(2, 0),
  ),
  Vehicle(
    id: 'D',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(3, 0),
  ),
  Vehicle(
    id: 'E',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(4, 0),
  ),
  Vehicle(
    id: 'F',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(5, 0),
  ),
  Vehicle(
    id: 'G',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(0, 2),
  ),
  Vehicle(
    id: 'H',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(1, 2),
  ),
  Vehicle(
    id: 'I',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(2, 2),
  ),
  Vehicle(
    id: 'J',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(3, 2),
  ),
  Vehicle(
    id: 'K',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(4, 2),
  ),
  Vehicle(
    id: 'L',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(5, 2),
  ),
  Vehicle(
    id: 'M',
    length: 3,
    steering: Steering.horizonal,
    firstPosition: const Position(0, 4),
  ),
  Vehicle(
    id: 'N',
    length: 3,
    steering: Steering.horizonal,
    firstPosition: const Position(3, 4),
  ),
  Vehicle(
    id: 'O',
    length: 3,
    steering: Steering.horizonal,
    firstPosition: const Position(0, 5),
  ),
  Vehicle(
    id: 'P',
    length: 3,
    steering: Steering.horizonal,
    firstPosition: const Position(3, 5),
  ),
];

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
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
              for (final vehicle in vehicles)
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
}
