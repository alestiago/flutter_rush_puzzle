import 'package:puzzle_models/puzzle_models.dart';
import 'package:test/test.dart';

void main() {
  group('RushPuzzle', () {
    // TODO(alestiago): test RushPuzzle.
    group('isSolved', () {
      test(
        'is true '
        'when jammedCar is in exit',
        () {
          const exit = Position(6, 3);
          final jammedVehicle = Vehicle(
            id: 'A',
            length: 3,
            steering: Steering.horizonal,
            firstPosition: exit,
          );

          final puzzle = RushPuzzle(
            jammedVehicle: jammedVehicle,
            vehicles: [jammedVehicle],
            exit: exit,
            dimension: const Position(5, 5),
          );

          expect(puzzle.isSolved, true);
        },
      );
    });
  });
}
