// ignore_for_file: public_member_api_docs, cast_nullable_to_non_nullable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/vehicle/vehicle.dart';
import 'package:zcomponents/zcomponents.dart';

class ZVehicleView extends StatelessWidget {
  const ZVehicleView({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    Widget child = ZVehicle(data: vehicle);
    assert(
      () {
        if (DebugGame.isDebugMode(context)) {
          child = const _VehicleDebugBox();
        }
        return true;
      }(),
      'In debug mode vehicles are replaced by boxes',
    );
    return BlocProvider(
      create: (context) {
        final state = context.read<PuzzleBloc>().state;
        return VehicleBloc(
          vehicle: vehicle,
          layout: layout,
          isMainVehicle: state.puzzle.jammedVehicleId == vehicle.id,
        );
      },
      child: ZVehicleContent(child: child),
    );
  }
}

class _VehicleDebugBox extends StatelessWidget {
  const _VehicleDebugBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = context.select((VehicleBloc bloc) => bloc.state.box);
    return ZBox(
      width: box.width,
      height: box.height,
      depth: zTileSize,
      color: Colors.red.withOpacity(0.2),
    );
  }
}
