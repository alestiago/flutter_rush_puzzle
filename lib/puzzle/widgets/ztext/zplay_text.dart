import 'package:flutter/material.dart';

import 'package:z_cubic_text/z_cubic_text.dart';
import 'package:zcomponents/zcomponents.dart';


class ZPlayText extends StatelessWidget {
  const ZPlayText({Key? key}) : super(key: key);

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
