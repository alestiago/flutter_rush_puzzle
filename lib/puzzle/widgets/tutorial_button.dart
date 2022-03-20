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

    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: isActive
            ? MaterialStateProperty.all(
                Colors.black.withOpacity(0.05),
              )
            : MaterialStateProperty.all(
                Colors.white,
              ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 11),
        ),
      ),
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
