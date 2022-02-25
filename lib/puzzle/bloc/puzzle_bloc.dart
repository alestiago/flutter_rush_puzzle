import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:puzzle_models/puzzle_models.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

// TODO(alestiago): Move this to a package.
// ignore: one_member_abstracts
final vehicles = [
  Vehicle(
    id: 'A',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(0, 0),
  ),
  Vehicle(
    id: 'B',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(1, 0),
  ),
  Vehicle(
    id: 'C',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(2, 0),
  ),
  Vehicle(
    id: 'D',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(3, 0),
  ),
  Vehicle(
    id: 'E',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(4, 0),
  ),
  Vehicle(
    id: 'F',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(5, 0),
  ),
  Vehicle(
    id: 'G',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(0, 2),
  ),
  Vehicle(
    id: 'H',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(1, 2),
  ),
  Vehicle(
    id: 'I',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(2, 2),
  ),
  Vehicle(
    id: 'J',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(3, 2),
  ),
  Vehicle(
    id: 'K',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(4, 2),
  ),
  Vehicle(
    id: 'L',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(5, 2),
  ),
  Vehicle(
    id: 'M',
    length: 3,
    steering: Steering.horizonal,
    firstPosition: const Position(0, 4),
  ),
  // Vehicle(
  //   id: 'N',
  //   length: 3,
  //   steering: Steering.horizonal,
  //   firstPosition: const Position(3, 4),
  // ),
  Vehicle(
    id: 'O',
    length: 3,
    steering: Steering.horizonal,
    firstPosition: const Position(0, 5),
  ),
  // Vehicle(
  //   id: 'P',
  //   length: 3,
  //   steering: Steering.horizonal,
  //   firstPosition: const Position(3, 5),
  // ),
];

class PuzzleRepository {
  PuzzleRepository();
  Future<RushPuzzle> getPuzzle() async {
    return RushPuzzle(
      exit: const Position(6, 3),
      jammedVehicle: vehicles.first,
      dimension: const Position(6, 6),
      vehicles: Map.fromEntries(vehicles.map((e) => MapEntry(e.id, e))),
    );
  }
}

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc({
    required PuzzleRepository puzzleRepository,
  })  : _puzzleRepository = puzzleRepository,
        super(
          PuzzleInitialState(),
        ) {
    on<PuzzleRequested>(_onPuzzleRequested);
    on<PuzzleVehicleMoved>(_onPuzzleVehicleMoved);
    on<PuzzleReseted>(_onPuzzleReseted);
    on<PuzzleMoveUndid>(_onPuzzleMoveUndid);
    on<PuzzleMoveRedid>(_onPuzzleMoveRedid);
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

  void _onPuzzleVehicleMoved(PuzzleVehicleMoved event, Emitter emit) {
    if (state is PuzzleDataState) {
      final state = this.state as PuzzleDataState;
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
  }

  void _onPuzzleReseted(PuzzleReseted event, Emitter emit) {
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

  void _onPuzzleMoveUndid(PuzzleMoveUndid event, Emitter emit) {
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

  void _onPuzzleMoveRedid(PuzzleMoveRedid event, Emitter emit) {
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
