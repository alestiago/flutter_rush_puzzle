import 'package:puzzle_models/puzzle_models.dart';
import 'package:test/test.dart';

void main() {
  group('RushPuzzle', () {
    group('isSolved', () {
      test(
        'is true '
        'when jammedCar is in exit',
        () {
          final jammedVehicle = Vehicle(
            id: 'A',
            length: 3,
            steering: Steering.horizonal,
            firstPosition: RushPuzzle.exit,
          );

          final puzzle = RushPuzzle(
            jammedVehicle: jammedVehicle,
            vehicles: {jammedVehicle.id: jammedVehicle},
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
        );

        final vehicle2 = Vehicle(
          id: 'B',
          length: 3,
          steering: Steering.horizonal,
          firstPosition: const Position(0, 1),
        );
        final puzzle2 = RushPuzzle(
          jammedVehicle: vehicle2,
          vehicles: {vehicle2.id: vehicle2},
        );

        final copy = puzzle.copyWith(
          jammedVehicle: puzzle2.jammedVehicle,
          vehicles: puzzle2.vehicles,
        );

        expect(copy, equals(puzzle2));
      });
    });
  });
}
