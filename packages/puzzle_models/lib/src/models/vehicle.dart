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
    required this.steering,
    required this.firstPosition,
    required this.type,
  })  : length = type.length,
        assert(
          type.length > 1,
          'Vehicle length must be greater than 1.',
        ),
        lastPosition = firstPosition +
            (steering == Steering.horizontal
                ? Position(type.length - 1, 0)
                : Position(0, type.length - 1));

  /// Unique identifier for this vehicle.
  final String id;

  /// {@macro vehicle_type}
  final VehicleType type;

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
      case Steering.horizontal:
        assert(
          firstPosition.y == lastPosition.y,
          'Vehicle must be horizontal.',
        );
        from = Position(0, firstPosition.y);
        to = Position(RushPuzzle.dimension.x, firstPosition.y);
        movement = const Position(1, 0);
        break;
      case Steering.vertical:
        assert(firstPosition.x == lastPosition.x, 'Vehicle must be vertical.');
        from = Position(firstPosition.x, 0);
        to = Position(firstPosition.x, RushPuzzle.dimension.y);
        movement = const Position(0, 1);
        break;
    }

    for (final vehicle in puzzle.vehicles.values) {
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

    if (id == puzzle.jammedVehicleId && to + movement == RushPuzzle.exit) {
      to += movement * length;
    }

    return DrivingBoundary(from, to);
  }

  /// Moves the [Vehicle] to the given [Position].
  RushPuzzle driveTo(RushPuzzle puzzle, Position to) {
    assert(
      puzzle.vehicles.values.contains(this),
      'Vehicle must be in the puzzle.',
    );
    assert(
      drivingBoundary(puzzle).contains(to),
      'Vehicle cannot move to the specified position.',
    );
    if (firstPosition == to) return puzzle;

    final newVehicle = Vehicle(
      id: id,
      type: type,
      steering: steering,
      firstPosition: to,
    );

    return puzzle.copyWith(
      vehicles: {
        for (final vehicle in puzzle.vehicles.values)
          if (newVehicle.id == vehicle.id)
            newVehicle.id: newVehicle
          else
            vehicle.id: vehicle,
      },
    );
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
            (steering == Steering.horizontal ? Position(i, 0) : Position(0, i)),
      );
    }
    return positions;
  }

  @override
  List<Object?> get props => [
        id,
        type,
        steering,
        firstPosition,
        lastPosition,
      ];
}
