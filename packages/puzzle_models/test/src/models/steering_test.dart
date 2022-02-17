import 'package:puzzle_models/puzzle_models.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Steering', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(Steering.horizonal, isA<Steering>());
        expect(Steering.vertical, isA<Steering>());
      });
    });
  });
}
