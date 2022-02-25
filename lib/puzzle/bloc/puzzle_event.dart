part of 'puzzle_bloc.dart';

@immutable
abstract class PuzzleEvent extends Equatable {
  const PuzzleEvent();
}

class PuzzleRequested extends PuzzleEvent {
  const PuzzleRequested();

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

// TODO(alestiago): Consider naming PuzzleUndo/PuzzleUndid.
class PuzzleMoveUndid extends PuzzleEvent {
  const PuzzleMoveUndid();

  @override
  List<Object?> get props => [];
}

// TODO(alestiago): Consider naming PuzzleRedo/PuzzleRedid.
class PuzzleMoveRedid extends PuzzleEvent {
  const PuzzleMoveRedid();

  @override
  List<Object?> get props => [];
}

class PuzzleReseted extends PuzzleEvent {
  const PuzzleReseted();

  @override
  List<Object?> get props => [];
}
