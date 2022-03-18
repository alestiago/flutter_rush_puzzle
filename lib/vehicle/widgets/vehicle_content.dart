// ignore_for_file: public_member_api_docs, cast_nullable_to_non_nullable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/vehicle/vehicle.dart';

import 'package:zcomponents/zcomponents.dart';

const Duration kDefaultDuration = Duration(milliseconds: 200);

class ZVehicleContent extends StatelessWidget {
  const ZVehicleContent({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final id = context.select((VehicleBloc bloc) => bloc.vehicleId);
    final isJammedVehicle =
        context.select((VehicleBloc bloc) => bloc.isMainVehicle);

    final dragging = context.select((VehicleBloc bloc) => bloc.state.dragging);
    final escaped = context.select((VehicleBloc bloc) => bloc.state.escaped);
    final shouldElevate = isJammedVehicle &&
        context.select((PuzzleBloc bloc) => bloc.state.status.isTutorial);

    final box = context.select((VehicleBloc bloc) {
      return bloc.state.draggingBox ?? bloc.state.box;
    });

    return BlocListener<VehicleBloc, VehicleState>(
      listener: (context, state) {
        final position = layout.positionForOffset(state.box.minPosition);

        final bloc = context.read<PuzzleBloc>();
        final vehicle = bloc.state.puzzle.vehicles[id]!;
        bloc.add(
          PuzzleVehicleMoved(vehicle: vehicle, newPosition: position),
        );
      },
      listenWhen: (previous, current) => previous.box != current.box,
      child: ZAnimatedPositioned(
        translate: ZVector.only(z: shouldElevate ? 30 : 0),
        duration: kDefaultDuration,
        child: ZAnimatedPositioned(
          translate: box.zCenter + const ZVector.only(z: 20),
          duration: dragging ? Duration.zero : kDefaultDuration,
          curve: Curves.easeInOut,
          child: ZAnimatedPositioned(
            duration: kDefaultDuration,
            translate: ZVector.only(z: dragging ? 10 : 0),
            child: ZBoundingBox(
              width: box.width,
              height: box.height,
              depth: layout.tileSize,
              children: [
                ZPositionTracker(
                  onTransform: (transforms) {
                    context.read<VehicleBloc>().add(
                          VehicleTransformationUpdated(transforms),
                        );
                  },
                  child: ZAnimatedPositioned(
                    translate: ZVector.only(x: escaped ? 1000 : 0),
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    child: ZGroup(
                      sortPoint: ZVector.zero,
                      sortMode: SortMode.update,
                      children: [
                        child,
                        const VehicleHitBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
