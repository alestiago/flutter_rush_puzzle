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
        children: [
          ZPositioned(
            translate: ZVector.only(x: style.fontSize, y: -15),
            // TODO (alestiago): Same as GameLayoutPerspective.presentation.
            rotate: const ZVector.only(x: -0.25, y: -0.75),
            child: ZGroup(
              children: [
                const ZCubicText(
                  'Rush',
                  style: style,
                ),
                ZPositioned(
                  translate: ZVector.only(
                    y: style.fontSize * 4,
                  ),
                  child: const ZCubicText(
                    'Puzzle',
                    style: style,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
