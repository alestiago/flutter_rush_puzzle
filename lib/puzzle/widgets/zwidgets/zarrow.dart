import 'package:flutter/material.dart';
import 'package:zcomponents/zcomponents.dart';

/// As opposed to `children.whereType<T>().first` this method returns [null]
/// instead of a [StateError] when no matching children are found.
class ZArrow extends StatelessWidget {
  const ZArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO(alestiago): Define this.
    const length = zTileSize * 1.5;
    const pointiness = zTileSize / 2;
    const width2 = zTileSize / 2;

    // TODO(alestiago): Transform this correctly.
    return ZPositioned(
      translate: ZVector(
        (layout.boundary.center.dx * 2) + (layout.boardPadding / 2),
        (layout.boundary.center.dy / 2) + (layout.boardPadding / 2),
        -layout.boardBorder - layout.boardPadding,
      ),
      child: ZShape(
        stroke: 5,
        color: Colors.yellow[600]!,
        path: [
          ZMove(0, 0, 0),
          ZLine(length, 0, 0),
          ZMove(length - pointiness, -width2, 0),
          ZLine(length, 0, 0),
          ZMove(length - pointiness, width2, 0),
          ZLine(length, 0, 0),
        ],
      ),
    );
  }
}
