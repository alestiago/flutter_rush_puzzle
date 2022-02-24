import 'package:equatable/equatable.dart';
import 'package:puzzle_models/puzzle_models.dart';

/// {@template vehicle}
/// Representation of a [RushPuzzle] vehicle.
///
/// [Vehicle] can have variable length, but the width is assumed to be one.
/// The orientation of the vehicle is fixed and determined by [Steering].
/// {@endtemplate}
class Vehicle extends Equatable {
  /// {@macro vehicle}
  Vehicle({
    required this.id,
    required this.length,
    required this.steering,
    required this.firstPosition,
  })  : assert(
          length > 0,
          'Vehicle length must be greater than 0.',
        ),
        lastPosition = firstPosition +
            (steering == Steering.horizonal
                ? Position(length - 1, 0)
                : Position(0, length - 1));

  /// Unique identifier for this vehicle.
  final String id;

  /// The length of the vehicle.
  ///
  /// The width of the vehicle is assumed to be one.
  final int length;

  /// Indicates the direction that the vehicle can steer.
  final Steering steering;

  /// The current 2d [Position] of the [Vehicle]'s back.
  ///
  /// The [Position] is relative to the [RushPuzzle] grid.
  final Position firstPosition;

  /// The current 2d [Position] of the [Vehicle]'s front.
  ///
  /// The [Position] is relative to the [RushPuzzle] grid.
  final Position lastPosition;

  /// Computes from which [Position] to which [Position] the vehicle can move.
  DrivingBoundary drivingBoundary(RushPuzzle puzzle) {
    Position from, to;
    late final Position movement;

    switch (steering) {
      case Steering.horizonal:
        assert(
          firstPosition.y == lastPosition.y,
          'Vehicle must be horizontal.',
        );
        from = Position(0, firstPosition.y);
        to = Position(puzzle.dimension.y, firstPosition.y);
        movement = const Position(1, 0);
        break;
      case Steering.vertical:
        assert(firstPosition.x == lastPosition.x, 'Vehicle must be vertical.');
        from = Position(firstPosition.x, 0);
        to = Position(firstPosition.x, puzzle.dimension.x);
        movement = const Position(0, 1);
        break;
    }

    for (final vehicle in puzzle.vehicles) {
      if (vehicle == this) continue;

      for (final position in vehicle.positions) {
        if (position <= firstPosition && position >= from) {
          from = position + movement;
        }
        if (position >= lastPosition && position <= to) {
          to = position - movement;
        }
      }
    }

    return DrivingBoundary(from, to);
  }

  /// Moves the [Vehicle] to the given [Position].
  RushPuzzle driveTo(RushPuzzle puzzle, Position to) {
    assert(puzzle.vehicles.contains(this), 'Vehicle must be in the puzzle.');
    assert(
      drivingBoundary(puzzle).bounds().contains(to),
      'Vehicle cannot move to the specified position.',
    );
    if (firstPosition == to) return puzzle;

    final vehicle = Vehicle(
      id: id,
      length: length,
      steering: steering,
      firstPosition: to,
    );

    return puzzle.copyWith(vehicles: puzzle.vehicles.replace(vehicle));
  }

  /// The [Position]s that the vehicle occupies.
  ///
  /// If you only require the first or last elements use [firstPosition] or
  /// [lastPosition].
  List<Position> get positions {
    final positions = <Position>[];
    for (var i = 0; i < length; i++) {
      positions.add(
        firstPosition +
            (steering == Steering.horizonal ? Position(i, 0) : Position(0, i)),
      );
    }
    return positions;
  }

  @override
  List<Object?> get props => [
        id,
        length,
        steering,
        firstPosition,
        lastPosition,
      ];
}

extension on List<Vehicle> {
  List<Vehicle> replace(Vehicle vehicle) {
    final replacedVehicle = firstWhere((v) => v.id == vehicle.id);
    final index = indexOf(replacedVehicle);
    if (index != -1) this[index] = vehicle;

    return this;
  }
}
