import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';


/// {@template score_board}
/// Overaly widget that shows details about the [PuzzlePage].
/// {@endtemplate}
class ScoreBoard extends StatelessWidget {
  /// {@macro score_board}
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
      padding: const EdgeInsets.all(8),
      constraints: BoxConstraints.loose(const Size(200, 60)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: ScoreBoardItem(
              title: Text('Difficulty'.toUpperCase()),
              text: Text(dificulty.stringify),
            ),
          ),
          Flexible(
            child: ScoreBoardItem(
              title: Text('Moves'.toUpperCase()),
              text: Text('$moves'),
            ),
          ),
          Flexible(
            child: ScoreBoardItem(
              title: Text('Time'.toUpperCase()),
              text: const PuzzleTimerText(),
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
          style: const TextStyle(
            fontSize: 6,
            color: Colors.grey,
          ),
          child: title,
        ),
        const SizedBox(height: 2),
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          child: text,
        )
      ],
    );
  }
}

extension on PuzzleDifficulty {
  // TODO(alestiago): Translate this instead.
  String get stringify {
    switch (this) {
      case PuzzleDifficulty.beginner:
        return 'Beginner';
      case PuzzleDifficulty.intermediate:
        return 'Intermediate';
      case PuzzleDifficulty.advanced:
        return 'Advanced';
      case PuzzleDifficulty.expert:
        return 'Expert';
    }
  }
}
