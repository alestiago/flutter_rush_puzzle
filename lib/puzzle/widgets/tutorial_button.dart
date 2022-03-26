import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';

// TODO(alestiago): Style appropiately.
class TutorialButton extends StatelessWidget {
  const TutorialButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive =
        context.select((PuzzleBloc b) => b.state.status.isTutorial);

    // TODO(alestiago): Correctly style the button.
    return CupertinoButton(
      onPressed: isActive
          ? null
          : () => context.read<PuzzleBloc>().add(
                const PuzzleTutorialStarted(),
              ),
      child: Icon(
        Icons.help,
        color: isActive ? Colors.white : Colors.black,
      ),
    );
  }
}
