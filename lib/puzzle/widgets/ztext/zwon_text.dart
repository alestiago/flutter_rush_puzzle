import 'package:flutter/material.dart';

import 'package:z_cubic_text/z_cubic_text.dart';
import 'package:zcomponents/zcomponents.dart';

class ZWonText extends StatelessWidget {
  const ZWonText({Key? key}) : super(key: key);

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
