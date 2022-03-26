import 'package:flutter/material.dart';
import 'package:zcomponents/zcomponents.dart';

/// As opposed to `children.whereType<T>().first` this method returns [null]
/// instead of a [StateError] when no matching children are found.
class ZArrow extends StatelessWidget {
  const ZArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const length = zTileSize * 1.5;
    const pointiness = zTileSize / 2;
    const width = zTileSize / 2;
    const stroke = 5.0;

    // TODO(alestiago): Transform this correctly.
    return ZPositioned(
      translate: ZVector(
        (layout.boundary.center.dx * 2) + (layout.boardPadding / 2),
        (layout.boundary.center.dy / 2) +
            zTileSize +
            (layout.boardPadding / 2) -
            stroke,
        10,
      ),
      child: ZShape(
        stroke: stroke,
        color: Colors.yellow[600]!,
        path: [
          ZMove(0, 0, 0),
          ZLine(length, 0, 0),
          ZMove(length - pointiness, -width, 0),
          ZLine(length, 0, 0),
          ZMove(length - pointiness, width, 0),
          ZLine(length, 0, 0),
        ],
      ),
    );
  }
}
