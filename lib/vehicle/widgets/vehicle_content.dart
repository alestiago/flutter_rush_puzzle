// ignore_for_file: public_member_api_docs, cast_nullable_to_non_nullable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/vehicle/vehicle.dart';

import 'package:zcomponents/zcomponents.dart';

const Duration kDefaultDuration = Duration(milliseconds: 200);

class VehicleContent extends StatelessWidget {
  const VehicleContent({
    Key? key,
    required this.child,
    required this.vehicle,
  }) : super(key: key);

  final Vehicle vehicle;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dragging = context.select((VehicleBloc bloc) => bloc.state.dragging);
    final box = context.select((VehicleBloc bloc) => bloc.state.box);
    final id = context.select((VehicleBloc bloc) => bloc.vehicleId);
    final draggingBox =
        context.select((VehicleBloc bloc) => bloc.state.draggingBox);
    final isDebug = DebugGame.isDebugMode(context);

    return BlocListener<VehicleBloc, VehicleState>(
      listener: (context, VehicleState state) {
        final position = layout.positionForOffset(state.box.minPosition);

        final bloc = context.read<PuzzleBloc>();
        final puzzleState = bloc.state as PuzzleDataState;
        final vehicle = puzzleState.puzzle.vehicles[id]!;
        bloc.add(
          PuzzleVehicleMoved(vehicle: vehicle, newPosition: position),
        );
      },
      listenWhen: (previous, current) {
        return previous.box != current.box;
      },
      child: ZGroup(
        sortMode: SortMode.update,
        sortPoint: box.zCenter + const ZVector.only(z: 60),
        children: [
          if (isDebug) ZPositionDebug(box: box),
          ZPositionTracker(
            onTransform: (transforms) {
              context.read<VehicleBloc>().add(
                    VehicleTransformationUpdated(transforms),
                  );
            },
            child: ZAnimatedPositioned(
              translate: draggingBox?.zCenter ?? box.zCenter,
              duration: dragging ? Duration.zero : kDefaultDuration,
              curve: Curves.easeInOut,
              child: ZPositioned(
                translate: const ZVector.only(z: 18),
                child: ZGroup(
                  sortPoint: ZVector.zero,
                  sortMode: SortMode.update,
                  children: [
                    ZAnimatedPositioned(
                      duration: kDefaultDuration,
                      translate: ZVector.only(z: dragging ? 10 : 0),
                      child: child,
                    ),
                    const VehicleHitBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ZPositionDebug extends StatelessWidget {
  const ZPositionDebug({Key? key, required this.box}) : super(key: key);

  final BoundingBox box;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ZPositioned(
          translate: box.zMinPosition,
          child: ZCircle(
            diameter: 4,
            color: Colors.blue,
            stroke: 4,
          ),
        ),
        ZPositioned(
          translate: box.zMaxPosition,
          child: ZCircle(
            diameter: 4,
            color: Colors.green,
            stroke: 4,
          ),
        ),
      ],
    );
  }
}
