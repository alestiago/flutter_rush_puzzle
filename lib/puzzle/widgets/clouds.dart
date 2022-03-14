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
          translate: ZVector(-400, -250, -100),
          child: ZAnimatedPositioned.position(
            position: GameLayoutPerspective.presentation.position,
            duration: Duration(milliseconds: 400),
            child: ZCloud(
               opacity: 0.6,
            ),
          ),
        ),
        ZPositioned(
          scale: ZVector.all(2.5),
          translate: ZVector(600, -50, -100),
          child: ZAnimatedPositioned.position(
            position: GameLayoutPerspective.presentation.position,
            duration: Duration(milliseconds: 400),
            child: ZCloud(
              opacity: 0.8,
            ),
          ),
        ),
        ZPositioned(
          scale: ZVector.all(1.75),
          translate: ZVector(300, -350, -100),
          child: ZAnimatedPositioned.position(
            position: GameLayoutPerspective.presentation.position,
            duration: Duration(milliseconds: 400),
            child: ZCloud(
              opacity: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
