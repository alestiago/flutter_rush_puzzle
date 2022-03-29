part of 'puzzle_bloc.dart';

@immutable
abstract class PuzzleEvent extends Equatable {
  const PuzzleEvent();
}

class PuzzleFetched extends PuzzleEvent {
  const PuzzleFetched();

  @override
  List<Object?> get props => [];
}

class PuzzleStarted extends PuzzleEvent {
  const PuzzleStarted();
  @override
  List<Object?> get props => [];
}

class PuzzleVehicleMoved extends PuzzleEvent {
  const PuzzleVehicleMoved({
    required this.vehicle,
    required this.newPosition,
  });

  final Vehicle vehicle;
  final Position newPosition;

  @override
  List<Object?> get props => [vehicle, newPosition];
}

class PuzzleReseted extends PuzzleEvent {
  const PuzzleReseted();

  @override
  List<Object?> get props => [];
}

class PuzzleShared extends PuzzleEvent {
  const PuzzleShared();

  @override
  List<Object?> get props => [];
}

class PuzzlePerspectiveChanged extends PuzzleEvent {
  const PuzzlePerspectiveChanged(this.perspective);

  final GameLayoutPerspective perspective;

  @override
  List<Object?> get props => [perspective];
}

class PuzzleTutorialStarted extends PuzzleEvent {
  const PuzzleTutorialStarted();

  @override
  List<Object?> get props => [];
}

class _PuzzleTutorialFinished extends PuzzleEvent {
  const _PuzzleTutorialFinished();

  @override
  List<Object?> get props => [];
}
