// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_models/puzzle_models.dart';

import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/timer/timer.dart';
import 'package:rush_hour_puzzle/vehicle/vehicle.dart';
import 'package:zcomponents/zcomponents.dart';

class PuzzleGame extends StatelessWidget {
  const PuzzleGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TimerBloc(
            ticker: const Ticker(),
          ),
        ),
        BlocProvider(
          create: (_) => PuzzleBloc(
            puzzleRepository: PuzzleRepository(),
          )..add(const PuzzleFetched()),
        ),
      ],
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
    final vehicleTheme = VehiclesThemeData.fallback;
    final state = context.select((PuzzleBloc b) => b.state);
    final perspective = state.status.isBeforePlaying
        ? GameLayoutPerspective.presentation
        : GameLayoutPerspective.p3D;

    final isNotPlayingDemoVehicle = Vehicle(
      id: 'isNotPlayingDemoVehicle--vehicle',
      steering: Steering.horizontal,
      firstPosition: const Position(2, 1),
      type: VehicleType.taxi,
    );
    final titleOffset = layout
        .boxForDrivingBoundary(
          DrivingBoundary(const Position(2, 2), const Position(3, 3)),
        )
        .center;
    final textOffset = layout
        .boxForDrivingBoundary(
          DrivingBoundary(const Position(2, 5), const Position(3, 5)),
        )
        .center;
    return GestureDetector(
      onTap: () {
        if (state.status == GameStatus.setup) {
          context.read<PuzzleBloc>().add(const PuzzleStarted());
        }
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<PuzzleBloc, PuzzleState>(
            listenWhen: (previous, current) {
              return current.status != previous.status;
            },
            listener: (context, state) {
              // Start the puzzle timer when the countdown finishes.
              if (state.status == GameStatus.playing) {
                context.read<TimerBloc>().add(const TimerStarted());
              }
              if (state.status == GameStatus.finished) {
                context.read<TimerBloc>().add(const TimerStopped());
              }
              if (state.status == GameStatus.setup) {
                context.read<TimerBloc>().add(const TimerReset());
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: themes.first.backgroundColor,
          body: AnimatedVehiclesTheme(
            data: vehicleTheme,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                DebugGame(
                  debug: false,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ZGame(
                      theme: themes.first,
                      perspective: perspective,
                      vehiclesTheme: vehicleTheme,
                      vehicles: [
                        if (!state.status.isBeforePlaying)
                          for (final vehicle in state.puzzle.vehicles.values)
                            VehicleView(
                              key: Key('Vehicle${vehicle.id}'),
                              vehicle: vehicle,
                            )
                        else ...[
                          ZGroup(
                            children: [
                              VehicleView(
                                key: Key(isNotPlayingDemoVehicle.id),
                                vehicle: isNotPlayingDemoVehicle,
                              ),
                              ZPositioned(
                                translate:
                                    ZVector(titleOffset.dx, titleOffset.dy, 0),
                                child: GameTitle(
                                  key: Key('Game'),
                                ),
                              ),
                              ZPositioned(
                                translate:
                                    ZVector(textOffset.dx, textOffset.dy, 0),
                                child: PlayText(
                                  key: Key('Play'),
                                ),
                              )
                            ],
                          )
                        ]
                      ],
                    ),
                  ),
                ),
                OverlayBarrier(
                  visible: state.status != GameStatus.playing &&
                      !state.status.isBeforePlaying,
                ),
                if (state.status == GameStatus.finished) ...[
                  const Fireworks(),
                  const Center(child: WinDialog()),
                ],
                if (state.status.isBeforePlaying) ...[
                  //     const Center(child: StartDialog()),
                ],
                if (state.status == GameStatus.playing) ...[
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: ScoreBoard(),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
