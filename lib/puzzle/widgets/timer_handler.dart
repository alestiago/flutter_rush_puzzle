import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/timer/timer.dart';

class TimerHandler extends StatelessWidget {
  const TimerHandler({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PuzzleBloc, PuzzleState>(
      listenWhen: (previous, current) {
        return current.status != previous.status;
      },
      listener: (context, state) {
        switch (state.status) {
          case GameStatus.setup:
            context.read<TimerBloc>().add(const TimerReset());
            break;
          case GameStatus.playing:
            context.read<TimerBloc>().add(const TimerResumed());
            break;
          case GameStatus.finished:
            context.read<TimerBloc>().add(const TimerPaused());
            FirebaseAnalytics.instance.logEvent(
              name: 'game_finished',
              parameters: {
                'version': context.read<PuzzleBloc>().puzzleVersion,
                'historyMove': state.historyPointer,
                'timer': context.read<TimerBloc>().state.secondsElapsed,
              },
            );
            break;
          case GameStatus.tutorial:
          case GameStatus.initial:
          case GameStatus.loading:
          case GameStatus.paused:
            break;
        }
      },
      child: child,
    );
  }
}
