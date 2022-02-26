import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/timer/timer.dart';

class PuzzleTimerText extends StatelessWidget {
  const PuzzleTimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final secondsElapsed = context.select((TimerBloc bloc) {
      return bloc.state.secondsElapsed;
    });
    final timeElapsed = Duration(seconds: secondsElapsed);

    return Text(
      _formatDuration(timeElapsed),
    );
  }
}

String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  final hoursText =
      duration.inHours == 0 ? '' : '${twoDigits(duration.inHours)}:';
  return '$hoursText$twoDigitMinutes:$twoDigitSeconds';
}
