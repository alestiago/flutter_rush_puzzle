import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:puzzles_repository/puzzles_repository.dart';

// ignore: always_use_package_imports

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc({
    required PuzzlesRepository puzzlesRepository,
  })  : _puzzlesRepository = puzzlesRepository,
        super(PuzzleState(history: const [RushPuzzle.empty()])) {
    on<PuzzleFetched>(_onPuzzleFetched);
    on<PuzzleStarted>(_onPuzzleStarted);
    on<PuzzleReseted>(_onPuzzleReseted);
    on<PuzzleVehicleMoved>(_onPuzzleVehicleMoved);
    on<PuzzleMoveUndid>(_onPuzzleMoveUndid);
  }

  final PuzzlesRepository _puzzlesRepository;

  Future<void> _onPuzzleFetched(
    PuzzleFetched event,
    Emitter<PuzzleState> emit,
  ) async {
    emit(state.copyWith(status: GameStatus.loading));
    final game = await _puzzlesRepository.getPuzzle();
    emit(state.copyWith(status: GameStatus.setup, history: [game]));
  }

  Future<void> _onPuzzleStarted(
    PuzzleStarted event,
    Emitter<PuzzleState> emit,
  ) async {
    emit(state.copyWith(status: GameStatus.playing));
  }

  void _onPuzzleVehicleMoved(PuzzleVehicleMoved event, Emitter emit) {
    assert(
      state.status == GameStatus.playing,
      'Vehicle should move only when playing',
    );
    final newPuzzle = event.vehicle.driveTo(state.puzzle, event.newPosition);
    final newPointer = state.historyPointer + 1;
    emit(
      state.copyWith(
        history: List.from(state.history)..insert(newPointer, newPuzzle),
        historyPointer: newPointer,
        status: newPuzzle.isSolved ? GameStatus.finished : null,
      ),
    );
  }

  void _onPuzzleReseted(PuzzleReseted event, Emitter emit) {
    emit(
      PuzzleState(
        status: GameStatus.setup,
        history: [state.history[0]],
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
