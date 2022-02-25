import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';

class MockPuzzleRepository extends Mock implements PuzzleRepository {}

class FakeRushPuzzle extends Fake implements RushPuzzle {}

void main() {
  // TODO(alestiago) test for PuzzleVehicleMoved, PuzzleMoveRedid, PuzzleMoveUndid.
  final puzzle = FakeRushPuzzle();

  group('PuzzleBloc', () {
    blocTest<PuzzleBloc, PuzzleState>(
      'emits [] when nothing is added',
      build: () => PuzzleBloc(puzzleRepository: MockPuzzleRepository()),
      expect: () => <PuzzleState>[],
    );

    group('when PuzzleRepository succeeds', () {
      late final MockPuzzleRepository mockPuzzleRepository;

      setUp(() {
        mockPuzzleRepository = MockPuzzleRepository();
        when(mockPuzzleRepository.getPuzzle).thenAnswer(
          (invocation) => Future<RushPuzzle>.delayed(
            const Duration(seconds: 1),
            () => puzzle,
          ),
        );
      });

      blocTest<PuzzleBloc, PuzzleState>(
        'emits PuzzleDataState',
        wait: const Duration(seconds: 1),
        build: () => PuzzleBloc(puzzleRepository: mockPuzzleRepository),
        act: (bloc) => bloc.add(const PuzzleRequested()),
        expect: () => [
          PuzzleLoadingState(),
          PuzzleDataState(history: [puzzle], historyPointer: 0)
        ],
      );
    });

    group('when puzzleRepository fails', () {
      final error = Exception();
      late final MockPuzzleRepository mockPuzzleRepository;

      setUp(() {
        mockPuzzleRepository = MockPuzzleRepository();
        when(mockPuzzleRepository.getPuzzle).thenAnswer(
          (invocation) => Future<RushPuzzle>.delayed(
            const Duration(seconds: 1),
            () => puzzle,
          ),
        );
      });

      blocTest<PuzzleBloc, PuzzleState>(
        'emits PuzzleErrorState',
        setUp: () {
          when(mockPuzzleRepository.getPuzzle).thenThrow(error);
        },
        build: () => PuzzleBloc(puzzleRepository: mockPuzzleRepository),
        act: (bloc) => bloc.add(const PuzzleRequested()),
        expect: () => [
          PuzzleLoadingState(),
          PuzzleErrorState(error),
        ],
      );
    });
  });
}
