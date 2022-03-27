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

  /// Game is paused.
  paused,

  /// Game has been won.
  finished,

  /// Showing game tutorial.
  tutorial,
}

extension GameStatusExtension on GameStatus {
  bool get isBeforePlaying =>
      this == GameStatus.initial ||
      this == GameStatus.loading ||
      this == GameStatus.setup;

  bool get isPlaying => this == GameStatus.playing || isTutorial;

  bool get isTutorial => this == GameStatus.tutorial;

  bool get isPaused => this == GameStatus.paused;
}

@immutable
class PuzzleState extends Equatable {
  const PuzzleState({
    required this.status,
    required this.perspective,
    required this.history,
    required this.historyPointer,
  }) : assert(
          0 <= historyPointer && historyPointer < history.length,
          'historyPointer is invalid',
        );

  const PuzzleState.empty()
      : this(
          status: GameStatus.initial,
          perspective: GameLayoutPerspective.p3D,
          history: const [RushPuzzle.empty()],
          historyPointer: 0,
        );

  final GameStatus status;

  final List<RushPuzzle> history;

  final int historyPointer;

  final GameLayoutPerspective perspective;

  RushPuzzle get puzzle => history[historyPointer];

  bool get canUndo => historyPointer > 0;

  bool get canRedo => historyPointer < history.length - 1;

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
  List<Object?> get props => [
        history,
        historyPointer,
        status,
        perspective,
      ];
}
