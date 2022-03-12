import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';

class FakeRushPuzzle extends Fake implements RushPuzzle {}

void main() {
  group('PuzzleState', () {
    group('canUndo', () {
      test(
          'is false '
          'when historyPointer is not the first', () {
        final puzzleState = PuzzleState(
          history: [FakeRushPuzzle(), FakeRushPuzzle()],
        );

        expect(puzzleState.canUndo, isFalse);
      });

      test(
          'is true '
          'when historyPointer is not the first', () {
        final puzzleState = PuzzleState(
          history: [FakeRushPuzzle(), FakeRushPuzzle()],
          historyPointer: 1,
        );

        expect(puzzleState.canUndo, isTrue);
      });
    });
    group('canRedo', () {
      test(
          'is true '
          'when historyPointer is not the latest', () {
        final puzzleState = PuzzleState(
          history: [FakeRushPuzzle(), FakeRushPuzzle()],
        );

        expect(puzzleState.canRedo, isTrue);
      });

      test(
          'is false '
          'when historyPointer is the latest', () {
        final puzzleState = PuzzleState(
          history: [FakeRushPuzzle(), FakeRushPuzzle()],
          historyPointer: 1,
        );

        expect(puzzleState.canRedo, isFalse);
      });
    });
  });
}
