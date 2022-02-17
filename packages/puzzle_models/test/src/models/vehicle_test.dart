import 'package:puzzle_models/puzzle_models.dart';
import 'package:puzzle_models/src/models/rush_puzzle.dart';
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
              steering: Steering.horizonal,
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
              steering: Steering.horizonal,
              firstPosition: const Position(0, 0),
            ),
            throwsA(const TypeMatcher<AssertionError>()),
          );
          expect(
            () => Vehicle(
              id: '1',
              length: 1,
              steering: Steering.horizonal,
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
          steering: Steering.horizonal,
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
            steering: Steering.horizonal,
            firstPosition: const Position(2, 3),
          );
          final puzzle = RushPuzzle(
            exit: const Position(6, 3),
            jammedVehicle: vehicle,
            dimension: const Position(5, 5),
            vehicles: [vehicle],
          );

          final drivingBoundaries = vehicle.drivingBoundary(puzzle);

          expect(vehicle.steering, equals(Steering.horizonal));
          expect(drivingBoundaries.from, const Position(0, 3));
          expect(drivingBoundaries.to, Position(puzzle.dimension.x, 3));
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
            exit: const Position(6, 3),
            jammedVehicle: vehicle,
            dimension: const Position(5, 5),
            vehicles: [vehicle],
          );

          final drivingBoundaries = vehicle.drivingBoundary(puzzle);

          expect(vehicle.steering, equals(Steering.vertical));
          expect(drivingBoundaries.from, const Position(2, 0));
          expect(drivingBoundaries.to, Position(2, puzzle.dimension.y));
        },
      );

      test(
          'is correct '
          'when steers horizontal and surrounded', () {
        final jammedVehicle = Vehicle(
          id: '1',
          length: 2,
          steering: Steering.horizonal,
          firstPosition: const Position(2, 3),
        );
        final vehicle2 = Vehicle(
          id: '2',
          length: 1,
          steering: Steering.horizonal,
          firstPosition: Position(0, jammedVehicle.firstPosition.y),
        );
        final vehicle3 = Vehicle(
          id: '3',
          length: 3,
          steering: Steering.vertical,
          firstPosition: Position(5, jammedVehicle.firstPosition.y - 1),
        );

        final puzzle = RushPuzzle(
          exit: const Position(6, 3),
          jammedVehicle: jammedVehicle,
          dimension: const Position(5, 5),
          vehicles: [jammedVehicle, vehicle2, vehicle3],
        );

        final drivingBoundaries = jammedVehicle.drivingBoundary(puzzle);

        expect(jammedVehicle.steering, equals(Steering.horizonal));
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
          steering: Steering.horizonal,
          firstPosition: const Position(1, 0),
        );
        final vehicle2 = Vehicle(
          id: '2',
          length: 2,
          steering: Steering.horizonal,
          firstPosition: const Position(3, 0),
        );
        final puzzle = RushPuzzle(
          exit: const Position(6, 0),
          jammedVehicle: jammedVehicle,
          dimension: const Position(5, 5),
          vehicles: [jammedVehicle, vehicle2],
        );

        final drivingBoundaries = jammedVehicle.drivingBoundary(puzzle);

        expect(jammedVehicle.steering, equals(Steering.horizonal));
        expect(
          drivingBoundaries.from,
          Position(0, jammedVehicle.firstPosition.y),
        );
        expect(
          drivingBoundaries.to,
          Position(vehicle2.firstPosition.x - 1, jammedVehicle.firstPosition.y),
        );
      });
    });

    group('driveTo', () {
      // TODO(alestiago): Write test.
    });

    group('positions', () {
      test(
          'correctly '
          'when length is 1', () {
        final vehicle = Vehicle(
          id: '1',
          length: 1,
          steering: Steering.horizonal,
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
          steering: Steering.horizonal,
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
            steering: Steering.horizonal,
            firstPosition: const Position(0, 0),
          );
          final vehicle2 = Vehicle(
            id: '1',
            length: 1,
            steering: Steering.horizonal,
            firstPosition: const Position(0, 0),
          );
          final vehicle3 = Vehicle(
            id: '2',
            length: 2,
            steering: Steering.horizonal,
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
