/// Copyright (c) 2020-2022, creativecreatorormaybenot
///
import 'dart:math';

import 'package:fireworks/src/foundation/object.dart';
import 'package:fireworks/src/foundation/particle.dart';

/// The part of a firework that handles the launch path.
///
/// The actual explosion is handled using [FireworkParticle]s.
///
/// Inspired by https://codepen.io/whqet/pen/Auzch.
class FireworkRocket extends FireworkObjectWithTrail {
  FireworkRocket({
    required Random random,
    required this.start,
    required this.target,
    required this.hue,
    required double size,
  })  : targetDistance = target.distanceTo(start),
        angle = atan2(target.y - start.y, target.x - start.x),
        brightness = .5 + random.nextDouble() * .2,
        super(
          trailCount: 2,
          position: start,
          random: random,
          size: size,
        );

  final Point<double> start;
  final Point<double> target;

  final double angle;
  final double targetDistance;
  double distanceTraveled = 0;

  double velocity = 1;
  final double acceleration = 1.025;

  final double hue;
  final double brightness;

  @override
  void update() {
    super.update();

    velocity *= acceleration;

    // In this case, using Offset would actually be nicer because it is counter
    // intuitive that the velocity vector is a point..
    final vp = Point(cos(angle) * velocity, sin(angle) * velocity);
    distanceTraveled = (position + vp).distanceTo(start);

    if (distanceTraveled < targetDistance) {
      position += vp;
    }
  }
}
