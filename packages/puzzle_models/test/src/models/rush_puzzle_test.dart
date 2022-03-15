import 'package:puzzle_models/puzzle_models.dart';
import 'package:test/test.dart';

void main() {
  group('RushPuzzle', () {
    group('initialization', () {
      test(
        'succeed with correct values',
        () {
          final jammedVehicle = Vehicle(
            id: 'A',
            type: VehicleType.taxi,
            steering: Steering.horizontal,
            firstPosition: Position.zero,
          );

          expect(
            RushPuzzle(
              difficulty: PuzzleDifficulty.beginner,
              jammedVehicleId: jammedVehicle.id,
              vehicles: {jammedVehicle.id: jammedVehicle},
            ),
            isA<RushPuzzle>(),
          );
        },
      );

      test(
        'throws assert if jammedVehicle not inside  vehicles',
        () {
          expect(
            () => RushPuzzle(
              difficulty: PuzzleDifficulty.beginner,
              jammedVehicleId: 'A',
              vehicles: const {},
            ),
            throwsA(isA<AssertionError>()),
          );
        },
      );

      test(
        'throws assert if a vehicle is outside puzzle',
        () {
          final jammedVehicle = Vehicle(
            id: 'A',
            type: VehicleType.taxi,
            steering: Steering.horizontal,
            firstPosition: Position.zero,
          );
          final outsideVehicle = Vehicle(
            id: 'A',
            type: VehicleType.taxi,
            steering: Steering.horizontal,
            firstPosition: const Position(10, 0),
          );
          expect(
            () => RushPuzzle(
              difficulty: PuzzleDifficulty.beginner,
              jammedVehicleId: jammedVehicle.id,
              vehicles: {
                jammedVehicle.id: jammedVehicle,
                outsideVehicle.id: outsideVehicle,
              },
            ),
            throwsA(isA<AssertionError>()),
          );
        },
      );

      test(
        '.empty creates an empty puzzle',
        () {
          expect(
            const RushPuzzle.empty().vehicles,
            isEmpty,
          );
        },
      );
    });
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

      test(
        'is false when is .empty ',
        () {
          expect(
            const RushPuzzle.empty().isSolved,
            isFalse,
          );
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
          firstPosition: Position.zero,
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
          firstPosition: Position.zero,
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
