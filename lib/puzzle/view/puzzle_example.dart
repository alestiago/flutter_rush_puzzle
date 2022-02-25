// TODO(alestiago): remove this file.

part of 'puzzle_page.dart';

class GamePuzzles {
  static final games = [
    SimpleRushPuzzle(
      vehicles: [
        Vehicle(
          id: 'A',
          length: 2,
          steering: Steering.horizonal,
          firstPosition: const Position(0, 0),
        ),
        Vehicle(
          id: 'P',
          length: 3,
          steering: Steering.vertical,
          firstPosition: const Position(0, 1),
        ),
        Vehicle(
          id: 'B',
          length: 2,
          steering: Steering.vertical,
          firstPosition: const Position(0, 4),
        ),
        Vehicle(
          id: 'X',
          length: 2,
          steering: Steering.horizonal,
          firstPosition: const Position(1, 2),
        ),
        Vehicle(
          id: 'Q',
          length: 3,
          steering: Steering.vertical,
          firstPosition: const Position(3, 1),
        ),
        Vehicle(
          id: 'R',
          length: 3,
          steering: Steering.horizonal,
          firstPosition: const Position(2, 5),
        ),
        Vehicle(
          id: 'C',
          length: 2,
          steering: Steering.horizonal,
          firstPosition: const Position(4, 4),
        ),
        Vehicle(
          id: 'O',
          length: 3,
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
          // TODO(jamesblasco): Specify jammedVehicleId instead of jammedVehicle.
          jammedVehicle: Vehicle(
            id: 'X',
            length: 2,
            steering: Steering.horizonal,
            firstPosition: const Position(0, 0),
          ),
          vehicles: {
            for (final vehicle in vehicles) vehicle.id: vehicle,
          },
        );
}
