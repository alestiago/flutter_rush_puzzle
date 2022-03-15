import 'package:flutter/material.dart';

import 'package:z_cubic_text/z_cubic_text.dart';
import 'package:zcomponents/zcomponents.dart';

class ZShareText extends StatelessWidget {
  const ZShareText({Key? key}) : super(key: key);

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
