import 'package:puzzle_models/puzzle_models.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('VehicleTypeX', () {
    group('length', () {
      test('all types have valid length', () {
        for (final type in VehicleType.values) {
          expect(type.length, greaterThan(1));
        }
      });
    });
  });
}
