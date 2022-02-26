import 'package:puzzle_models/puzzle_models.dart';
import 'package:test/test.dart';

void main() {
  group('RushPuzzle', () {
    group('isSolved', () {
      test(
        'is true '
        'when jammedVehcile is in exit',
        () {
          final jammedVehicle = Vehicle(
            id: 'A',
            type: VehicleType.taxi,
            steering: Steering.horizontal,
            firstPosition: RushPuzzle.exit,
          );

          final puzzle = RushPuzzle(
            difficulty: PuzzleDifficulty.beginner,
            jammedVehicleId: jammedVehicle.id,
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
          type: VehicleType.taxi,
          steering: Steering.horizontal,
          firstPosition: const Position(0, 0),
        );
        final puzzle = RushPuzzle(
          difficulty: PuzzleDifficulty.beginner,
          jammedVehicleId: vehicle.id,
          vehicles: {vehicle.id: vehicle},
        );

        final copy = puzzle.copyWith();

        expect(copy, equals(puzzle));
      });

      test('copies correctly', () {
        final vehicle = Vehicle(
          id: 'A',
          type: VehicleType.taxi,
          steering: Steering.horizontal,
          firstPosition: const Position(0, 0),
        );
        final puzzle = RushPuzzle(
          difficulty: PuzzleDifficulty.beginner,
          jammedVehicleId: vehicle.id,
          vehicles: {vehicle.id: vehicle},
        );

        final vehicle2 = Vehicle(
          id: 'B',
          type: VehicleType.taxi,
          steering: Steering.horizontal,
          firstPosition: const Position(0, 1),
        );
        final puzzle2 = RushPuzzle(
          difficulty: PuzzleDifficulty.expert,
          jammedVehicleId: vehicle2.id,
          vehicles: {vehicle2.id: vehicle2},
        );

        final copy = puzzle.copyWith(
          difficulty: puzzle2.difficulty,
          jammedVehicleId: puzzle2.jammedVehicleId,
          vehicles: puzzle2.vehicles,
        );

        expect(copy, equals(puzzle2));
      });
    });
  });
}
