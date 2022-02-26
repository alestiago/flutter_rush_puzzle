// TODO(alestiago): remove this file.

part of 'puzzle_page.dart';

class GamePuzzles {
  static final games = [
    SimpleRushPuzzle(
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
          type: VehicleType.taxi,
          steering: Steering.vertical,
          firstPosition: const Position(0, 4),
        ),
        Vehicle(
          id: 'X',
          type: VehicleType.taxi,
          steering: Steering.horizontal,
          firstPosition: const Position(1, 2),
        ),
        Vehicle(
          id: 'Q',
          type: VehicleType.bus,
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
          type: VehicleType.taxi,
          steering: Steering.horizontal,
          firstPosition: const Position(4, 4),
        ),
        Vehicle(
          id: 'O',
          type: VehicleType.bus,
          steering: Steering.vertical,
          firstPosition: const Position(5, 0),
        ),
      ],
    ),
  ];
}

class SimpleRushPuzzle extends RushPuzzle {
  SimpleRushPuzzle({
    required List<Vehicle> vehicles,
  }) : super(
          // TODO(jamesblasco): Specify the difficulty of this puzzle.
          difficulty: PuzzleDifficulty.beginner,
          // TODO(jamesblasco): Specify jammedVehicleId instead of jammedVehicle.
          jammedVehicleId: vehicles.first.id,
          vehicles: {
            for (final vehicle in vehicles) vehicle.id: vehicle,
          },
        );
}
