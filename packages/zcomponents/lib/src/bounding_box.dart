import 'package:flutter/rendering.dart';
import 'package:zcomponents/zcomponents.dart';

// TODO(jaime): Remove with Position model class
class TileOffset {
  const TileOffset(this.dx, this.dy);

  final int dx;
  final int dy;
}

/// A 2-dimensional axis-aligned bounding box between a min and a max position.
class BoundingBox {
  /// Creates a bounding box by a given min and  max position.
  BoundingBox(this.minPosition, this.maxPosition);

  /// Creates a bounding box by a given min and  max position.
  factory BoundingBox.fromLTWH(
    double left,
    double top,
    double width,
    double height,
  ) {
    return BoundingBox(Offset(left, top), Offset(left + width, top + height));
  }

  final Offset minPosition;

  final Offset maxPosition;

  late final vMinPosition = ZVector(minPosition.dx, minPosition.dy, 0);

  late final vMaxPosition = ZVector(maxPosition.dx, maxPosition.dy, 0);

  late final width = maxPosition.dx - minPosition.dx;

  late final height = maxPosition.dy - minPosition.dy;

  bool contains(BoundingBox box) {
    return box.minPosition >= minPosition && box.maxPosition <= maxPosition;
  }

  bool fitsInside(BoundingBox bounds) {
    return bounds.width >= width && bounds.height >= height;
  }

  BoundingBox clamp(BoundingBox bounds) {
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

  late final Offset center = minPosition + (maxPosition - minPosition) / 2;

  late final ZVector vCenter = ZVector(center.dx, center.dy, 0);

  BoundingBox translate(Offset offset) {
    return BoundingBox(minPosition + offset, maxPosition + offset);
  }
}
