import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:puzzle_models/puzzle_models.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc({required RushPuzzle puzzle})
      : super(
          PuzzleState(
            history: [puzzle],
            historyPointer: 0,
          ),
        ) {
    on<PuzzleVehicleMoved>(_onPuzzleVehicleMoved);
    on<PuzzleReseted>(_onPuzzleReseted);
    on<PuzzleMoveUndid>(_onPuzzleMoveUndid);
  }

  void _onPuzzleVehicleMoved(PuzzleVehicleMoved event, Emitter emit) {
    final newPuzzle = event.vehicle.driveTo(state.puzzle, event.newPosition);

    emit(
      state.copyWith(
        history: List.from(state.history)
          ..insert(
            state.historyPointer + 1,
            newPuzzle,
          ),
        historyPointer: state.historyPointer + 1,
      ),
    );
  }

  void _onPuzzleReseted(PuzzleReseted event, Emitter emit) {
    emit(
      PuzzleState(
        history: [state.history[0]],
        historyPointer: 0,
      ),
    );
  }

  void _onPuzzleMoveUndid(PuzzleMoveUndid event, Emitter emit) {
    if (!state.canUndo) return;

    emit(
      state.copyWith(
        historyPointer: state.historyPointer - 1,
      ),
    );
  }
}
