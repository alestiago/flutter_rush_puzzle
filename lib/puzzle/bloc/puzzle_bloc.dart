import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:puzzle_models/puzzle_models.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

// TODO(alestiago): Move this to a package.
// ignore: one_member_abstracts
abstract class PuzzleRepository {
  Future<RushPuzzle> getPuzzle();
}

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc({
    required PuzzleRepository puzzleRepository,
  })  : _puzzleRepository = puzzleRepository,
        super(
          PuzzleInitialState(),
        ) {
    on<PuzzleRequested>(_onPuzzleRequested);
    on<VehicleMoved>(_onVehicleMoved);
    on<PuzzleReset>(_onPuzzleReset);
    on<UndidMove>(_onUndidMove);
    on<RedidMove>(_onRedidMove);
  }

  final PuzzleRepository _puzzleRepository;

  Future<void> _onPuzzleRequested(PuzzleRequested event, Emitter emit) async {
    if (state is PuzzleInitialState) {
      emit(PuzzleLoadingState());

      try {
        final puzzle = await _puzzleRepository.getPuzzle();
        emit(PuzzleDataState(history: [puzzle], historyPointer: 0));
      } catch (error) {
        emit(PuzzleErrorState(error));
      }
    }
  }

  void _onVehicleMoved(VehicleMoved event, Emitter emit) {
    if (state is PuzzleDataState) {
      final state = this.state as PuzzleDataState;
      final newPuzzle = event.vehicle.driveTo(state.puzzle, event.newPosition);

      emit(
        state.copyWith(
          history: List.from(state.history)
            ..insert(
              state.historyPointer,
              newPuzzle,
            ),
          historyPointer: state.historyPointer + 1,
        ),
      );
    }
  }

  void _onPuzzleReset(PuzzleReset event, Emitter emit) {
    if (state is PuzzleDataState) {
      final state = this.state as PuzzleDataState;
      emit(
        PuzzleDataState(
          history: [state.history[0]],
          historyPointer: 0,
        ),
      );
    }
  }

  void _onUndidMove(UndidMove event, Emitter emit) {
    if (state is PuzzleDataState) {
      final state = this.state as PuzzleDataState;
      if (!state.canUndo) return;

      emit(
        state.copyWith(
          historyPointer: state.historyPointer - 1,
        ),
      );
    }
  }

  void _onRedidMove(RedidMove event, Emitter emit) {
    if (state is PuzzleDataState) {
      final state = this.state as PuzzleDataState;
      if (!state.canRedo) return;

      emit(
        state.copyWith(
          historyPointer: state.historyPointer - 1,
        ),
      );
    }
  }
}
