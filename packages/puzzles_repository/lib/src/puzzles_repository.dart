import 'dart:async';
import 'dart:convert';

import 'package:puzzle_models/puzzle_models.dart';
import 'package:flutter/services.dart' show rootBundle;

/// {@template puzzles_repository}
/// A repository that handles [RushPuzzle]s related requests.
/// {@endtemplate}
class PuzzlesRepository {
  /// {@macro puzzles_repository}
  const PuzzlesRepository();

  /// Retrieves a [RushPuzzle].
  ///
  /// The [RushPuzzle] is expected to be on the initial state.
  FutureOr<RushPuzzle> getPuzzle(int number) async {
    final game = await rootBundle
        .loadString('packages/puzzles_repository/assets/$number.json');
    final json = jsonDecode(game) as Map<String, dynamic>;
    return RushPuzzle.fromJson(json);
  }
}
