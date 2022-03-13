import 'package:flutter/material.dart';

import 'package:zcomponents/zcomponents.dart';

class ZClouds extends StatelessWidget {
  const ZClouds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZIllustration(
      children: [
        ZPositioned(
          scale: ZVector.all(2),
          translate: ZVector(-300, -300, -100),
          child: ZAnimatedPositioned.position(
            position: GameLayoutPerspective.presentation.position,
            duration: Duration(milliseconds: 400),
            child: ZCloud(),
          ),
        ),
        ZPositioned(
          scale: ZVector.all(2),
          translate: ZVector(500, -100, -100),
          child: ZAnimatedPositioned.position(
            position: GameLayoutPerspective.presentation.position,
            duration: Duration(milliseconds: 400),
            child: ZCloud(),
          ),
        ),
        ZPositioned(
          scale: ZVector.all(2),
          translate: ZVector(200, -400, -100),
          child: ZAnimatedPositioned.position(
            position: GameLayoutPerspective.presentation.position,
            duration: Duration(milliseconds: 400),
            child: ZCloud(),
          ),
        ),
      ],
    );
  }
}
