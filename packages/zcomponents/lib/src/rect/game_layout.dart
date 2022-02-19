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

  /// Number of tiles for a given axis
  /// It is implicit that it is squared and there are the same amount of tiles
  /// in the horizontal and vertical axis
  final int tileCount;

  /// Size of the board borders
  final boardBorder = 5.0;

  /// Padding between the board border and the tils
  late final boardPadding = 2 * tileSpace;

  /// Depth of a tile
  final boardDepth = 20.0;

  /// Returns the real offset for a relative position
  Offset getPoint(Position offset) {
    return Offset(
      offset.x * tileSize + tileSpace * offset.x,
      offset.y * tileSize + tileSpace * offset.y,
    );
  }

  /// Total size of the game constraints
  late final size = tileSizeForLength(tileCount);

  /// Total size of the board with tiles and the external borders
  late final boardSize = size + boardPadding * 2 + boardBorder * 2;

  /// Returns the size of a tile with a given length
  double tileSizeForLength(int length) {
    return length * tileSize + (length - 1) * tileSpace;
  }

  /// Returns the size of the tile and the next space for a given length
  double tileStride(int length) {
    return length * (tileSize + tileSpace);
  }

  /// Board bounding box
  late final BoundingBox board = BoundingBox(Offset.zero, Offset(size, size));

  /// Returns offset of the board top left from a center point origin
  late final ZVector boardTopLeft = () {
    final halfLength = tileCount / 2;
    final size = halfLength * tileSize + tileSpace * (halfLength - 0.5);
    return ZVector(size, size, 0).multiplyScalar(-1);
  }();

  BoundingBox boxFor(Position offset, int length, Steering steering) {
    final minPosition = getPoint(offset);
    final maxPosition = steering == Steering.horizonal
        ? Offset(
            minPosition.dx + tileSizeForLength(length),
            minPosition.dy + tileSizeForLength(1),
          )
        : Offset(
            minPosition.dx + tileSizeForLength(1),
            minPosition.dy + tileSizeForLength(length),
          );
    return BoundingBox(minPosition, maxPosition);
  }

  BoundingBox boxForVehicle(Vehicle vehicle) {
    return boxFor(vehicle.firstPosition, vehicle.length, vehicle.steering);
  }

  late List<double> offsets = [
    for (final tile in List.generate(tileCount, (i) => i)) tileStride(tile)
  ];

  final Tolerance tolerance = _kDefaultTolerance;

  static final Tolerance _kDefaultTolerance = Tolerance(
    velocity: 1.0 /
        (0.050 *
            WidgetsBinding.instance!.window
                .devicePixelRatio), // logical pixels per second
    distance: 1.0 /
        WidgetsBinding.instance!.window.devicePixelRatio, // logical pixels
  );
}
