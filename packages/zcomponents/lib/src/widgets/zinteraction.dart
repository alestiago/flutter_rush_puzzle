import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zcomponents/zcomponents.dart';
import 'package:zflutter/zflutter.dart';

class ZInterationController extends ValueNotifier<double> {
  ZInterationController() : super(0);

  ZVector get rotation => ZVector.only(z: value);
}

class ZInteraction extends StatefulWidget {
  const ZInteraction({
    Key? key,
    required this.child,
    this.enabled = true,
  }) : super(key: key);

  final bool enabled;
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
  void didUpdateWidget(covariant ZInteraction oldWidget) {
    if (widget.enabled != oldWidget.enabled) {
      var startPosition = controller.value % tau;
      if (startPosition < 0) startPosition += tau;
      tween
        ..begin = startPosition
        ..end = 0;
      animationController
        ..value = 0
        ..animateTo(1, curve: Curves.easeOut);
      previousDelta = 0;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide;

    return ChangeNotifierProvider.value(
      value: controller,
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onPanStart: (event) {
          if (!widget.enabled) return;
          animationController.stop();
          previousDelta = controller.value;
          dragStart = Offset(event.localPosition.dx, event.localPosition.dy);
        },
        onPanUpdate: (event) {
          if (!widget.enabled) return;
          final delta = event.localPosition - dragStart;
          final moveRY = delta.dx / size * tau;
          controller.value = previousDelta - moveRY;
        },
        onPanEnd: (event) {
          if (!widget.enabled) return;
          var startPosition = controller.value % tau;
          if (startPosition < 0) startPosition += tau;
          final snaps = <double>[
            0,
            pi / 2,
            pi,
            3 * pi / 2,
            2 * pi,
          ];

          var endPosition = snaps.first;
          for (final snap in snaps) {
            if (snap >= startPosition) {
              endPosition = snap;
              break;
            }
          }
          if (event.velocity.pixelsPerSecond.dx > 0) {
            endPosition -= pi / 2;
            assert(
              startPosition >= endPosition,
              'Start position needs to be before or same as endPosition',
            );
          } else if (event.velocity.pixelsPerSecond.dx < 0) {
            //   endPosition += pi / 2;
          }

          tween
            ..begin = startPosition
            ..end = endPosition;
          animationController
            ..value = 0
            ..animateTo(1, curve: Curves.easeOut);
          //..fling(
          //  velocity: event.velocity.pixelsPerSecond.dy,
          //);
        },
        onPanCancel: () {},
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
