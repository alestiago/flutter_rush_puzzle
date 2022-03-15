import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:z_cubic_text/z_cubic_text.dart';
import 'package:zcomponents/zcomponents.dart';

final _dialogOffset = layout
    .boxForMinMax(
      Position.zero,
      const Position.all(5),
    )
    .zCenter;

class PuzzleZFinishGroup extends StatelessWidget {
  const PuzzleZFinishGroup({
    Key? key,
    required this.boardTheme,
  }) : super(key: key);

  final BoardThemeData boardTheme;

  @override
  Widget build(BuildContext context) {
    final state = context.select((PuzzleBloc b) => b.state);

    return ZGroup(
      children: [
        ZPositioned(
          translate: _dialogOffset + const ZVector.only(z: -2),
          child: ZBox(
            depth: layout.tileDepth,
            color: boardTheme.tileSideColor!,
            frontColor: boardTheme.tileColor,
            width: layout.size,
            height: layout.size,
          ),
        ),
        ZPositioned(
          translate: _dialogOffset + const ZVector.only(z: 10),
          child: ZGroup(
            sortMode: SortMode.update,
            children: [
              const ZPositioned(
                translate: ZVector.only(y: -60),
                child: ZWonText(
                  key: Key('finishView_wonText'),
                ),
              ),
              ZPositioned(
                translate: const ZVector.only(y: 15),
                child: ZCubicText(
                  'Moves: ${state.historyPointer}',
                  style: ZCubicTextStyle(
                    color: Colors.grey[900]!,
                    frontColor: Colors.grey[800],
                    fontSize: 4,
                  ),
                ),
              ),
              const ZPositioned(
                translate: ZVector.only(y: 35),
                child: ZPuzzleTimerText(),
              ),
              const ZPositioned(
                translate: ZVector.only(y: 75),
                child: ZShareText(
                  key: Key('finishView_shareText'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
