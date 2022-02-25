import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:zcomponents/zcomponents.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc({
    required Vehicle vehicle,
    required GameLayout layout,
  })  : _steering = vehicle.steering,
        _layout = layout,
        vehicleId = vehicle.id,
        super(
          VehicleState(box: layout.boxForVehicle(vehicle)),
        ) {
    on<VehicleDragStarted>(_onDragStarted);
    on<VehicleDragUpdated>(_onDragUpdated);
    on<VehicleDragEnd>(_onDragEnd);
    on<VehicleTransformationUpdated>(_onTransformationUpdated);
  }

  final Steering _steering;

  final String vehicleId;

  final GameLayout _layout;

  Future<void> _onDragStarted(
    VehicleDragStarted event,
    Emitter<VehicleState> emit,
  ) async {
    emit(
      state.copyWith(
        dragStartPosition: event.dragPosition,
        dragging: true,
        draggingBox: state.box,
        boundary: event.boundary,
      ),
    );
  }

  Future<void> _onDragUpdated(
    VehicleDragUpdated event,
    Emitter<VehicleState> emit,
  ) async {
    final globalOffset = event.dragPosition - state.dragStartPosition;
    final vector = math.Vector3(globalOffset.dx, globalOffset.dy, 0);
    final matrix = state.transformation ?? Matrix4.translationValues(0, 0, 0);
    Offset offset;
    if (_steering == Steering.horizonal) {
      offset = Offset(vector.dot(matrix.right), 0);
    } else {
      offset = Offset(0, vector.dot(matrix.up));
    }
    if (offset.distance <= _precisionErrorTolerance) {
      offset = Offset.zero;
    }
    emit(
      state.copyWith(
        draggingBox: getTranslatedBox(
          state.box,
          boundary: state.boundary!,
          offset: offset,
        ),
      ),
    );
  }

  Future<void> _onDragEnd(
    VehicleDragEnd event,
    Emitter<VehicleState> emit,
  ) async {
    final vector = math.Vector3(event.velocity.dx, event.velocity.dy, 0);
    final matrix = state.transformation ?? Matrix4.translationValues(0, 0, 0);

    double velocity;
    if (_steering == Steering.horizonal) {
      velocity = vector.dot(matrix.right);
    } else {
      velocity = vector.dot(matrix.up);
    }
    emit(
      state
          .copyWith(
            dragging: false,
            box: getFinalPosition(
              state.draggingBox!,
              boundary: state.boundary!,
              layout: _layout,
              velocity: velocity,
            ),
          )
          .withoutDraggingBox(),
    );
  }

  Future<void> _onTransformationUpdated(
    VehicleTransformationUpdated event,
    Emitter<VehicleState> emit,
  ) async {
    final previousTransformation =
        state.transformation ?? Matrix4.translationValues(0, 0, 0);
    final transformation = matrixFromTransformations(event.transformations);
    if (!previousTransformation.closeTo(transformation)) {
      emit(
        state.copyWith(transformation: transformation),
      );
    }
  }
}

const double _precisionErrorTolerance = 1e-10;

extension CloseTo on Matrix4 {
  // Checks a matrix is similar to another one with an allowed threshold
  bool closeTo(Matrix4 value, {double tolerance = _precisionErrorTolerance}) {
    for (var index = 0; index < value.storage.length; index++) {
      if (!storage[index].closeTo(value.storage[index])) return false;
    }
    return true;
  }
}

extension CloseToDouble on double {
  // Checks a double is similar to another one with an allowed threshold
  bool closeTo(double value, {double tolerance = _precisionErrorTolerance}) {
    var diff = this - value;
    if (diff < 0) diff = -diff;
    return diff <= tolerance;
  }
}

BoundingBox getTranslatedBox(
  BoundingBox box, {
  required BoundingBox boundary,
  required Offset offset,
}) {
  final newBox = box.translate(offset);
  if (newBox.fitsInside(boundary)) {
    return newBox.clampInside(boundary);
  } else {
    return BoundingBox.fromLTWH(
      boundary.minPosition.dx,
      boundary.minPosition.dy,
      box.width,
      box.height,
    );
  }
}

BoundingBox getFinalPosition(
  BoundingBox box, {
  required BoundingBox boundary,
  required GameLayout layout,
  required double velocity,
}) {
  double roundPosition(double value) {
    final offset = value / layout.tileStride;
    int roundedOffset;

    final tolerance = layout.tolerance;
    if (velocity < -tolerance.velocity) {
      roundedOffset = offset.floor();
    } else if (velocity > tolerance.velocity) {
      roundedOffset = offset.ceil();
    } else {
      roundedOffset = offset.round();
    }

    return layout.tileStrideForLength(roundedOffset);
  }

  return BoundingBox.fromLTWH(
    roundPosition(box.minPosition.dx),
    roundPosition(box.minPosition.dy),
    box.width,
    box.height,
  ).clampInside(boundary);
}
