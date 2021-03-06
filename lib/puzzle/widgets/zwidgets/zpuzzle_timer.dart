import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/timer/timer.dart';
import 'package:z_cubic_text/z_cubic_text.dart';

class ZPuzzleTimerText extends StatelessWidget {
  const ZPuzzleTimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final secondsElapsed = context.select((TimerBloc bloc) {
      return bloc.state.secondsElapsed;
    });
    final timeElapsed = Duration(seconds: secondsElapsed);

    return ZCubicText(
      'Time: ${formatDuration(timeElapsed)}',
      style: ZCubicTextStyle(
        color: Colors.grey[900]!,
        frontColor: Colors.grey[800],
        fontSize: 4,
      ),
    );
  }
}
