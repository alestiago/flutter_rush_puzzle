import 'package:puzzle_models/puzzle_models.dart';
import 'package:test/test.dart';

void main() {
  group('RushPuzzle', () {
    group('isSolved', () {
      test(
        'is true '
        'when jammedCar is in exit',
        () {
          const exit = Position(6, 3);
          final jammedVehicle = Vehicle(
            id: 'A',
            length: 3,
            steering: Steering.horizonal,
            firstPosition: exit,
          );

          final puzzle = RushPuzzle(
            jammedVehicle: jammedVehicle,
            vehicles: {jammedVehicle.id: jammedVehicle},
            exit: exit,
            dimension: const Position(5, 5),
          );

          expect(puzzle.isSolved, true);
        },
      );
    });

    group('copyWith', () {
      test(
          'stays the same '
          'when empty ', () {
        final vehicle = Vehicle(
          id: 'A',
          length: 3,
          steering: Steering.horizonal,
          firstPosition: const Position(0, 0),
        );
        final puzzle = RushPuzzle(
          jammedVehicle: vehicle,
          vehicles: {vehicle.id: vehicle},
          exit: const Position(6, 3),
          dimension: const Position(5, 5),
        );

        final copy = puzzle.copyWith();

        expect(copy, equals(puzzle));
      });

      test('copies correctly', () {
        final vehicle = Vehicle(
          id: 'A',
          length: 3,
          steering: Steering.horizonal,
          firstPosition: const Position(0, 0),
        );
        final puzzle = RushPuzzle(
          jammedVehicle: vehicle,
          vehicles: {vehicle.id: vehicle},
          exit: const Position(6, 3),
          dimension: const Position(5, 5),
        );

        final vehicle2 = Vehicle(
          id: 'B',
          length: 3,
          steering: Steering.horizonal,
          firstPosition: const Position(0, 1),
        );
        final puzzle2 = RushPuzzle(
          exit: const Position(5, 3),
          jammedVehicle: vehicle2,
          dimension: const Position(4, 4),
          vehicles: {vehicle2.id: vehicle2},
        );

        final copy = puzzle.copyWith(
          exit: puzzle2.exit,
          jammedVehicle: puzzle2.jammedVehicle,
          vehicles: puzzle2.vehicles,
          dimension: puzzle2.dimension,
        );

        expect(copy, equals(puzzle2));
      });
    });
  });
}
