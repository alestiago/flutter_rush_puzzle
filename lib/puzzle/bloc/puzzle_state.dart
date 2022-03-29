part of 'puzzle_bloc.dart';

enum GameStatus {
  /// Initial game state, no game has been loaded yet.
  initial,

  /// A game is being loaded.
  loading,

  /// A game is ready to play.
  setup,

  /// Game is being played.
  playing,

  /// Game has been won.
  finished,

  /// Showing game tutorial.
  tutorial,
}

extension GameStatusExtension on GameStatus {
  bool get isInitial => this == GameStatus.initial;

  bool get isLoading => this == GameStatus.loading;

  bool get isSetup => this == GameStatus.setup;

  bool get isBeforePlaying =>
      this == GameStatus.initial ||
      this == GameStatus.loading ||
      this == GameStatus.setup;

  bool get isPlaying => this == GameStatus.playing || isTutorial;

  bool get isTutorial => this == GameStatus.tutorial;

  bool get isFinished => this == GameStatus.finished;
}

@immutable
class PuzzleState extends Equatable {
  const PuzzleState({
    this.status = GameStatus.initial,
    this.perspective = GameLayoutPerspective.p3D,
    required this.history,
    this.historyPointer = 0,
  }) : assert(
          0 <= historyPointer && historyPointer < history.length,
          'historyPointer is invalid',
        );

  final GameStatus status;

  final List<RushPuzzle> history;

  final int historyPointer;

  final GameLayoutPerspective perspective;

  RushPuzzle get puzzle => history[historyPointer];

  PuzzleState copyWith({
    GameStatus? status,
    List<RushPuzzle>? history,
    int? historyPointer,
    GameLayoutPerspective? perspective,
  }) {
    return PuzzleState(
      status: status ?? this.status,
      history: history ?? this.history,
      historyPointer: historyPointer ?? this.historyPointer,
      perspective: perspective ?? this.perspective,
    );
  }

  @override
  List<Object?> get props => [history, historyPointer, status, perspective];
}
