part of 'puzzle_bloc.dart';

enum GameStatus {
  /// Initial game state, no game has been loaded yet
  initial,

  /// A game is being loaded
  loading,

  /// A game is ready to play
  setup,

  /// Game is being played
  playing,

  /// Game has been won
  finished,
}

extension GameStatusExtension on GameStatus {
  bool get isBeforePlaying =>
      this == GameStatus.initial ||
      this == GameStatus.loading ||
      this == GameStatus.setup;
}

@immutable
class PuzzleState extends Equatable {
  const PuzzleState({
    this.status = GameStatus.initial,
    required this.history,
    this.historyPointer = 0,
  }) : assert(
          0 <= historyPointer && historyPointer < history.length,
          'historyPointer is invalid',
        );

  final GameStatus status;

  final List<RushPuzzle> history;
  final int historyPointer;

  RushPuzzle get puzzle => history[historyPointer];

  bool get canUndo => historyPointer > 0;

  bool get canRedo => historyPointer < history.length - 1;

  PuzzleState copyWith({
    GameStatus? status,
    List<RushPuzzle>? history,
    int? historyPointer,
  }) {
    return PuzzleState(
      status: status ?? this.status,
      history: history ?? this.history,
      historyPointer: historyPointer ?? this.historyPointer,
    );
  }

  @override
  List<Object?> get props => [history, historyPointer, status];
}
