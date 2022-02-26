/// Copyright (c) 2020-2022, creativecreatorormaybenot

import 'dart:math';

import 'package:flutter/foundation.dart';

/// Abstract class for firework objects that store information about their
/// trail.
///
/// This also acts as an abstract base class for all firework objects in
/// general, i.e. the [update] function.
abstract class FireworkObjectWithTrail {
  FireworkObjectWithTrail({
    required this.random,
    required this.trailCount,
    required this.position,
    required this.size,
  })  : assert(size >= 0),
        trailPoints = [
          // Fill the trail with the starting position initially.
          for (var i = 0; i < trailCount; i++) position,
        ];

  /// [Random] instance used for generating random numbers in the firework
  /// object.
  final Random random;

  /// The current position of the object.
  Point<double> position;

  /// How many trailing points should be stored.
  final int trailCount;

  final List<Point<double>> trailPoints;

  /// The particle size in logical pixels.
  ///
  /// This size will be used for the stroke width.
  final double size;

  /// Updates the state of the object.
  @mustCallSuper
  void update() {
    trailPoints.removeLast();
    trailPoints.insert(0, position);
  }
}
