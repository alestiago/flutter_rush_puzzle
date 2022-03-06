import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:zflutter/zflutter.dart';

class ZBoundingBox extends ZMultiChildWidget {
  ZBoundingBox({
    required this.width,
    required this.height,
    required this.depth,
    List<Widget> children = const [],
  }) : super(children: children);
  final double width;
  final double height;
  final double depth;

  @override
  RenderZBoundingBox createRenderObject(BuildContext context) {
    return RenderZBoundingBox(
      width: width,
      height: height,
      depth: depth,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderZBoundingBox renderObject,
  ) {
    renderObject
      ..depthBox = depth
      ..width = width
      ..height = height;
  }
}

class RenderZBoundingBox extends RenderMultiChildZBox {
  RenderZBoundingBox({
    double width = 0,
    double height = 0,
    double depth = 0,
    List<RenderZBox>? children,
  })  : _width = width,
        _height = height,
        _depth = depth,
        boundingBox = buildBoundingBox(width, height, depth),
        super(children: children, sortMode: SortMode.update);

  math.Aabb3 boundingBox;
  math.Aabb3 transformedBoundingBox = math.Aabb3();

  static math.Aabb3 buildBoundingBox(
    double width,
    double height,
    double depth,
  ) {
    assert(width == depth || height == depth);
    return math.Aabb3.centerAndHalfExtents(
      math.Vector3.zero(),
      math.Vector3(width / 2, height / 2, depth / 2),
    );
  }

  double _width = 0;
  double get width => _width;
  set width(double value) {
    assert(value >= 0, 'width needs to equal or more than 0');
    if (_width == value) return;
    _width = value;
    boundingBox = buildBoundingBox(width, height, depthBox);
    markNeedsLayout();
  }

  double _height = 0;
  double get height => _height;
  set height(double value) {
    assert(value >= 0, 'height needs to equal or more than 0');
    if (_height == value) return;
    _height = value;
    boundingBox = buildBoundingBox(width, height, depthBox);
    markNeedsLayout();
  }

  double _depth = 1;
  double get depthBox => _depth;
  set depthBox(double value) {
    assert(value >= 0, 'depth needs to equal or more than 0');
    if (_depth == value) return;
    _depth = value;
    boundingBox = buildBoundingBox(width, height, depthBox);
    markNeedsLayout();
  }

  @override
  void performTransformation() {
    boundingBox.transformed(matrix, transformedBoundingBox);
    super.performTransformation();
  }

  @override
  int compareSort(RenderZBox renderBox) {
    if (renderBox is! RenderZBoundingBox) {
      return sortValue.compareTo(renderBox.sortValue);
    }

    if (transformedBoundingBox
        .intersectsWithAabb3(renderBox.transformedBoundingBox)) {
      // IF INTERSECTS SORTING COULD BE WRONG
    }
    return transformedBoundingBox.max.z.compareTo(
      renderBox.transformedBoundingBox.max.z,
    );
  }

  @override
  void debugPaintPointers(PaintingContext context, Offset offset) {
    super.debugPaintPointers(context, offset);
    final c = math.Vector3.zero();
    final min = transformedBoundingBox.min;
    final max = transformedBoundingBox.max;
    final h = math.Vector3.zero();
    transformedBoundingBox.copyCenterAndHalfExtents(c, h);

    final points = [
      math.Vector3.copy(c)..add(h.clone()..multiply(math.Vector3(1, 1, 1))),
      math.Vector3.copy(c)..add(h.clone()..multiply(math.Vector3(-1, 1, 1))),
      math.Vector3.copy(c)..add(h.clone()..multiply(math.Vector3(-1, -1, 1))),
      math.Vector3.copy(c)..add(h.clone()..multiply(math.Vector3(-1, -1, -1))),
      math.Vector3.copy(c)..add(h.clone()..multiply(math.Vector3(1, -1, -1))),
      math.Vector3.copy(c)..add(h.clone()..multiply(math.Vector3(1, 1, -1))),
      math.Vector3.copy(c)..add(h.clone()..multiply(math.Vector3(-1, 1, -1))),
    ];
    context.canvas.drawCircle(
      Offset(c.x, c.y),
      2,
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill,
    );

    context.canvas.drawRect(
      Rect.fromPoints(Offset(min.x, min.y), Offset(max.x, max.y)),
      Paint()
        ..color = Colors.blue.withOpacity(0.5)
        ..style = PaintingStyle.fill,
    );
    for (final point in points) {
      context.canvas.drawCircle(
        Offset(point.x, point.y),
        2,
        Paint()
          ..color = Colors.green
          ..style = PaintingStyle.fill,
      );
    }
  }
}
