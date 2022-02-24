import 'package:puzzle_models/puzzle_models.dart';
import 'package:test/test.dart';

void main() {
  group('bounds', () {
    test(
      'is correct '
      'when from and to are vertical',
      () {
        const from = Position(0, 0);
        final to = Position(from.x + 2, from.y);
        final drivingBoundary = DrivingBoundary(from, to);

        final actual = drivingBoundary.bounds();
        final expected = [
          from,
          Position(from.x + 1, from.y),
          to,
        ];

        expect(actual, equals(expected));
      },
    );
    test(
      'is correct '
      'when from and to are horizontal',
      () {
        const from = Position(0, 0);
        final to = Position(from.x, from.y + 2);
        final drivingBoundary = DrivingBoundary(from, to);

        final actual = drivingBoundary.bounds();
        final expected = [
          from,
          Position(from.x, from.y + 1),
          to,
        ];

        expect(actual, equals(expected));
      },
    );
  });
}
