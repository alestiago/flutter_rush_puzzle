// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:zcomponents/zcomponents.dart';

void main() {
  group('PuzzleEvent', () {
    group('PuzzleFetched', () {
      test('supports value equality', () {
        expect(PuzzleFetched(), equals(PuzzleFetched()));
      });
    });

    group('PuzzleStarted', () {
      test('supports value equality', () {
        expect(PuzzleStarted(), equals(PuzzleStarted()));
      });
    });

    group('PuzzleVehicleMoved', () {
      test('supports value equality', () {
        final vehicle = Vehicle(
          id: '1',
          firstPosition: Position(0, 0),
          type: VehicleType.car,
          steering: Steering.horizontal,
        );
        final eventA =
            PuzzleVehicleMoved(vehicle: vehicle, newPosition: Position(1, 1));
        final eventB =
            PuzzleVehicleMoved(vehicle: vehicle, newPosition: Position(2, 1));

        expect(
          eventA,
          equals(
            PuzzleVehicleMoved(vehicle: vehicle, newPosition: Position(1, 1)),
          ),
        );
        expect(
          eventA,
          isNot(equals(eventB)),
        );
      });
    });

    group('PuzzleReseted', () {
      test('supports value equality', () {
        expect(PuzzleReseted(), equals(PuzzleReseted()));
      });
    });

    group('PuzzleShared', () {
      test('supports value equality', () {
        expect(PuzzleShared(), equals(PuzzleShared()));
      });
    });

    group('PuzzlePerspectiveChanged', () {
      test('supports value equality', () {
        expect(
          PuzzlePerspectiveChanged(GameLayoutPerspective.p2D),
          equals(
            PuzzlePerspectiveChanged(GameLayoutPerspective.p2D),
          ),
        );
        expect(
          PuzzlePerspectiveChanged(GameLayoutPerspective.p2D),
          isNot(
            equals(
              PuzzlePerspectiveChanged(GameLayoutPerspective.p3D),
            ),
          ),
        );
      });
    });

    group('PuzzleTutorialStarted', () {
      test('supports value equality', () {
        expect(PuzzleTutorialStarted(), equals(PuzzleTutorialStarted()));
      });
    });
  });
}
