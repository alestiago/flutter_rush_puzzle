/// Copyright (c) 2020-2022, creativecreatorormaybenot

import 'package:fireworks/src/foundation/controller.dart';
import 'package:fireworks/src/rendering/fireworks.dart';
import 'package:flutter/widgets.dart';

class Fireworks extends LeafRenderObjectWidget {
  Fireworks({
    Key? key,
    required this.controller,
  }) : super(key: key);

  /// The controller that manages the fireworks and tells the render box what
  /// and when to paint.
  final FireworkController controller;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderFireworks(
      controller: controller,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderFireworks renderObject) {
    renderObject.controller = controller;
  }
}
