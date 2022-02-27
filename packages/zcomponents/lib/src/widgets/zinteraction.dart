import 'dart:math';

import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zcomponents/zcomponents.dart';
import 'package:zflutter/zflutter.dart';

class ZInterationController extends ValueNotifier<double> {
  ZInterationController() : super(0);

  ZVector get rotation => ZVector.only(z: value);
}

class ZInteraction extends StatefulWidget {
  const ZInteraction({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() => _ZInteractionState();
}

class _ZInteractionState extends State<ZInteraction>
    with TickerProviderStateMixin {
  late ZInterationController controller;
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );
  Tween<double> tween = Tween(begin: 0, end: 0);
  Offset dragStart = Offset.zero;
  double previousDelta = 0;

  @override
  void initState() {
    controller = ZInterationController();
    animationController.addListener(() {
      controller.value = tween.evaluate(animationController);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide;
    final width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider.value(
      value: controller,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (event) {
          animationController.stop();
          previousDelta = controller.value;
          dragStart = Offset(event.localPosition.dx, event.localPosition.dy);
        },
        onPanUpdate: (event) {
          final delta = event.localPosition - dragStart;
          final moveRY = delta.dx / size * tau;
          controller.value = previousDelta - moveRY;
        },
        onPanEnd: (event) {
          double startPosition = controller.value % tau;
          if (startPosition < 0) startPosition += tau;
          final snaps = <double>[
            0,
            pi / 2,
            pi,
            3 * pi / 2,
            2 * pi,
          ];

          double endPosition = snaps.first;
          for (final snap in snaps) {
            if (snap >= startPosition) {
              endPosition = snap;
              break;
            }
          }
          if (event.velocity.pixelsPerSecond.dx < 0) {
            endPosition -= pi / 2;
            assert(startPosition >= endPosition);
          }

          tween
            ..begin = startPosition
            ..end = endPosition;
          animationController
            ..value = 0
            ..animateWith(
              ScrollSpringSimulation(
                SpringDescription.withDampingRatio(
                  mass: 0.5,
                  stiffness: 100,
                  ratio: 1.1,
                ),
                0,
                1,
                event.velocity.pixelsPerSecond.dy / size,
                tolerance: _kDefaultTolerance,
              ),
            );
          //..fling(
          //  velocity: event.velocity.pixelsPerSecond.dy,
          //);
        },
        onPanCancel: () {
          tween
            ..begin = controller.value
            ..end = 0;
          animationController
            ..value = 0
            ..fling(velocity: 0);
        },
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class ZInterationPositioned extends StatelessWidget {
  const ZInterationPositioned({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final rotation = context.select((ZInterationController controller) {
      return controller.rotation;
    });
    return ZPositioned(
      rotate: rotation,
      child: child,
    );
  }
}

late final Tolerance _kDefaultTolerance = Tolerance(
  // TODO(ianh): Handle the case of the device pixel ratio changing.
  // TODO(ianh): Get this from the local MediaQuery not dart:ui's window object.
  velocity: 1.0 /
      (0.050 *
          WidgetsBinding
              .instance!.window.devicePixelRatio), // logical pixels per second
  distance:
      1.0 / WidgetsBinding.instance!.window.devicePixelRatio, // logical pixels
);
