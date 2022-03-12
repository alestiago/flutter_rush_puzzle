// ignore_for_file: public_member_api_docs, cast_nullable_to_non_nullable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/vehicle/vehicle.dart';

import 'package:zcomponents/zcomponents.dart';

class VehicleHitBox extends StatelessWidget {
  const VehicleHitBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = context.select((VehicleBloc bloc) => bloc.state.box);
    final id = context.select((VehicleBloc bloc) => bloc.vehicleId);

    return ZHitBox(
      width: box.width,
      height: box.height,
      depth: layout.tileSize,
      onPanDown: (details) {
        final state = context.read<PuzzleBloc>().state;
        final vehicle = state.puzzle.vehicles[id];
        if (vehicle == null) return;
        HapticFeedback.selectionClick();

        final boundary = vehicle.drivingBoundary(state.puzzle);
        context.read<VehicleBloc>().add(
              VehicleDragStarted(
                dragPosition: details.globalPosition,
                boundary: layout.boxForDrivingBoundary(boundary),
              ),
            );
      },
      onPanUpdate: (details) {
        final state = context.read<PuzzleBloc>().state;
        final vehicle = state.puzzle.vehicles[id];
        if (vehicle == null) return;
        context.read<VehicleBloc>().add(
              VehicleDragUpdated(details.globalPosition),
            );
      },
      onPanEnd: (details) {
        final state = context.read<PuzzleBloc>().state;
        final vehicle = state.puzzle.vehicles[id];
        if (vehicle == null) return;
        context.read<VehicleBloc>().add(
              VehicleDragEnd(
                velocity: details.velocity.pixelsPerSecond,
              ),
            );
      },
      onPanCancel: () {
        final state = context.read<PuzzleBloc>().state;
        final vehicle = state.puzzle.vehicles[id];
        if (vehicle == null) return;
        context.read<VehicleBloc>().add(
              VehicleDragEnd(),
            );
      },
    );
  }
}
