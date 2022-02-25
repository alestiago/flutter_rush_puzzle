part of 'puzzle_bloc.dart';

@immutable
abstract class PuzzleState extends Equatable {
  const PuzzleState();
}

class PuzzleInitialState extends PuzzleState {
  @override
  List<Object?> get props => [];
}

class PuzzleLoadingState extends PuzzleState {
  @override
  List<Object?> get props => [];
}

class PuzzleErrorState extends PuzzleState {
  const PuzzleErrorState(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

@immutable
class PuzzleDataState extends PuzzleState {
  const PuzzleDataState({
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

  PuzzleDataState copyWith({
    List<RushPuzzle>? history,
    int? historyPointer,
  }) {
    return PuzzleDataState(
      history: history ?? this.history,
      historyPointer: historyPointer ?? this.historyPointer,
    );
  }

  @override
  List<Object?> get props => [puzzle];
}
