import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/l10n/l10n.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';

class StartDialog extends StatelessWidget {
  const StartDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(),
        const Expanded(
          child: RushPuzzleIllustration(),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<PuzzleBloc>().add(const PuzzleStarted());
          },
          child: Text(l10n.startButtonTitle),
        ),
      ],
    );
  }
}
