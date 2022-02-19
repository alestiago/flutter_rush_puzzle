// ignore_for_file: public_member_api_docs, cast_nullable_to_non_nullable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:vector_math/vector_math_64.dart' as v_math;
import 'package:zcomponents/zcomponents.dart';

class ZVehicleController extends StatefulWidget {
  const ZVehicleController({
    Key? key,
    required this.child,
    required this.vehicle,
  }) : super(key: key);

  final Vehicle vehicle;

  final Widget child;

  @override
  State<ZVehicleController> createState() => _ZVehicleControllerState();
}

class _ZVehicleControllerState extends State<ZVehicleController> {
  bool dragging = false;

  List<ZTransform> transforms = [];

  late BoundingBox _boundingBox = game.boxFor(
    widget.vehicle.firstPosition,
    widget.vehicle.length,
    widget.vehicle.steering,
  );

  BoundingBox? _draggingBox;

  Matrix4 matrix = Matrix4.translationValues(0, 0, 0);

  Offset dragStartOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final isDebug = DebugGame.isDebugMode(context);
    final child = isDebug ? ZBoxDebug(box: _boundingBox) : widget.child;
    return ZGroup(
      children: [
        if (isDebug) ZPositionDebug(box: _boundingBox),
        ZPositionTracker(
          onTransform: (transforms) {
            this.transforms = transforms;
          },
          child: TweenAnimationBuilder<ZVector>(
            tween: ZVectorTween(
              begin: _boundingBox.zCenter,
              end: dragging
                  ? (_draggingBox?.zCenter ?? ZVector.zero)
                  : _boundingBox.zCenter,
            ),
            duration:
                dragging ? Duration.zero : const Duration(milliseconds: 100),
            builder: (context, value, child) {
              return ZPositioned(
                translate: value,
                rotate: widget.vehicle.steering == Steering.horizonal
                    ? ZVector.zero
                    : const ZVector(0, 0, pi / 2),
                child: child!,
              );
            },
            child: ZPositioned(
              translate: const ZVector(0, 0, 18),
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
                    child: child,
                  ),
                  ZBoxGestureDetector(
                    width: game.tileSizeForLength(widget.vehicle.length) + 4,
                    height: game.tileSize + 4,
                    depth: game.tileSize + 4,
                    onPanDown: (details) {
                      setState(() {
                        matrix = matrixFromTransformations(transforms)
                          ..invert();
                        dragStartOffset = details.globalPosition;
                        _draggingBox = _boundingBox;
                        dragging = true;
                      });
                    },
                    onPanUpdate: (details) {
                      final offset = details.globalPosition - dragStartOffset;
                      final projectedOffset =
                          v_math.Vector3(offset.dx, offset.dy, 0)
                              .dot(matrix.right);

                      setState(() {
                        Offset realOffset;
                        if (widget.vehicle.steering == Steering.horizonal) {
                          realOffset = Offset(projectedOffset, 0);
                        } else {
                          realOffset = Offset(0, -projectedOffset);
                        }
                        _draggingBox =
                            _boundingBox.translate(realOffset).clampInside(
                                  game.board,
                                );
                      });
                    },
                    onPanEnd: (details) {
                      final velocityOffset = details.velocity.pixelsPerSecond;
                      final projectedVelocity = v_math.Vector3(
                        velocityOffset.dx,
                        velocityOffset.dy,
                        0,
                      ).dot(matrix.right);
                      onDragEnd(projectedVelocity);
                    },
                    onPanCancel: () {
                      onDragEnd(0);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onDragEnd(double velocity) {
    setState(() {
      dragging = false;
      _boundingBox = game.round(_draggingBox!, velocity);
      _draggingBox = null;
    });
  }
}

class ZPositionDebug extends StatelessWidget {
  const ZPositionDebug({Key? key, required this.box}) : super(key: key);

  final BoundingBox box;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ZPositioned(
          translate: box.zMinPosition,
          child: ZCircle(
            diameter: 4,
            color: Colors.blue,
            stroke: 4,
          ),
        ),
        ZPositioned(
          translate: box.zMaxPosition,
          child: ZCircle(
            diameter: 4,
            color: Colors.green,
            stroke: 4,
          ),
        ),
      ],
    );
  }
}

class ZBoxDebug extends StatelessWidget {
  const ZBoxDebug({Key? key, required this.box}) : super(key: key);

  final BoundingBox box;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ZBox(
          width: box.size.longestSide,
          height: box.size.shortestSide,
          depth: size,
          color: Colors.red.withOpacity(0.2),
        ),
      ],
    );
  }
}
