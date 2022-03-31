import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';

const double _kCornerRadius = 8;

class TutorialButton extends StatelessWidget {
  const TutorialButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive =
        context.select((PuzzleBloc b) => b.state.status.isTutorial);

    const border = BorderRadius.all(Radius.circular(_kCornerRadius));
    return InkWell(
      onTap: isActive
          ? null
          : () => context.read<PuzzleBloc>().add(
                const PuzzleTutorialStarted(),
              ),
      borderRadius: border,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: border,
          color: CupertinoDynamicColor.resolve(
            CupertinoColors.tertiarySystemFill,
            context,
          ),
        ),
        child: Icon(
          Icons.help_outline,
          size: 20,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}
