import 'package:flutter/material.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:zcomponents/zcomponents.dart';

/// Layout properties for the game
class GameLayout {
  /// Layout properties for the game
  GameLayout({
    required this.tileSize,
    required this.tileSpace,
    this.tileCount = 6,
  });

  /// Size of a tile
  final double tileSize;

  /// Depth of a tile
  final tileDepth = 8.0;

  /// Space between tiles
  final double tileSpace;

  /// Space that occupies a tile and the following space
  late final double tileStride = tileSize + tileSpace;

  /// Number of tiles for a given axis
  /// It is implicit that it is squared and there are the same amount of tiles
  /// in the horizontal and vertical axis
  final int tileCount;

  /// Size of the board borders
  final boardBorder = 5.0;

  /// Padding between the board border and the tils
  late final boardPadding = 2.5 * tileSpace;

  /// Depth of a tile
  final boardDepth = 15.0;

  /// Total size of the board with tiles and the external borders
  late final boardSize = size + boardPadding * 2 + boardBorder * 2;

  /// Total size of the game constraints
  late final size = tileSizeForLength(tileCount);

  /// Board bounding box
  late final BoundingBox boundary = BoundingBox(
    Offset.zero,
    Offset(size, size),
  );

  /// Returns the real offset for a relative position
  Offset offsetForPosition(Position offset) {
    return Offset(offset.x * tileStride, offset.y * tileStride);
  }

  /// Returns the real offset for a relative position
  Position positionForOffset(Offset offset) {
    return Position(
      (offset.dx / tileStride).round(),
      (offset.dy / tileStride).round(),
    );
  }

  /// Returns the size of a tile with a given length
  double tileSizeForLength(int length) {
    return length * tileStride - tileSpace;
  }

  /// Returns the size of the tile and the next space for a given length
  double tileStrideForLength(int length) {
    return length * tileStride;
  }

  /// Returns offset of the board top left from a center point origin
  late final ZVector boardTopLeft = () {
    final halfLength = tileCount / 2;
    final size = halfLength * tileSize + tileSpace * (halfLength - 0.5);
    return ZVector(-size, -size, 0);
  }();

  /// Generates a boundary box for a vehicle
  BoundingBox boxForVehicle(Vehicle vehicle) {
    return boxFor(vehicle.firstPosition, vehicle.length, vehicle.steering);
  }

  /// Generates a boundary box for a given offest, length and steering
  BoundingBox boxFor(Position minPosition, int length, Steering steering) {
    final maxPosition = steering == Steering.horizontal
        ? Position(minPosition.x + length - 1, minPosition.y)
        : Position(minPosition.x, minPosition.y + length - 1);
    return boxForDrivingBoundary(DrivingBoundary(minPosition, maxPosition));
  }

  /// Generates a boundary box for a driving boundary
  BoundingBox boxForDrivingBoundary(DrivingBoundary bounds) {
    final minPosition = offsetForPosition(bounds.from);
    final maxPosition =
        offsetForPosition(bounds.to) + Offset(tileSize, tileSize);
    return BoundingBox(minPosition, maxPosition);
  }

  /// Tolerance while drag and drop
  late final Tolerance tolerance = _kDefaultTolerance;

  static late final Tolerance _kDefaultTolerance = Tolerance(
    velocity: 1.0 /
        (0.050 *
            WidgetsBinding.instance!.window
                .devicePixelRatio), // logical pixels per second
    distance: 1.0 /
        WidgetsBinding.instance!.window.devicePixelRatio, // logical pixels
  );
}
