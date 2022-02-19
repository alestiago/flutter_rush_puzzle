// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:zcomponents/zcomponents.dart';

/// A 2-dimensional axis-aligned bounding box between a min and a max position.
class BoundingBox extends Equatable {
  /// Creates a bounding box by a given min and  max position.
  BoundingBox(Offset minPosition, Offset maxPosition)
      : rect = Rect.fromPoints(minPosition, maxPosition);

  /// Creates a bounding box by a given min and  max position.
  BoundingBox.fromLTWH(
    double left,
    double top,
    double width,
    double height,
  ) : rect = Rect.fromLTWH(left, top, width, height);

  final Rect rect;

  late final Offset minPosition = rect.topLeft;

  late final Offset maxPosition = rect.bottomRight;

  late final double width = rect.width;

  late final double height = rect.height;

  late final Size size = rect.size;

  late final Offset center = rect.center;

  late final ZVector zMinPosition = ZVector(minPosition.dx, minPosition.dy, 0);

  late final ZVector zMaxPosition = ZVector(maxPosition.dx, maxPosition.dy, 0);

  late final ZVector zCenter = ZVector(center.dx, center.dy, 0);

  bool contains(BoundingBox box) {
    return box.minPosition >= minPosition && box.maxPosition <= maxPosition;
  }

  bool fitsInside(BoundingBox bounds) {
    return bounds.width >= width && bounds.height >= height;
  }

  BoundingBox clampInside(BoundingBox bounds) {
    assert(
      fitsInside(bounds),
      'This box needs to be bigger or at least the '
      'same size of the one its being clamped',
    );
    final dx = minPosition.dx.clamp(
      bounds.minPosition.dx,
      bounds.maxPosition.dx - width,
    );
    final dy = minPosition.dy.clamp(
      bounds.minPosition.dy,
      bounds.maxPosition.dy - height,
    );
    final newBox = BoundingBox(
      Offset(dx, dy),
      Offset(dx + width, dy + height),
    );
    assert(bounds.contains(newBox), 'new box is not inside bounds');
    return newBox;
  }

  BoundingBox translate(Offset offset) {
    return BoundingBox(minPosition + offset, maxPosition + offset);
  }

  @override
  List<Object?> get props => [rect];
}
