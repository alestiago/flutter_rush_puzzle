import 'package:puzzle_models/puzzle_models.dart';
import 'package:test/test.dart';

void main() {
  group('contains', () {
    test(
      'is true '
      'when from and to are vertical and position is inside',
      () {
        const from = Position.zero;
        const to = Position(0, 3);
        const position = Position(0, 2);
        final drivingBoundary = DrivingBoundary(from, to);

        final actual = drivingBoundary.contains(position);

        expect(actual, isTrue);
      },
    );
    test(
      'is false '
      'when from and to are vertical and position is outside',
      () {
        const from = Position.zero;
        const to = Position(0, 3);
        const position = Position(0, 4);
        final drivingBoundary = DrivingBoundary(from, to);

        final actual = drivingBoundary.contains(position);

        expect(actual, isFalse);
      },
    );

    test(
      'is true '
      'when from and to are horizontal and position is inside',
      () {
        const from = Position.zero;
        const to = Position(3, 0);
        const position = Position(2, 0);
        final drivingBoundary = DrivingBoundary(from, to);

        final actual = drivingBoundary.contains(position);

        expect(actual, isTrue);
      },
    );

    test(
      'is true '
      'when from and to are vertical and position is inside',
      () {
        const from = Position.zero;
        const to = Position(0, 3);
        const position = Position(0, 4);
        final drivingBoundary = DrivingBoundary(from, to);

        final actual = drivingBoundary.contains(position);

        expect(actual, isFalse);
      },
    );
  });
}
