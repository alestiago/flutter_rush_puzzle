import 'package:puzzle_models/puzzle_models.dart';
import 'package:test/test.dart';

void main() {
  group('Vehicle', () {
    group('constructor', () {
      test(
        'can be instantiated',
        () {
          expect(
            Vehicle(
              id: '1',
              length: 2,
              steering: Steering.horizontal,
              firstPosition: const Position(0, 0),
            ),
            isA<Vehicle>(),
          );
        },
      );

      test(
        'throws AssertionError '
        'when Vehicle has a length smaller than 0',
        () {
          expect(
            () => Vehicle(
              id: '1',
              length: 0,
              steering: Steering.horizontal,
              firstPosition: const Position(0, 0),
            ),
            throwsA(const TypeMatcher<AssertionError>()),
          );
          expect(
            () => Vehicle(
              id: '1',
              length: 1,
              steering: Steering.horizontal,
              firstPosition: const Position(0, 0),
            ),
            returnsNormally,
          );
        },
      );

      test(
          'correctly sets endPosition '
          'when steering is horizontal', () {
        final vehicle = Vehicle(
          id: '1',
          length: 2,
          steering: Steering.horizontal,
          firstPosition: const Position(0, 0),
        );
        expect(vehicle.lastPosition, const Position(1, 0));
      });

      test(
          'correctly sets endPosition '
          'when steering is vertical', () {
        final vehicle = Vehicle(
          id: '1',
          length: 2,
          steering: Steering.vertical,
          firstPosition: const Position(0, 0),
        );
        expect(vehicle.lastPosition, const Position(0, 1));
      });
    });
    group('drivingBoundary', () {
      test(
        'is correct '
        'when is single horizontal car in puzzle',
        () {
          final vehicle = Vehicle(
            id: '1',
            length: 2,
            steering: Steering.horizontal,
            firstPosition: const Position(0, 0),
          );
          final puzzle = RushPuzzle(
            difficulty: PuzzleDifficulty.beginner,
            jammedVehicleId: vehicle.id,
            vehicles: {vehicle.id: vehicle},
          );

          final drivingBoundaries = vehicle.drivingBoundary(puzzle);

          expect(vehicle.steering, equals(Steering.horizontal));
          expect(drivingBoundaries.from, vehicle.firstPosition);
          expect(
            drivingBoundaries.to,
            Position(RushPuzzle.dimension.x, vehicle.firstPosition.y),
          );
        },
      );

      test(
        'is correct '
        'when is single vertical car in puzzle',
        () {
          final vehicle = Vehicle(
            id: '1',
            length: 2,
            steering: Steering.vertical,
            firstPosition: const Position(2, 3),
          );
          final puzzle = RushPuzzle(
            difficulty: PuzzleDifficulty.beginner,
            jammedVehicleId: vehicle.id,
            vehicles: {vehicle.id: vehicle},
          );

          final drivingBoundaries = vehicle.drivingBoundary(puzzle);

          expect(vehicle.steering, equals(Steering.vertical));
          expect(drivingBoundaries.from, const Position(2, 0));
          expect(drivingBoundaries.to, Position(2, RushPuzzle.dimension.y));
        },
      );

      test(
          'is correct '
          'when steers horizontal and surrounded', () {
        final jammedVehicle = Vehicle(
          id: '1',
          length: 2,
          steering: Steering.horizontal,
          firstPosition: const Position(2, 3),
        );
        final vehicle2 = Vehicle(
          id: '2',
          length: 1,
          steering: Steering.horizontal,
          firstPosition: Position(0, jammedVehicle.firstPosition.y),
        );
        final vehicle3 = Vehicle(
          id: '3',
          length: 3,
          steering: Steering.vertical,
          firstPosition: Position(5, jammedVehicle.firstPosition.y - 1),
        );

        final puzzle = RushPuzzle(
          difficulty: PuzzleDifficulty.beginner,
          jammedVehicleId: jammedVehicle.id,
          vehicles: {
            jammedVehicle.id: jammedVehicle,
            vehicle2.id: vehicle2,
            vehicle3.id: vehicle3,
          },
        );

        final drivingBoundaries = jammedVehicle.drivingBoundary(puzzle);

        expect(jammedVehicle.steering, equals(Steering.horizontal));
        expect(
          drivingBoundaries.from,
          Position(1, jammedVehicle.firstPosition.y),
        );
        expect(
          drivingBoundaries.to,
          Position(vehicle3.firstPosition.x - 1, jammedVehicle.firstPosition.y),
        );
      });

      test(
          'is correct '
          'when steers horizontal and has right neighbour', () {
        final jammedVehicle = Vehicle(
          id: '1',
          length: 2,
          steering: Steering.horizontal,
          firstPosition: const Position(1, 0),
        );
        final vehicle2 = Vehicle(
          id: '2',
          length: 2,
          steering: Steering.horizontal,
          firstPosition: const Position(3, 0),
        );
        final puzzle = RushPuzzle(
          difficulty: PuzzleDifficulty.beginner,
          jammedVehicleId: jammedVehicle.id,
          vehicles: {
            jammedVehicle.id: jammedVehicle,
            vehicle2.id: vehicle2,
          },
        );

        final drivingBoundaries = jammedVehicle.drivingBoundary(puzzle);

        expect(jammedVehicle.steering, equals(Steering.horizontal));
        expect(
          drivingBoundaries.from,
          Position(0, jammedVehicle.firstPosition.y),
        );
        expect(
          drivingBoundaries.to,
          Position(vehicle2.firstPosition.x - 1, jammedVehicle.firstPosition.y),
        );
      });

      test(
        'is correct '
        'when jammedVehicle can exit',
        () {
          expect(RushPuzzle.exit, equals(const Position(6, 2)));
          const length = 3;
          final vehicle = Vehicle(
            id: '1',
            length: length,
            steering: Steering.horizontal,
            firstPosition: RushPuzzle.exit - const Position(length, 0),
          );
          final puzzle = RushPuzzle(
            difficulty: PuzzleDifficulty.beginner,
            jammedVehicleId: vehicle.id,
            vehicles: {vehicle.id: vehicle},
          );

          final drivingBoundaries = vehicle.drivingBoundary(puzzle);

          expect(puzzle.jammedVehicleId, equals(vehicle.id));
          expect(vehicle.steering, equals(Steering.horizontal));
          expect(drivingBoundaries.from, Position(0, RushPuzzle.exit.y));
          expect(
            drivingBoundaries.to,
            RushPuzzle.exit + const Position(length - 1, 0),
          );
        },
      );
    });

    group('driveTo', () {
      test('moves vehicle', () {
        final vehicle = Vehicle(
          id: '1',
          length: 2,
          steering: Steering.horizontal,
          firstPosition: const Position(0, 0),
        );
        final puzzle = RushPuzzle(
          difficulty: PuzzleDifficulty.beginner,
          jammedVehicleId: vehicle.id,
          vehicles: {
            vehicle.id: vehicle,
          },
        );

        final newPosition = vehicle.firstPosition + const Position(1, 0);
        final newPuzzle = vehicle.driveTo(
          puzzle,
          newPosition,
        );

        expect(
          newPuzzle.vehicles,
          equals({
            vehicle.id: Vehicle(
              id: vehicle.id,
              length: vehicle.length,
              steering: vehicle.steering,
              firstPosition: newPosition,
            )
          }),
        );
      });

      test(
          'throws AssertionError '
          'when drives to an invalid positon', () {
        final vehicleA = Vehicle(
          id: 'A',
          length: 2,
          steering: Steering.horizontal,
          firstPosition: const Position(0, 0),
        );
        final vehicleB = Vehicle(
          id: 'B',
          length: 2,
          steering: Steering.horizontal,
          firstPosition: const Position(3, 0),
        );
        final puzzle = RushPuzzle(
          difficulty: PuzzleDifficulty.beginner,
          jammedVehicleId: vehicleA.id,
          vehicles: {
            vehicleA.id: vehicleA,
            vehicleB.id: vehicleB,
          },
        );
        expect(
          () => vehicleA.driveTo(puzzle, vehicleB.firstPosition),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('positions', () {
      test(
          'correctly '
          'when length is 1', () {
        final vehicle = Vehicle(
          id: '1',
          length: 1,
          steering: Steering.horizontal,
          firstPosition: const Position(2, 3),
        );

        final expected = [
          vehicle.firstPosition,
        ];

        expect(expected.length, equals(vehicle.length));
        expect(vehicle.positions, expected);
      });
      test(
          'correctly '
          'when steering is horizontal', () {
        final vehicle = Vehicle(
          id: '1',
          length: 3,
          steering: Steering.horizontal,
          firstPosition: const Position(2, 3),
        );

        final expected = [
          vehicle.firstPosition,
          const Position(3, 3),
          vehicle.lastPosition,
        ];

        expect(expected.length, equals(vehicle.length));
        expect(vehicle.positions, expected);
      });

      test(
          'correctly '
          'when steering is vertical', () {
        final vehicle = Vehicle(
          id: '1',
          length: 3,
          steering: Steering.vertical,
          firstPosition: const Position(2, 3),
        );

        final expected = [
          vehicle.firstPosition,
          const Position(2, 4),
          vehicle.lastPosition,
        ];

        expect(expected.length, equals(vehicle.length));
        expect(vehicle.positions, expected);
      });
    });

    group('== operator', () {
      test(
        'supports value equality '
        'whit all properties',
        () {
          final vehicle1 = Vehicle(
            id: '1',
            length: 1,
            steering: Steering.horizontal,
            firstPosition: const Position(0, 0),
          );
          final vehicle2 = Vehicle(
            id: '1',
            length: 1,
            steering: Steering.horizontal,
            firstPosition: const Position(0, 0),
          );
          final vehicle3 = Vehicle(
            id: '2',
            length: 2,
            steering: Steering.horizontal,
            firstPosition: const Position(0, 0),
          );

          expect(vehicle1, equals(vehicle2));
          expect(vehicle1, isNot(equals(vehicle3)));
          expect(vehicle2, isNot(equals(vehicle3)));
        },
      );
    });
  });
}
