import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moves = context.select((PuzzleBloc bloc) {
      return bloc.state.historyPointer;
    });
    final dificulty = context.select((PuzzleBloc bloc) {
      return bloc.state.puzzle.difficulty;
    });
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      constraints: BoxConstraints.loose(const Size(400, 64)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: ScoreBoardItem(
              title: const Text('Difficulty'),
              text: Text(describeEnum(dificulty)),
            ),
          ),
          Flexible(
            child: ScoreBoardItem(
              title: const Text('Moves'),
              text: Text('$moves'),
            ),
          ),
          const Flexible(
            child: ScoreBoardItem(
              title: Text('Time'),
              text: PuzzleTimerText(),
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreBoardItem extends StatelessWidget {
  const ScoreBoardItem({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  final Widget title;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultTextStyle(
          style: Theme.of(context).textTheme.caption!,
          child: title,
        ),
        DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyLarge!,
          child: text,
        )
      ],
    );
  }
}