import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

/// A ZBox that has GestureDetectors for each face
class ZHitBox extends StatelessWidget {
  /// A ZBox that has GestureDetectors for each face
  const ZHitBox({
    Key? key,
    required this.width,
    required this.height,
    required this.depth,
    this.onPanDown,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
  }) : super(key: key);

  /// [width] of the cube
  final double width;

  /// [height] of the cube
  final double height;

  /// [depth] of the cube
  final double depth;

  /// A pointer has contacted the screen with a primary button and might begin
  /// to move.
  final GestureDragDownCallback? onPanDown;

  /// A pointer has contacted the screen with a primary button and has begun to
  /// move.
  final GestureDragStartCallback? onPanStart;

  /// A pointer that is in contact with the screen with a primary button and
  /// moving has moved again.
  final GestureDragUpdateCallback? onPanUpdate;

  /// A pointer that was previously in contact with the screen with a primary
  /// button and moving is no longer in contact with the screen and was moving
  /// at a specific velocity when it stopped contacting the screen.
  final GestureDragEndCallback? onPanEnd;

  /// The pointer that previously triggered [onPanDown] did not complete.
  final GestureDragCancelCallback? onPanCancel;

  @override
  Widget build(BuildContext context) {
    final gestureDetector = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: onPanDown,
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanCancel: onPanCancel,
      onPanEnd: onPanEnd,
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
