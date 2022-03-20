import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';

class TutorialButton extends StatelessWidget {
  const TutorialButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<PuzzleBloc>().add(
            const PuzzleTutorialStarted(),
          ),
      icon: const Icon(Icons.help),
    );
  }
}
