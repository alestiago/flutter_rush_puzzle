// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:puzzles_repository/puzzles_repository.dart';

import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/puzzle/widgets/perspective_segmented_control.dart';
import 'package:rush_hour_puzzle/puzzle/widgets/zpuzzle_timer.dart';
import 'package:rush_hour_puzzle/timer/timer.dart';
import 'package:rush_hour_puzzle/vehicle/vehicle.dart';
import 'package:z_cubic_text/z_cubic_text.dart';
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
            puzzlesRepository: context.read<PuzzlesRepository>(),
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
    final perspective = () {
      switch (state.status) {
        case GameStatus.initial:
        case GameStatus.loading:
        case GameStatus.setup:
          return GameLayoutPerspective.presentation;

        case GameStatus.playing:
          return state.perspective;

        case GameStatus.finished:
          return GameLayoutPerspective.presentation;
      }
    }();

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

    final dialogOffset = layout
        .boxForDrivingBoundary(
          DrivingBoundary(const Position(0, 0), const Position(5, 5)),
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
        } else if (state.status == GameStatus.finished) {
          context.read<PuzzleBloc>().add(const PuzzleShared());
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
                if (state.status == GameStatus.finished) const Fireworks(),
                DebugGame(
                  key: const Key('puzzleGame'),
                  debug: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ZGame(
                      theme: themes.first,
                      perspective: perspective,
                      vehiclesTheme: vehicleTheme,
                      vehicles: [
                        if (state.status == GameStatus.finished)
                          ZGroup(
                            children: [
                              for (final vehicle
                                  in state.puzzle.vehicles.values.where(
                                (element) =>
                                    element.id == state.puzzle.jammedVehicleId,
                              ))
                                VehicleView(
                                  key: Key('Vehicle${vehicle.id}'),
                                  vehicle: vehicle,
                                ),
                              ZPositioned(
                                translate: ZVector(
                                  dialogOffset.dx,
                                  dialogOffset.dy,
                                  -2,
                                ),
                                child: ZBox(
                                  depth: layout.tileDepth,
                                  color: themes.first.tileSideColor!,
                                  frontColor: themes.first.tileColor,
                                  width: layout.tileSizeForLength(6),
                                  height: layout.tileSizeForLength(6),
                                ),
                              ),
                              ZPositioned(
                                translate: ZVector(
                                  dialogOffset.dx,
                                  dialogOffset.dy,
                                  10,
                                ),
                                child: ZGroup(
                                  sortMode: SortMode.update,
                                  children: [
                                    ZPositioned(
                                      translate: ZVector.only(y: -60),
                                      child: const WonText(
                                        key: Key('Won'),
                                      ),
                                    ),
                                    ZPositioned(
                                      translate: ZVector.only(y: 15),
                                      child: ZCubicText(
                                        'Moves: ${state.historyPointer}',
                                        style: ZCubicTextStyle(
                                          frontColor: Colors.black,
                                          color: Colors.grey[900]!,
                                          fontSize: 4,
                                          letterSpacing: 3,
                                        ),
                                      ),
                                    ),
                                    ZPositioned(
                                      translate: ZVector.only(y: 35),
                                      child: ZPuzzleTimerText(),
                                    ),
                                    ZPositioned(
                                      translate: ZVector.only(y: 75),
                                      child: const ShareText(
                                        key: Key('Play'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else if (!state.status.isBeforePlaying)
                          ZGroup(
                            children: [
                              ZPositioned(
                                translate: ZVector(
                                  -layout.boundary.center.dx,
                                  -80,
                                  -layout.boardBorder - layout.boardPadding,
                                ),
                                child: ZPositioned(
                                    rotate:
                                        ZVector.only(x: -tau / 4, y: -tau / 4),
                                    child: ZGroup(
                                      children: [
                                        ZPositioned(
                                          translate: ZVector(
                                              0, 0, -layout.boardBorder / 2),
                                          child: ZBox(
                                            height: 54,
                                            width: 180,
                                            depth: layout.boardBorder,
                                            color: Colors.grey[200]!,
                                            frontColor: Colors.white,
                                            topColor: Colors.grey[100]!,
                                            rearColor: Colors.grey[300]!,
                                          ),
                                        ),
                                        ZToBoxAdapter(
                                          height: 60,
                                          width: 200,
                                          child: ScoreBoard(),
                                        ),
                                      ],
                                    )),
                              ),
                              for (final vehicle
                                  in state.puzzle.vehicles.values)
                                VehicleView(
                                  key: Key('Vehicle${vehicle.id}'),
                                  vehicle: vehicle,
                                )
                            ],
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
                                child: const GameTitle(
                                  key: Key('Game'),
                                ),
                              ),
                              ZPositioned(
                                translate:
                                    ZVector(textOffset.dx, textOffset.dy, 0),
                                child: const PlayText(
                                  key: Key('Play'),
                                ),
                              )
                            ],
                          )
                        ],
                      ],
                    ),
                  ),
                ),
                if (state.status == GameStatus.finished) ...[
                  // const Center(child: WinDialog()),
                ],
                if (state.status == GameStatus.playing) ...[
                  //const Align(
                  //  alignment: Alignment.topCenter,
                  //  child: SafeArea(
                  //    child: ScoreBoard(),
                  //  ),
                  //),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: PerspectiveSegmentedControl(),
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
