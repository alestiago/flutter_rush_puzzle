// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/game_piece/game_piece.dart';
import 'package:zcomponents/zcomponents.dart';
import 'package:rush_hour_puzzle/counter/counter.dart';
import 'package:rush_hour_puzzle/l10n/l10n.dart';

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

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final PageController _pageController = PageController(viewportFraction: 0.7);

  Key? selected;

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
    final ZTransform chooseState = ZTransform(
      rotate: ZVector.only(x: -0.25, y: -0.75),
    );
    final ZTransform play2d = ZTransform();
    final ZTransform play3d = ZTransform(
      rotate: ZVector.only(x: 1.2, y: -0.2, z: -0.5),
    );

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
    final l10n = context.l10n;
    return Scaffold(
        body: AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        final color =
            _pageController.hasClients ? _pageController.page! / 3 : .0;

        return DecoratedBox(
          decoration: BoxDecoration(
            color: background.transform(color),
          ),
          child: child,
        );
      },
      child: DebugGame(
        debug: true,
        child: ZGame(
          theme: themes.first,
          vehiclesTheme: vehicleTheme,
          transform: play2d,
          vehicles: [
            for (final vehicle in vehicles) GamePiece(vehicle: vehicle),
          ],
        ),
      ),
    ));
  }
}

class CounterText extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.headline1);
  }
}
