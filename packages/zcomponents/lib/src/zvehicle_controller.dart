import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zcomponents/zcomponents.dart';
import 'package:zflutter/zflutter.dart';

class TileOffset {
  const TileOffset(this.dx, this.dy);

  final int dx;
  final int dy;
}

class ZVehicleController extends StatefulWidget {
  const ZVehicleController({
    Key? key,
    required this.length,
    this.axis = Axis.horizontal,
    this.offset = const TileOffset(0, 0),
    required this.child,
  }) : super(key: key);

  final int length;
  final Axis axis;

  final TileOffset offset;

  final Widget child;

  @override
  State<ZVehicleController> createState() => _ZVehicleControllerState();
}

class _ZVehicleControllerState extends State<ZVehicleController> {
  final size = 30.0;

  final space = 10.0;

  bool dragging = false;

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      translate: _translateMatrix(
            widget.offset,
            size,
            space,
            widget.length,
            widget.axis,
          ) +
          const ZVector(0, 0, 18),
      child: ZGroup(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: dragging ? 10 : 0),
            duration: const Duration(milliseconds: 200),
            builder: (context, value, child) {
              return ZPositioned(
                translate: ZVector(0, 0, value),
                child: child!,
              );
            },
            child: widget.child,
          ),
          ZBoxGestureDetector(
            width: _getWidth() + 4,
            height: size + 4,
            depth: size + 4,
            onPointerDown: (details) {
              setState(() {
                dragging = true;
              });
            },
            onPointerUp: (details) {
              setState(() {
                dragging = false;
              });
            },
            onPointerCancel: (details) {
              setState(() {
                dragging = false;
              });
            },
          ),
        ],
      ),
    );
  }

  double _getWidth() {
    return widget.length * size + space * (widget.length - 1);
  }

  ZVector _translateMatrix(
    TileOffset offset,
    double size,
    double space,
    int vehicleLength,
    Axis axis, [
    int tileLength = 6,
  ]) {
    final halfLength = tileLength / 2;
    final boardStart = ZVector(
      (halfLength - 0.5) * size + space * (halfLength - 0.5),
      (halfLength - 0.5) * size + space * (halfLength - 0.5),
      0,
    ).multiplyScalar(-1);
    final relativePosition = ZVector(
      offset.dx * size + space * (offset.dx),
      offset.dy * size + space * (offset.dy),
      0,
    );

    final ZVector vehicleOffset;
    final vehicleRealLength =
        (vehicleLength - 1) * size / 2 + space * (vehicleLength - 1) / 2;

    if (axis == Axis.horizontal) {
      vehicleOffset = ZVector(vehicleRealLength, 0, 0);
    } else {
      vehicleOffset = ZVector(0, vehicleRealLength, 0);
    }
    return boardStart + relativePosition + vehicleOffset;
  }
}

class ZBoxGestureDetector extends StatelessWidget {
  const ZBoxGestureDetector({
    Key? key,
    required this.width,
    required this.height,
    required this.depth,
    this.onPointerDown,
    this.onPointerMove,
    this.onPointerUp,
    this.onPointerHover,
    this.onPointerCancel,
  }) : super(key: key);

  final double width;
  final double height;
  final double depth;

  /// Called when a pointer comes into contact with the screen (for touch
  /// pointers), or has its button pressed (for mouse pointers) at this widget's
  /// location.
  final PointerDownEventListener? onPointerDown;

  /// Called when a pointer that triggered an [onPointerDown] changes position.
  final PointerMoveEventListener? onPointerMove;

  /// Called when a pointer that triggered an [onPointerDown] is no longer in
  /// contact with the screen.
  final PointerUpEventListener? onPointerUp;

  /// Called when a pointer that has not triggered an [onPointerDown] changes
  /// position.
  ///
  /// This is only fired for pointers which report their location when not down
  /// (e.g. mouse pointers, but not most touch pointers).
  final PointerHoverEventListener? onPointerHover;

  /// Called when the input from a pointer that triggered an [onPointerDown] is
  /// no longer directed towards this receiver.
  final PointerCancelEventListener? onPointerCancel;



  @override
  Widget build(BuildContext context) {
    final gestureDetector = Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: onPointerDown,
      onPointerMove: onPointerMove,
      onPointerUp: onPointerUp,
      onPointerCancel: onPointerCancel,
      onPointerHover: onPointerHover,
    );
    return ZBoxToBoxAdapter(
      width: width,
      height: height,
      depth: depth,
      color: Colors.transparent,
      front: gestureDetector,
      top: gestureDetector,
      left: gestureDetector,
      right: gestureDetector,
      bottom: gestureDetector,
      rear: gestureDetector,
    );
  }
}
