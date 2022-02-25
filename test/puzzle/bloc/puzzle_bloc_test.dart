import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';

class FakeRushPuzzle extends Fake implements RushPuzzle {}

void main() {
  // TODO(alestiago) test for PuzzleVehicleMoved, PuzzleMoveUndid.

  group('PuzzleBloc', () {
    blocTest<PuzzleBloc, PuzzleState>(
      'emits [] when nothing is added',
      build: () => PuzzleBloc(puzzle: FakeRushPuzzle()),
      expect: () => <PuzzleState>[],
    );
  });
}
