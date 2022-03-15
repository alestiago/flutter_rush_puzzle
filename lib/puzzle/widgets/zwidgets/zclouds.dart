import 'package:flutter/material.dart';
import 'package:zclouds/zclouds.dart';

import 'package:zcomponents/zcomponents.dart';

class ZClouds extends StatelessWidget {
  const ZClouds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cloudStyle = ZCloudStyle(
      frontColor: Colors.grey[200],
      sideColor: Colors.grey[100],
    );
    const cloudType = ZCloudType.cumulus;

    return ZIllustration(
      children: [
        ZPositioned(
          scale: const ZVector.all(2),
          translate: const ZVector(-400, -250, -100),
          child: ZAnimatedPositioned.position(
            position: GameLayoutPerspective.presentation.position,
            duration: const Duration(milliseconds: 400),
            child: ZCloud(
              style: cloudStyle.copyWith(opacity: 0.6),
              type: cloudType,
            ),
          ),
        ),
        ZPositioned(
          scale: const ZVector.all(2.5),
          translate: const ZVector(600, -50, -100),
          child: ZAnimatedPositioned.position(
            position: GameLayoutPerspective.presentation.position,
            duration: const Duration(milliseconds: 400),
            child: ZCloud(
              style: cloudStyle.copyWith(opacity: 0.8),
              type: cloudType,
            ),
          ),
        ),
        ZPositioned(
          scale: const ZVector.all(1.75),
          translate: const ZVector(300, -350, -100),
          child: ZAnimatedPositioned.position(
            position: GameLayoutPerspective.presentation.position,
            duration: const Duration(milliseconds: 400),
            child: ZCloud(
              style: cloudStyle.copyWith(opacity: 0.5),
              type: cloudType,
            ),
          ),
        ),
      ],
    );
  }
}
