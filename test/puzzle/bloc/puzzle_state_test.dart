import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:zcomponents/zcomponents.dart';

class FakeRushPuzzle extends Fake implements RushPuzzle {}

void main() {
  group('PuzzleState', () {
    group('constructor', () {
      test('can be instantiated', () {
        final state = PuzzleState(
          history: [FakeRushPuzzle()],
        );

        expect(state, isA<PuzzleState>());
      });

      test(
        'throws AssertionError '
        'when historyPointer is larger than history',
        () {
          expect(
            () => PuzzleState(
              history: [FakeRushPuzzle()],
              historyPointer: 2,
            ),
            throwsAssertionError,
          );
        },
      );

      test(
        'throws AssertionError '
        'when historyPointer is smaller than 0',
        () {
          expect(
            () => PuzzleState(
              history: [FakeRushPuzzle()],
              historyPointer: -1,
            ),
            throwsAssertionError,
          );
        },
      );
    });

    group('copyWith', () {
      test('does nothing when no arguments are specified', () {
        final state = PuzzleState(history: [FakeRushPuzzle()]);
        expect(state.copyWith(), equals(state));
      });

      test('correctly copies', () {
        final state = PuzzleState(
          history: [FakeRushPuzzle()],
        );
        final newState = state.copyWith(
          status: GameStatus.finished,
          history: [FakeRushPuzzle()],
          historyPointer: 0,
          perspective: GameLayoutPerspective.p3D,
        );
        expect(state, isNot(equals(newState)));

        final copiedState = state.copyWith(
          status: newState.status,
          history: newState.history,
          historyPointer: newState.historyPointer,
          perspective: newState.perspective,
        );

        expect(copiedState, equals(newState));
      });
    });

    test('supports value equality', () {
      final stateA = PuzzleState(
        history: [FakeRushPuzzle()],
      );
      final stateB = PuzzleState(
        status: GameStatus.playing,
        historyPointer: 1,
        history: [FakeRushPuzzle(), FakeRushPuzzle()],
        perspective: GameLayoutPerspective.p2D,
      );

      expect(
        stateA,
        equals(PuzzleState(history: stateA.history)),
      );
      expect(stateA, isNot(equals(stateB)));
    });
  });
}
