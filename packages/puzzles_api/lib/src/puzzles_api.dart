import 'dart:async';

import 'package:puzzle_models/puzzle_models.dart';

/// {@template puzzles_api}
/// API interface that provides access to [RushPuzzle]s.
/// {@endtemplate}
abstract class PuzzlesApi {
  /// {@macro puzzles_api}
  const PuzzlesApi();

  /// Retrieves a [RushPuzzle].
  ///
  /// The [RushPuzzle] is expected to be on the initial state.
  FutureOr<RushPuzzle> getPuzzle(String id);
}
