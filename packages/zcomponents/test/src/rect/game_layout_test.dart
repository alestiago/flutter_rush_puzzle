// ignore_for_file: use_named_constants

import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:zcomponents/zcomponents.dart';

void main() {
  group('GameLayout', () {
    final game = GameLayout(tileSize: 20, tileSpace: 10);
    test('initializes correctly', () async {
      expect(GameLayout(tileSize: 20, tileSpace: 20), isA<GameLayout>());
    });

    test('has correct tile stride', () async {
      expect(game.tileStride, equals(30));
    });

    test('has correct game size', () async {
      expect(game.size, equals(170));
    });

    test('offsetForPosition is correct', () async {
      expect(
        game.offsetForPosition(Position.zero),
        equals(Offset.zero),
      );
      expect(
        game.offsetForPosition(const Position(4, 2)),
        equals(const Offset(120, 60)),
      );
    });

    test('tileSizeForLength is correct', () async {
      expect(
        game.tileSizeForLength(2),
        equals(50),
      );
    });

    test('tileStrideForLength is correct', () async {
      expect(
        game.tileStrideForLength(2),
        equals(60),
      );
    });

    test('boxFor returns correct box for horizontal', () async {
      expect(
        game.boxFor(const Position(1, 2), 2, Steering.horizontal),
        equals(BoundingBox(const Offset(30, 60), const Offset(80, 80))),
      );
    });

    test('boxFor returns correct box for horizontal', () async {
      final vehicle = Vehicle(
        id: 'id',
        firstPosition: const Position(1, 2),
        type: VehicleType.taxi,
        steering: Steering.horizontal,
      );

      expect(vehicle.length, equals(2));
      expect(
        game.boxForVehicle(vehicle),
        equals(BoundingBox(const Offset(30, 60), const Offset(80, 80))),
      );
    });
  });
}
