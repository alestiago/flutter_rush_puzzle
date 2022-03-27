import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:puzzle_models/puzzle_models.dart';

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
    String game;

    try {
      game = await rootBundle
          .loadString('packages/puzzles_repository/assets/14.json');
    } catch (e) {
      game = await rootBundle.loadString(
        'packages/puzzles_repository/assets/${gamesAvailable - 1}.json',
      );
    }
    final json = jsonDecode(game) as Map<String, dynamic>;
    return RushPuzzle.fromJson(json);
  }
  
  /// Amount of games available in the assets folder
  static const int gamesAvailable = 20;
}
