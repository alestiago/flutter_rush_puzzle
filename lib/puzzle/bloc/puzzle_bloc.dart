import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:puzzles_repository/puzzles_repository.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zcomponents/zcomponents.dart';

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
    on<PuzzleShared>(_onPuzzleShared);
    on<PuzzlePerspectiveChanged>(_onPuzzlePerspectiveChanged);
    on<PuzzleTutorialStarted>(_onPuzzleTutorialStarted);
    on<_PuzzleTutorialFinished>(_onPuzzleTutorialFinished);
  }

  final PuzzlesRepository _puzzlesRepository;

  final puzzleVersion = DateTime.now().difference(DateTime(2022, 3, 15)).inDays;

  Future<void> _onPuzzleFetched(
    PuzzleFetched event,
    Emitter<PuzzleState> emit,
  ) async {
    try {
      emit(state.copyWith(status: GameStatus.loading));
      final game = await _puzzlesRepository.getPuzzle(puzzleVersion);
      emit(state.copyWith(status: GameStatus.setup, history: [game]));
      await FirebaseAnalytics.instance.logEvent(
        name: 'game_loaded',
        parameters: {
          'version': puzzleVersion,
        },
      );
    } catch (e) {
      await FirebaseAnalytics.instance.logEvent(
        name: 'game_failed',
        parameters: {
          'version': puzzleVersion,
        },
      );
    }
  }

  Future<void> _onPuzzleStarted(
    PuzzleStarted event,
    Emitter<PuzzleState> emit,
  ) async {
    emit(state.copyWith(status: GameStatus.playing));
    await FirebaseAnalytics.instance.logEvent(
      name: 'game_started',
      parameters: {
        'version': puzzleVersion,
      },
    );
  }

  Future<void> _onPuzzleVehicleMoved(
    PuzzleVehicleMoved event,
    Emitter emit,
  ) async {
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
    await FirebaseAnalytics.instance.logEvent(
      name: 'game_vehicle_moved',
      parameters: {
        'version': puzzleVersion,
        'vehicle': event.vehicle.id,
        'newPositionX': event.newPosition.x,
        'newPositionY': event.newPosition.y,
        'historyMove': newPointer,
      },
    );
  }

  Future<void> _onPuzzleReseted(PuzzleReseted event, Emitter emit) async {
    emit(
      PuzzleState(
        status: GameStatus.setup,
        history: [state.history[0]],
      ),
    );
    await FirebaseAnalytics.instance.logEvent(
      name: 'game_rested',
      parameters: {
        'version': puzzleVersion,
      },
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

  Future<void> _onPuzzlePerspectiveChanged(
    PuzzlePerspectiveChanged event,
    Emitter<PuzzleState> emit,
  ) async {
    emit(state.copyWith(perspective: event.perspective));
    await FirebaseAnalytics.instance.logEvent(
      name: 'game_perspective_changed',
      parameters: {
        'version': puzzleVersion,
        'vehicle': event.perspective.toString(),
      },
    );
  }

  Future<void> _onPuzzleShared(PuzzleShared event, Emitter emit) async {
    if (!state.puzzle.isSolved) return;

    sharePuzzle(state, puzzleVersion);
    await FirebaseAnalytics.instance.logEvent(
      name: 'game_shared',
      parameters: {
        'version': puzzleVersion,
        'historyMove': state.historyPointer,
      },
    );
  }

  Future<void> _onPuzzleTutorialStarted(
    PuzzleTutorialStarted _,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(status: GameStatus.tutorial),
    );

    Future<void>.delayed(
      const Duration(seconds: 4),
      () => add(const _PuzzleTutorialFinished()),
    );
  }

  Future<void> _onPuzzleTutorialFinished(
    _PuzzleTutorialFinished _,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(status: GameStatus.playing),
    );
  }
}

void sharePuzzle(PuzzleState state, int version) {
  final introMessage = '''
https://flutter-rush.web.app/  (#$version)
''';
  final buffer = StringBuffer();
  for (final state in state.history) {
    if (state.lastVehicleMoved != null) {
      buffer.write(state.lastVehicleMoved?.type.emoji);
    }
  }

  var message = '''
$introMessage

${state.historyPointer}: ${buffer.toString()}
''';

  if (message.characters.length > 140) {
    final map = <VehicleType, int>{};
    for (final state in state.history) {
      final vehicle = state.lastVehicleMoved;
      if (vehicle != null) {
        map[vehicle.type] ??= 0;
        map[vehicle.type] = map[vehicle.type]! + 1;
      }
    }

    final buffer = StringBuffer();
    for (final entry in map.entries) {
      buffer.write('${entry.key.emoji}x${entry.value} ');
    }

    message = '''
$introMessage

${state.historyPointer}: ${buffer.toString()}
''';
  }

  Share.share(
    message,
  );
}

extension on VehicleType {
  String get emoji {
    switch (this) {
      case VehicleType.taxi:
        return '🚕';
      case VehicleType.police:
        return '🚓';
      case VehicleType.bus:
        return '🚌';
      case VehicleType.secondaryBus:
        return '🚎';
      case VehicleType.truck:
        return '🚛';
      case VehicleType.secondaryTruck:
        return '🚚';
      case VehicleType.car:
        return '🚗';
      case VehicleType.ambulance:
        return '🚐';
    }
  }
}
