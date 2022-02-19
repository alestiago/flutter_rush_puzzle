// ignore_for_file: public_member_api_docs, cast_nullable_to_non_nullable
import 'package:flutter/material.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/game_piece/zvehicle_controller.dart';
import 'package:zcomponents/zcomponents.dart';

class GamePiece extends StatelessWidget {
  const GamePiece({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return ZVehicleController(
      vehicle: vehicle,
      child: ZVehicle(
        data: vehicle,
      ),
    );
  }
}
