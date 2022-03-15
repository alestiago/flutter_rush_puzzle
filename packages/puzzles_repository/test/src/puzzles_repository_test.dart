// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:puzzles_repository/puzzles_repository.dart';

void main() {
  group('PuzzlesRepository', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    test('can be constructed', () {
      expect(PuzzlesRepository(), isA<PuzzlesRepository>());
    });

    test('gets a puzzle', () {
      final repository = PuzzlesRepository();
      expect(repository.getPuzzle(1), completion(isA<RushPuzzle>()));
    });

      test('3', () {
      final repository = PuzzlesRepository();
      expect(repository.getPuzzle(1), completion(isA<RushPuzzle>()));
    });
  });
}
