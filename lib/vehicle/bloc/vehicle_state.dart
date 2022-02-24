part of 'vehicle_bloc.dart';

@immutable
class VehicleState extends Equatable {
  const VehicleState({
    required this.box,
    this.dragging = false,
    this.dragStartPosition = Offset.zero,
    this.draggingBox,
    this.boundary,
    this.transformation,
  });

  final bool dragging;

  final BoundingBox box;

  final BoundingBox? draggingBox;

  final BoundingBox? boundary;

  final Matrix4? transformation;

  final Offset dragStartPosition;

  @override
  List<Object?> get props => [
        dragging,
        box,
        draggingBox,
        boundary,
        transformation,
        dragStartPosition,
      ];

  VehicleState copyWith({
    bool? dragging,
    BoundingBox? box,
    BoundingBox? draggingBox,
    BoundingBox? boundary,
    Matrix4? transformation,
    Offset? dragStartPosition,
  }) {
    return VehicleState(
      dragging: dragging ?? this.dragging,
      box: box ?? this.box,
      draggingBox: draggingBox ?? this.draggingBox,
      boundary: boundary ?? this.boundary,
      transformation: transformation ?? this.transformation,
      dragStartPosition: dragStartPosition ?? this.dragStartPosition,
    );
  }

  VehicleState withoutDraggingBox() {
    return VehicleState(
      dragging: dragging,
      box: box,
      boundary: boundary,
      transformation: transformation,
      dragStartPosition: dragStartPosition,
    );
  }
}
