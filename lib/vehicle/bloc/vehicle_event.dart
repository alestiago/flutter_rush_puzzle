part of 'vehicle_bloc.dart';

@immutable
abstract class VehicleEvent extends Equatable {}

class VehicleTransformationUpdated extends VehicleEvent {
  VehicleTransformationUpdated(this.transformations);

  final List<ZTransform> transformations;

  @override
  List<Object?> get props => [transformations];
}

class VehicleDragStarted extends VehicleEvent {
  VehicleDragStarted({
    required this.dragPosition,
    required this.boundary,
  });

  final Offset dragPosition;

  final BoundingBox boundary;
  @override
  List<Object?> get props => [dragPosition];
}

class VehicleDragUpdated extends VehicleEvent {
  VehicleDragUpdated(this.dragPosition);

  final Offset dragPosition;

  @override
  List<Object?> get props => [dragPosition];
}

class VehicleDragEnd extends VehicleEvent {
  VehicleDragEnd({this.velocity = Offset.zero});

  final Offset velocity;

  @override
  List<Object?> get props => [velocity];
}
