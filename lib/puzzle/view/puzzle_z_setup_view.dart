import 'package:flutter/material.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/vehicle/vehicle.dart';
import 'package:zcomponents/zcomponents.dart';

final _titleOffset = layout
    .boxForMinMax(
      const Position(2, 2),
      const Position(3, 3),
    )
    .zCenter;

final _textOffset = layout
    .boxForMinMax(
      const Position(2, 5),
      const Position(3, 5),
    )
    .zCenter;

final _setupPreviewDevice = Vehicle(
  id: 'isNotPlayingDemoVehicle--vehicle',
  steering: Steering.horizontal,
  firstPosition: const Position(2, 1),
  type: VehicleType.taxi,
);

class PuzzleZSetupView extends StatelessWidget {
  const PuzzleZSetupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ZVehicleView(
          key: Key(_setupPreviewDevice.id),
          vehicle: _setupPreviewDevice,
        ),
        ZPositioned(
          translate: _titleOffset,
          child: const ZGameTitle(
            key: Key('setupView_gameTitle'),
          ),
        ),
        ZPositioned(
          translate: _textOffset,
          child: const ZPlayText(
            key: Key('setupView_playText'),
          ),
        )
      ],
    );
  }
}
