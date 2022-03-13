import 'package:flutter/material.dart';
import 'package:z_cubic_text/z_cubic_text.dart';
import 'package:zcomponents/zcomponents.dart';

class GameTitle extends StatelessWidget {
  const GameTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = ZCubicTextStyle(
      letterSpacing: 10,
      frontColor: Colors.grey[900],
    );
    return ZPositioned(
      translate: ZVector.only(
        x: -1,
        y: style.fontSize - layout.tileSize,
        z: layout.tileDepth,
      ),
      child: ZGroup(
        children: [
          ZCubicText('Rush', style: style),
          ZPositioned(
            translate: ZVector.only(
              y: style.fontSize * 4,
            ),
            child: ZCubicText('Puzzle', style: style),
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
      color: Colors.yellow[700]!,
      frontColor: Colors.yellow[600],
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

class WonText extends StatelessWidget {
  const WonText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = ZCubicTextStyle(
      letterSpacing: 10,
      frontColor: Colors.grey[900],
    );
    return ZPositioned(
      translate: ZVector.only(
        x: -1,
        y: style.fontSize - layout.tileSize,
        z: layout.tileDepth,
      ),
      child: ZGroup(
        children: [
          ZCubicText('YOU', style: style),
          ZPositioned(
            translate: ZVector.only(
              y: style.fontSize * 4,
            ),
            child: ZCubicText('Won!', style: style),
          ),
        ],
      ),
    );
  }
}

class ShareText extends StatelessWidget {
  const ShareText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = ZCubicTextStyle(
      letterSpacing: 6,
      fontSize: 6,
      color: Colors.yellow[700]!,
      frontColor: Colors.yellow[600],
    );
    return ZPositioned(
      translate: ZVector.only(
        x: -0.5,
        z: layout.tileDepth,
      ),
      child: ZGroup(
        children: [
          ZCubicText(
            '-SHARE-',
            style: style,
          ),
        ],
      ),
    );
  }
}
