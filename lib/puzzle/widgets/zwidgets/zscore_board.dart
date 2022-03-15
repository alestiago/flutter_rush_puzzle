import 'package:flutter/material.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:zcomponents/zcomponents.dart';

class ZScoreBoard extends StatelessWidget {
  const ZScoreBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      translate: ZVector(
        -layout.boundary.center.dx,
        -80,
        -layout.boardBorder - layout.boardPadding,
      ),
      child: ZPositioned(
        rotate: const ZVector.only(
          x: -tau / 4,
          y: -tau / 4,
        ),
        child: ZGroup(
          children: [
            ZPositioned(
              translate: ZVector.only(z: -layout.boardBorder / 2),
              child: ZBox(
                height: 60,
                width: 180,
                depth: layout.boardBorder,
                color: Colors.grey[200]!,
                frontColor: Colors.white,
                topColor: Colors.grey[100],
                rearColor: Colors.grey[300],
              ),
            ),
            const ZToBoxAdapter(
              height: 60,
              width: 200,
              child: ScoreBoard(),
            ),
          ],
        ),
      ),
    );
  }
}
