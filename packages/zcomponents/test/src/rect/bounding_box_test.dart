// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zcomponents/zcomponents.dart';

void main() {
  group('BoundingBox', () {
    test('creates correct boundaries', () async {
      final box = BoundingBox(Offset.zero, const Offset(100, 200));
      expect(box.rect, const Rect.fromLTWH(0, 0, 100, 200));
      expect(box.width, 100);
      expect(box.height, 200);
      expect(box.size, const Size(100, 200));
      expect(box.center, const Offset(50, 100));
      expect(box.minPosition, Offset.zero);
      expect(box.maxPosition, const Offset(100, 200));
    });

    test('BoundingBox.fromLTWH creates correct boundaries', () async {
      final box = BoundingBox.fromLTWH(0, 0, 100, 200);
      expect(box.rect, const Rect.fromLTWH(0, 0, 100, 200));
    });

    test('contains returns correctly', () async {
      final box = BoundingBox(Offset.zero, const Offset(100, 100));

      final rects = [
        // Top left
        BoundingBox.fromLTWH(0, 0, 10, 10),

        /// Top right
        BoundingBox.fromLTWH(100 - 10, 0, 10, 10),

        // bottom left
        BoundingBox.fromLTWH(0, 100 - 10, 10, 10),

        /// bottom right
        BoundingBox.fromLTWH(100 - 10, 100 - 10, 10, 10),

        /// center
        BoundingBox.fromLTWH(45, 45, 10, 10),

        /// full
        BoundingBox.fromLTWH(0, 0, 100, 100),
      ];

      for (final rect in rects) {
        expect(
          box.contains(rect),
          isTrue,
          reason: '$rect should be inside bounding box',
        );
      }
    });

    test('contains is false if it is not contained', () async {
      final box = BoundingBox(Offset.zero, const Offset(100, 100));

      final rects = [
        // Top left
        BoundingBox.fromLTWH(-1, 0, 10, 10),
        BoundingBox.fromLTWH(0, -1, 10, 10),

        /// Top right
        BoundingBox.fromLTWH(100 - 9, 0, 10, 10),
        BoundingBox.fromLTWH(100 - 10, -1, 10, 10),

        // bottom left
        BoundingBox.fromLTWH(-1, 100 - 10, 10, 10),
        BoundingBox.fromLTWH(0, 100 - 9, 10, 10),

        /// bottom right
        BoundingBox.fromLTWH(100 - 9, 100 - 10, 10, 10),
        BoundingBox.fromLTWH(100 - 10, 100 - 9, 10, 10),

        /// overflow
        BoundingBox.fromLTWH(-1, -1, 102, 102),
      ];

      for (final rect in rects) {
        expect(
          box.contains(rect),
          isFalse,
          reason: '$rect should not be inside bounding box',
        );
      }
    });

    test('fitsInside if box is bigger', () async {
      final box = BoundingBox.fromLTWH(0, 0, 200, 200);
      expect(box.fitsInside(BoundingBox.fromLTWH(100, 100, 300, 300)), isTrue);
    });

    test('fitsInside if box is the same size', () async {
      final box = BoundingBox.fromLTWH(0, 0, 200, 200);
      expect(box.fitsInside(BoundingBox.fromLTWH(100, 100, 200, 200)), isTrue);
    });

    test('does not fitsInside if box is smaller', () async {
      final box = BoundingBox.fromLTWH(0, 0, 200, 200);
      expect(box.fitsInside(BoundingBox.fromLTWH(100, 100, 100, 100)), isFalse);
    });

    test('clams correctly', () async {
      final box = BoundingBox(Offset.zero, const Offset(100, 100));
      final topLeft = BoundingBox.fromLTWH(0, 0, 10, 10);
      final topRight = BoundingBox.fromLTWH(100 - 10, 0, 10, 10);
      final bottomLeft = BoundingBox.fromLTWH(0, 100 - 10, 10, 10);
      final bottomRight = BoundingBox.fromLTWH(100 - 10, 100 - 10, 10, 10);
      final rects = {
        // Top left
        topLeft.translate(Offset(-20, 0)): topLeft,
        topLeft.translate(Offset(0, -20)): topLeft,

        /// Top right
        topRight.translate(Offset(20, 0)): topRight,
        topRight.translate(Offset(0, -20)): topRight,

        // bottom left
        bottomLeft.translate(Offset(-20, 0)): bottomLeft,
        bottomLeft.translate(Offset(0, 20)): bottomLeft,

        /// bottom right
        bottomRight.translate(Offset(20, 0)): bottomRight,
        bottomRight.translate(Offset(0, 20)): bottomRight,
      };

      for (final entry in rects.entries) {
        final rect = entry.key;
        final clampedRect = entry.value;
        expect(
          rect.clampInside(box),
          clampedRect,
          reason: '$rect should be clamped to $clampedRect',
        );
      }
    });

    test('translates correctly', () async {
      final box = BoundingBox(Offset.zero, const Offset(100, 200))
          .translate(const Offset(10, 10));
      expect(box.minPosition, const Offset(10, 10));
      expect(box.maxPosition, const Offset(110, 210));
    });
  });
}
