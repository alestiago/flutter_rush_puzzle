part of 'puzzle_bloc.dart';

@immutable
class PuzzleState extends Equatable {
  const PuzzleState({
    required this.history,
    required this.historyPointer,
  }) : assert(
          0 <= historyPointer && historyPointer < history.length,
          'historyPointer is invalid',
        );

  final List<RushPuzzle> history;
  final int historyPointer;

  RushPuzzle get puzzle => history[historyPointer];

  bool get canUndo => historyPointer > 0;

  bool get canRedo => historyPointer < history.length - 1;

  PuzzleState copyWith({
    List<RushPuzzle>? history,
    int? historyPointer,
  }) {
    return PuzzleState(
      history: history ?? this.history,
      historyPointer: historyPointer ?? this.historyPointer,
    );
  }

  @override
  List<Object?> get props => [puzzle];
}
