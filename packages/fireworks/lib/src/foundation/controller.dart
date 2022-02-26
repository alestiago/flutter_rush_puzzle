/// Copyright (c) 2020-2022, creativecreatorormaybenot

import 'dart:math';
import 'dart:ui';

import 'package:fireworks/src/foundation/particle.dart';
import 'package:fireworks/src/foundation/rocket.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

/// Class managing a whole firework show.
///
/// [addListener] can be used to get notified about updates (triggered by the
/// ticker created by the given [vsync]).
///
/// It spawns [FireworkRocket]s and creates [FireworkParticle] explosions.
class FireworkController implements Listenable {
  FireworkController({
    required this.vsync,
  })  : rockets = [],
        particles = [],
        _listeners = [],
        _random = Random();

  /// Provider for the ticker that updates the controller.
  final TickerProvider vsync;

  /// The firework rockets that are currently launching.
  final List<FireworkRocket> rockets;

  /// The currently live explosion particles.
  final List<FireworkParticle> particles;

  /// The size of the window the fireworks are flying in.
  ///
  /// This has to be set by the renderer.
  Size windowSize = Size.zero;

  final Random _random;

  /// The hue that is globally used by rockets and particles at a given point
  /// in time.
  ///
  /// We cycle through hues in order to create nice variation.
  ///
  /// Starts at 42.
  double _globalHue = 42;

  late final Ticker _ticker;

  /// Starts the firework show.
  ///
  /// This has to be called before anything else and can only be called
  /// once.
  void start() {
    // We could also allow resyncing, however, this is not needed in the
    // standard use case.
    _ticker = vsync.createTicker(_update)..start();
  }

  final List<VoidCallback> _listeners;

  @override
  void addListener(listener) {
    assert(!_listeners.contains(listener));

    _listeners.add(listener);
  }

  @override
  void removeListener(listener) {
    assert(_listeners.contains(listener));

    _listeners.remove(listener);
  }

  void dispose() {
    _listeners.clear();
    _ticker.dispose();
  }

  Duration _lastAutoLaunch = Duration.zero;

  /// The duration that needs to elapse until a new firework rocket will
  /// automatically launched.
  ///
  /// Launches the rockets at random positions.
  ///
  /// Set this to [Duration.zero] to not launch any rockets automatically.
  Duration autoLaunchDuration = Duration(seconds: 1);

  /// The particle size for both the firework rockets and particles.
  ///
  /// Note that the [particleSize] is used as is for the stroke width of the
  /// particles while the stroke width of the rocket is one less.
  /// Also note that this will be clamped to a minimum of 0.
  double get particleSize => _particleSize;
  double _particleSize = 3.5;

  set particleSize(double value) {
    _particleSize = max(1, value);
  }

  /// The rocket size for the firework rockets.
  ///
  /// This is based on [particleSize], which is why this might seem like
  /// duplication.
  double get _rocketSize => max(0, particleSize - 1);

  FireworkRocket? _rocketToSpawn;
  Duration _lastRocketSpawn = Duration.zero;

  void _update(Duration elapsedDuration) {
    if (windowSize == Size.zero) {
      // We need to wait until we have the size.
      return;
    }

    _globalHue += _random.nextDouble() * 360;
    _globalHue %= 360;

    if (autoLaunchDuration != Duration.zero &&
        elapsedDuration - _lastAutoLaunch >= autoLaunchDuration) {
      _lastAutoLaunch = elapsedDuration;
      rockets.add(FireworkRocket(
        random: _random,
        start: Point(
          32 + _random.nextDouble() * (windowSize.width - 32) - 32,
          windowSize.height * 1.2,
        ),
        target: Point(
          8 + _random.nextDouble() * (windowSize.width - 8) - 8,
          8 + _random.nextDouble() * windowSize.height * 4 / 7,
        ),
        hue: _globalHue,
        size: _rocketSize,
      ));
    }

    if (_rocketToSpawn != null &&
        rocketSpawnTimeout != Duration.zero &&
        elapsedDuration - _lastRocketSpawn >= rocketSpawnTimeout) {
      rockets.add(_rocketToSpawn!);
      _rocketToSpawn = null;
      _lastRocketSpawn = elapsedDuration;
    }

    for (final rocket in rockets) {
      rocket.update();
    }
    for (final particle in particles) {
      particle.update();
    }

    rockets.removeWhere((element) {
      final targetReached = element.distanceTraveled >= element.targetDistance;
      if (!targetReached) return false;

      // We want to create an explosion when a rocket reaches its target.
      _createExplosion(element);
      return targetReached;
    });
    particles.removeWhere((element) => element.alpha <= 0);

    // Notify listeners.
    // The copy of the list and the condition prevent
    // ConcurrentModificationError's, in case a listener removes itself
    // or another listener.
    // See https://stackoverflow.com/q/62417999/6509751.
    for (final listener in List.of(_listeners)) {
      if (!_listeners.contains(listener)) continue;
      listener.call();
    }
  }

  /// The duration that has to elapse before the rocket added by [spawnRocket]
  /// will be spawned.
  ///
  /// Set this to [Duration.zero] if you want to forbid manual spawns.
  Duration rocketSpawnTimeout = Duration(milliseconds: 420);

  /// Launches a new [FireworkRocket] with the given [target].
  ///
  /// At most one rocket per [rocketSpawnTimeout] will be spawned.
  ///
  /// If [forceSpawn] is `true`, the [rocketSpawnTimeout] and related logic will
  /// be ignored and the rocket will be spawned immediately.
  void spawnRocket(Point<double> target, {bool forceSpawn = false}) {
    final rocket = FireworkRocket(
      random: _random,
      start: Point(
        windowSize.width / 2,
        windowSize.height * 1.2,
      ),
      target: target,
      hue: _globalHue,
      size: _rocketSize,
    );

    if (forceSpawn) {
      rockets.add(rocket);
      return;
    }
    _rocketToSpawn = rocket;
  }

  /// How many particles will be spawned when a rocket explodes.
  int explosionParticleCount = 160;

  void _createExplosion(FireworkRocket rocket) {
    for (var i = 0; i < explosionParticleCount; i++) {
      particles.add(FireworkParticle(
        random: _random,
        position: rocket.position,
        hueBaseValue: rocket.hue,
        size: particleSize,
      ));
    }
  }
}
