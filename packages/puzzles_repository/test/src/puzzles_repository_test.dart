// ignore_for_file: prefer_const_constructors

import 'package:puzzle_models/puzzle_models.dart';
import 'package:puzzles_repository/puzzles_repository.dart';
import 'package:test/test.dart';

void main() {
  group('PuzzlesRepository', () {
    test('can be constructed', () {
      expect(PuzzlesRepository(), isA<PuzzlesRepository>());
    });

    test('gets a puzzle', () {
      final repository = PuzzlesRepository();
      expect(repository.getPuzzle(), isA<RushPuzzle>());
    });
  });
}
