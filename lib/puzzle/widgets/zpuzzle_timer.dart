import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/timer/timer.dart';
import 'package:z_cubic_text/z_cubic_text.dart';
import 'puzzle_timer.dart';

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
        frontColor: Colors.black,
        color: Colors.grey[900]!,
        fontSize: 4,
        letterSpacing: 3,
      ),
    );
  }
}
