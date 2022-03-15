import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/timer/timer.dart';


class TimerHandler extends StatelessWidget {
  const TimerHandler({Key? key,  this.child}) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return BlocListener<PuzzleBloc, PuzzleState>(
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
      child: child,
    );
  }
}
