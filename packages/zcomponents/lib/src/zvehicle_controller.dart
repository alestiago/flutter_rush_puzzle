// ignore_for_file: public_member_api_docs, cast_nullable_to_non_nullable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as v_math;
import 'package:zcomponents/zcomponents.dart';

class ZVehicleController extends StatefulWidget {
  const ZVehicleController({
    Key? key,
    required this.length,
    required this.axis,
    required this.offset,
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
  bool dragging = false;

  List<ZTransform> transforms = [];

  late BoundingBox _boundingBox = game.boxFor(
    widget.offset,
    widget.length,
    widget.axis,
  );

  BoundingBox? _draggingBox;

  Matrix4 matrix = Matrix4.translationValues(0, 0, 0);

  Offset dragStartOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ZPositioned(
          translate: game.board.vMinPosition,
          child: ZCircle(diameter: 4, color: Colors.red),
        ),
        ZPositioned(
          translate: game.board.vMaxPosition,
          child: ZCircle(diameter: 4, color: Colors.red),
        ),
        ZPositioned(
          translate: _boundingBox.vMinPosition,
          child: ZCircle(diameter: 4, color: Colors.blue),
        ),
        ZPositioned(
          translate: _boundingBox.vMaxPosition,
          child: ZCircle(diameter: 4, color: Colors.green),
        ),
        ZTrackPosition(
          onTransform: (transforms) {
            this.transforms = transforms;
          },
          child: TweenAnimationBuilder<ZVector>(
            tween: ZVectorTween(
              begin: _boundingBox.vCenter,
              end: dragging
                  ? (_draggingBox?.vCenter ?? ZVector.zero)
                  : _boundingBox.vCenter,
            ),
            duration:
                dragging ? Duration.zero : const Duration(milliseconds: 100),
            builder: (context, value, child) {
              return ZPositioned(
                translate: value,
                rotate: widget.axis == Axis.horizontal
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
                    child: widget.child,
                  ),
                  ZBoxGestureDetector(
                    width: game.tileSizeForLength(widget.length) + 4,
                    height: game.tileSize + 4,
                    depth: game.tileSize + 4,
                    onPanDown: (details) {
                      setState(() {
                        matrix = ZUtils.matrixFromTransformations(transforms)
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
                        if (widget.axis == Axis.horizontal) {
                          realOffset = Offset(projectedOffset, 0);
                        } else {
                          realOffset = Offset(0, -projectedOffset);
                        }
                        _draggingBox = _boundingBox.translate(realOffset).clamp(
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
                      setState(() {
                        dragging = false;
                        _boundingBox =
                            game.round(_draggingBox!, projectedVelocity);
                        _draggingBox = null;
                      });
                    },
                    onPanCancel: () {
                      setState(() {
                        dragging = false;
                        _boundingBox = game.round(_draggingBox!, 0);
                        _draggingBox = null;
                      });
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
}

class ZTrackPosition extends ZPositioned {
  ZTrackPosition({
    Key? key,
    this.onTransform,
    required Widget child,
  }) : super(key: key, child: child);

  final void Function(List<ZTransform>)? onTransform;
  @override
  void updateParentData(
    RenderObject renderObject,
    ZPositioned oldWidget,
    ZTransform transform,
  ) {
    super.updateParentData(renderObject, oldWidget, transform);
    final parentData = renderObject.parentData as ZParentData;
    onTransform?.call(parentData.transforms.toList());
  }

  @override
  Type get debugTypicalAncestorWidgetClass => ZWidget;

  @override
  void startParentData(RenderObject renderObject, ZTransform transform) {
    assert(
      renderObject.parentData is ZParentData,
      'ZTrackPosition should only be used with ZWidgets',
    );
    final parentData = renderObject.parentData as ZParentData;
    onTransform?.call(parentData.transforms.toList());
  }
}

class ZVectorTween extends Tween<ZVector> {
  ZVectorTween({
    ZVector? begin,
    ZVector? end,
  }) : super(begin: begin, end: end);

  @override
  ZVector lerp(double t) {
    return ZVector.lerp(begin, end, t);
  }
}
