import 'dart:async';

import 'package:puzzle_models/puzzle_models.dart';

/// {@template puzzles_repository}
/// A repository that handles [RushPuzzle]s related requests.
/// {@endtemplate}
class PuzzlesRepository {
  /// {@macro puzzles_repository}
  const PuzzlesRepository();

  /// Retrieves a [RushPuzzle].
  ///
  /// The [RushPuzzle] is expected to be on the initial state.
  FutureOr<RushPuzzle> getPuzzle() {
    return _GamePuzzles.games.first;
  }
}

class _GamePuzzles {
  static final games = [
    _SimpleRushPuzzle(
      difficulty: PuzzleDifficulty.beginner,
      vehicles: [
        Vehicle(
          id: 'A',
          type: VehicleType.taxi,
          steering: Steering.horizontal,
          firstPosition: const Position(0, 0),
        ),
        Vehicle(
          id: 'P',
          type: VehicleType.bus,
          steering: Steering.vertical,
          firstPosition: const Position(0, 1),
        ),
        Vehicle(
          id: 'B',
          type: VehicleType.car,
          steering: Steering.vertical,
          firstPosition: const Position(0, 4),
        ),
        Vehicle(
          id: 'X',
          type: VehicleType.ambulance,
          steering: Steering.horizontal,
          firstPosition: const Position(1, 2),
        ),
        Vehicle(
          id: 'Q',
          type: VehicleType.truck,
          steering: Steering.vertical,
          firstPosition: const Position(3, 1),
        ),
        Vehicle(
          id: 'R',
          type: VehicleType.bus,
          steering: Steering.horizontal,
          firstPosition: const Position(2, 5),
        ),
        Vehicle(
          id: 'C',
          type: VehicleType.car,
          steering: Steering.horizontal,
          firstPosition: const Position(4, 4),
        ),
        Vehicle(
          id: 'O',
          type: VehicleType.truck,
          steering: Steering.vertical,
          firstPosition: const Position(5, 0),
        ),
      ],
    ),
  ];
}

// TODO(alestiago): define another constructor.
class _SimpleRushPuzzle extends RushPuzzle {
  _SimpleRushPuzzle({
    required PuzzleDifficulty difficulty,
    required List<Vehicle> vehicles,
  }) : super(
          difficulty: difficulty,
          jammedVehicleId: 'X',
          vehicles: {
            for (final vehicle in vehicles) vehicle.id: vehicle,
          },
        );
}
