import 'package:puzzle_models/puzzle_models.dart';
import 'package:test/test.dart';

void main() {
  group('Position', () {
    group(
      'constructor',
      () {
        test(
          'can be instantiated',
          () {
            expect(const Position(0, 0), isA<Position>());
          },
        );

        test(
          'throws an AssertionError '
          'when x is smaller than 0',
          () {
            expect(() => Position(-1, 0), throwsA(isA<AssertionError>()));
          },
        );

        test(
          'throws an AssertionError '
          'when y is smaller than 0',
          () {
            expect(() => Position(-1, 0), throwsA(isA<AssertionError>()));
          },
        );
      },
    );

    group('+ operator', () {
      test(
        'correctly adds',
        () {
          expect(
            const Position(0, 0) + const Position(1, 1),
            equals(const Position(1, 1)),
          );
        },
      );
    });

    group(
      '- operator',
      () {
        test(
          'correctly subtracts',
          () {
            expect(
              const Position(3, 3) - const Position(1, 1),
              equals(const Position(2, 2)),
            );
          },
        );
      },
    );

    group('* operator', () {
      test(
        'correctly multiplies',
        () {
          expect(
            const Position(3, 3) * 2,
            equals(const Position(6, 6)),
          );
        },
      );
    });

    group(
      '<= operator',
      () {
        test(
          'correctly compares',
          () {
            expect(const Position(1, 1) <= const Position(1, 2), isTrue);
            expect(const Position(1, 1) <= const Position(0, 1), isFalse);
            expect(const Position(5, 5) <= const Position(5, 5), isTrue);
          },
        );
      },
    );

    group(
      '>= operator',
      () {
        test(
          'correctly compares',
          () {
            expect(const Position(1, 1) >= const Position(1, 2), isFalse);
            expect(const Position(1, 1) >= const Position(0, 1), isTrue);
            expect(const Position(5, 5) >= const Position(5, 5), isTrue);
          },
        );
      },
    );

    group(
      '== operator',
      () {
        test(
          'correctly compares '
          'based on x and y',
          () {
            expect(const Position(1, 1) == const Position(1, 1), isTrue);
            expect(const Position(1, 1) == const Position(2, 1), isFalse);
            expect(const Position(1, 1) == const Position(1, 2), isFalse);
          },
        );
      },
    );
  });
}
