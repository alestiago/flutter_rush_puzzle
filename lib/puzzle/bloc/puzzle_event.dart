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

class VehicleMoved extends PuzzleEvent {
  const VehicleMoved({
    required this.vehicle,
    required this.newPosition,
  });

  final Vehicle vehicle;
  final Position newPosition;

  @override
  List<Object?> get props => [vehicle, newPosition];
}

// TODO(alestiago): Consider naming PuzzleUndo/PuzzleUndid.
class UndidMove extends PuzzleEvent {
  const UndidMove();

  @override
  List<Object?> get props => [];
}

// TODO(alestiago): Consider naming PuzzleRedo/PuzzleRedid.
class RedidMove extends PuzzleEvent {
  const RedidMove();

  @override
  List<Object?> get props => [];
}

class PuzzleReset extends PuzzleEvent {
  const PuzzleReset();

  @override
  List<Object?> get props => [];
}
