import 'package:flutter/material.dart';
import 'package:z_cubic_text/z_cubic_text.dart';
import 'package:zcomponents/zcomponents.dart';

class RushPuzzleIllustration extends StatelessWidget {
  const RushPuzzleIllustration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = ZCubicTextStyle(
      fontSize: 18,
    );

    return LayoutBuilder(builder: (context, constraints) {
      final scale = constraints.biggest.shortestSide / (style.fontSize * 42);

      return ZIllustration(
        zoom: scale,
        children: const [GameTitle()],
      );
    },);
  }
}

class GameTitle extends StatelessWidget {
  const GameTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = ZCubicTextStyle(
      
    );
    return ZPositioned(
      translate: ZVector.only(
        x: style.fontSize / 2,
        y: style.fontSize - layout.tileSize - layout.tileSpace,
        z: layout.tileDepth,
      ),
      child: ZGroup(
        children: [
          const ZCubicText(
            'Rush',
          ),
          ZPositioned(
            translate: ZVector.only(
              y: style.fontSize * 4,
            ),
            child: const ZCubicText(
              'Puzzle',
            ),
          ),
        ],
      ),
    );
  }
}

class PlayText extends StatelessWidget {
  const PlayText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = ZCubicTextStyle(
      color: Colors.yellow[600]!,
    );
    return ZPositioned(
      translate: ZVector.only(
        x: style.fontSize / 2,
        y: -style.fontSize,
        z: layout.tileDepth,
      ),
      child: ZGroup(
        children: [
          ZCubicText(
            'Play',
            style: style,
          ),
        ],
      ),
    );
  }
}
