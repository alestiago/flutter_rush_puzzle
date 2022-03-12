import 'package:flutter/material.dart';
import 'package:z_cubic_text/z_cubic_text.dart';
import 'package:zcomponents/zcomponents.dart';

class GameTitle extends StatelessWidget {
  const GameTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = ZCubicTextStyle(
      letterSpacing: 10,
    );
    return ZPositioned(
      translate: ZVector.only(
        x: -1,
        y: style.fontSize - layout.tileSize,
        z: layout.tileDepth,
      ),
      child: ZGroup(
        children: [
          const ZCubicText('Rush', style: style),
          ZPositioned(
            translate: ZVector.only(
              y: style.fontSize * 4,
            ),
            child: const ZCubicText('Puzzle', style: style),
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
      letterSpacing: 10,
      color: Colors.yellow[600]!,
    );
    return ZPositioned(
      translate: ZVector.only(
        x: -0.5,
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
